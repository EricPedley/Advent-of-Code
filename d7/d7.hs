import Data.List.Split
import qualified Data.Map as HM
import qualified Data.Set as Set

insertVals :: HM.Map String Int -> [String] -> Int -> HM.Map String Int
insertVals m keys value =
    if (length keys) == 0 
        then m
    else let
        newMap = HM.insertWith (+) (head keys) value m   
        in insertVals newMap (tail keys) value

buildMap :: HM.Map String Int -> [String] -> [String] -> HM.Map String Int -> HM.Map String Int
buildMap m lines directoryStack visitedSet = if (length lines) > 0
    then let
        line = lines !! 0
        in if (line !! 0) == '$'
            then let
                command = take 2 (drop 2 line)
                directory = drop 5 line
                fullPath = (head directoryStack) ++ directory ++ "/"
                in if command == "cd"
                    then if directory == "/"
                        then
                            buildMap m (drop 1 lines) ["/"] visitedSet
                        else if directory == ".."
                            then buildMap m (drop 1 lines) (tail directoryStack) visitedSet
                        else
                            buildMap m (drop 1 lines) ([fullPath] ++ directoryStack) visitedSet
                    else
                        buildMap m (drop 1 lines) directoryStack (HM.insertWith (+) (head directoryStack) 1 visitedSet)
            else let
                tokens = splitOn " " line
                in if (tokens !! 0) == "dir"
                    then
                        buildMap m (drop 1 lines) directoryStack visitedSet
                    else let
                        newMap = if (HM.findWithDefault 2 (head directoryStack) visitedSet) > 1
                            then m
                            else
                                insertVals m directoryStack (read (tokens !! 0) :: Int) 
                        in buildMap newMap (drop 1 lines) directoryStack visitedSet
                
    else m

solve s = let
    lines = splitOn "\n" s
    -- in HM.toList $ buildMap HM.empty lines ["/"] HM.empty
    values = snd $ unzip $ HM.toList $ buildMap HM.empty lines ["/"] HM.empty
    biggest = maximum values
    in minimum $ filter ((<=) (30000000- (70000000 - biggest))) values 
main = do
    content <- getContents
    print $ solve content
-- 210136316 too high

-- 1038055 too low

-- pt2:
-- 44795677 too high
-- 41523658 too high