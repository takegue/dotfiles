#!/usr/bin/env perl
$latex            = 'uplatex -synctex=1 -kanji=utf8 -halt-on-error';
$latex_silent     = 'uplatex -synctex=1 -kanji=utf8 -halt-on-error -interaction=batchmode';
$bibtex           = 'pbibtex -kanji=utf8';
$dvipdf           = 'dvipdfmx %O -o %D %S';
$dvips            = 'dvips %O -o %D %S';
$ps2pdf           = 'ps2pdf   %O %S %D';
$makeindex        = 'mendex %O -o %D %S';
$max_repeat       = 5;
$pdf_mode	  = 3; # generates pdf via dvipdfmx

# Prevent latexmk from removing PDF after typeset.
# This enables Skim to chase the update in PDF automatically.
# $pvc_view_file_via_temporary = 3;

# Use Skim as a previewer
