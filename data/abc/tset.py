import base64
import os
#!/usr/bin/env python
#coding:utf-8

files = os.listdir(os.getcwd())
for filename in files:
    if filename is not "tset.py":
        data = open(filename).read()
        decode_data = base64.b64decode(data)
        print decode_data
    