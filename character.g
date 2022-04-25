Read("fixed_points.g");

####################################################
###   Computing a basis of the L-class radical   ###
####################################################

LClassRadical := function(S, e)
   local D, H, ord, map, HH, LHH, deg, invmap,
         l_transitions, nl, r_transitions, nr,
         l_ref_to_goal, l_goal_to_ref, r_ref_to_goal,
         M, Rad, c, j, r, k, i, l, x;

   D   := DClass(S, e);
   H   := HClass(S, e);
   ord := Number(H);
   map := IsomorphismPermGroup(H);
   HH  := Range(map);
   LHH := List(HH);
   deg := DegreeOfTransformationSemigroup(S);
   invmap := InverseGeneralMapping(map);

   l_transitions := LTransitions(S, D, H);
   nl            := Length(l_transitions) / 2;
   l_ref_to_goal := List([1..nl], i -> e * l_transitions[2*i-1]);
   l_goal_to_ref := List([1..nl], i -> l_transitions[2*i] * e);

   r_transitions := RTransitions(S, D, H);
   nr := Length(r_transitions) / 2;
   r_ref_to_goal := List([1..nr], i -> r_transitions[2*i-1] * e);

   M := List([1 .. ord * nr], x -> List([1 .. ord * nl], x -> 0));

   c := 0;
   for k in H do
     for i in [1 .. nr] do
       r := r_ref_to_goal[i];
       for j in [1 .. nl] do
         l  := l_ref_to_goal[j];
         if (l * r) in H then
           x := (k ^ map) * ((l * r) ^ map) ^ (-1);
           M[i + nr * c][(j - 1) * ord + Position(LHH, x)] := 1;
         fi;
       od;
     od;
     c := c + 1;
   od;

   Rad := NullspaceMat(TransposedMatMutable(M));
   l_ref_to_goal := List([1..nl], i -> e * l_transitions[2*i-1]);
   l_goal_to_ref := List([1..nl], i -> l_transitions[2*i] * e);

   return rec( rad := Rad, 
   	       transitions := l_ref_to_goal,
               returns := l_goal_to_ref, 
               HList := LHH, 
               morph := map);
end;

############################################################
###   Computing the bicharacter of the L-class radical   ###
############################################################

LClassRadicalBicharacter := function(S, e)
  local Rec, Rad, LHH, map, l_transitions, l_returns,
        ListLClass, n, H, ord, B, dim,
        RepS, ns, RepG, ng, mat,
        h, k, chi, ind_r, r, row, i, coeff,
        ind_transition, ind_groupe, x, lp, g, ind_l_class;

  Rec := LClassRadical(S, e);
  Rad := Rec.rad;
  LHH := Rec.HList;
  map := Rec.morph;
  l_transitions := Rec.transitions;
  l_returns     := Rec.returns;
  
  ListLClass    := List(l_transitions, l -> LClass(S, e * l)); 
  
  if Length(Rad) = 0 then
    Rad := [[0]];
  fi;
  n    := Length(Rad[1]);
  H    := HClass(S, e);
  ord  := Length(LHH);
  B    := Basis(VectorSpace(Rationals, Rad));
  dim  := Length(B);

  RepS := SConjugacyClassReps(S);
  ns   := Length(RepS);
  RepG := DConjugacyClassReps(S, DClass(S, e));
  ng   := Length(RepG);

  mat  := List([1 .. ng], x -> List([1 .. ns], x -> 0));

  for h in RepS do
    for k in RepG do
      chi := 0;

      # Computing the contribution to the trace of each basis vector
      for ind_r in [1 .. dim] do
        r   := B[ind_r];
        row := List([1 .. n], x-> 0);

        # Computing the image of the vector
        for i in [1 .. n] do
          coeff := r[i];
          # Les listes commencent à 1 bleurk
          ind_transition := QuoInt(i - 1, ord) + 1;
          ind_groupe := RemInt(i - 1, ord) + 1;
          x := k * LHH[ind_groupe] * l_transitions[ind_transition] * h;
          ind_transition := Position(ListLClass, LClass(S, x));
          if not ind_transition = fail then
            lp := l_returns[ind_transition];
            #Print(e, x, lp, e*x*lp, Representative(H), "\n\n");
            g  := (e * x * lp) ^ map;
            ind_groupe  := Position(LHH, g);
            ind_l_class := (ind_transition - 1) * ord + ind_groupe;
            row[ind_l_class] := row[ind_l_class] + coeff;
          fi;
        od;
        chi := chi + Coefficients(B, row)[ind_r];
      od;
      mat[Position(RepG, k)][Position(RepS, h)] := chi;
    od;
  od;

  return mat;
end;

ConcatenatedLClassRadicalBicharacters := function(S)
  local idempotents, e, M;

  idempotents := TransversalIdempotents(S);
  M           := [];
  for e in idempotents do
    M := Concatenation(M, LClassRadicalBicharacter(S, e));
  od;

  return M;
end;

############################
###   Character Table    ###
############################

###   Group Character Tables

DiagonalOfCharacterTables := function(S)
  local C, n, M, idempotents, maps, map, XG, CG, h, k,
  	b, e, G, I, l, i, j;

  C := SConjugacyClassReps(S);
  n := Length(C);
  M := List([1..n], x -> List([1..n], x -> 0));
  idempotents := TransversalIdempotents(S);

  maps := List(RegularDClasses(S), GroupHClass);
  maps := List(maps, IsomorphismPermGroup);

  b := 0;
  for map in maps do
    G := Range(map);
    XG := CharacterTable(G);
    I  := Irr(XG);
    CG := ConjugacyClasses(XG);
    l  := Length(I);
    for i in [1..l] do
      h := ConjugacyClass(G, C[i+b] ^ map);
      for j in [1..l] do
        k := ConjugacyClass(G, C[j+b] ^ map);
        M[i+b][j+b] := I[Position(CG, h)][Position(CG, k)];
      od;
    od;
    b := b + l;
  od;

  return M;
end;

###   Monoid Character Table

MonoidCharacterTable := function(S)
  local L, R, D;

  L := ConcatenatedLClassBicharacters(S);
  R := ConcatenatedLClassRadicalBicharacters(S);
  D := DiagonalOfCharacterTables(S);

  return Inverse(TransposedMatMutable(D)) * (L - R);
end;
