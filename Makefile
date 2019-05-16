configure: 
  cabal new-configure

build: 
  cabal new-build

install: 
  cabal new-install exe:Varg

all : configure build install

clean : 
  cabal new-clean
