// Let V be a boolean array of size K, and consistent and change be boolean flags
//https://core.ac.uk/download/pdf/82477946.pdf

begin
  let S = {C1, ..., Cm}, where A = C1 ^ ... ^ Cm
  consistent = true;
  change = true;

  for each propositional letter P in A do
    V(P) = false;
  endfor;

  for each P such that (P) is a basic Horn formula in A do
    V(P) = true
  endfor;

  while change and consistent do
    change = false;

    for each basic Horn formula C in S and consistent do
      // This condition finds false
      if C is of the form ¬P1 ∨ ... ∨ ¬Pm and V(P1) = ... = V(Pm) = true then
        consistent = false;
      // This condition verifies truth
      else if C is of the form ¬P1 ∨ ... ∨ ¬Pm ∨ P and V(P1) = ... = V(Pm) = true and V(P) = false then
        V(P) = true;
        change = true;
        // Remove horn formula from set
        S = S-{C}
    endfor;
  endwhile;
