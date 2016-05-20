module Data.Op where

import Control.Category (class Category, id)
import Control.Semigroupoid (class Semigroupoid, compose, (<<<))

import Data.Functor.Contravariant (class Contravariant)

-- | The opposite of the function category.
newtype Op a b = Op (b -> a)

-- | Unpack a value of type `Op a b`, revealing a function.
runOp :: forall a b. Op a b -> b -> a
runOp (Op op) = op

instance semigroupoidOp :: Semigroupoid Op where
  compose (Op f) (Op g) = Op (compose g f)

instance categoryOp :: Category Op where
  id = Op id

instance contravariantOp :: Contravariant (Op a) where
  cmap f (Op g) = Op (g <<< f)
