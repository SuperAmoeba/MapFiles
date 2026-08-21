import System.Environment (getArgs)
import System.Process (callCommand)
import System.Directory (doesDirectoryExist, getDirectoryContents, listDirectory, doesFileExist)
import System.FilePath (takeExtension, (</>))


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
        else putStrLn "\xE61F Error. Something went wrong. Usage: './map <cmd> <dir>' || './map <cmd> <dir> <file extension>' || './map <flag> <cmd> <dir> <file extension>'"
    [flag, command, dir, ext] -> do 
      exists <- doesDirectoryExist dir
      if exists
        then do
          if flag == "-r"
            then do 
              files <- listDirectory dir
              recurse files dir ext command
          else putStrLn "\xE61F Error: Only supported flag is '-r'"
      else putStrLn "\xE61F Error: Folder does not exist"
    _ ->
      putStrLn "\xE61F Usage: './map <cmd> <dir>' || './map <cmd> <dir> <file extension>' || './map <flag> <cmd> <dir> <file extension>'"


type Extention = String
type Command = String

recurse :: [FilePath] -> FilePath -> Extention -> Command -> IO ()
recurse []     _   _   _   = return ()
recurse (x:xs) pre ext cmd = do
  let y = pre </> x
  isDir <- doesDirectoryExist y
  if isDir then do
    subfiles <- listDirectory y
    recurse subfiles y ext cmd
    recurse xs pre ext cmd
  else do
    isFile <- doesFileExist y
    if isFile && (takeExtension y == ext) then do
      callCommand $ cmd ++ " " ++ y
      recurse xs pre ext cmd
    else recurse xs pre ext cmd
    

filterExtensions :: String -> [FilePath] -> [FilePath]
filterExtensions ext = filter (\f -> takeExtension f == ext)
