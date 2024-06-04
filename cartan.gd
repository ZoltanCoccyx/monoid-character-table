

DeclareCategory("IsMonoidCartanMatrix", IsObject);


DeclareOperation("MonoidCartanMatrix", [IsMonoid]);
DeclareOperation("MonoidCartanMatrix", [IsMonoid, IsField]);


DeclareAttribute("MonoidOfMonoidCartanMatrix", IsMonoidCartanMatrix);
DeclareAttribute("FieldOfMonoidCartanMatrix", IsMonoidCartanMatrix);
DeclareAttribute("MatrixOfMonoidCartanMatrix", IsMonoidCartanMatrix);
