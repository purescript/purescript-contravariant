## Module Data.Equivalence

#### `Equivalence`

``` purescript
newtype Equivalence a
  = Equivalence (a -> a -> Boolean)
```

An adaptor allowing `>$<` to map over the inputs of an equivalence
relation.

##### Instances
``` purescript
instance contravariantEquivalence :: Contravariant Equivalence
instance semigroupEquivalence :: Semigroup (Equivalence a)
instance monoidEquivalence :: Monoid (Equivalence a)
```

#### `runEquivalence`

``` purescript
runEquivalence :: forall a. Equivalence a -> a -> a -> Boolean
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


