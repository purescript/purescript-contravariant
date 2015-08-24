## Module Data.Op

This module defines the opposite of the function category, `Op` and its instances.

#### `Op`

``` purescript
newtype Op a b
  = Op (b -> a)
```

The opposite of the function category.

##### Instances
``` purescript
instance semigroupoidOp :: Semigroupoid Op
instance categoryOp :: Category Op
instance contravariantOp :: Contravariant (Op a)
instance semigroupOp :: (Semigroup a) => Semigroup (Op a b)
instance monoidOp :: (Monoid a) => Monoid (Op a b)
```

#### `runOp`

``` purescript
runOp :: forall a b. Op a b -> b -> a
```

Unpack a value of type `Op a b`, revealing a function.


