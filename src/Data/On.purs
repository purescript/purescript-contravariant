module Data.On where

import Prelude

import Data.Function (on)
import Data.Functor.Contravariant (class Contravariant)
import Data.Monoid.Conj (Conj)
import Data.Newtype (class Newtype)

newtype On m a = On (a -> a -> m)

derive instance newtypeEquivalence :: Newtype (On m a) _

instance semigroupEquivalence :: (Semigroup m) => Semigroup (On m a) where
  append (On p) (On q) = On (\a b -> p a b <> q a b)

instance monoidEquivalence :: (Monoid m) => Monoid (On m a) where
  mempty = On mempty

instance contravariantEquivalence :: Contravariant (On m) where
  cmap f (On g) = On (g `on` f)

type Equivalence = On (Conj Boolean)
type Comparison = On Ordering
