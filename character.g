Read("fixed_points.g");

####################################################
###   Computing a basis of the R-class radical   ###
####################################################

RClassRadical := function(S, e)
  local D, H, ord, map, HH, LHH, invmap, 
        l_mults, r_mults, rp_mults, nl, nr,
        M, Rad, c, j, r, k, i, l, x;

  D   := DClass(S, e);
  H   := HClass(S, e);
  ord := Size(H);
  map := IsomorphismPermGroup(H);
  HH  := Range(map);
  LHH := List(HH);
  invmap := InverseGeneralMapping(map);

  l_mults  := List(HClassReps(LClass(S, e)), h -> LeftGreensMultiplierNC(S, e, h) * e);
  r_mults  := List(HClassReps(RClass(S, e)), h -> e * RightGreensMultiplierNC(S, e, h));
  rp_mults := List(HClassReps(RClass(S, e)), h -> RightGreensMultiplierNC(S, h, e) * e);
  nl := Length(l_mults);
  nr := Length(r_mults);

  M := List([1 .. ord * nl], x -> List([1 .. ord * nr], x -> 0));

  c := 0;
  for k in H do
    for i in [1 .. nl] do
      l := l_mults[i];
      for j in [1 .. nr] do
        r  := r_mults[j];
        if (r * l) in H then
          x := (k ^ map) * ((r * l) ^ map) ^ (-1);
          M[i + nl * c][(j - 1) * ord + Position(LHH, x)] := 1;
        fi;
      od;
    od;
    c := c + 1;
  od;
  
  Rad := NullspaceMat(TransposedMatMutable(M));

  return rec( rad := Rad, 
          transitions := r_mults,
              returns := rp_mults, 
              HList := LHH, 
              morph := map);
end;

############################################################
###   Computing the bicharacter of the R-class radical   ###
############################################################

RClassRadicalBicharacter := function(S, e)
  local Rec, Rad, LHH, map, r_mults, rp_mults,
        ListLClass, n, H, ord, B, dim,
        CS, cS, CG, cG, mat, compt,
        h, k, chi, ind_r, r, row, i, coeff,
        ind_transition, ind_groupe, x, lp, g, ind_l_class;

  Rec := RClassRadical(S, e);
  Rad := Rec.rad;
  LHH := Rec.HList;
  map := Rec.morph;
  r_mults  := Rec.transitions;
  rp_mults := Rec.returns;
  
  ListLClass := List(r_mults, r -> LClass(S, e * r)); 
  
  if Length(Rad) = 0 then
    Rad := [[0]];
  fi;
  n    := Length(Rad[1]);
  H    := HClass(S, e);
  ord  := Length(LHH);
  B    := Basis(VectorSpace(Rationals, Rad));
  dim  := Length(B);

  CS   := SConjugacyClassReps(S);
  cS   := Length(CS);
  CG   := Filtered(CS, x -> x in HClass(S, e));;
  cG   := Length(CG);

  mat  := List([1 .. cG], x -> List([1 .. cS], x -> 0));

  for h in CS do
    for k in CG do
      chi := 0;

      # Computing the contribution to the trace of each basis vector
      for ind_r in [1 .. dim] do
        r   := B[ind_r];
        row := List([1 .. n], x-> 0);
        compt := 0;
        # Computing the image of the vector
        for i in [1 .. n] do
          coeff := r[i];
          if coeff = 0 then continue; fi;
          #Print(r, "\n");
          ind_transition := QuoInt(i - 1, ord) + 1;
          ind_groupe := RemInt(i - 1, ord) + 1;
          x := k * LHH[ind_groupe] * r_mults[ind_transition] * h;
          ind_transition := Position(ListLClass, LClass(S, x));
          if not ind_transition = fail then
            compt := compt + 1;
            #Print("-----------Here------------", ind_transition, " ", coeff , "\n\n");
            lp := rp_mults[ind_transition];
            #Print(e, x, lp, e*x*lp, Representative(H), "\n\n");
            g  := (e * x * lp) ^ map;
            ind_groupe  := Position(LHH, g);
            ind_l_class := (ind_transition - 1) * ord + ind_groupe;
            row[ind_l_class] := row[ind_l_class] + coeff;
          fi;
        od;
        chi := chi + Coefficients(B, row)[ind_r];
      od;
      mat[Position(CG, k)][Position(CS, h)] := chi;
    od;
  od;

  return mat;
end;

ConcatenatedRClassRadicalBicharacters := function(S)
  local idempotents, e, M;

  idempotents := TransversalIdempotents(S);
  M           := [];
  for e in idempotents do
    M := Concatenation(M, RClassRadicalBicharacter(S, e));
  od;

  return M;
end;

############################
###   Character Table    ###
############################

###   Group Character Tables

DiagonalOfCharacterTables := function(S)
  local CS, n, M, idempotents, maps, map, XG, CG, h, k,
  	b, e, G, I, l, i, j;

  CS := SConjugacyClassReps(S);
  n := Length(CS);
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
      h := ConjugacyClass(G, CS[i+b] ^ map);
      for j in [1..l] do
        k := ConjugacyClass(G, CS[j+b] ^ map);
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

  L := ConcatenatedRClassBicharacters(S);
  R := ConcatenatedRClassRadicalBicharacters(S);
  D := DiagonalOfCharacterTables(S);

  return Inverse(TransposedMatMutable(D)) * (L - R);
end;

