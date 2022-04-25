Read("character.g");

################################
###   Monoid Cartan matrix   ###
################################

MonoidCartanMatrix := function(S)
  local C, M;

  C := MonoidCharacterTable(S);
  M := RegularRepresentationBiCharacter(S);

  return Inverse(TransposedMatMutable(C)) * M * Inverse(C);
end;
