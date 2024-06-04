##################################################
###   Character-equivalence representatives    ###
##################################################

InstallMethod(TransversalIdempotents, "for a semigroup",
[IsSemigroup],
function(S)
  local out;

  out := List(List(RegularDClasses(S), GroupHClass), MultiplicativeNeutralElement);

  SetTransversalIdempotents(S,out);

  return out;
end);

InstallMethod(GeneralisedConjugacyClassesRepresentatives, "for a semigroup",
[IsSemigroup],
function(S)
  local D, out, C, map;

  D := List(RegularDClasses(S), GroupHClass);
  D := List(D, IsomorphismPermGroup);
  out := [];
  for map in D do
    C := List(ConjugacyClasses(CharacterTable(Range(map))), Representative);
    # Ugly fix: ensures that the conjugacy classes are computed 
    # in the same order each time. Also ensures the conjugacy classes of the 
    # group and the charater table are in the same order.
    map := InverseGeneralMapping(map);
    C := List(C, x -> x ^ map);
    Append(out, C);
  od;

  SetGeneralisedConjugacyClassesRepresentatives(S, out);

  return out;
end);

InstallMethod(DClassBicharacter, "for a D class",
[IsGreensDClass],
function(D)
  local S, C, G, cardG, CG, cG, cS, d, 
        l_mults, lp_mults, l, lp, r_mults, rp_mults, r, rp,
        LRec, RRec, h, k, i, j, g, pos, Diag;

  S   := ParentAttr(D);
  C   := GeneralisedConjugacyClassesRepresentatives(S);
  G   := SchutzenbergerGroup(D);
  cardG := Size(G);
  CG  := ConjugacyClasses(G);
  cG  := Length(CG);
  cS  := Length(C);

  d   := Representative(D);

  l_mults  := List(HClassReps(LClass(S, d)), h -> LeftGreensMultiplierNC(S, d, h));
  lp_mults := List(HClassReps(LClass(S, d)), h -> LeftGreensMultiplierNC(S, h, d));
  r_mults  := List(HClassReps(RClass(S, d)), h -> RightGreensMultiplierNC(S, d, h));
  rp_mults := List(HClassReps(RClass(S, d)), h -> RightGreensMultiplierNC(S, h, d));

  LRec := List([1..cS], x -> List([1..cG], x -> 0));

  for i in [1 .. cS] do
    h := C[i];
    for j in [1..Length(l_mults)] do
      l  := l_mults[j];
      lp := lp_mults[j];
      if h * l * d in RClass(S, l * d) then 
        g := Inverse(LambdaPerm(S)(d, lp * h * l * d));
        pos := Position(CG, ConjugacyClass(G, g));
        LRec[i][pos] := LRec[i][pos] + 1;
      fi;
    od;
  od;

  RRec := List([1..cG], x -> List([1..cS], x -> 0));

  for i in [1..cS] do
    k := C[i];
    for j in [1..Length(r_mults)] do
      r  := r_mults[j];
      rp := rp_mults[j];
      if d * r * k in LClass(S, d * r) then
        g   := LambdaPerm(S)(d, d * r * k * rp);
        pos := Position(CG, ConjugacyClass(G, g));
        RRec[pos][i] := RRec[pos][i] + 1;
      fi;
    od;
  od;
 
  Diag := DiagonalMat(List(CG, x -> cardG / Size(x)));
  SetDClassBicharacter(D,LRec * Diag * RRec);

  return LRec * Diag * RRec;
end);

InstallMethod(RegularRepresentationBicharacter, "for a semigroup",
[IsSemigroup],
function(S)
  local C, D, c, mat, i, j;

  C := GeneralisedConjugacyClassesRepresentatives(S);
  c := Length(C);
  mat := List([1 .. c], x -> List([1 .. c], x -> 0));

  for D in DClasses(S) do
    mat := mat + DClassBicharacter(D);
  od;

  SetRegularRepresentationBicharacter(S, mat);

  return mat;
end);