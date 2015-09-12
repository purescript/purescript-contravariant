## Module Data.Functor.Contravariant.Divisible

This module defines the following contravariant analogues of some standard
type classes:

    Divide    <-> Apply
    Divisible <-> Applicative
    Decide    <-> Alt
    Decidable <-> Alternative

Ported to PureScript from the Haskell 
[contravariant](https://hackage.haskell.org/package/contravariant) library.

#### `Divide`

``` purescript
class (Contravariant f) <= Divide f where
  divide :: forall a b c. (a -> Tuple b c) -> f b -> f c -> f a
```

`Divide` is the contravariant analogue of `Apply`.

For example, to test equality of `Point`s, we can use the `Divide` instance
for `Equivalence`:

```purescript
type Point = Tuple Int Int

pointEquiv :: Equivalence Point
pointEquiv = divided defaultEquivalence defaultEquivalence
```

##### Instances
``` purescript
instance divideComparison :: Divide Comparison
instance divideEquivalence :: Divide Equivalence
instance dividePredicate :: Divide Predicate
instance divideOp :: (Semigroup r) => Divide (Op r)
```

#### `Divisible`

``` purescript
class (Divide f) <= Divisible f where
  conquer :: forall a. f a
```

`Divisible` is the contravariant analogue of `Applicative`.

##### Instances
``` purescript
instance divisibleComparison :: Divisible Comparison
instance divisibleEquivalence :: Divisible Equivalence
instance divisiblePredicate :: Divisible Predicate
instance divisibleOp :: (Monoid r) => Divisible (Op r)
```

#### `divided`

``` purescript
divided :: forall f a b. (Divide f) => f a -> f b -> f (Tuple a b)
```

`divided = divide id`

#### `Decide`

``` purescript
class (Divide f) <= Decide f where
  decide :: forall a b c. (a -> Either b c) -> f b -> f c -> f a
```

`Decide` is the contravariant analogue of `Alt`.

##### Instances
``` purescript
instance decideComparison :: Decide Comparison
instance decideEquivalence :: Decide Equivalence
instance decidePredicate :: Decide Predicate
instance decideOp :: (Semigroup r) => Decide (Op r)
```

#### `Decidable`

``` purescript
class (Decide f, Divisible f) <= Decidable f where
  lose :: forall a. (forall r. a -> r) -> f a
```

`Decidable` is the contravariant analogue of `Alternative`.

##### Instances
``` purescript
instance decidableComparison :: Decidable Comparison
instance decidableEquivalence :: Decidable Equivalence
instance decidablePredicate :: Decidable Predicate
instance decidableOp :: (Monoid r) => Decidable (Op r)
```

#### `decided`

``` purescript
decided :: forall f a b. (Decide f) => f a -> f b -> f (Either a b)
```

`decided = decide id`


