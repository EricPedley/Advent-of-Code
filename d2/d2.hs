import Data.List.Split
import Data.Map
scores = fromList [
          (["A","X"], 3), -- lose
          (["B","X"], 1),
          (["C","X"], 2),
          (["A","Y"], 4), -- draw
          (["B","Y"], 5),
          (["C","Y"], 6),
          (["A","Z"], 8), -- win
          (["B","Z"], 9),
          (["C","Z"], 7)
        ]
solve s = let a = init [splitOn " " line | line <- splitOn "\n" s]
          in sum [(scores ! pair) | pair <- a, let x = pair !! 0, let y = pair !! 1]
main = do
    content <- getContents
    print $ solve content

-- 12533 too high
-- 11801 too low