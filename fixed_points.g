LoadPackage("semigroups");

##################################################
###   Character-equivalence representatives    ###
##################################################

TransversalIdempotents := function(S)
  return List(List(RegularDClasses(S), GroupHClass), MultiplicativeNeutralElement);
end;

SConjugacyClassReps := function(S)
  local D, out, C, map, Conj, Dom;

  D := List(RegularDClasses(S), GroupHClass);
  D := List(D, IsomorphismPermGroup);
  out := [];
  for map in D do
    C := List(ConjugacyClasses(CharacterTable(Range(map))), Representative);
    map := InverseGeneralMapping(map);
    C := List(C, x -> x ^ map);
    Append(out, C);
  od;
  return out;
end;

DConjugacyClassReps := function(S, D)
  # Note: D must be regular.
  local H, HH, out, C, map;

  H   := GroupHClass(D);
  map := IsomorphismPermGroup(H);
  HH  := Range(map);
  map := InverseGeneralMapping(map);
  C   := List(ConjugacyClasses(HH), Representative);
  C   := List(C, x -> x ^ map);

  return C;
end;

###################
### Green Pairs ###
###################

LTransitions := function(S, D, H)
  local deg, x, targets, transitions, y, l, lp, k;

  deg     := DegreeOfTransformationSemigroup(S);
  x       := ImageListOfTransformation(Representative(H));
  x       := Concatenation(x, [Length(x)+1..deg]);
  targets := List(HClasses(RClass(H)), Representative);
  transitions := [];

  for y in targets do
    y := ImageListOfTransformation(y);
    y := Concatenation(y, [Length(y)+1..deg]);
    l := ListWithIdenticalEntries(deg, x[1]);
    lp := ListWithIdenticalEntries(deg, y[1]);
    for k in [1..deg] do
      l[x[k]] := y[k];
      lp[y[k]] := x[k];
    od;
    Append(transitions, [Transformation(l), Transformation(lp)]);
  od;

  return transitions;
end;

RTransitions := function(S, D, H)
  local deg, x, targets, transitions, y, r, rp, k;

  deg     := DegreeOfTransformationSemigroup(S);
  x       := ImageListOfTransformation(Representative(H));
  x       := Concatenation(x, [Length(x)+1..deg]);
  targets := List(HClasses(LClass(H)), Representative);
  transitions := [];

  for y in targets do
    r := List([1..deg], x -> 1);
    rp := List([1..deg], x -> 1);
    y := ImageListOfTransformation(y);
    y := Concatenation(y, [Length(y)+1..deg]);
    for k in [1..deg] do
      r[k] := Position(x, y[k]);
      rp[k] := Position(y, x[k]);
    od;
    Append(transitions, [Transformation(r), Transformation(rp)]);
  od;

  return transitions;
end;

#############################
###   L-class character   ###
#############################

# TODO : Rewrite using the Green pair functions

LClassBicharacter := function(S, e, RepS)
  local D, H, map, HH, deg, im_e, l_e_box,
        l_mults, l_to_first, l_from_first, l_transitions, l_returns,
        ns, RepG, ng, M, a, g, b, s, ind, l, lp, x, y;

  D   := DClass(S, e);
  H   := HClass(S, e);
  map := IsomorphismPermGroup(H);
  HH  := Range(map);
  deg := DegreeOfTransformationSemigroup(S);

  im_e    := ImageSetOfTransformation(e, deg);
  l_e_box := Position(LambdaOrb(D), im_e);

  l_mults       := LambdaOrbMults(LambdaOrb(D), LambdaOrbSCCIndex(D));
  l_to_first    := l_mults[l_e_box][2];
  l_from_first  := l_mults[l_e_box][1];
  l_transitions := List(LambdaOrbSCC(D), i -> e * l_to_first * l_mults[i][1]);
  l_returns     := List(LambdaOrbSCC(D), i -> l_mults[i][2] * l_from_first * e);

  ns   := Length(RepS);
  RepG := Filtered(RepS, x -> x in DClass(S, e));;
  ng   := Length(RepG);
  M    := List([1 .. ng], x -> List([1 .. ns], x -> 0));

  for a in [1 .. ng] do
    g := RepG[a];
    for b in [1 .. ns] do
      s := RepS[b];
      for ind in [1 .. Length(l_transitions)] do
        l  := l_transitions[ind];
        lp := l_returns[ind];
        x := g * e * l * s;
        if x in HClass(S, e * l) then
          y := Inverse((l * s * lp)^map);
          if ConjugacyClass(HH, g^map) = ConjugacyClass(HH, y) then
            M[a][b] := M[a][b] + CentralizerOrder(HH, g^map);
          fi;
        fi;
      od;
    od;
  od;

  return M;
end;

ConcatenatedLClassBicharacters := function(S)
  local idempotents, M, RepS, e;

  M           := [];
  RepS        := SConjugacyClassReps(S);
  idempotents := TransversalIdempotents(S);

  for e in idempotents do
    M := Concatenation(M, LClassBicharacter(S, e, RepS));
  od;

  return M;
end;


###############################################
###   Regular representation Bicharacter    ###
###############################################

DClassBicharacter := function(S, D, ConjList)
  local G, cardG, CG, cG,
        d, H, L, R, cS, deg, l_transitions, nl, r_transitions, nr, M,
        LRec, RRec, i, k, j, l, lp, g, pos, h, r, rp, Diag;

  G   := SchutzenbergerGroup(D);
  cardG := Size(G);
  CG  := ConjugacyClasses(G);
  cG  := Length(CG);

  d   := Representative(D);
  H   := HClass(S, d);
  L   := LClass(S, d);
  R   := RClass(S, d);
  cS  := Length(ConjList);
  deg := DegreeOfTransformationSemigroup(S);

  l_transitions := LTransitions(S, D, H);
  nl            := Length(l_transitions) / 2;
  r_transitions := RTransitions(S, D, H);
  nr            := Length(r_transitions) / 2;

  M   := List([1 .. cS], x -> List([1 .. cS], x -> 0));

  LRec := List([1..cG], x -> List([1..cS], x -> 0));

  for i in [1..cS] do
    k  := ConjList[i];
    for j in [1..nl] do
      l  := l_transitions[2*j-1];
      lp := l_transitions[2*j];
      if d * l * k in LClass(S, d * l) then
        g   := LambdaPerm(S)(d, d * l * k * lp);
        pos := Position(CG, ConjugacyClass(G, g));
        LRec[pos][i] := LRec[pos][i] + 1;
      fi;
    od;
  od;

  RRec := List([1..cS], x -> List([1..cG], x -> 0));

  for i in [1 .. cS] do
    h := ConjList[i];
    for j in [1..nr] do
      r  := r_transitions[2*j-1];
      rp := r_transitions[2*j];
      if h * r * d in RClass(S, r * d) then # Implies k in kernel stabiliser
        g     := Inverse(LambdaPerm(S)(d, rp * h * r * d));
        pos   := Position(CG, ConjugacyClass(G, g));
        RRec[i][pos] := RRec[i][pos] + 1;
      fi;
    od;

  od;

  Diag := DiagonalMat(List(CG, x -> cardG / Size(x)));
  return RRec * Diag * LRec;
end;

### Regular representation Bicharacter
# DClass bicharacter iterated over all Dclasses of S.

RegularRepresentationBiCharacter := function(S)
  local C, D, DD, n, mat, i, j;

  C := SConjugacyClassReps(S);
  n := Length(C);
  DD := DClasses(S);
  mat := List([1 .. n], x -> List([1 .. n], x -> 0));

  for D in DD do
    mat := mat + DClassBicharacter(S, D, C);
  od;

  return mat;
end;

# To compare, simple fixed point counting
DClassBicharacterNaive := function(S, D, C)
  local c, M, a, h, b, k, s;

  c   := Length(C);
  M   := List([1 .. c], x -> List([1 .. c], x -> 0));

  for a in [1 .. c] do
    h := C[a];
    for b in [1 .. c] do
      k := C[b];

      M[a][b] := Number(D, x -> h * x * k = x);
    od;
  od;

  return M;
end;

RegularRepresentationBicharacterNaive := function(S)
  local C, n, mat, D, DD;

  C   := SConjugacyClassReps(S);
  n   := Length(C);
  mat := List([1 .. n], x -> List([1 .. n], x -> 0));
  DD  := DClasses(S);

  for D in DD do
    mat := mat + DClassBicharacterNaive(S, D, C);
  od;

  return mat;
end;
