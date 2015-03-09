module Data.Comparison where

import Data.Function (on)
import Data.Functor.Contravariant
import Data.Monoid (Monoid, mempty)

-- | An adaptor allowing `>$<` to map over the inputs of a comparison function.
newtype Comparison a = Comparison (a -> a -> Ordering)

runComparison :: forall a. Comparison a -> a -> a -> Ordering
runComparison (Comparison a) = a

instance contravariantComparison :: Contravariant Comparison where
  (>$<) f (Comparison g) = Comparison (g `on` f)

instance semigroupComparison :: Semigroup (Comparison a) where
  (<>) (Comparison p) (Comparison q) = Comparison (p <> q)

instance monoidComparison :: Monoid (Comparison a) where
  mempty = Comparison (\_ _ -> EQ)

-- | The default comparison for any values with an `Ord` instance.
defaultComparison :: forall a. (Ord a) => Comparison a
defaultComparison = Comparison compare
