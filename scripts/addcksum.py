# -*- coding: utf-8 -*-
# @Author: yaqiang.li
# @Date:   2022-04-15 20:24:02
# @Last Modified by:   yaqiang.li
# @Last Modified time: 2022-04-15 20:27:50

import os
import struct
import sys
import traceback

def addCheckSum(filename):
    file_object = open(filename, 'rb')
    file_content = file_object.read()
    file_object.close()

    sum = 0
    for c in file_content:
        if isinstance(c, int):
            sum += c
        else:
            sum += ord(c)
    return sum

if __name__ == '__main__':
    sum = addCheckSum(sys.argv[1])
    print(sum)
    print('sum: 0x%x'%sum)