module Data.Predicate where

import Data.Functor.ContraFunctor

-- | An adaptor allowing `>$<` to map over the inputs of a predicate.
newtype Predicate a = Predicate (a -> Boolean)

runPredicate :: forall a. Predicate a -> a -> Boolean
runPredicate (Predicate a) = a

instance contraFunctorPredicate :: ContraFunctor Predicate where
  (>$<) f (Predicate g) = Predicate (g <<< f)
