module Data.Decide where

import Data.Comparison (Comparison(..))
import Data.Divide (class Divide)
import Data.Either (Either(..), either)
import Data.Equivalence (Equivalence(..))
import Data.Function (id, (<<<))
import Data.Op (Op(..))
import Data.Ordering (Ordering(..))
import Data.Predicate (Predicate(..))
import Data.Semigroup (class Semigroup)

-- | `Decide` is the contravariant analogue of `Alt`.
class Divide f <= Decide f where
  choose :: forall a b c. (a -> Either b c) -> f b -> f c -> f a

instance chooseComparison :: Decide Comparison where
  choose f (Comparison g) (Comparison h) = Comparison \a b -> case f a of
    Left c -> case f b of
      Left d -> g c d
      Right _ -> LT
    Right c -> case f b of
      Left _ -> GT
      Right d -> h c d

instance chooseEquivalence :: Decide Equivalence where
  choose f (Equivalence g) (Equivalence h) = Equivalence \a b -> case f a of
    Left c -> case f b of
      Left d -> g c d
      Right _ -> false
    Right c -> case f b of
      Left _ -> false
      Right d -> h c d

instance choosePredicate :: Decide Predicate where
  choose f (Predicate g) (Predicate h) = Predicate (either g h <<< f)

instance chooseOp :: Semigroup r => Decide (Op r) where
  choose f (Op g) (Op h) = Op (either g h <<< f)

-- | `chosen = choose id`
chosen :: forall f a b. Decide f => f a -> f b -> f (Either a b)
chosen = choose id
