import Data.List.Split
import qualified Data.Map as HM

insertVals :: HM.Map String Int -> [String] -> Int -> HM.Map String Int
insertVals m keys value =
    if (length keys) == 0 
        then m
    else let
        newMap = HM.insertWith (+) (head keys) value m   
        in insertVals newMap (tail keys) value

buildMap :: HM.Map String Int -> [String] -> [String] -> HM.Map String Int
buildMap m lines directoryStack = if (length lines) > 0
    then let
        line = lines !! 0
        in if (line !! 0) == '$'
            then let
                command = take 2 (drop 2 line)
                in if command == "cd"
                    then let
                        directory = drop 5 line
                        in if directory == "/"
                            then
                                buildMap m (drop 1 lines) [""]
                            else if directory == ".."
                                then buildMap m (drop 1 lines) (tail directoryStack)
                            else
                                buildMap m (drop 1 lines) ([(foldl1 (++) directoryStack) ++ "/" ++ directory] ++ directoryStack)
                    else
                        buildMap m (drop 1 lines) directoryStack
            else let
                tokens = splitOn " " line
                in if (tokens !! 0) == "dir"
                    then
                        buildMap m (drop 1 lines) directoryStack
                    else let
                        newMap = insertVals m directoryStack (read (tokens !! 0) :: Int) 
                        in buildMap newMap (drop 1 lines) directoryStack
                
    else m

solve s = let
    lines = splitOn "\n" s
    in sum $ filter ((>=) 100000) $ snd $ unzip $ HM.toList $ buildMap HM.empty lines ["/"]
main = do
    content <- getContents
    print $ solve content
-- 210136316 too high

-- 1038055 too low