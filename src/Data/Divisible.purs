module Data.Divisible where

import Prelude

import Data.Divide (class Divide)
import Data.On (On(..))
import Data.Op (Op(..))
import Data.Predicate (Predicate(..))

-- | `Divisible` is the contravariant analogue of `Applicative`.
class Divide f <= Divisible f where
  conquer :: forall a. f a

instance divisibleOn :: Monoid m => Divisible (On m) where
  conquer = On $ \_ _ -> mempty

instance divisiblePredicate :: Divisible Predicate where
  conquer = Predicate (const true)

instance divisibleOp :: (Monoid r) => Divisible (Op r) where
  conquer = Op $ const mempty
