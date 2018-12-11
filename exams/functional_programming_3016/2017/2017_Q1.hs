-- Q1

-- a)

tail' :: [a] -> [a]
tail' []     = error "empty list"
tail' (x:xs) = xs

-- b)

last' :: [a] -> a
last' []       = error "empty list"
last' (x:y:[]) = y
last' (x:xs)   = last' xs

-- c)

init' :: [a] -> [a]
init' [] = error "empty list"
init' (x:y:[]) = x:[]
init' (x:xs) = x : init' xs

-- d)

splitAt' :: Int -> [a] -> ([a], [a])
splitAt' 0 ys = ([], ys)
splitAt' _ [] = ([], [])
splitAt' n (y:ys)
  | n < 0     = ([], (y:ys))
  | otherwise = ((y:a), b)
  where (a,b) = splitAt' (n-1) ys

-- e)

replicate' :: Int -> a -> [a]
replicate' 0 _  = []
replicate' n x  = x : replicate (n-1) x

-- f)

foldl1' :: (a -> a -> a) -> [a] -> a
foldl1' f (x:xs) = foldl' f x xs
foldl1' _ []     =  errorEmptyList "foldl1"

foldl' :: (a -> a -> a) -> a -> [a] -> a
foldl' _ z []     = z
foldl' f z (x:xs) = foldl' f (f z x) xs
