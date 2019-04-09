all:
	happy -gca ParVarg.y
	alex -g LexVarg.x
	ghc --make TestVarg.hs -o TestVarg

clean:
	-rm -f *.log *.aux *.hi *.o *.dvi

distclean: clean
	-rm -f DocVarg.* LexVarg.* ParVarg.* LayoutVarg.* SkelVarg.* PrintVarg.* TestVarg.* AbsVarg.* TestVarg ErrM.* SharedString.* ComposOp.* Varg.dtd XMLVarg.* Makefile*
	

