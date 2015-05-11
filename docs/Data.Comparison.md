## Module Data.Comparison

#### `Comparison`

``` purescript
newtype Comparison a
  = Comparison (a -> a -> Ordering)
```

##### Instances
``` purescript
instance contravariantComparison :: Contravariant Comparison
instance semigroupComparison :: Semigroup (Comparison a)
instance monoidComparison :: Monoid (Comparison a)
```

An adaptor allowing `>$<` to map over the inputs of a comparison function.

#### `runComparison`

``` purescript
runComparison :: forall a. Comparison a -> a -> a -> Ordering
```

#### `defaultComparison`

``` purescript
defaultComparison :: forall a. (Ord a) => Comparison a
```

The default comparison for any values with an `Ord` instance.


