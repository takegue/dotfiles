
setlocal nowrap
setlocal textwidth=79
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4        "オートインデントの幅
setlocal softtabstop=4       "インデントをスペース4つ分に設定
setlocal expandtab
setlocal nowrap


iab <buffer> code # -*- coding:utf-8 -*-<CR>
iab <buffer> pypath #!/usr/bin/env python<CR>
inoremap """ """<CR>"""<Up>
inoremap ''' '''<CR>'''<Up>
iab <buffer> ### ###############################################################################

"TODO:ローカル(.local/path/to/python)も追加する
"python sys.pathを set pathで追加
python << EOF
import os
import sys
import vim

sys.path.append('~/.local/lib/python{}.{}/site-packages'.format(
                            sys.version_info.major, 
                            sys.version_info.minor))
# Add each directory in sys.path, if it exists.
for p in sys.path:
# Add each directory in sys.path, if it exists.
    if os.path.isdir(p):
# Command 'set' needs backslash before each space.
        vim.command(r"setlocal path+=%s" % (p.replace(" ", r"\ ")))
EOF

