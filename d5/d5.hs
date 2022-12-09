import Data.List.Split
import Data.List (singleton, transpose)

moveCrates :: [[Char]] -> [(Int,Int,Int)] -> [[Char]]
moveCrates stacks [] = stacks
moveCrates stacks instructions =
    let (n,src,dst) = head instructions
        toTransfer = take n (stacks !! src)
    in moveCrates [
        if i==src 
            then drop n stack 
            else if i == dst
                then (reverse toTransfer) ++ stack
                else stack
        | (i, stack) <- zip [0..] stacks] $ tail instructions

solve s = 
    let regions = splitOn "\n\n" s
        crateLineStrings = init $ splitOn "\n" $ regions !! 0
        instructionLines = splitOn "\n" $ regions !! 1
        -- ex: "move 10 from 8 to 4"
        translatedInstructions = [ 
            (read n :: Int, (read src :: Int) - 1, (read dst :: Int) - 1)
            | line <- instructionLines
            , let tokens = splitOn " " line
            , let n = tokens !! 1
            , let src = tokens !! 3
            , let dst = tokens !! 5
            ]
        crateLines = [map (\l -> l !! 1) $ chunksOf 4 line | line <- crateLineStrings]
        crateStacks = map (filter (\c -> c /=  ' ')) $ transpose crateLines
        -- crateStacks = foldl1 (zipWith (++)) $ map (map singleton) crateLines
        finalCrates = moveCrates crateStacks translatedInstructions
        in map head finalCrates
main = do
    content <- getContents
    print $ solve content