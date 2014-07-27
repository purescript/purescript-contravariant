# Module Documentation

## Module Data.Contravariant

### Type Classes

    class Contravariant f where
      (>$<) :: forall a b. (b -> a) -> f a -> f b



