# Estimation of Kernel Home-Range

Modified version of
[`kernelUD`](https://rdrr.io/pkg/adehabitatHR/man/kernelUD.html), which
fixes the bug when using `same4all = TRUE` together with a single
`SpatialPixels` as a `grid`.

## Usage

``` r
kernelUD(
  xy,
  h = "href",
  grid = 60,
  same4all = FALSE,
  hlim = c(0.1, 1.5),
  kern = c("bivnorm", "epa"),
  extent = 1,
  boundary = NULL
)
```

## Arguments

- xy:

  An object inheriting the class `SpatialPoints` containing the x and y
  relocations of the animal. If `xy` inherits the class
  `SpatialPointsDataFrame`, it should contain only one column (factor)
  corresponding to the identity of the animals for each relocation.

- h:

  A character string or a number. If `h` is set to `"href"`, the ad hoc
  method is used for the smoothing parameter (see details). If `h` is
  set to `"LSCV"`, the least-square cross validation method is used.
  Note that `"LSCV"` is not available if `kern = "epa"`. Alternatively,
  `h` may be set to any given numeric value.

- grid:

  A number giving the size of the grid on which the UD should be
  estimated. Alternatively, this parameter may be an object inheriting
  the class `SpatialPixels`, that will be used for all animals. For the
  function `kernelUD`, it may in addition be a list of objects of class
  `SpatialPixels`, with named elements corresponding to each level of
  the factor id.

- same4all:

  Logical. If `TRUE`, the same grid is used for all animals. If `FALSE`,
  one grid per animal is used.

- hlim:

  A numeric vector of length two. If `h = "LSCV"`, the function
  minimizes the cross-validation criterion for values of h ranging from
  `hlim[1]*href` to `hlim[2]*href`, where `href` is the smoothing
  parameter computed with the ad hoc method (see details in
  [`kernelUD`](https://rdrr.io/pkg/adehabitatHR/man/kernelUD.html)).

- kern:

  A character string. If `"bivnorm"`, a bivariate normal kernel is used.
  If `"epa"`, an Epanechnikov kernel is used.

- extent:

  A value controlling the extent of the grid used for the estimation
  (the extent of the grid on the abscissa is equal to
  `(min(abscissa.relocations) + extent * diff(range(abscissa.relocations)))`,
  and similarly for the ordinate).

- boundary:

  If not `NULL`, an object inheriting the class `SpatialLines` defining
  a barrier that cannot be crossed by the animals. There are constraints
  on the shape of the barrier that depend on the smoothing parameter `h`
  (see details in
  [`kernelUD`](https://rdrr.io/pkg/adehabitatHR/man/kernelUD.html)).

## See also

See [`kernelUD`](https://rdrr.io/pkg/adehabitatHR/man/kernelUD.html) for
further details on the function.

## Author

Clement Calenge, modified by Mathieu Basille <mathieu@basille.org>

## Examples

``` r
## Prepare the data:
data(puechabonsp, package = "adehabitatMA")
loc <- puechabonsp$relocs
elev <- puechabonsp$map

## Compute the kernel estimation
ker1 <- kernelUD(puechabonsp$relocs[,1], grid = elev, same4all = TRUE)

## Summarizing the overlaps
summary(kerneloverlap(ker1, conditional = TRUE))
#>                  HR12       HR21      PHR12      PHR21         VI         BA
#> Brock-Calou 0.4066986 0.55555556 0.70685107 0.29236891 0.24165242 0.40480572
#> Brock-Chou  0.0000000 0.00000000 0.00000000 0.00000000 0.00000000 0.00000000
#> Brock-Jean  0.1100478 0.08185053 0.01435803 0.04285041 0.01435803 0.02419357
#> Calou-Chou  0.0000000 0.00000000 0.00000000 0.00000000 0.00000000 0.00000000
#> Calou-Jean  0.1568627 0.08540925 0.01483001 0.30867483 0.01483001 0.06731914
#> Chou-Jean   0.8122605 0.75444840 0.88311135 0.90023740 0.63594844 0.82790055
#>                     UDOI       HD
#> Brock-Calou 0.1940343708 1.043681
#> Brock-Chou  0.0000000000 1.378030
#> Brock-Jean  0.0006209118 1.360336
#> Calou-Chou  0.0000000000 1.378110
#> Calou-Jean  0.0047583491 1.328338
#> Chou-Jean   1.0633745943 0.493362
```
