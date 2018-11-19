{- butrfeld Andrew Butterfield -}
module Ex02 where

-- Datatypes -------------------------------------------------------------------

-- do not change anything in this section !


-- a binary tree datatype
data Tree k d
  = Br (Tree k d) (Tree k d) k d
  | Leaf k d
  | Nil
  deriving (Eq, Show)

type IntFun = Tree Int Int -- binary tree with integer keys and data

data Expr
  = Val Double
  | Var String
  | Add Expr Expr
  | Mul Expr Expr
  | Sub Expr Expr
  | Abs Expr
  | Sign Expr
   deriving (Eq, Show)



-- Part 1 : Tree Insert -------------------------------

-- Implement:
ins :: Ord k => k -> d -> Tree k d -> Tree k d

ins k d Nil  = Leaf k d                               -- if insert into nil, create leaf

ins k d (Leaf x y)                                    -- if insert into leaf
  | k == x  = Leaf k d                                      -- if keys are the same, replace
  | k < x   = Br (Leaf k d) Nil x y                         -- if key is less, insert left of leaf
  | k > x   = Br Nil (Leaf k d) x y                         -- if key is more, insert right

ins k d (Br l r x y)                                  -- if insert into tree
  | k == x  = Br l r k d                                    -- if keys are the same, replace
  | k < x   = Br (ins k d l) r x y                          -- if keys are less, recursively insert left
  | k > x   = Br l (ins k d r) x y                          -- if keys are more, recursively insert right



-- Part 2 : Tree Lookup -------------------------------

-- Implement:
lkp :: (Monad m, Ord k) => Tree k d -> k -> m d
lkp Nil _ = fail "Empty leaf"

lkp (Leaf x y) a                                       -- if leaf lookup
  | a == x    = return y                                      -- if keys match return data
  | otherwise = fail "Key not found"                          -- else return fail

lkp (Br l r x y) a                                     -- if tree lookup
  | a == x    = return y                                      -- if keys match return data
  | a < x     = lkp l a                                       -- if keys less lkp left
  | a > x     = lkp r a                                       -- if keys more lkp right

-- Part 3 : Instance of Num for Expr

{-
  Fix the following instance for Num of Expr so all tests pass

  Note that the tests expect simplification to be done
  only when *all* Expr arguments are of the form Val v

  Hint 1 :  implementing fromInteger *first* is recommended!
  Hint 2 :  remember that Double is already an instance of Num
-}

-- eval to be used to perform arithmetic and convert to val
eval :: Expr -> Expr
eval (Add (Val a) (Val b)) = Val (a + b)
eval (Sub (Val a) (Val b)) = Val (a - b)
eval (Mul (Val a) (Val b)) = Val (a * b)
eval (Abs (Val a)) = Val (abs a)
eval (Sign (Val a)) = Val (signum a)
eval a = a

instance Num Expr where
  e1 + e2 = eval (Add e1 e2)
  e1 - e2 = eval (Sub e1 e2)
  e1 * e2 = eval (Mul e1 e2)
  negate e = eval (Sub 0 e)
  abs e = eval (Abs e)
  signum e = eval (Sign e)
  fromInteger i = Val (fromInteger i)
