# coding=utf-8
import os
import sys
import os.path
import glob
from pathlib import Path
import shutil
import time
from datetime import datetime
from reportlab.pdfgen import canvas
from reportlab.lib.units import inch, cm
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from PyPDF2 import PdfFileWriter, PdfFileReader, generic
import xlrd
import math
import matplotlib.pyplot as plt
from add_book_mark import get_fist_grade

pdfmetrics.registerFont(TTFont('song', 'simsun.ttc'))#宋体

os.getcwd()
g_local_path = os.path.split(os.path.realpath(sys.argv[0]))[0]
os.chdir(os.path.join(g_local_path))
os.getcwd()    #获取当前工作目录

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        pass
 
    try:
        import unicodedata
        unicodedata.numeric(s)
        return True
    except (TypeError, ValueError):
        pass
 
    return False

# 像素值转厘米的比例因子
# 595.22pixs -> 21 cm
# 842pixs -> 29.7 cm
g_bl = 28.35
# g_pageMediaBox = generic.RectangleObject([0,0,0,0])


# 统计一行字符的不同字符个数，空格、中文、英文、数字和其他
def get_ch_count(str):
    count0 = count1 = count2 = count3 = count4 = 0
    count0 = str.count(" ")
    for s in str:
        if 'a' <= s <= 'z' or 'A' <= s <= 'Z':
            count1 += 1  # 英文计数
        elif 0x4e00 <= ord(s) <= 0x9fa5:  # 中文的Unicode编码范围
            count2 += 1  # 中文计数
        elif 48 <= ord(s) and ord(s) <= 57:
            count3 += 1  # 数字计数
    count4 = len(str)-count0-count1-count2-count3
    return count2, len(str) - count2

def get_angle(a, b):
    c = math.sqrt(a**2 + b**2)
    print(a, b, c)
    # return math.degrees(math.acos((c*c-a*a-b*b)/(-2*a*b))) # a b 夹角
    # return math.degrees(math.acos((a*a-b*b-c*c)/(-2*b*c))) # b c 夹角
    return math.degrees(math.acos((b*b-a*a-c*c)/(-2*a*c)))


def get_a_b(c, angle):
    # 角度值转成弧度再计算
    return math.cos(math.radians(angle)) * c, math.sin(math.radians(angle)) * c

######## 1.生成水印pdf的函数 ########
def create_watermark(content, pageMediaBox, Rotate):
    c = canvas.Canvas('mark.pdf', pagesize = (pageMediaBox[2], pageMediaBox[3]))
    strLen = (int)((len(content) * (int)(pageMediaBox[3]/15))/2)
    # 计算对角线像素
    duijiaoxian_len = math.sqrt((pageMediaBox[2] ** 2 + pageMediaBox[3] ** 2))
    content_len = len(content.encode()) # 获取字节数
    # print(strLen, len(content), duijiaoxian_len, content_len)
    # c.setFont('song', (int)(pageMediaBox[3]/15))#设置字体为宋体，大小22号
    zh_count, other_count = get_ch_count(content)
    font_size = (int)(duijiaoxian_len*0.8 / (zh_count + other_count/2))
    c.setFont('song', font_size, leading=1)#设置字体为宋体
    c.setFillColorRGB(0.2,0.2,0.2, 0.15)#灰色
    # 求倾斜角度
    angle = get_angle(float(pageMediaBox[2]), float(pageMediaBox[3]))
    # angle = math.atan(pageMediaBox[3] / pageMediaBox[2])
    # print("对角线角度: ", angle)
    # 移动 坐标原点
    a1, b1 = get_a_b(duijiaoxian_len*0.8, angle)
    print(duijiaoxian_len*0.8, angle, a1, b1, font_size)
    # 旋转会导致左右两边不对称，所以 x 轴除以1.8来补偿
    # c.translate(((float(pageMediaBox[2]) - a1)/(1.8*g_bl))*cm, ((float(pageMediaBox[3]) - b1) / (2.2*g_bl)) *cm) # 移动坐标原点(坐标系左下为(0,0)))
    ifx_off = ((float(pageMediaBox[2]) / (zh_count + other_count/2)) / 4)
    print(((float(pageMediaBox[2]) - a1)/(2*g_bl))*cm, ((float(pageMediaBox[3]) - b1) / (2*g_bl)) *cm,  ifx_off)
    x = (float(pageMediaBox[2]) - a1) / 2 + ifx_off
    y = (float(pageMediaBox[3]) - b1) / 2 - ifx_off
    print(x, y, ifx_off, cm, g_bl)
    c.translate(x, y) # 移动坐标原点(坐标系左下为(0,0)))
    #旋转
    c.rotate(angle)#旋转45度，坐标系被旋转

    # x = (int)((float)(pageMediaBox[2]) * 0.05)
    c.drawString(0, 0, content)
    c.save()#关闭并保存pdf文件

    # plt.figure()
    # plt.subplot(121)
    # plt.imshow()
    # plt.show()

######## 2.为pdf文件加水印的函数 ########
def add_watermark2pdf(input_pdf, output_pdf, watermark_pdf, pageMediaBox, Rotate):
    watermark = PdfFileReader(watermark_pdf)
    watermark_page = watermark.getPage(0)
    pdf = PdfFileReader(input_pdf,strict=False)
    # -----------------------------------------------------------------------------
    # 检索页面
    page_marks = {}  # 标签
    count = pdf.numPages
    pageLabels = {}  # 标签页
    for index in range(count):
        pageObj = pdf.getPage(index)
        pageLabels[pageObj.indirectRef.idnum] = index  # 页码索引
    # print(pageLabels)
    outlines = pdf.getOutlines()
    get_fist_grade(outlines, pageLabels, page_marks)
    print("书签:", page_marks)
    # ------------------------------------------------------------------------------
    pdf_writer = PdfFileWriter()
    for page in range(pdf.getNumPages()):
        pdf_page = pdf.getPage(page)
        page_mediaBox_temp = pdf_page.mediaBox
        if pageMediaBox != page_mediaBox_temp:
            print("页面大小变了，重新生成水印文件", pageMediaBox, page_mediaBox_temp)
            os.remove("mark.pdf")
            Rotate = pdf_page['/Rotate']
            create_watermark(g_customer_name, page_mediaBox_temp, Rotate)
            pageMediaBox = page_mediaBox_temp
            # 重新加载水印文件
            watermark = PdfFileReader(watermark_pdf)
            watermark_page = watermark.getPage(0)
        # if Rotate != 0:
        #     pdf_page.mergeRotatedPage(watermark_page, 270)
        # else:
        pdf_page.mergePage(watermark_page)

        pdf_writer.addPage(pdf_page)

    # -----------------------------------------------------------------------------
    # 添加书签
    pg_marks = {}
    for index in range(1, len(page_marks) + 1):
        print(page_marks[index])
        (pt_index, pgnum, pgtitle, bktyp) = page_marks[index]
        if pt_index == 0:
            # 添加书签，建书签索引
            # pg_marks[index] = pdfWriter.addBookmark(title=pgtitle, pagenum=pgnum, fit=bktyp)
            pg_marks[index] = pdf_writer.addBookmark(title=pgtitle, pagenum=pgnum)
        else:
            # 存在父节点，书签定向到父节点下面
            pts = pg_marks[pt_index]
            # pg_marks[index] = pdfWriter.addBookmark(title=pgtitle, pagenum=pgnum, parent=pts, fit=bktyp)
            pg_marks[index] = pdf_writer.addBookmark(title=pgtitle, pagenum=pgnum, parent=pts)
    # -----------------------------------------------------------------------------

    # 写入文件
    pdfOutputFile = open(output_pdf,'wb')
    # pdf_writer.encrypt("aionhorizon") #设置pdf密码
    pdf_writer.write(pdfOutputFile)
    pdfOutputFile.close()

def do_add_water_mark(filename):
    print(filename)
    pdf = PdfFileReader(filename, strict=False)
    pageMediaBox = pdf.getPage(0).mediaBox
    Rotate = 0
    if '/Rotate' in pdf.getPage(0).keys():
        Rotate = pdf.getPage(0)['/Rotate']
    # print(pdf.getPage(0))
    # 页面大小和旋转角度
    print("pageMediaBox", pageMediaBox, Rotate)
    create_watermark(g_customer_name, pageMediaBox, Rotate)  # 创造了一个水印pdf：mark.pdf
    add_watermark2pdf(filename, filename, "mark.pdf", pageMediaBox, Rotate)
    os.remove("mark.pdf")


if __name__=='__main__':

    # print ('参数个数为:', len(sys.argv), '个参数。')
    # print ('参数列表:', str(sys.argv))

    # 如果命令行只指定了需要打水印的文件或者目录，则从已有水印中选择，否则把第三个参数当作水印
    if len(sys.argv) == 2:
        with open("customers.txt", "r") as f:
            customers = f.readlines()
            idx = 0
            for customer in customers:
                print(idx, ":", customer.replace('\n', ''))
                idx += 1
            f.close()

        val = input('\n请选择客户水印(可直接输入水印文字代替选择)：')
        if is_number(val) == True:
            print(val, "客户水印:", customers[int(val)].replace('\n', ''))
            g_customer_name = customers[int(val)].replace('\n', '')
        else:
            g_customer_name = val
    elif len(sys.argv) == 3:
        g_customer_name = sys.argv[2]
    else:
        print("参数输入不争取！")

    input_pdf = sys.argv[1]

    # 判断输入的文件是目录还是文件
    if os.path.isdir(input_pdf):
        print("输入是目录")
        single_file = False
    elif os.path.isfile(input_pdf):
        print("输入是文件")
        if input_pdf.endswith(('.pdf')):
            single_file = True
        else:
            print("输入文件类型不是pdf格式")
            quit()
    else:
        print("输入的是特殊文件类型")
        quit()

    if single_file:
        do_add_water_mark(input_pdf)
    else:
        g_out_putpath = os.path.join(input_pdf, "..",
                                     "for_" + g_customer_name + datetime.now().strftime('%Y%m%d-%H%M%S'))
        print(g_out_putpath)
        # shutil.rmtree(g_out_putpath)
        shutil.copytree(input_pdf, g_out_putpath)

        for filename in glob.iglob(g_out_putpath + '**/*.pdf', recursive=True):
            do_add_water_mark(filename)

    print(g_customer_name, '———————所有文件已转化完毕———————')
