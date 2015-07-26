" =============================================================================
" Filename: autoload/lightline/colorscheme/autoload/lightline/colorscheme/papercolor_light.vim
" Author: TKNGUE
" License: MIT License
" Last Change: 2015/07/21 13:18:03
" =============================================================================

fun! <SID>grey_number(x) "{{{
    if &t_Co == 88
      if a:x < 23
        return 0
      elseif a:x < 69
        return 1
      elseif a:x < 103
        return 2
      elseif a:x < 127
        return 3
      elseif a:x < 150
        return 4
      elseif a:x < 173
        return 5
      elseif a:x < 196
        return 6
      elseif a:x < 219
        return 7
      elseif a:x < 243
        return 8
      else
        return 9
      endif
    else
      if a:x < 14
        return 0
      else
        let l:n = (a:x - 8) / 10
        let l:m = (a:x - 8) % 10
        if l:m < 5
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun"}}}

  " Returns the actual grey level represented by the grey index
  fun! <SID>grey_level(n)"{{{
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 46
      elseif a:n == 2
        return 92
      elseif a:n == 3
        return 115
      elseif a:n == 4
        return 139
      elseif a:n == 5
        return 162
      elseif a:n == 6
        return 185
      elseif a:n == 7
        return 208
      elseif a:n == 8
        return 231
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 8 + (a:n * 10)
      endif
    endif
  endfun"}}}

  " Returns the palette index for the given grey index
  fun! <SID>grey_colour(n)"{{{
    if &t_Co == 88
      if a:n == 0
        return 16
      elseif a:n == 9
        return 79
      else
        return 79 + a:n
      endif
    else
      if a:n == 0
        return 16
      elseif a:n == 25
        return 231
      else
        return 231 + a:n
      endif
    endif
  endfun"}}}

  " Returns an approximate colour index for the given colour level
  fun! <SID>rgb_number(x)"{{{
    if &t_Co == 88
      if a:x < 69
        return 0
      elseif a:x < 172
        return 1
      elseif a:x < 230
        return 2
      else
        return 3
      endif
    else
      if a:x < 75
        return 0
      else
        let l:n = (a:x - 55) / 40
        let l:m = (a:x - 55) % 40
        if l:m < 20
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun"}}}

  " Returns the actual colour level for the given colour index
  fun! <SID>rgb_level(n)"{{{
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 139
      elseif a:n == 2
        return 205
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 55 + (a:n * 40)
      endif
    endif
  endfun"}}}

  " Returns the palette index for the given R/G/B colour indices
  fun! <SID>rgb_colour(x, y, z)"{{{
    if &t_Co == 88
      return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
      return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
  endfun"}}}

  " Returns the palette index to approximate the given R/G/B colour levels
  fun! <SID>colour(r, g, b)"{{{
    " Get the closest grey
    let l:gx = <SID>grey_number(a:r)
    let l:gy = <SID>grey_number(a:g)
    let l:gz = <SID>grey_number(a:b)

    " Get the closest colour
    let l:x = <SID>rgb_number(a:r)
    let l:y = <SID>rgb_number(a:g)
    let l:z = <SID>rgb_number(a:b)

    if l:gx == l:gy && l:gy == l:gz
      " There are two possibilities
      let l:dgr = <SID>grey_level(l:gx) - a:r
      let l:dgg = <SID>grey_level(l:gy) - a:g
      let l:dgb = <SID>grey_level(l:gz) - a:b
      let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
      let l:dr = <SID>rgb_level(l:gx) - a:r
      let l:dg = <SID>rgb_level(l:gy) - a:g
      let l:db = <SID>rgb_level(l:gz) - a:b
      let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
      if l:dgrey < l:drgb
        " Use the grey
        return <SID>grey_colour(l:gx)
      else
        " Use the colour
        return <SID>rgb_colour(l:x, l:y, l:z)
      endif
    else
      " Only one possibility
      return <SID>rgb_colour(l:x, l:y, l:z)
    endif
  endfun"}}}

  " Returns the palette index to approximate the '#rrggbb' hex string
  fun! <SID>rgb(rgb)"{{{
    let l:r = ("0x" . strpart(a:rgb, 1, 2)) + 0
    let l:g = ("0x" . strpart(a:rgb, 3, 2)) + 0
    let l:b = ("0x" . strpart(a:rgb, 5, 2)) + 0

    return <SID>colour(l:r, l:g, l:b)
  endfun"}}}

 fun! <SID>X(color)"{{{
   return [a:color, <SID>rgb(a:color)]
 endfun"}}}

let s:red     = <SID>X("#df0000")       "Include/Exception
let s:green   = <SID>X("#008700")       "Boolean/Special
let s:blue    = <SID>X("#4271ae")       "Keyword

let s:pink    = <SID>X("#d7005f")       "Type
let s:olive   = <SID>X("#718c00")       "String
let s:navy    = <SID>X("#005f87")       "StorageClass

let s:orange  = <SID>X("#d75f00")       "Number
let s:purple  = <SID>X("#8959a8")       "Repeat/Conditional
let s:aqua    = <SID>X("#3e999f")       "Operator/Delimiter


" Basics:
let s:foreground          = <SID>X('#f8f8f2')
let s:background          = <SID>X("#1b1d1e")
let s:mid_fg              = <SID>X('#f8f8f2')
let s:mid_bg              = <SID>X("#232526")
let s:status              = <SID>X("#1b1d1e")
let s:background_inactive = <SID>X('#080808')
let s:foreground_inactive = <SID>X('#808080 ')

" Tabline:
let s:tabline_active_fg   = <SID>X('#1b1d1e')
let s:tabline_active_bg   = <SID>X("#e6db74")
let s:tabline_inactive_fg = s:foreground_inactive
let s:tabline_inactive_bg = s:background_inactive
let s:tabline_bg          = s:status

let s:normal_fg = <SID>X("#000000")
let s:normal_bg = <SID>X("#e6db74")

let s:insert_fg = <SID>X("#000000")
let s:insert_bg = <SID>X("#66D9EF")

let s:visual_fg = <SID>X("#000000")
let s:visual_bg = <SID>X("#fd971f")

let s:replace_fg = <SID>X("#000000")
let s:replace_bg = <SID>X("#F92672")

let s:window       = <SID>X("#efefef")
let s:error        = <SID>X("#F92672")
let s:warning_bg   = <SID>X("#333333")
let s:warning_fg   = <SID>X("#FFFFFF")

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}, }
let s:p.normal.left       = [ [ s:normal_fg, s:normal_bg ], [ s:mid_fg, s:mid_bg ], [ s:foreground, s:background ] ]
let s:p.normal.right      = [ [ s:normal_fg, s:normal_bg ], [ s:foreground, s:background ], [ s:foreground, s:background ] ]
let s:p.normal.middle     = [ [ s:normal_fg, s:normal_bg ] ]
let s:p.inactive.right    = [ [ s:foreground_inactive, s:background_inactive  ]]
let s:p.inactive.left     = [ [ s:foreground_inactive, s:background_inactive ]]
let s:p.inactive.middle   = [ [ s:foreground_inactive, s:background_inactive ]]

" Mode:
let s:p.insert.left    = [ [s:insert_fg  , s:insert_bg]  , [ s:mid_fg, s:mid_bg ], [ s:foreground, s:background ] ]
let s:p.replace.left   = [ [ s:replace_fg, s:replace_bg ], [ s:mid_fg, s:mid_bg ], [ s:foreground, s:background ] ]
let s:p.visual.left    = [ [ s:visual_fg , s:visual_bg ] , [ s:mid_fg, s:mid_bg ], [ s:foreground, s:background ] ]
let s:p.insert.middle  = [ [s:insert_fg, s:insert_bg]]
let s:p.replace.middle = [ [ s:replace_fg, s:replace_bg ]]
let s:p.visual.middle  = [ [ s:visual_fg, s:visual_bg ]]
let s:p.insert.right    = copy(s:p.insert.left)
let s:p.replace.right   = copy(s:p.replace.left)
let s:p.visual.right    = copy(s:p.visual.left)

let s:p.tabline.left      = [ [s:tabline_inactive_fg, s:tabline_inactive_bg ]]
let s:p.tabline.tabsel    = [ [s:tabline_active_fg, s:tabline_active_bg ] ]
let s:p.tabline.middle    = [ [s:tabline_bg, s:tabline_bg]]
let s:p.tabline.right   = copy(s:p.normal.right)
let s:p.normal.error    = [ [ s:background, s:error ] ]
let s:p.normal.warning  = [ [ s:warning_fg, s:warning_bg] ]

let lightline#colorscheme#my_colorscheme#palette = lightline#colorscheme#flatten(s:p)

