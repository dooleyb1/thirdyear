-- Q2

-- a)

hof :: a -> (a -> a -> a)  -> [a] -> a
hof x _ []      = x
hof x f (y:ys)  = f y (hof x f ys)


f1 :: (Num a) => [a] -> a
f1 = hof 42 (*)

f2 :: (Num a) => [a] -> a
f2 = hof 0 g
  where g x y = (99*y)

f3 :: (Num a) => [a] -> a
f3 = hof 0 (+)

f4 :: (Num a) => [a] -> [a]
f4 = hof [] (++)

f5 :: (Num a) => [a] -> a
f5 = hof 0 g
  where g x y = (x-42) + y

f5' [] = 0
f5' (x:xs) = (x-42) + f5' xs
