#!/usr/bin/env perl
$latex            = 'platex -synctex=1  -halt-on-error';
$latex_silent     = 'platex  -synctex=1  -halt-on-error -interaction=batchmode';
$bibtex           = 'pbibtex';
$dvipdf           = 'dvipdfmx -p a4 -x 1in -y 1in %O -o %D %S';
$dvips            = 'dvips %O -o %D %S';
$pdflatex         = 'lualatex -synctex=1 -halt-on-error -interaction=nonstopmode';
$ps2pdf           = 'ps2pdf   %O %S %D';
$makeindex        = 'mendex %O -o %D %S';
$max_repeat       = 5;
$pdf_mode         = 3; 

# Prevent latexmk from removing PDF after typeset.
# This enables Skim to chase the update in PDF automatically.
# $pvc_view_file_via_temporary = 3;

# Use Skim as a previewer
