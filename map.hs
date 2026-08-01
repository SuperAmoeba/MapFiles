import System.IO
import System.Environment (getArgs)
import System.Process (callCommand)
import System.Directory (doesDirectoryExist, getDirectoryContents)
import System.FilePath (takeExtension)

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
          putStrLn ""
          putStrLn "\xE61F Yay! It worked :3"
        else putStrLn "\xE61F Error: Folder does not exist"
    [command, dir, ext] -> do
      exists <- doesDirectoryExist dir
      if exists
        then do
          files <- (filter (\f -> f /= "." && f /= "..")) <$> (getDirectoryContents dir)
          let ffiles = filterExtensions ext files
          let fullCmd file = command ++ " \"" ++ dir ++ "/" ++ file ++ "\""
          mapM_ callCommand $ map fullCmd ffiles
          putStrLn ""
          putStrLn "\xE61F Yay! It worked :3"
        else putStrLn "\xE61F Error: Folder does not exist"
    _ ->
      putStrLn "\xE61F Usage: './map <cmd> <dir>' or './map <cmd> <dir> <file extension>'"

filterExtensions :: String -> [FilePath] -> [FilePath]
filterExtensions ext = filter (\f -> takeExtension f == ext)