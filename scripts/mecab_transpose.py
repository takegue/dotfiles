#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import argparse

from itertools import chain,izip_longest


pos2label = {
    "フィラー" :"F",
    "副詞"     :"ADV",
    "助動詞"   :"ADVP",
    "助詞"     :"P",
    "動詞"     :"VB",
    "名詞"     :"N",
    "形容詞"   :"ADJ",
    "感動詞"   :"INTJ",
    "接続詞"   :"CONJ",
    "接頭詞"   :"PRE",
    "記号"     :"S",
    "連体詞"   :"N",
}


# buff = []
# for line in sys.stdin:
#     line = line.rstrip()
#     if not line: continue
#     if line.startswith('EOS'):
#         if not buff : continue
#         for words in izip_longest(*buff, fillvalue=''):
#             print ' '.join( pos2label[w] if w in pos2label else w for w in words)
#         buff = []
#         print 'EOS'
#         print
#         continue

#     cols = line.split()
#     buff.append(chain.from_iterable([ col.split(',') for col in cols ]))


buff = []
for line in sys.stdin:
    line = line.rstrip()
    if not line: continue
    if line.startswith('EOS'):
        if not buff : continue
        for words in buff:
            print '/'.join(list(words)[:9]),
        print
        buff = []
        continue


    cols = line.split()
    buff.append(chain.from_iterable([ col.split(',')[:3] for col in cols ]))
