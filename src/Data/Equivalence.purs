module Data.Equivalence where

import Data.Comparison
import Data.Function (on)
import Data.Functor.Contravariant
import Data.Monoid (Monoid, mempty)

-- | An adaptor allowing `>$<` to map over the inputs of an equivalence
-- | relation.
newtype Equivalence a = Equivalence (a -> a -> Boolean)

runEquivalence :: forall a. Equivalence a -> a -> a -> Boolean
runEquivalence (Equivalence a) = a

instance contravariantEquivalence :: Contravariant Equivalence where
  (>$<) f (Equivalence g) = Equivalence (g `on` f)

instance semigroupEquivalence :: Semigroup (Equivalence a) where
  (<>) (Equivalence p) (Equivalence q) = Equivalence (\a b -> p a b && q a b)

instance monoidEquivalence :: Monoid (Equivalence a) where
  mempty = Equivalence (\_ _ -> true)

-- | The default equivalence relation for any values with an `Eq` instance.
defaultEquivalence :: forall a. (Eq a) => Equivalence a
defaultEquivalence = Equivalence (==)

-- | An equivalence relation for any `Comparison`.
comparisonEquivalence :: forall a. Comparison a -> Equivalence a
comparisonEquivalence (Comparison p) = Equivalence (\a b -> p a b == EQ)
