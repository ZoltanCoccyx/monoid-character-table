# Fixed point counting and character table of finite monoid

System-gap experimental code with functions to compute
  - the bicharacter of L, R and D classes
  - the bicharacter of the regular representation of a finite monoid
  - the radical of an R-class of a finite monoid M as a <img src="https://render.githubusercontent.com/render/math?math=\mathbb{C}">M-mod
  - the bicharacter of this radical
  - the character table of <img src="https://render.githubusercontent.com/render/math?math=\mathbb{C}">M
  - the Cartan matrix of <img src="https://render.githubusercontent.com/render/math?math=\mathbb{C}">M

As of this commit, works on transformation, bipartition and partial permutation semigroups provided by the Gap package [semigroups](https://www.gap-system.org/Packages/semigroups.html).

## TODO:
  - [X] Clean up code 
  - [ ] Consistentely reorder the simple modules such that
      - [ ] The character table is block triangular
      - [ ] The Cartan matrix is unitriangular
  - [ ] Add LClass radical computation for coherence with [the proofs](https://arxiv.org/abs/2303.13647)
  - [ ] Change the Cartan and character table function to return labels of their rows and columns
  - [ ] Automate performance testing 
  - [ ] Add documentation
  - [ ] Add test using the naive sanity chack functions
  - [ ] Add examples
