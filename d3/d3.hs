import Data.List.Split
import Data.Set (fromList, findMin, intersection, Set)
import Data.Char
-- ord 'a' = 97
-- ord 'A' = 65
splitLines s = splitOn "\n" s
myIntersect :: ([Char], [Char]) -> Set Char
myIntersect t = intersection (fromList $ fst t) (fromList $ snd t)
solve s = sum [ if char>=97 then char-96 else 27+char-65 
              | line<-splitLines s
              , let charSets = splitAt (length line `div` 2) line
              , let char = ord $ findMin $ myIntersect charSets ]
main = do
    content <- getContents
    print $ solve content