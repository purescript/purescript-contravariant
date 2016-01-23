module Data.Op where

import Control.Category (class Category, id)
import Control.Semigroupoid (class Semigroupoid, compose, (<<<))

import Data.BooleanAlgebra (class BooleanAlgebra, not, (||), (&&))
import Data.Bounded (class Bounded, bottom, top)
import Data.DivisionRing (class DivisionRing)
import Data.Function (const)
import Data.Functor.Contravariant (class Contravariant)
import Data.ModuloSemiring (class ModuloSemiring, mod, (/))
import Data.Monoid (class Monoid, mempty)
import Data.Num (class Num)
import Data.Ring (class Ring, (-))
import Data.Semigroup (class Semigroup, (<>))
import Data.Semiring (class Semiring, one, zero, (+), (*))

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

instance semigroupOp :: Semigroup a => Semigroup (Op a b) where
  append (Op p) (Op q) = Op \a -> p a <> q a

instance monoidOp :: Monoid a => Monoid (Op a b) where
  mempty = Op (const mempty)

instance boundedOp :: Bounded a => Bounded (Op a b) where
  top = Op top
  bottom = Op bottom

instance semiringOp :: Semiring a => Semiring (Op a b) where
  add (Op f) (Op g) = Op \a -> f a + g a
  zero = Op (const zero)
  mul (Op f) (Op g) = Op \a -> f a * g a
  one = Op (const one)

instance ringOp :: Ring a => Ring (Op a b) where
  sub (Op f) (Op g) = Op \a -> f a - g a

instance moduloSemiringOp :: ModuloSemiring a => ModuloSemiring (Op a b) where
  div (Op f) (Op g) = Op \a -> f a / g a
  mod (Op f) (Op g) = Op \a -> f a `mod` g a

instance divisionRingOp :: DivisionRing a => DivisionRing (Op a b)

instance numOp :: Num a => Num (Op a b)

instance booleanAlgebraOp :: BooleanAlgebra a => BooleanAlgebra (Op a b) where
  conj (Op f) (Op g) = Op \a -> f a && g a
  disj (Op f) (Op g) = Op \a -> f a || g a
  not (Op f) = Op \a -> not (f a)
