# Module Documentation

## Module Data.Comparison

#### `Comparison`

``` purescript
newtype Comparison a
  = Comparison (a -> a -> Ordering)
```

An adaptor allowing `>$<` to map over the inputs of a comparison function.

#### `runComparison`

``` purescript
runComparison :: forall a. Comparison a -> a -> a -> Ordering
```


#### `contravariantComparison`

``` purescript
instance contravariantComparison :: Contravariant Comparison
```


#### `semigroupComparison`

``` purescript
instance semigroupComparison :: Semigroup (Comparison a)
```


#### `monoidComparison`

``` purescript
instance monoidComparison :: Monoid (Comparison a)
```


#### `defaultComparison`

``` purescript
defaultComparison :: forall a. (Ord a) => Comparison a
```

The default comparison for any values with an `Ord` instance.



