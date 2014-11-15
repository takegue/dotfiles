
setlocal nowrap
setlocal textwidth=0
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4        "オートインデントの幅
setlocal softtabstop=4       "インデントをスペース4つ分に設定
setlocal expandtab

iab <buffer> code # -*- coding:utf-8 -*-<CR>
iab <buffer> pypath # !/usr/bin/env Python<CR>
inoremap """ """<CR>"""<Up>

"TODO:ローカル(.local/path/to/python)も追加する
"python sys.pathを set pathで追加
python << EOF
import os
import sys
import vim
for p in sys.path:
    # Add each directory in sys.path, if it exists.
    if os.path.isdir(p):
        # Command 'set' needs backslash before each space.
        vim.command(r"setlocal path+=%s" % (p.replace(" ", r"\ ")))
EOF

