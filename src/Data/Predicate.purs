module Data.Predicate where

import Prelude

import Data.Functor.Contravariant (class Contravariant)
import Data.Newtype (class Newtype)

-- | An adaptor allowing `>$<` to map over the inputs of a predicate.
newtype Predicate a = Predicate (a -> Boolean)

derive instance newtypePredicate :: Newtype (Predicate a) _

instance contravariantPredicate :: Contravariant Predicate where
  cmap f (Predicate g) = Predicate (g <<< f)
