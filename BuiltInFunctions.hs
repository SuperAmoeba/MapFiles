module BuiltInFunctions (hgrep) where

import System.Environment (getArgs)
import System.Directory (doesFileExist)

-- Functions

hgrep :: String -> FilePath -> IO ()
hgrep word file = do
  fExist <- doesFileExist file
  if not fExist then putStrLn "\xE61F Error: File doesn't exist"
  else do
    fileContents <- readFile file
    if word `elem` words fileContents then
      putStrLn $ word ++ "            <- found in " ++ file
    else
      --putStrLn $ word ++ " not found in " ++ file
      return ()
