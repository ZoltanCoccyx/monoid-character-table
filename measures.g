Read("cartan.g");

Measure := function(f, x, reprx)
	local t, mem;
	
	t := NanosecondsSinceEpoch();
	mem := TotalMemoryAllocated( );
	f(x);
	return rec(x:= reprx, t:= NanosecondsSinceEpoch()-t, mem:= TotalMemoryAllocated()-mem);
end;

AllMeasures := function(f, L, reprL)
	
	local i, value, values;
	
	values := [];
	
	for i in [1..Length(L)] do
		Print(reprL[i]);
		value := Measure(f, L[i], reprL[i]);
		Add(values, value);
		Print("\t done \t", value, "\n");
	od;
	return values;
end;

L := function(n) return List([3..n], x -> FullTransformationMonoid(x)); end;
reprL := function(n) return List([3..n], x -> Concatenation("T", String(x))); end;

L43 := [ [ Transformation( [ 4, 3, 4, 3 ] ), Transformation( [ 1, 4, 3, 2 ] ), 
      Transformation( [ 3, 2, 2, 1 ] ) ], 
  [ Transformation( [ 4, 1, 1, 3 ] ), Transformation( [ 2, 2, 4, 4 ] ), 
      Transformation( [ 1, 1, 1 ] ) ], 
  [ Transformation( [ 3, 2, 1, 2 ] ), Transformation( [ 4, 1, 1, 3 ] ), 
      Transformation( [ 1, 1, 2, 1 ] ) ], 
  [ Transformation( [ 2, 4, 1, 4 ] ), Transformation( [ 2, 3, 1, 2 ] ), 
      Transformation( [ 3, 2, 3, 2 ] ) ], 
  [ Transformation( [ 4, 3, 2, 2 ] ), Transformation( [ 2, 1, 2, 3 ] ), 
      Transformation( [ 3, 1, 4, 3 ] ) ], 
  [ Transformation( [ 4, 4, 2, 1 ] ), Transformation( [ 2, 1, 4, 4 ] ), 
      Transformation( [ 4, 2, 1, 1 ] ) ], 
  [ Transformation( [ 2, 4, 4, 4 ] ), Transformation( [ 4, 2, 4, 3 ] ), 
      Transformation( [ 4, 1, 1, 3 ] ) ], 
  [ Transformation( [ 3, 1, 3, 2 ] ), Transformation( [ 4, 3, 3, 1 ] ), 
      Transformation( [ 1, 4, 3, 4 ] ) ], 
  [ Transformation( [ 1, 4, 2, 1 ] ), Transformation( [ 1, 4, 1, 4 ] ), 
      Transformation( [ 4, 4, 2, 1 ] ) ], 
  [ Transformation( [ 1, 2, 2, 2 ] ), Transformation( [ 2, 2, 3, 1 ] ), 
      Transformation( [ 4, 2, 3, 2 ] ) ] ]
;
reprL43 := List([0..9], x -> Concatenation("L43_", String(x)));

L53 := [ [ Transformation( [ 4, 3, 4, 5, 1 ] ), Transformation( [ 4, 1, 1, 2 ] ), 
      Transformation( [ 3, 5, 4, 2, 5 ] ) ], 
  [ Transformation( [ 5, 2, 1, 3, 3 ] ), Transformation( [ 2, 2, 5, 5, 3 ] ), 
      Transformation( [ 2, 4, 5, 5, 5 ] ) ], 
  [ Transformation( [ 2, 2, 4, 5, 1 ] ), Transformation( [ 2, 4, 3, 4, 2 ] ), 
      Transformation( [ 5, 2, 1, 5, 2 ] ) ], 
  [ Transformation( [ 4, 4, 3, 2, 1 ] ), Transformation( [ 3, 1, 4, 2, 1 ] ), 
      Transformation( [ 4, 1, 4, 1, 2 ] ) ], 
  [ Transformation( [ 1, 4, 5, 4, 4 ] ), Transformation( [ 2, 4, 3, 5, 2 ] ), 
      Transformation( [ 3, 5, 5, 4, 4 ] ) ], 
  [ Transformation( [ 1, 4, 4, 1 ] ), Transformation( [ 5, 1, 1, 5, 4 ] ), 
      Transformation( [ 4, 1, 1, 4 ] ) ], 
  [ Transformation( [ 1, 4, 1, 4, 1 ] ), Transformation( [ 5, 4, 3, 5, 5 ] ), 
      Transformation( [ 3, 4, 1, 5, 5 ] ) ], 
  [ Transformation( [ 1, 4, 2, 3, 3 ] ), Transformation( [ 2, 1, 5, 5, 2 ] ), 
      Transformation( [ 1, 1, 1, 3, 2 ] ) ], 
  [ Transformation( [ 5, 4, 3, 1, 4 ] ), Transformation( [ 1, 5, 3, 3, 2 ] ), 
      Transformation( [ 5, 2, 4, 5, 3 ] ) ], 
  [ Transformation( [ 1, 4, 3, 1, 2 ] ), Transformation( [ 2, 1, 4, 3, 1 ] ), 
      Transformation( [ 1, 1, 1, 3, 3 ] ) ] ]
;
reprL53 := List([0..9], x -> Concatenation("L53_", String(x)));

L54 := [ [ Transformation( [ 2, 3, 5, 4, 3 ] ), Transformation( [ 2, 4, 2, 1 ] ), 
      Transformation( [ 3, 4, 1, 4, 1 ] ), Transformation( [ 4, 3, 3, 1, 3 ] ) ], 
  [ Transformation( [ 1, 5, 1, 2, 4 ] ), Transformation( [ 5, 3, 5, 4, 3 ] ), 
      Transformation( [ 5, 4, 3, 1, 2 ] ), Transformation( [ 2, 1, 2, 5, 4 ] ) ], 
  [ Transformation( [ 4, 5, 3, 2, 2 ] ), Transformation( [ 2, 4, 1, 3 ] ), 
      Transformation( [ 4, 1, 4, 1, 2 ] ), Transformation( [ 1, 3, 2, 3, 1 ] ) ], 
  [ Transformation( [ 5, 2, 4, 5, 5 ] ), Transformation( [ 3, 5, 4, 1, 2 ] ), 
      Transformation( [ 2, 3, 5, 3, 1 ] ), Transformation( [ 4, 1, 3, 3, 2 ] ) ], 
  [ Transformation( [ 2, 2, 5, 4, 1 ] ), Transformation( [ 4, 1, 4, 3, 4 ] ), 
      Transformation( [ 4, 3, 1, 5, 3 ] ), Transformation( [ 1, 4, 3, 5, 1 ] ) ], 
  [ Transformation( [ 3, 1, 1, 1, 3 ] ), Transformation( [ 4, 2, 2, 4, 2 ] ), 
      Transformation( [ 5, 5, 3, 5, 5 ] ), Transformation( [ 4, 1, 1, 1, 2 ] ) ], 
  [ Transformation( [ 3, 4, 2, 2, 3 ] ), Transformation( [ 4, 4, 2, 4 ] ), 
      Transformation( [ 5, 1, 5, 5, 4 ] ), Transformation( [ 2, 1, 2, 3, 1 ] ) ], 
  [ Transformation( [ 3, 5, 4, 3, 5 ] ), Transformation( [ 2, 4, 1, 4 ] ), 
      Transformation( [ 3, 5, 3, 2, 4 ] ), Transformation( [ 2, 1, 1, 3, 2 ] ) ], 
  [ Transformation( [ 2, 3, 1, 3 ] ), Transformation( [ 3, 2, 1, 3, 3 ] ), 
      Transformation( [ 4, 3, 1, 3, 4 ] ), Transformation( [ 2, 1, 1, 5, 5 ] ) ], 
  [ Transformation( [ 1, 5, 4, 1, 4 ] ), Transformation( [ 3, 5, 2, 1, 1 ] ), 
      Transformation( [ 1, 2, 2, 4, 4 ] ), Transformation( [ 2, 4, 3, 2, 4 ] ) ] ]
;
reprL54 := List([0..9], x -> Concatenation("L54_", String(x)));

L65 := [ [ Transformation( [ 4, 4, 1, 3, 1 ] ), Transformation( [ 1, 4, 1, 5, 6, 6 ] ), 
      Transformation( [ 5, 5, 4, 5, 6, 3 ] ), Transformation( [ 3, 6, 4, 5, 1, 3 ] ), 
      Transformation( [ 1, 6, 3, 4, 5, 5 ] ) ], 
  [ Transformation( [ 5, 6, 3, 4, 1, 1 ] ), Transformation( [ 3, 3, 2, 1, 4 ] ), 
      Transformation( [ 5, 5, 1, 3, 1, 3 ] ), Transformation( [ 4, 4, 3, 4, 6, 6 ] ), 
      Transformation( [ 5, 2, 2, 5, 1, 2 ] ) ], 
  [ Transformation( [ 5, 2, 6, 2, 2, 6 ] ), Transformation( [ 5, 6, 4, 4, 5, 6 ] ), 
      Transformation( [ 5, 6, 4, 3, 1, 2 ] ), Transformation( [ 5, 1, 2, 2, 5, 2 ] ), 
      Transformation( [ 2, 1, 4, 6, 5, 3 ] ) ], 
  [ Transformation( [ 5, 6, 3, 6, 5, 1 ] ), Transformation( [ 4, 4, 5, 2, 4, 5 ] ), 
      Transformation( [ 3, 6, 5, 6, 5, 6 ] ), Transformation( [ 4, 3, 6, 6, 3, 1 ] ), 
      Transformation( [ 2, 2, 1, 1, 2, 5 ] ) ], 
  [ Transformation( [ 3, 6, 5, 4, 4, 6 ] ), Transformation( [ 1, 6, 1, 5, 6, 5 ] ), 
      Transformation( [ 4, 3, 5, 3, 1 ] ), Transformation( [ 5, 3, 2, 5, 1 ] ), 
      Transformation( [ 2, 6, 3, 6, 5, 1 ] ) ], 
  [ Transformation( [ 1, 2, 5, 3, 5 ] ), Transformation( [ 6, 2, 4, 4, 3, 5 ] ), 
      Transformation( [ 6, 6, 5, 3, 4, 1 ] ), Transformation( [ 3, 2, 6, 4, 6, 6 ] ), 
      Transformation( [ 2, 3, 6, 5, 4, 4 ] ) ], 
  [ Transformation( [ 4, 4, 4, 4, 4, 1 ] ), Transformation( [ 6, 4, 5, 2, 1, 1 ] ), 
      Transformation( [ 6, 5, 2, 6, 2, 3 ] ), Transformation( [ 2, 1, 2, 1, 6, 1 ] ), 
      Transformation( [ 3, 6, 5, 1, 5, 1 ] ) ], 
  [ Transformation( [ 4, 2, 2, 2, 1, 3 ] ), Transformation( [ 3, 2, 3, 5, 5, 2 ] ), 
      Transformation( [ 2, 4, 4, 6, 2, 1 ] ), Transformation( [ 6, 1, 1, 5, 3, 4 ] ), 
      Transformation( [ 5, 4, 5, 4, 1, 2 ] ) ], 
  [ Transformation( [ 1, 4, 1, 5, 2, 2 ] ), Transformation( [ 3, 4, 2, 3, 3, 5 ] ), 
      Transformation( [ 2, 1, 5, 2, 1, 5 ] ), Transformation( [ 4, 5, 1, 4, 2, 2 ] ), 
      Transformation( [ 1, 2, 6, 5, 3, 1 ] ) ], 
  [ Transformation( [ 2, 4, 1, 2, 5, 1 ] ), Transformation( [ 6, 4, 1, 2, 6, 2 ] ), 
      Transformation( [ 5, 2, 6, 4, 2, 2 ] ), Transformation( [ 6, 5, 6, 5, 3, 6 ] ), 
      Transformation( [ 4, 3, 5, 2, 5, 4 ] ) ] ]
;
reprL65 := List([0..9], x -> Concatenation("L65_", String(x)));

L76 := [ [ Transformation( [ 1, 5, 7, 3, 7, 4, 4 ] ), Transformation( [ 6, 2, 4, 5, 2, 6 ] ), 
      Transformation( [ 5, 5, 1, 4, 5, 1, 2 ] ), Transformation( [ 1, 6, 3, 4, 1, 3, 1 ] ), 
      Transformation( [ 3, 6, 1, 4, 6, 6, 1 ] ), Transformation( [ 2, 6, 1, 7, 6, 1, 1 ] ) ], 
  [ Transformation( [ 6, 3, 2, 1, 6, 1, 2 ] ), Transformation( [ 1, 4, 6, 3, 4, 2, 3 ] ), 
      Transformation( [ 2, 6, 4, 2, 2, 3, 1 ] ), Transformation( [ 2, 3, 5, 3, 7, 1, 1 ] ), 
      Transformation( [ 5, 7, 3, 4, 5, 1, 3 ] ), Transformation( [ 6, 4, 4, 6, 6, 7, 2 ] ) ], 
  [ Transformation( [ 4, 2, 7, 4, 4, 7, 7 ] ), Transformation( [ 6, 4, 2, 3, 7, 2, 2 ] ), 
      Transformation( [ 2, 5, 7, 5, 1, 6, 6 ] ), Transformation( [ 1, 4, 4, 3, 6, 2, 3 ] ), 
      Transformation( [ 7, 7, 6, 5, 2, 7, 1 ] ), Transformation( [ 7, 2, 4, 7, 2, 3, 1 ] ) ], 
  [ Transformation( [ 2, 5, 7, 2, 6, 6, 5 ] ), Transformation( [ 7, 1, 2, 1, 7, 6, 5 ] ), 
      Transformation( [ 7, 4, 5, 5, 3, 1, 5 ] ), Transformation( [ 3, 2, 4, 7, 3, 1, 2 ] ), 
      Transformation( [ 2, 1, 7, 1, 4, 2, 7 ] ), Transformation( [ 2, 1, 2, 4, 7, 6, 3 ] ) ], 
  [ Transformation( [ 1, 2, 6, 2, 6, 3, 5 ] ), Transformation( [ 7, 2, 2, 7, 3, 5, 7 ] ), 
      Transformation( [ 2, 2, 2, 7, 6, 5, 3 ] ), Transformation( [ 5, 1, 3, 7, 1, 6, 2 ] ), 
      Transformation( [ 4, 7, 5, 7, 2, 5, 6 ] ), Transformation( [ 1, 7, 1, 3, 2, 6, 3 ] ) ], 
  [ Transformation( [ 6, 3, 6, 7, 2, 5, 7 ] ), Transformation( [ 3, 2, 4, 6, 6, 7, 6 ] ), 
      Transformation( [ 4, 6, 7, 2, 7, 5, 5 ] ), Transformation( [ 4, 7, 7, 1, 6, 7, 7 ] ), 
      Transformation( [ 6, 1, 5, 2, 3, 5, 2 ] ), Transformation( [ 2, 5, 3, 6, 4, 5 ] ) ], 
  [ Transformation( [ 1, 5, 7, 2, 6, 6, 5 ] ), Transformation( [ 2, 5, 4, 6, 2, 6, 6 ] ), 
      Transformation( [ 7, 3, 1, 1, 1, 5, 1 ] ), Transformation( [ 2, 4, 3, 1, 2, 5, 2 ] ), 
      Transformation( [ 6, 3, 5, 7, 2, 7, 1 ] ), Transformation( [ 2, 7, 4, 4, 1, 3, 5 ] ) ], 
  [ Transformation( [ 3, 4, 4, 6, 3, 1, 4 ] ), Transformation( [ 7, 1, 7, 1, 3, 5, 2 ] ), 
      Transformation( [ 3, 4, 4, 5, 4, 3, 6 ] ), Transformation( [ 4, 1, 4, 1, 7, 1, 2 ] ), 
      Transformation( [ 2, 6, 2, 1, 3, 3, 4 ] ), Transformation( [ 6, 4, 7, 3, 2, 4, 6 ] ) ], 
  [ Transformation( [ 1, 6, 1, 2, 5, 1, 4 ] ), Transformation( [ 3, 3, 4, 3, 6, 7, 7 ] ), 
      Transformation( [ 5, 3, 3, 6, 1, 7, 2 ] ), Transformation( [ 2, 4, 2, 5, 4, 7, 5 ] ), 
      Transformation( [ 4, 5, 5, 4, 6, 4 ] ), Transformation( [ 7, 4, 6, 4, 2, 1, 7 ] ) ], 
  [ Transformation( [ 5, 3, 5, 2, 5, 5 ] ), Transformation( [ 1, 1, 2, 3, 2, 1, 5 ] ), 
      Transformation( [ 6, 6, 4, 3, 6, 3, 4 ] ), Transformation( [ 3, 7, 1, 5, 3, 5, 5 ] ), 
      Transformation( [ 6, 2, 7, 6, 5, 5, 7 ] ), Transformation( [ 4, 2, 4, 4, 3, 1, 6 ] ) ] ]
;
reprL76 := List([0..9], x -> Concatenation("L76_", String(x)));

L98 := [ [ Transformation( [ 8, 1, 4, 2, 4, 5, 2, 2, 6 ] ), 
      Transformation( [ 8, 3, 3, 3, 8, 6, 4, 4, 5 ] ), 
      Transformation( [ 9, 4, 5, 4, 8, 2, 4, 8, 3 ] ), 
      Transformation( [ 5, 2, 2, 8, 6, 4, 7, 2, 4 ] ), 
      Transformation( [ 7, 1, 1, 6, 9, 7, 2, 4, 8 ] ), 
      Transformation( [ 2, 8, 3, 9, 1, 6, 9, 9, 5 ] ), 
      Transformation( [ 4, 5, 1, 7, 6, 8, 2, 9, 3 ] ), 
      Transformation( [ 9, 7, 4, 3, 1, 8, 5, 9, 1 ] ) ], 
  [ Transformation( [ 7, 7, 4, 2, 6, 4, 4, 2, 3 ] ), 
      Transformation( [ 2, 1, 2, 8, 6, 5, 5, 5, 2 ] ), 
      Transformation( [ 7, 5, 1, 2, 7, 4, 4, 3, 7 ] ), 
      Transformation( [ 6, 6, 1, 5, 5, 8, 2, 4 ] ), 
      Transformation( [ 2, 8, 4, 5, 7, 7, 5, 1, 8 ] ), 
      Transformation( [ 7, 9, 8, 3, 7, 9, 5, 2, 5 ] ), 
      Transformation( [ 3, 9, 7, 3, 8, 3, 5, 8, 8 ] ), 
      Transformation( [ 2, 2, 2, 1, 1, 4, 6, 5, 6 ] ) ], 
  [ Transformation( [ 6, 8, 5, 8, 7, 8, 7, 8, 3 ] ), 
      Transformation( [ 3, 7, 2, 3, 4, 4, 9, 8, 4 ] ), 
      Transformation( [ 2, 4, 7, 6, 5, 3, 1, 5, 8 ] ), 
      Transformation( [ 7, 8, 5, 4, 9, 3, 7, 5, 2 ] ), 
      Transformation( [ 4, 5, 4, 7, 6, 3, 7, 4, 3 ] ), 
      Transformation( [ 4, 5, 5, 9, 4, 6, 5, 2, 4 ] ), 
      Transformation( [ 6, 9, 8, 2, 2, 3, 1, 5, 7 ] ), 
      Transformation( [ 2, 2, 4, 3, 7, 3, 2, 8, 5 ] ) ], 
  [ Transformation( [ 4, 2, 9, 2, 4, 1, 7, 7, 6 ] ), 
      Transformation( [ 2, 5, 5, 8, 2, 2, 9, 4, 5 ] ), 
      Transformation( [ 9, 1, 4, 3, 7, 9, 6, 6, 8 ] ), 
      Transformation( [ 5, 5, 6, 4, 9, 4, 7, 9, 6 ] ), 
      Transformation( [ 3, 2, 7, 1, 4, 6, 9, 4, 9 ] ), 
      Transformation( [ 8, 3, 3, 4, 5, 6, 8, 8, 5 ] ), 
      Transformation( [ 4, 5, 2, 4, 5, 2, 1, 1, 8 ] ), 
      Transformation( [ 5, 9, 5, 2, 4, 2, 1, 8, 8 ] ) ], 
  [ Transformation( [ 9, 1, 5, 9, 3, 4, 7, 1, 5 ] ), 
      Transformation( [ 5, 6, 5, 4, 8, 5, 1, 1, 1 ] ), 
      Transformation( [ 6, 2, 1, 2, 4, 4, 3 ] ), 
      Transformation( [ 6, 3, 2, 3, 5, 9, 3, 7, 4 ] ), 
      Transformation( [ 9, 1, 1, 1, 5, 2, 4, 2, 7 ] ), 
      Transformation( [ 7, 7, 1, 7, 3, 6, 9, 3, 3 ] ), 
      Transformation( [ 3, 8, 3, 9, 4, 6, 6, 1, 8 ] ), 
      Transformation( [ 1, 7, 2, 2, 2, 7, 7, 4, 1 ] ) ], 
  [ Transformation( [ 5, 4, 5, 8, 5, 4, 3, 8, 5 ] ), 
      Transformation( [ 9, 5, 1, 7, 5, 9, 1, 5, 2 ] ), 
      Transformation( [ 4, 1, 3, 5, 3, 3, 4, 5, 8 ] ), 
      Transformation( [ 4, 3, 2, 4, 6, 3, 8, 3, 2 ] ), 
      Transformation( [ 9, 2, 3, 1, 9, 2, 1, 9, 4 ] ), 
      Transformation( [ 2, 2, 6, 2, 5, 1, 4, 1, 8 ] ), 
      Transformation( [ 5, 4, 8, 8, 2, 5, 1, 3, 5 ] ), 
      Transformation( [ 6, 3, 9, 1, 7, 1, 9, 6, 1 ] ) ], 
  [ Transformation( [ 1, 8, 8, 2, 2, 9, 2, 5, 8 ] ), 
      Transformation( [ 6, 6, 3, 3, 3, 2, 2, 3, 1 ] ), 
      Transformation( [ 6, 5, 6, 7, 9, 6, 6, 3, 3 ] ), 
      Transformation( [ 7, 1, 6, 9, 6, 1, 7, 5, 1 ] ), 
      Transformation( [ 7, 4, 7, 4, 7, 3, 3, 1, 7 ] ), 
      Transformation( [ 9, 6, 8, 9, 9, 1, 6, 9, 2 ] ), 
      Transformation( [ 2, 6, 8, 1, 3, 2, 1, 4 ] ), 
      Transformation( [ 4, 5, 9, 6, 9, 2, 3, 4, 3 ] ) ], 
  [ Transformation( [ 4, 2, 2, 6, 9, 3, 5, 9, 9 ] ), 
      Transformation( [ 5, 1, 1, 8, 8, 9, 1, 6, 9 ] ), 
      Transformation( [ 9, 8, 7, 3, 4, 4, 5, 2, 8 ] ), 
      Transformation( [ 2, 2, 5, 1, 8, 6, 4, 9, 5 ] ), 
      Transformation( [ 9, 8, 6, 6, 9, 5, 2, 7, 9 ] ), 
      Transformation( [ 4, 9, 1, 4, 8, 7, 1, 7, 6 ] ), 
      Transformation( [ 7, 7, 9, 6, 2, 5, 7, 4, 6 ] ), 
      Transformation( [ 2, 6, 2, 5, 2, 3, 5, 6, 3 ] ) ], 
  [ Transformation( [ 1, 7, 9, 5, 3, 1, 6, 8, 2 ] ), 
      Transformation( [ 1, 9, 7, 6, 7, 5, 8, 1, 7 ] ), 
      Transformation( [ 1, 2, 3, 6, 7, 6, 8, 8, 8 ] ), 
      Transformation( [ 5, 7, 8, 5, 2, 1, 5, 4, 4 ] ), 
      Transformation( [ 8, 3, 9, 1, 1, 3, 6, 4, 9 ] ), 
      Transformation( [ 2, 5, 8, 3, 8, 4, 2, 4 ] ), 
      Transformation( [ 3, 5, 2, 4, 2, 7, 9, 9, 8 ] ), 
      Transformation( [ 5, 7, 1, 5, 9, 2, 1, 3, 7 ] ) ], 
  [ Transformation( [ 8, 8, 1, 4, 6, 2, 9, 9, 8 ] ), 
      Transformation( [ 2, 5, 1, 1, 6, 7, 9, 8, 4 ] ), 
      Transformation( [ 3, 4, 3, 9, 4, 1, 5, 5, 9 ] ), 
      Transformation( [ 3, 7, 2, 9, 2, 7, 7, 7, 6 ] ), 
      Transformation( [ 3, 1, 9, 4, 7, 1, 3, 7, 6 ] ), 
      Transformation( [ 3, 6, 5, 2, 9, 8, 4, 4, 3 ] ), 
      Transformation( [ 5, 1, 9, 7, 9, 3, 1, 3, 6 ] ), 
      Transformation( [ 7, 4, 8, 2, 9, 9, 1, 4, 4 ] ) ] ]
;
reprL98 := List([0..9], x -> Concatenation("L98_", String(x)));

