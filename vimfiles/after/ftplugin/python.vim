
setlocal nowrap
setlocal textwidth=79
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4        "オートインデントの幅
setlocal softtabstop=4       "インデントをスペース4つ分に設定
setlocal expandtab
setlocal nowrap
setlocal tags+=$HOME/python.tags

iab <buffer> code # -*- coding:utf-8 -*-<CR>
iab <buffer> pypath #!/usr/bin/env python<CR>
inoremap """ """<CR>"""<Up>
inoremap ''' '''<CR>'''<Up>

"TODO:ローカル(.local/path/to/python)も追加する
"python sys.pathを set pathで追加
python << EOF
import os
import sys
import vim

ver = sys.version_info
fmt = '~/.local/lib/python{major}.{minor}/site-packages'
sys.path.append(fmt.format(major=ver.major, minor=ver.minor))

for p in sys.path:
# Add each directory in sys.path, if it exists.
    if os.path.isdir(p):
# Command 'set' needs backslash before each space.
        vim.command(r"setlocal path+=%s" % (p.replace(" ", r"\ ")))
EOF

