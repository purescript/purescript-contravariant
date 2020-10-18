module Data.Equivalence where

import Prelude

import Data.Comparison (Comparison)
import Data.Monoid.Conj (Conj(..))
import Data.On (On(..))

-- | An adaptor allowing `>$<` to map over the inputs of an equivalence
-- | relation.
type Equivalence = On (Conj Boolean)

-- | The default equivalence relation for any values with an `Eq` instance.
defaultEquivalence :: forall a. Eq a => Equivalence a
defaultEquivalence = On (\a b -> Conj (eq a b))

-- | An equivalence relation for any `Comparison`.
comparisonEquivalence :: forall a. Comparison a -> Equivalence a
comparisonEquivalence (On p) = On (\a b -> Conj (p a b == EQ))
