module Data.Functor.Contravariant where

import Prelude

import Data.Const (Const(..))

-- | A `Contravariant` functor can be seen as a way of changing the input type
-- | of a consumer of input, in contrast to the standard covariant `Functor`
-- | that can be seen as a way of changing the output type of a producer of
-- | output.
-- |
-- | `Contravariant` instances should satisfy the following laws:
-- |
-- | - Identity `cmap id = id`
-- | - Composition `cmap f <<< cmap g = cmap (g <<< f)`
class Contravariant f where
  cmap :: forall a b. (b -> a) -> f a -> f b

infixl 4 cmap as >$<

-- | `cmapFlipped` is `cmap` with its arguments reversed.
cmapFlipped :: forall a b f. Contravariant f => f a -> (b -> a) -> f b
cmapFlipped x f = f >$< x

infixl 4 cmapFlipped as >#<

coerce :: forall f a b. Contravariant f => Functor f => f a -> f b
coerce a = absurd <$> (absurd >$< a)

-- | As all `Contravariant` functors are also trivially `Invariant`, this function can be used as the `imap` implementation for any types that have an existing `Contravariant` instance.
imapC :: forall f a b. Contravariant f => (a -> b) -> (b -> a) -> f a -> f b
imapC _ f = cmap f

instance contravariantConst :: Contravariant (Const a) where
  cmap _ (Const x) = Const x

cflap :: forall a f b. Contravariant f => f b -> a -> f (a -> b)
cflap ff x  = (\f -> f x) >$< ff

infixl 4 cflap as >@<

cvoid :: forall a f. Contravariant f => f Unit -> f a
cvoid = cmap (const unit)

cvoidRight :: forall a b f. Contravariant f => a -> f a -> f b
cvoidRight x = cmap (const x)

infixl 4 cvoidRight as >$

cvoidLeft :: forall a b f. Contravariant f => f a -> a -> f b
cvoidLeft f x = cmap (const x) f

infixl 4 cvoidLeft as $<
