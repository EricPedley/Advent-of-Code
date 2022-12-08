import Data.List.Split
import Data.Set (fromList, findMin, intersection, Set)
import Data.Char
-- ord 'a' = 97
-- ord 'A' = 65
splitLines s = splitOn "\n" s
toInt s  = read s :: Int
solve s = sum [ if not (b<c || a>d) then 1 else 0
                | intervalStringPair <- map (splitOn ",") $ splitLines s
                , let (p1,p2) = (splitOn "-" $ intervalStringPair !! 0, splitOn "-" $ intervalStringPair !! 1)
                , let (a,b) = (toInt $ p1 !! 0, toInt $ p1 !! 1)
                , let (c,d) = (toInt $ p2 !! 0, toInt $ p2 !! 1)
            ]
main = do
    content <- getContents
    print $ solve content