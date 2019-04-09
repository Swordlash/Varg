#!/bin/bash
rm *.hs
rm *.x
rm *.y
bnfc -m --haskell Varg.cf && bnfc --latex Varg.cf && happy -i ParVarg.y && alex LexVarg.x
cp AbsVarg.hs LexVarg.hs ParVarg.hs LayoutVarg.hs PrintVarg.hs ../Zad2/src
cp Varg.tex ../../../Aplikacje/Overleaf/Varg
