dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ xs@[]       =  []
dropWhile' p xs@(x:xs')
           | p x         =  xs
           | otherwise   =  dropWhile' p xs'
