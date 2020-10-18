module Data.Decide where

import Prelude

import Data.Divide (class Divide)
import Data.Either (Either(..), either)
import Data.On (On(..))
import Data.Op (Op(..))
import Data.Predicate (Predicate(..))

-- | `Decide` is the contravariant analogue of `Alt`.
class Divide f <= Decide f where
  choose :: forall a b c. (a -> Either b c) -> f b -> f c -> f a

instance chooseOn :: Decide (On m) where
  choose f (On g) (On h) = On \a b -> case f a of
    Left c -> case f b of
      Left d -> g c d
      Right _ -> LT
    Right c -> case f b of
      Left _ -> GT
      Right d -> h c d

instance choosePredicate :: Decide Predicate where
  choose f (Predicate g) (Predicate h) = Predicate (either g h <<< f)

instance chooseOp :: Semigroup r => Decide (Op r) where
  choose f (Op g) (Op h) = Op (either g h <<< f)

-- | `chosen = choose id`
chosen :: forall f a b. Decide f => f a -> f b -> f (Either a b)
chosen = choose identity
