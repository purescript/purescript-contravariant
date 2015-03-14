module Data.Functor.ContraFunctor where

-- | A `ContraFunctor` can be seen as a way of changing the input type of a
-- | consumer of input, in contrast to the standard covariant `Functor` that
-- | can be seen as a way of changing the output type of a producer of output.
-- |
-- | `ContraFunctor` instances should satisfy the following laws:
-- |
-- | - Identity `(>$<) id = id`
-- | - Composition `(f >$<) <<< (g >$<) = (>$<) (g <<< f)`
class ContraFunctor f where
  (>$<) :: forall a b. (b -> a) -> f a -> f b

-- | `(>#<)` is `(>$<)` with its arguments reversed.
(>#<) :: forall a b f. (ContraFunctor f) => f a -> (b -> a) -> f b
(>#<) x f = f >$< x
