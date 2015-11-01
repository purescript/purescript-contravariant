-- | This module defines the following contravariant analogues of some standard
-- | type classes:
-- |
-- |     Divide    <-> Apply
-- |     Divisible <-> Applicative
-- |     Decide    <-> Alt
-- |     Decidable <-> Alternative
-- |
-- | Ported to PureScript from the Haskell
-- | [contravariant](https://hackage.haskell.org/package/contravariant) library.

module Data.Functor.Contravariant.Divisible
  ( Divide, divide, divided
  , Divisible, conquer
  , Decide, decide, decided
  , Decidable, lose
  , module Data.Functor.Contravariant
  ) where

import Prelude

import Data.Comparison (Comparison(..))
import Data.Either (Either(..), either)
import Data.Equivalence (Equivalence(..))
import Data.Functor.Contravariant (Contravariant)
import Data.Monoid (Monoid, mempty)
import Data.Op (Op(..))
import Data.Predicate (Predicate(..))
import Data.Tuple (Tuple(..))

-- | `Divide` is the contravariant analogue of `Apply`.
-- |
-- | For example, to test equality of `Point`s, we can use the `Divide` instance
-- | for `Equivalence`:
-- |
-- | ```purescript
-- | type Point = Tuple Int Int
-- |
-- | pointEquiv :: Equivalence Point
-- | pointEquiv = divided defaultEquivalence defaultEquivalence
-- | ```

class (Contravariant f) <= Divide f where
  divide :: forall a b c. (a -> Tuple b c) -> f b -> f c -> f a

-- | `Divisible` is the contravariant analogue of `Applicative`.
class (Divide f) <= Divisible f where
  conquer :: forall a. f a

instance divideComparison :: Divide Comparison where
  divide f (Comparison g) (Comparison h) = Comparison \a b -> case f a of
    Tuple a' a'' -> case f b of
      Tuple b' b'' -> g a' b' <> h a'' b''

instance divisibleComparison :: Divisible Comparison where
  conquer = Comparison $ \_ _ -> EQ

instance divideEquivalence :: Divide Equivalence where
  divide f (Equivalence g) (Equivalence h) = Equivalence \a b -> case f a of
    Tuple a' a'' -> case f b of
      Tuple b' b'' -> g a' b' && h a'' b''

instance divisibleEquivalence :: Divisible Equivalence where
  conquer = Equivalence $ \_ _ -> true

instance dividePredicate :: Divide Predicate where
  divide f (Predicate g) (Predicate h) = Predicate \a -> case f a of
    Tuple b c -> g b && h c

instance divisiblePredicate :: Divisible Predicate where
  conquer = Predicate (const true)

instance divideOp :: (Semigroup r) => Divide (Op r) where
  divide f (Op g) (Op h) = Op \a -> case f a of
    Tuple b c -> g b <> h c

instance divisibleOp :: (Monoid r) => Divisible (Op r) where
  conquer = Op $ const mempty

-- | `divided = divide id`
divided :: forall f a b. (Divide f) => f a -> f b -> f (Tuple a b)
divided = divide id

-- | `Decide` is the contravariant analogue of `Alt`.
class (Divide f) <= Decide f where
  decide :: forall a b c. (a -> Either b c) -> f b -> f c -> f a

-- | `Decidable` is the contravariant analogue of `Alternative`.
class (Decide f, Divisible f) <= Decidable f where
  lose :: forall a. (forall r. a -> r) -> f a

-- | `decided = decide id`
decided :: forall f a b. (Decide f) => f a -> f b -> f (Either a b)
decided = decide id

instance decideComparison :: Decide Comparison where
  decide f (Comparison g) (Comparison h) = Comparison \a b -> case f a of
    Left c -> case f b of
      Left d -> g c d
      Right _ -> LT
    Right c -> case f b of
      Left _ -> GT
      Right d -> h c d

instance decidableComparison :: Decidable Comparison where
  lose f = Comparison \a _ -> f a

instance decideEquivalence :: Decide Equivalence where
  decide f (Equivalence g) (Equivalence h) = Equivalence \a b -> case f a of
    Left c -> case f b of
      Left d -> g c d
      Right _ -> false
    Right c -> case f b of
      Left _ -> false
      Right d -> h c d

instance decidableEquivalence :: Decidable Equivalence where
  lose = Equivalence

instance decidePredicate :: Decide Predicate where
  decide f (Predicate g) (Predicate h) = Predicate $ either g h <<< f

instance decidablePredicate :: Decidable Predicate where
  lose = Predicate

instance decideOp :: (Semigroup r) => Decide (Op r) where
  decide f (Op g) (Op h) = Op $ either g h <<< f

instance decidableOp :: (Monoid r) => Decidable (Op r) where
  lose = Op
