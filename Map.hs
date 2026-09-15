module Main where

import System.Environment (getArgs)
import System.Process (callCommand)
import System.Directory (doesDirectoryExist, getDirectoryContents, listDirectory, doesFileExist)
import System.FilePath (takeExtension, (</>))
import BuiltInFunctions (hgrep)

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
          --putStrLn ""
          --putStrLn "\xE61F Yay! It worked :3"
        else putStrLn "\xE61F Error: Folder does not exist"
    [command, dir, ext] -> do
      exists <- doesDirectoryExist dir
      if exists
        then do
          files <- (filter (\f -> f /= "." && f /= "..")) <$> (getDirectoryContents dir)
          let ffiles = filterExtensions ext files
          let fullCmd file = command ++ " \"" ++ dir ++ "/" ++ file ++ "\""
          mapM_ callCommand $ map fullCmd ffiles
          --putStrLn ""
          --putStrLn "\xE61F Yay! It worked :3"
        else putStrLn "\xE61F Error: Folder does not exist"
    ["-r", command, dir, ext] -> do 
      exists <- doesDirectoryExist dir
      if exists
        then do
          files <- listDirectory dir
          recurse files dir ext command
      else putStrLn "\xE61F Error: Folder does not exist"
    ["-f", action, word, dir] -> do
      exists <- doesDirectoryExist dir
      if exists then do
        files <- (filter (\f -> f /= "." && f /= "..")) <$> (getDirectoryContents dir)
        let fullPaths = map (dir </>) files
        case action of
          "hgrep" -> do
            mapM_ (hgrep word) fullPaths
            --putStrLn ""
            --putStrLn "\xE61F Yay! It worked :3"
          _ ->
            putStrLn "\xE61F Error: Function does not exist"
      else putStrLn "\xE61F Error: Folder does not exist"
    ["-f", action, word, dir, ext] -> do
      exists <- doesDirectoryExist dir
      if exists then do
        files <- (filter (\f -> f /= "." && f /= "..")) <$> (getDirectoryContents dir)
        let ffiles = filterExtensions ext files
            fullPaths = map (dir </>) ffiles
        case action of
          "hgrep" -> do
            mapM_ (hgrep word) fullPaths
            --putStrLn ""
            --putStrLn "\xE61F Yay! It worked :3"
          _ ->
            putStrLn "\xE61F Error: Function does not exist"
      else putStrLn "\xE61F Error: Folder does not exist"
    _ ->
      putStrLn "\xE61F Usage: './map <cmd> <dir>' || './map <cmd> <dir> <file extension>' || './map <flag> <cmd/function> <dir> <file extension>'"


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
