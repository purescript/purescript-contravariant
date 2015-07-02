## Module Data.Functor.Contravariant

#### `Contravariant`

``` purescript
class Contravariant f where
  cmap :: forall a b. (b -> a) -> f a -> f b
```

A `Contravariant` functor can be seen as a way of changing the input type
of a consumer of input, in contrast to the standard covariant `Functor`
that can be seen as a way of changing the output type of a producer of
output.

`Contravariant` instances should satisfy the following laws:

- Identity `(>$<) id = id`
- Composition `(f >$<) <<< (g >$<) = (>$<) (g <<< f)`

#### `(>$<)`

``` purescript
(>$<) :: forall a b f. (Contravariant f) => (b -> a) -> f a -> f b
```

_left-associative / precedence -1_

An infix version of `cmap`.

#### `(>#<)`

``` purescript
(>#<) :: forall a b f. (Contravariant f) => f a -> (b -> a) -> f b
```

_left-associative / precedence -1_

`(>#<)` is `(>$<)` with its arguments reversed.


