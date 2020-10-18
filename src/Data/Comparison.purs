module Data.Comparison where

import Prelude

import Data.On (On(..))

-- | An adaptor allowing `>$<` to map over the inputs of a comparison function.
type Comparison = On Ordering

-- | The default comparison for any values with an `Ord` instance.
defaultComparison :: forall a. Ord a => Comparison a
defaultComparison = On compare
