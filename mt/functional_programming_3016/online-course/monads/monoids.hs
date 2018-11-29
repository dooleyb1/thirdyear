import Data.Monoid

type Food = String
type Price = Sum Int

-- Function to preserve logs
isBigGang :: Int -> (Bool, String)
isBigGang x = (x > 9, "Compared gang size to 9.")

-- Log Monads
applyLog :: (a, String) -> (a -> (b, String)) -> (b, String)
applyLog (x, log) f = let (y, newLog) = f x in (y, log ++ newLog)

-- Monoid apply log
applyLogMonoid :: (Monoid m) => (a,m) -> (a -> (b, m)) -> (b, m)
applyLogMonoid (x, log) f = let (y, newLog) = f x in (y, log `mappend` newLog)

-- Add drink function
addDrink :: Food -> (Food, Price)
addDrink "beans" = ("milk", Sum 25)
addDrink "jerky" = ("whiskey", Sum 99)
addDrink _       = ("beer", Sum 30)
