-- | This module defines the opposite of the function category, `Op` and its instances.
module Data.Op
  ( Op(..)
  , runOp
  ) where

import Prelude

import Data.Monoid (Monoid, mempty)
import Data.Functor.Contravariant (Contravariant)

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
  cmap f g = Op (runOp g <<< f)

instance semigroupOp :: (Semigroup a) => Semigroup (Op a b) where
  append (Op p) (Op q) = Op \a -> p a <> q a

instance monoidOp :: (Monoid a) => Monoid (Op a b) where
  mempty = Op (const mempty)
