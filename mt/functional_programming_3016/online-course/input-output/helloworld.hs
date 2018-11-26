import Data.Char
import Control.Monad

-- Read user input
main = do
  putStrLn "Hello, what is your name?"
  name <- getLine
  putStrLn ("Hey " ++ name ++ ", you rock!")

-- Read user input and capitalise name
main = do
  putStrLn "Whats your first name?"
  firstName <- getLine
  putStrLn "Whats your last name?"
  lastName <- getLine
  let bigFirstName = map toUpper firstName
      bigLastName = map toUpper lastName
  putStrLn $ "hey " ++ bigFirstName ++ " " ++ bigLastName ++ ", how are you?"

-- Pass input to functions
main = do
  line <- getLine
  if null line
    then return()
  else do
    putStrLn $ reverseWords line
    main

reverseWords :: String -> String
reverseWords = unwords . map reverse . words

-- Read character by character
main = do
  c <- getChar
  if c /= ' '
    then do
      putChar c
      main
    else return ()

-- Use a when clause (requires Control.Monad)
main = do
  c <- getChar
  when (c /= ' ') $ do
    putChar c
    main
