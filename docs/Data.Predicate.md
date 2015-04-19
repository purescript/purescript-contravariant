# Module Documentation

## Module Data.Predicate

#### `Predicate`

``` purescript
newtype Predicate a
  = Predicate (a -> Boolean)
```

An adaptor allowing `>$<` to map over the inputs of a predicate.

#### `runPredicate`

``` purescript
runPredicate :: forall a. Predicate a -> a -> Boolean
```


#### `contravariantPredicate`

``` purescript
instance contravariantPredicate :: Contravariant Predicate
```




