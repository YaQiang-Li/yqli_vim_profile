# -*- coding: utf-8 -*-
"""
Created on Tue Apr 21 17:51:20 2020

@author: teyond

下载的pdf边缘很大，代码切了一下，同样加载了标签
"""

import PyPDF2

# -----------------------------------------------------------------------------
# 解析目录

# 信息整理：父索引序号，页内索引号，标题，类型
def get_bookmark_info(strline, pageLabels, level_id):
    dtn = strline
    idobj = dtn.page

    return level_id, pageLabels[idobj.idnum], dtn.title, dtn.typ


# 第一级索引信息
def get_fist_grade(strline, pageLabels, page_marks, level1_id=0):
    num = level1_id
    parent_id = level1_id
    for subline in strline:
        if isinstance(subline, list):
            num, parent_id = get_second_grade(subline, pageLabels, page_marks, num)
        else:
            num = num + 1
            page_marks[num] = get_bookmark_info(subline, pageLabels, level1_id)
            # print('level1---:',num,parent_id)
    return num, parent_id


# 第二级索引信息
def get_second_grade(strline, pageLabels, page_marks, level2_id=0):
    num = level2_id
    parent_id = level2_id
    for subline in strline:
        if isinstance(subline, list):
            num, parent_id = get_third_grade(subline, pageLabels, page_marks, num)
        else:
            num = num + 1
            page_marks[num] = get_bookmark_info(subline, pageLabels, level2_id)
            # print('level2---:',num,parent_id)
    return num, parent_id


# 第三级索引信息
def get_third_grade(strline, pageLabels, page_marks, level3_id=0):
    num = level3_id
    parent_id = level3_id
    for subline in strline:
        if isinstance(subline, list):
            num, parent_id = get_fourth_grade(subline, pageLabels, page_marks, num)
        else:
            num = num + 1
            page_marks[num] = get_bookmark_info(subline, pageLabels, level3_id)
            # print('level3---:',num,parent_id)
    return num, parent_id


# 第四级索引信息
def get_fourth_grade(strline, pageLabels, page_marks, level4_id=0):
    num = level4_id
    parent_id = level4_id
    for subline in strline:
        if isinstance(subline, list):
            continue
        else:
            num = num + 1
            page_marks[num] = get_bookmark_info(subline, pageLabels, level4_id)
            # print('level4---:',num,parent_id)
    return num, parent_id


# -----------------------------------------------------------------------------
if __name__=='__main__':
    pdfFile = open(r'C:\Users\yaqiang.li\Desktop\MU-EN-2510-1-X3-Hardware Design Guide-V0.6.pdf', 'rb')

    pdfReader = PyPDF2.PdfFileReader(pdfFile)
    pdfWriter = PyPDF2.PdfFileWriter()

    # -----------------------------------------------------------------------------
    # 检索页面
    count = pdfReader.numPages
    pageLabels = {}  # 标签页
    page_marks = {}  # 标签
    for index in range(count):
        pageObj = pdfReader.getPage(index)
        pageLabels[pageObj.indirectRef.idnum] = index  # 页码索引

    outlines = pdfReader.getOutlines()
    get_fist_grade(outlines, pageLabels, page_marks)
    print(page_marks)
    # ------------------------------------------------------------------------------

    # 获取原始页面的size
    firstpage = pdfReader.getPage(0)
    w = float(firstpage.mediaBox.getWidth())
    h = float(firstpage.mediaBox.getHeight())

    # 切边后在原页面位置
    xs = w * 0.21  # 截取页面left
    xe = w * 0.79  # 截取页面right
    ys = 0
    ye = h
    # -----------------------------------------------------------------------------
    # 页面剪切 页面四个顶点，位置需要输出自己调整
    for index in range(count):
        pageObj = pdfReader.getPage(index)
        pageObj.mediaBox.uppderLeft = (xs, ye)
        pageObj.mediaBox.uppderRight = (xe, ye)
        pageObj.mediaBox.lowerLeft = (xs, ys)
        pageObj.mediaBox.lowerRight = (xe, ys)
        pdfWriter.addPage(pageObj)
    # -----------------------------------------------------------------------------
    # 添加书签
    pg_marks = {}
    for index in range(1, len(page_marks) + 1):
        print(page_marks[index])
        (pt_index, pgnum, pgtitle, bktyp) = page_marks[index]
        if pt_index == 0:
            # 添加书签，建书签索引
            # pg_marks[index] = pdfWriter.addBookmark(title=pgtitle, pagenum=pgnum, fit=bktyp)
            pg_marks[index] = pdfWriter.addBookmark(title=pgtitle, pagenum=pgnum)
        else:
            # 存在父节点，书签定向到父节点下面
            pts = pg_marks[pt_index]
            # pg_marks[index] = pdfWriter.addBookmark(title=pgtitle, pagenum=pgnum, parent=pts, fit=bktyp)
            pg_marks[index] = pdfWriter.addBookmark(title=pgtitle, pagenum=pgnum, parent=pts)
    # -----------------------------------------------------------------------------
    # 写入文件
    pdfWriter.write(open(r'C:\Users\yaqiang.li\Desktop\321.pdf', 'wb'))

    pdfFile.close()