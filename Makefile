all: configure build install

configure:
	cabal new-configure --symlink-bindir=.

build:
	cabal new-build

install:
	cabal new-install exe:Varg

clean:
	cabal new-clean
