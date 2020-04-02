import Protolude

import Data.Aeson (decode, encode)
import Criterion.Main (defaultMain, bench, whnf)
import Hedgehog (Gen)
import qualified Hedgehog.Gen as Gen
import qualified Hedgehog.Range as Range
import System.IO.Unsafe (unsafePerformIO)

import qualified AnyClass as A
import qualified GenericManual as B

main :: IO ()
main = do
  print $ length sampleA -- make sure it's evaluated
  defaultMain
    [ bench "AnyClass" $ whnf encode sampleA
    , bench "ManualGeneric" $ whnf encode sampleB
    ]

gen :: Gen B.Foo
gen = B.Foo
  <$> text
  <*> int
  <*> Gen.float (Range.linearFrac 0 100000)
  <*> field4
  <*> Gen.list linear field5
  <*> Gen.maybe field6
  where
    linear :: Integral a => Range.Range a
    linear = Range.linear 10 100

    text = Gen.text linear Gen.alpha
    int = Gen.int linear

    field4 = B.Field4
      <$> text
      <*> Gen.maybe field5
      <*> Gen.list linear int

    field5 = B.Field5
      <$> int
      <*> Gen.list linear text

    field6 = Gen.bool >>= \case
      True -> B.Field6_1 <$> text
      False -> B.Field6_2 <$> int

{-# NOINLINE sampleB #-}
sampleB :: [B.Foo]
sampleB = unsafePerformIO $ Gen.sample (Gen.list (Range.constant 200 200) gen)

sampleA :: [A.Foo]
sampleA = maybe (panic "oops") identity $ decode $ encode sampleB