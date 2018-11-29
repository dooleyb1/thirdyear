-- Representation of types for tightrope
type Birds = Int
type Pole = (Birds, Birds)

-- Bird landing functions (no monad)
landLeftUnsafe :: Birds -> Pole -> Pole
landLeftUnsafe n (left, right) = (left+n, right)

landRightUnsafe :: Birds -> Pole -> Pole
landRightUnsafe n (left, right) = (left, right+n)

-- Bird landing functions (with monads)
landLeftSafe :: Birds -> Pole -> Maybe Pole
landLeftSafe n (left, right)
  | abs ((left+n) - right)  < 4 = Just (left + n, right)
  | otherwise                   = Nothing

landRightSafe :: Birds -> Pole -> Maybe Pole
landRightSafe n (left, right)
  | abs (left - (right+n)) < 4 = Just (left, right+n)
  | otherwise                  = Nothing

-- Routing using Monads and do
routine :: Maybe Pole
routine = do
  start <- return (0,0)
  first <- landLeftSafe 2 start
  second <- landRightSafe 2 first
  landLeftSafe 1 second
