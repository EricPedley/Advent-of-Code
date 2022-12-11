import qualified Data.Set as Set

solve s i = let
    uniqueChars = Set.size $ Set.fromList $ take 4 s
    in if uniqueChars==4 then i+4 else solve (drop 1 s) i+1
main = do
    content <- getContents
    print $ solve content 0

-- 1076 too low