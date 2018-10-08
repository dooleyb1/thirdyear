{- dooleyb1 Brandon Dooley -}
module Ex01 where
import Data.List ((\\))

-- Datatypes -------------------------------------------------------------------

-- do not change anything in this section !

type Id = String

data Expr
  = Val Double
  | Add Expr Expr
  | Mul Expr Expr
  | Sub Expr Expr
  | Dvd Expr Expr
  | Var Id
  | Def Id Expr Expr
  deriving (Eq, Show)

type Dict k d  =  [(k,d)]

define :: Dict k d -> k -> d -> Dict k d
define d s v = (s,v):d

find :: Eq k => Dict k d -> k -> Maybe d
find []             _                 =  Nothing
find ( (s,v) : ds ) name | name == s  =  Just v
                         | otherwise  =  find ds name

type EDict = Dict String Double

-- Part 1 : Evaluating Expressions -- (63 marks) -------------------------------

-- Implement the following function so all 'eval' tests pass.

-- eval should return Nothing if:
  -- (1) a divide by zero operation was going to be performed;
  -- (2) the expression contains a variable not in the dictionary.

eval :: EDict -> Expr -> Maybe Double
eval _ (Val e) = Just e                               -- return just e
eval d (Var i) = find d i                             -- find i in d

eval d (Add x y) = evalArithmetic d (+) x y           -- use evalArithmetic for add
eval d (Mul x y) = evalArithmetic d (*) x y           -- use evalArithmetic for mul
eval d (Sub x y) = evalArithmetic d (-) x y           -- use evalArithmetic for sub

eval d (Dvd x y) =
  case (eval d x, eval d y) of                        -- switch
    (Just a, Just b) -> if(a==0.0||b==0.0) then Nothing else Just (a/b)
    _ -> Nothing

eval d (Def x e1 e2) =
  case (eval d e1) of                                 -- switch(eval d e1)
    Nothing -> Nothing                                --  if e1 not in d -> nothing
    Just val1 -> eval (define d x val1) e2            --  if e1 in d -> merge and check for e2


-- Define evalArithmetic to handle eval tests for add, sub, div etcs

evalArithmetic dict op x y =
  let m = eval dict x ; n = eval dict y
  in case (m,n) of
    (Just a, Just b) -> Just (a `op` b)
    _ -> Nothing

-- Part 2 : Simplifying Expressions -- (57 marks) ------------------------------

-- Given the following code :

simp :: EDict -> Expr -> Expr
simp d (Var v)        =  simpVar d v
simp d (Add e1 e2)    =  simpAdd d   (simp d e1) (simp d e2)
simp d (Sub e1 e2)    =  simpSub d   (simp d e1) (simp d e2)
simp d (Mul e1 e2)    =  simpMul d   (simp d e1) (simp d e2)
simp d (Dvd e1 e2)    =  simpDvd d   (simp d e1) (simp d e2)
simp d (Def v e1 e2)  =  simpDef d v (simp d e1) (simp d e2)
simp _ e = e  -- simplest case, Val, needs no special treatment

-- Implement the following functions so all 'simp' tests pass.

  -- (1) see test scripts for most required properties
  -- (2) (Def v e1 e2) should simplify to just e2 in the following two cases:
    -- (2a) if there is mention of v in e2
    -- (2b) if any mention of v in e2 is inside another (Def v .. ..)

simpVar :: EDict -> Id -> Expr
simpVar d v = case (find d v) of                        -- switch(find d v)
    Nothing -> Var v                                    --  if Nothing return variable v
    Just x -> Val x                                     --  if Found return value of v

simpAdd :: EDict -> Expr -> Expr -> Expr
simpAdd d e1 e2 = case (eval d e1, eval d e2) of        -- switch((find e1 in d), (find e2 in d))
    (Just 0.0, _) -> e2                                 --  0 + _ = _
    (_, Just 0.0) -> e1                                 --  _ + 0 = _
    (Just x, Just y) -> Val(x + y)                      --  x + y = Val (x+y)
    (_, _) -> Add e1 e2                                 --  _ + _ = Add _ _

simpSub :: EDict -> Expr -> Expr -> Expr
simpSub d e1 e2 = case (eval d e1, eval d e2) of        -- switch((find e1 in d), (find e2 in d))
    (_, Just 0.0) -> e1                                 --  _ - 0 = _
    (Just x, Just y) -> Val(x - y)                      --  x - y = Val (x-y)
    (_, _) -> Sub e1 e2                                 --  _ - _ = Sub _ _

simpMul :: EDict -> Expr -> Expr -> Expr
simpMul d e1 e2 =
  let m = simp d e1 ; n = simp d e2
  in case (m,n) of                                     -- switch((simp d e1), (simp d e2))
    (Val 1.0, x) -> x                                  --  1 * x = x
    (x, Val 1.0) -> x                                  --  x * 1 = x
    (Val 0.0, x) -> Val 0.0                            --  0 * _ = 0
    (_, Val 0.0) -> Val 0.0                            --  _ * 0 = 0
    (Val x, Val y) -> Val(x * y)                       --  x * y = Val (x*y)
    (_, _) -> Mul e1 e2                                --  _ * _ = Mul _ _

simpDvd :: EDict -> Expr -> Expr -> Expr
simpDvd d e1 e2 = case (eval d e1, eval d e2) of        -- switch((find e1 in d), (find e2 in d))
    (Just x, Just 1.0) -> Val x                         --  _ / 1 = e1
    (_, Just 0.0) -> Dvd e1 (Val 0.0)                   --  _ / 0 = _ / 0
    (Just 0.0, _) -> Val 0.0                            --  0 / _ = 0
    (Just x, Just y) -> Val(x/y)                        --  x / y = x/y
    (_, _) -> Dvd e1 e2                                 -- _ / _ = _/_

simpDef :: EDict -> Id -> Expr -> Expr -> Expr
simpDef d v (Val x) e2 = simp (define d v x) e2         --
simpDef d v e1 e2 = Def v e1 e2                         --
