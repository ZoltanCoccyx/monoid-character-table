
BindGlobal("MonoidCartanMatrixType",
NewType(NewFamily("MonoidCartanMatrixFamily"),
        IsMonoidCartanMatrix and
        IsAttributeStoringRep));

InstallMethod(MonoidCartanMatrix, "for a monoid",
[IsMonoid],
function(M)
  # Your code here
  return MonoidCartanMatrix(M, SplittingField(M));
end);

InstallMethod(MonoidCartanMatrix, "for a monoid and a field",
[IsMonoid, IsField],
function(M, F)
  local result;

  # Your code here
  result := Objectify(MonoidCartanMatrixType, rec());
  SetMonoidOfMonoidCartanMatrix(result, M);
  SetFieldOfMonoidCartanMatrix(result, F);
  return result;
end);

InstallMethod(ViewString, "for a monoid Cartan matrix",
[IsMonoidCartanMatrix],
function(mat)
  return StringFormatted("<Cartan matrix over monoid {} and field {}>",
  MonoidOfMonoidCartanMatrix(mat),
  FieldOfMonoidCartanMatrix(mat));
end);
