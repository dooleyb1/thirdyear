-- Function to double x
doubleMe x = x + x

-- Function to double x and y using doubleMe
doubleUs x y = doubleMe x + doubleMe y

-- Function to doubleNumber if small
doubleSmallNumber x = if x > 100
	then x
	else x*2

-- Function to use lists to generate BOOM or BANG
boomBang xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

-- Function to return the length of a list
--			Generates a list of 1's for every element and sums them
length' xs = sum [1 | _ <- xs]

-- Function to remove all non uppercase letters from a string
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

-- Function to generate tuples of all possible right angled triangles of
-- sides < 10 and a perimeter of 24
rightTriangles' = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a+b+c == 24]
