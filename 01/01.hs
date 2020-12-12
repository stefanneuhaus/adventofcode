pairs :: [a] -> [[a]]
pairs values = [[x,y] | x <- values, y <- values]

triples :: [a] -> [[a]]
triples values = [[x,y,z] | x <- values, y <- values, z <- values]

sumsUpTo2020 :: [Int] -> Bool
sumsUpTo2020 numbers = sum numbers == 2020

productOfValuesSummingUpTo2020 :: [[Int]] -> Int
productOfValuesSummingUpTo2020 values = product (head (filter sumsUpTo2020 values))


main = do
  expensesReport <- readFile "./expense-report.txt"
  let expenses = map read (lines expensesReport)
  print (productOfValuesSummingUpTo2020 (pairs expenses))
  print (productOfValuesSummingUpTo2020 (triples expenses))
