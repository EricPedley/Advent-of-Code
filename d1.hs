import Data.List
import Data.List.Split
lastN n xs = drop (length xs - n) xs
solve s = sum $ lastN 3 $ sort [sum [if length el > 0 then read el::Int else 0 | el <- splitOn "\n" group] | group <- (splitOn "\n\n" s)]
main = do
    contents <- getContents 
    print $ solve contents 
