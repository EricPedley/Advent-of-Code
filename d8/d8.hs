import Data.List
import Data.List.Split
import Data.Char

maxOr0 :: [Int] -> Int
maxOr0 [] = -1
maxOr0 xs = maximum xs

argmax :: [Int] -> Int
argmax xs = head $ elemIndices (maximum xs) xs

blockIndex :: Int -> [Int] -> Int
blockIndex a [] = 0
blockIndex i xs = let 
    indices = findIndices ((<=) i) xs
    in if indices == []
        then 0
        else last indices            

solve s = let
    lines = splitOn "\n" s
    numMatrix = [map (\c -> (ord c - ord '0')) line | line <- lines]
    leftPerspective = [[if el > maxOr0 (take i row) then i else i - blockIndex el (take i row) | (i,el) <- zip [0..] row]| row <- numMatrix]
    rightPerspective = [reverse [if el > maxOr0 (take i reversed) then i else i - blockIndex el (take i reversed) | (i,el) <- zip [0..] reversed]| row <- numMatrix, let reversed = reverse row]
    topPerspective = transpose [[if el > maxOr0 (take i col) then i else i - blockIndex el (take i col) | (i,el) <- zip [0..] col]| col <- transpose numMatrix]
    bottomPerspective = transpose [reverse [if el > maxOr0 (take i reversed) then i else i - blockIndex el (take i reversed) | (i,el) <- zip [0..] reversed]| col <- transpose numMatrix, let reversed = reverse col]
    visibility = foldl1 (\a b -> [zipWith (*) rowa rowb | (rowa, rowb) <- zip a b]) [leftPerspective, rightPerspective, topPerspective, bottomPerspective]
    in maximum [el | row <- visibility, el <- row]

main = do
    content <- getContents
    print $ solve content