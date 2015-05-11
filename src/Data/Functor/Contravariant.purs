module Data.Functor.Contravariant where

-- | A `Contravariant` functor can be seen as a way of changing the input type
-- | of a consumer of input, in contrast to the standard covariant `Functor`
-- | that can be seen as a way of changing the output type of a producer of
-- | output.
-- |
-- | `Contravariant` instances should satisfy the following laws:
-- |
-- | - Identity `(>$<) id = id`
-- | - Composition `(f >$<) <<< (g >$<) = (>$<) (g <<< f)`
class Contravariant f where
  cmap :: forall a b. (b -> a) -> f a -> f b

-- | An infix version of `cmap`.
(>$<) :: forall a b f. (Contravariant f) => (b -> a) -> f a -> f b
(>$<) = cmap

-- | `(>#<)` is `(>$<)` with its arguments reversed.
(>#<) :: forall a b f. (Contravariant f) => f a -> (b -> a) -> f b
(>#<) x f = f >$< x
