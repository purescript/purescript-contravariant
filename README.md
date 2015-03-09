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


## Module Data.Equivalence

#### `Equivalence`

``` purescript
newtype Equivalence a
  = Equivalence (a -> a -> Boolean)
```

An adaptor allowing `>$<` to map over the inputs of an equivalence
relation.

#### `runEquivalence`

``` purescript
runEquivalence :: forall a. Equivalence a -> a -> a -> Boolean
```


#### `contravariantEquivalence`

``` purescript
instance contravariantEquivalence :: Contravariant Equivalence
```


#### `semigroupEquivalence`

``` purescript
instance semigroupEquivalence :: Semigroup (Equivalence a)
```


#### `monoidEquivalence`

``` purescript
instance monoidEquivalence :: Monoid (Equivalence a)
```


#### `defaultEquivalence`

``` purescript
defaultEquivalence :: forall a. (Eq a) => Equivalence a
```

The default equivalence relation for any values with an `Eq` instance.

#### `comparisonEquivalence`

``` purescript
comparisonEquivalence :: forall a. Comparison a -> Equivalence a
```

An equivalence relation for any `Comparison`.


## Module Data.Functor.Contravariant

#### `Contravariant`

``` purescript
class Contravariant f where
  (>$<) :: forall a b. (b -> a) -> f a -> f b
```

A `Contravariant` functor can be seen as a way of changing the input type
of a consumer of input, in contrast to the standard covariant `Functor`
that can be seen as a way of changing the output type of a producer of
output.

`Contravariant` instances should satisfy the following laws:

- Identity `(>$<) id = id`
- Composition `(f >$<) <<< (g >$<) = (>$<) (g <<< f)`

#### `(>#<)`

``` purescript
(>#<) :: forall a b f. (Contravariant f) => f a -> (b -> a) -> f b
```

`(>#<)` is `(>$<)` with its arguments reversed.


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