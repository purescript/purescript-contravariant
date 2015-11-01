module Data.Predicate where

import Prelude

import Data.Functor.Contravariant (Contravariant)

-- | An adaptor allowing `>$<` to map over the inputs of a predicate.
newtype Predicate a = Predicate (a -> Boolean)

runPredicate :: forall a. Predicate a -> a -> Boolean
runPredicate (Predicate a) = a

instance contravariantPredicate :: Contravariant Predicate where
  cmap f (Predicate g) = Predicate (g <<< f)
