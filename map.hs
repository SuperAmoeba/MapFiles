import System.IO
import System.Environment (getArgs)
import System.Process (callCommand)
import System.Directory (doesDirectoryExist, getDirectoryContents)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [command, dir] -> do
      exists <- doesDirectoryExist dir
      if exists
        then do
          files <- (filter (\f -> f /= "." && f /= "..")) <$> (getDirectoryContents dir)
          let fullCmd file = command ++ " \"" ++ dir ++ "/" ++ file ++ "\""
          mapM_ callCommand $ map fullCmd files
          putStrLn "Yay! It worked :3"
        else putStrLn "Error: Folder does not exist"
    _ ->
      putStrLn "Usage: ./map <cmd> <dir>"

{-
-- already predefined as mapM_ :sob:
mapC :: (a -> IO ()) -> [a] -> IO ()
mapC f []     = return ()
mapC f (x:xs) = f x >> mapC f xs
-}