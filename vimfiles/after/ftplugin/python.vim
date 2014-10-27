
setlocal textwidth=80
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4        "オートインデントの幅
setlocal softtabstop=4       "インデントをスペース4つ分に設定
setlocal expandtab

iab <buffer> code # -*- coding:utf-8 -*-<CR>
iab <buffer> pypath # !/usr/bin/env Python<CR>

"python sys.pathを set pathで追加
python << EOF
import os
import sys
import vim

sys.path.append('~/.local/lib/python2.6/site-packages')
sys.path.append('~/.local/lib/python2.7/site-packages')
sys.path.append('~/.local/lib/python3.3/site-packages')
sys.path.append('~/.local/lib/python3.4/site-packages')

for p in sys.path:
    # Add each directory in sys.path, if it exists.
    if os.path.isdir(p):
        # Command 'set' needs backslash before each space.
        vim.command(r"setlocal path+=%s" % (p.replace(" ", r"\ ")))
EOF

