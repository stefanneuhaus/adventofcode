hitsTree :: (String,Int) -> Bool
hitsTree rowIndexed = ((fst rowIndexed) !! (snd rowIndexed)) == '#'

main = do
  mapString <- readFile "./map.txt"
  let landscape = lines mapString
  let indexes = [ mod i 31 | i <- [0,3..]]
  print (length (filter hitsTree (zip landscape indexes)))
