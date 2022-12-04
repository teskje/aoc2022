module Main where

import Aoc (Parser, getParsedLines)
import Data.Ix (range)
import Data.List (intersect)
import Text.Megaparsec.Char (char)
import Text.Megaparsec.Char.Lexer (decimal)

main :: IO ()
main = do
  input <- getParsedLines 4 sectionsPair
  print $ (length . filter contains) input
  print $ (length . filter overlaps) input

sectionsPair :: Parser ([Int], [Int])
sectionsPair = do
  a <- sections
  _ <- char ','
  b <- sections
  return (a, b)
  where
    sections = range' <$> decimal <* char '-' <*> decimal
    range' = curry range

contains :: ([Int], [Int]) -> Bool
contains (a, b) =
  let i = a `intersect` b
   in i == a || i == b

overlaps :: ([Int], [Int]) -> Bool
overlaps (a, b) =
  let i = a `intersect` b
   in not (null i)
