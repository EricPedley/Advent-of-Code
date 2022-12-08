import Data.List.Split
import Data.Set (fromList, findMin, intersection, Set)
import Data.Char
-- ord 'a' = 97
-- ord 'A' = 65
splitLines s = splitOn "\n" s
solve s = sum [ if char>=97 then char-96 else 27+char-65 
              | group <- map (map fromList) $ chunksOf 3 $ splitLines s
              , let char = ord $ findMin $ intersection (group !! 0) (intersection (group !! 1) (group !! 2)) ]
main = do
    content <- getContents
    print $ solve content