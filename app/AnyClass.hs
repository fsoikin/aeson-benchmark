module AnyClass where

import Protolude

import Data.Aeson
import GHC.Generics (Generic)

data Foo = Foo
  { field1 :: Text
  , field2 :: Int
  , field3 :: Float
  , field4 :: Field4
  , field5 :: [Field5]
  , field6 :: Maybe Field6
  }
  deriving (Show, Generic)
  deriving anyclass (FromJSON, ToJSON)

data Field4 = Field4
  { field1_1 :: Text
  , field1_2 :: Maybe Field5
  , field1_3 :: [Int]
  }
  deriving (Show, Generic)
  deriving anyclass (FromJSON, ToJSON)

data Field5 = Field5
  { field5_1 :: Int
  , field5_2 :: [Text]
  }
  deriving (Show, Generic)
  deriving anyclass (FromJSON, ToJSON)

data Field6
  = Field6_1 Text | Field6_2 Int
  deriving (Show, Generic)
  deriving anyclass (FromJSON, ToJSON)