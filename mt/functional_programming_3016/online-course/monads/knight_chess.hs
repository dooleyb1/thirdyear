type KnightPos = (Int, Int)

-- Knights movements (only diagonal by 1)
moveKnight :: KnightPos -> [KnightPos]
moveKnight (c, r) = do
  (c', r') <- [(c+2,r-1),(c+2,r+1),(c-2,r-1),(c-2,r+1)
               ,(c+1,r-2),(c+1,r+2),(c-1,r-2),(c-1,r+2)]
  guard (c' `elem` [1..8] && r `elem` [1..8])
  return (c', r')

-- Alternative
moveKnightFilter :: KnightPos -> [KnightPos]
moveKnightFilter (c,r) = filter onBoard
    [(c+2,r-1),(c+2,r+1),(c-2,r-1),(c-2,r+1)
     ,(c+1,r-2),(c+1,r+2),(c-1,r-2),(c-1,r+2)
     ]
     where onBoard(c,r) = c `elem` [1..8] && r `elem` [1..8]

-- Where a night can go in three moves
in3 :: KnightPos -> [KnightPos]
in3 start = do
  first <- moveKnight start
  second <- moveKnight first
  moveKnight second

-- Determine if knight can reach here
canReachIn3 :: KnightPos -> KnightPos -> Bool
canReachIn3 start end = end `elem` in3 start

class Monad m => MonadPlus m where
   mzero :: m a
   mplus :: m a -> m a -> m a

instance MonadPlus [] where
   mzero = []
   mplus = (++)

guard :: (MonadPlus m) => Bool -> m ()
guard True = return ()
guard False = mzero
