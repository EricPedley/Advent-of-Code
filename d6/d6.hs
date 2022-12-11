import qualified Data.Set as Set

solve s i = let
    uniqueChars = Set.size $ Set.fromList $ take 14 s
    in if uniqueChars==14 then i+14 else solve (drop 1 s) i+1
main = do
    content <- getContents
    print $ solve content 0

-- 1076 too low