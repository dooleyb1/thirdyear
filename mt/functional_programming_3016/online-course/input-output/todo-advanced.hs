import System.Environment
import System.Directory
import System.IO
import Data.List

-- Lookup function for args
dispatch :: [(String, [String] -> IO())]
dispatch = [ ("add", add),
             ("view", view),
             ("remove", remove)]

-- Mainline
main = do
  (command:args) <- getArgs                                                         -- First will be the command, then a list of args
  let (Just action) = lookup command dispatch                                       -- Action will be the IO action based on the command string
  action args                                                                       -- Perform this action on args

-- Define functions for each seperate action
add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")                   -- Append todoItem to fileName

-- view :: [String] -> IO ()
-- view [fileName] = do
--   contents <- readFile fileName                                                     -- Read contents of todo file
--   let todoTasks = lines contents                                                    -- Extract tasks using lines contents
--       numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks  -- Number each line and print
--    putStr $ unlines numberedTasks

view :: [String] -> IO ()
view [fileName] = do
   contents <- readFile fileName
   let todoTasks = lines contents
       numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
   putStr $ unlines numberedTasks

remove :: [String] -> IO ()
remove [fileName, numberString] = do
  handle <- openFile fileName ReadMode                                               -- Open file in ReadMode into handle
  (tempName, tempHandle) <- openTempFile "." "temp"                                  -- Open temp file in local directory
  contents <- hGetContents handle                                                    -- Get contents of todofile
  let number = read numberString                                                     -- int(todoNumber)
      todoTasks = lines contents
      newTodoItems = delete (todoTasks !! number) todoTasks                          -- Delete task at index number
  hPutStr tempHandle $ unlines newTodoItems                                          -- Update todo list into temp file
  hClose handle
  hClose tempHandle
  removeFile fileName
  renameFile tempName fileName
