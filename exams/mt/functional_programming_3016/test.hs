hof :: a -> (a -> b -> a) -> [b] -> a
hof z _ [] = z
hof z f (x:xs) = hof (f z x) f xs

f1 :: (Num a) => a -> [a] -> a
f1 p l = hof p f l
  where f x y = x*y

f2 :: (Num a) => a -> [a] -> a
f2 p l = hof p f l
  where f x y = y+1

f3 :: (Num a) => a -> [a] -> a
f3 p l = hof p f l
  where f x y = x+y

f4 :: (Num a) => [a] -> [[a]] -> [a]
f4 p l = hof p f l
  where f x y = x ++ y

f5 :: (Num a) => a -> [a] -> a
f5 p l = hof p f l
  where f x y = (x+y*y)
