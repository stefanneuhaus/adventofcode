numberOfHitTrees :: [String] -> (Int, Int) -> Int
numberOfHitTrees landscape (slopeRight, slopeDown) = (length (filter hitsTree
    (zip
        [ landscapeRow | (landscapeRow, rowIndex) <- (zip landscape [0..]), mod rowIndex slopeDown == 0 ]
        [0, slopeRight..])))

hitsTree :: (String, Int) -> Bool
hitsTree (landscapeRow, positionOffset) = (landscapeRow !! (mod positionOffset (length landscapeRow))) == '#'

main = do
    mapString <- readFile "./map.txt"
    let landscape = lines mapString
    print (numberOfHitTrees landscape (3, 1))
    print (product (map (numberOfHitTrees landscape) [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]))
