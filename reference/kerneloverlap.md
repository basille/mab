# Spatial Interaction between Animals Monitored Using Radio-Tracking

Modified version of
[`kerneloverlap`](https://rdrr.io/pkg/adehabitatHR/man/kerneloverlap.html),
which now allows to select several methods at once, and works on
`SpatialPointsDataFrame` or `estUDm` in the same function.

## Usage

``` r
kerneloverlap(
  x,
  method = c("HR", "PHR", "VI", "BA", "UDOI", "HD"),
  percent = 95,
  conditional = FALSE,
  ...
)

# S3 method for class 'kerneloverlap'
summary(object, ...)
```

## Arguments

- x:

  An object of class `SpatialPointsDataFrame` containing only one column
  (which is a factor indicating the identity associated to the
  relocations) or an object of class `estUDm` containing several
  home-ranges for which the overlap is to be calculated

- method:

  The desired method(s)for the estimation of overlap (several methods
  can be chosen, defaults to all at once)

- percent:

  The percentage level of the home range estimation.

- conditional:

  Logical. If `TRUE`, the function sets to 0 the pixels of the grid over
  which the UD is estimated, outside the home range of the animal
  estimated at a level of probability equal to `percent`. Note that this
  argument has no effect when `meth="HR"`.

- ...:

  Additional arguments to be passed to the function `kernelUD` for the
  kernel estimation of the utilization distribution.

- object:

  An array or matrix of class `kerneloverlap`

## Value

An array of class `kerneloverlap` with as many matrices as chosen
methods (if only one method is chosen, a matrix of class
`kerneloverlap`); each matrix gives the value of indices of overlap for
all pairs of animals.

## See also

See
[`kerneloverlap`](https://rdrr.io/pkg/adehabitatHR/man/kerneloverlap.html)
for further details on the function.

## Author

Clement Calenge, modified by Mathieu Basille <mathieu@basille.org>

## Examples

``` r
## Prepare the data:
data(puechabonsp, package = "adehabitatMA")
loc <- puechabonsp$relocs
elev <- puechabonsp$map

## Kernel overlap using various approaches:
kerneloverlap(puechabonsp$relocs[,1], grid = 200, meth = "HR", conditional = TRUE)
#>            Brock      Calou      Chou      Jean
#> Brock 1.00000000 0.40063593 0.0000000 0.1112878
#> Calou 0.54901961 1.00000000 0.0000000 0.1590414
#> Chou  0.00000000 0.00000000 1.0000000 0.8089172
#> Jean  0.08284024 0.08639053 0.7514793 1.0000000
#> attr(,"method")
#> [1] "HR"
#> attr(,"class")
#> [1] "kerneloverlap"
kerneloverlap(puechabonsp$relocs[,1], grid = elev, meth = c("HR", "VI"), conditional = TRUE)
#> , , HR
#> 
#>            Brock      Calou      Chou      Jean
#> Brock 1.00000000 0.40669856 0.0000000 0.1100478
#> Calou 0.55555556 1.00000000 0.0000000 0.1568627
#> Chou  0.00000000 0.00000000 1.0000000 0.8122605
#> Jean  0.08185053 0.08540925 0.7544484 1.0000000
#> 
#> , , VI
#> 
#>            Brock      Calou      Chou       Jean
#> Brock 0.94933028 0.24165242 0.0000000 0.01435803
#> Calou 0.24165242 0.94955017 0.0000000 0.01483001
#> Chou  0.00000000 0.00000000 0.9496367 0.63594844
#> Jean  0.01435803 0.01483001 0.6359484 0.94957049
#> 
#> attr(,"method")
#> [1] "HR" "VI"
#> attr(,"class")
#> [1] "kerneloverlap"
kerneloverlap(puechabonsp$relocs[,1], grid = 200, conditional = TRUE)
#> , , HR
#> 
#>            Brock      Calou      Chou      Jean
#> Brock 1.00000000 0.40063593 0.0000000 0.1112878
#> Calou 0.54901961 1.00000000 0.0000000 0.1590414
#> Chou  0.00000000 0.00000000 1.0000000 0.8089172
#> Jean  0.08284024 0.08639053 0.7514793 1.0000000
#> 
#> , , PHR
#> 
#>           Brock     Calou      Chou       Jean
#> Brock 0.9498781 0.7039511 0.0000000 0.01452433
#> Calou 0.2903614 0.9497348 0.0000000 0.01498872
#> Chou  0.0000000 0.0000000 0.9498829 0.88277495
#> Jean  0.0441493 0.3133549 0.9002833 0.94991689
#> 
#> , , VI
#> 
#>            Brock      Calou      Chou       Jean
#> Brock 0.94987811 0.24130937 0.0000000 0.01452433
#> Calou 0.24130937 0.94973485 0.0000000 0.01498872
#> Chou  0.00000000 0.00000000 0.9498829 0.63583701
#> Jean  0.01452433 0.01498872 0.6358370 0.94991689
#> 
#> , , BA
#> 
#>            Brock      Calou      Chou       Jean
#> Brock 0.94987811 0.40326534 0.0000000 0.02465505
#> Calou 0.40326534 0.94973485 0.0000000 0.06817038
#> Chou  0.00000000 0.00000000 0.9498829 0.82783255
#> Jean  0.02465505 0.06817038 0.8278326 0.94991689
#> 
#> , , UDOI
#> 
#>              Brock       Calou     Chou         Jean
#> Brock 1.4270479991 0.191596263 0.000000 0.0006435704
#> Calou 0.1915962629 1.361203336 0.000000 0.0048786542
#> Chou  0.0000000000 0.000000000 1.557351 1.0618369331
#> Jean  0.0006435704 0.004878654 1.061837 1.8444783240
#> 
#> , , HD
#> 
#>          Brock    Calou      Chou      Jean
#> Brock 0.000000 1.045506 1.3783182 1.3603253
#> Calou 1.045506 0.000000 1.3782662 1.3278972
#> Chou  1.378318 1.378266 0.0000000 0.4940999
#> Jean  1.360325 1.327897 0.4940999 0.0000000
#> 
#> attr(,"method")
#> [1] "HR"   "PHR"  "VI"   "BA"   "UDOI" "HD"  
#> attr(,"class")
#> [1] "kerneloverlap"

## Summarizing the results:
summary(kerneloverlap(puechabonsp$relocs[,1], grid = 200))
#>                  HR12       HR21        PHR12     PHR21           VI
#> Brock-Calou 0.4006359 0.54901961 7.166792e-01 0.3075112 0.2800219962
#> Brock-Chou  0.0000000 0.00000000 0.000000e+00 0.0000000 0.0000268396
#> Brock-Jean  0.1112878 0.08284024 2.144321e-02 0.0449102 0.0328342595
#> Calou-Chou  0.0000000 0.00000000 3.369378e-07 0.0000000 0.0001922746
#> Calou-Jean  0.1590414 0.08639053 2.925034e-02 0.3133549 0.0332083362
#> Chou-Jean   0.8089172 0.75147929 8.920712e-01 0.9122777 0.6699438552
#>                       BA        UDOI        HD
#> Brock-Calou 5.103714e-01 0.202051003 0.9894451
#> Brock-Chou  9.862805e-05 0.000000000 1.4140523
#> Brock-Jean  7.127024e-02 0.001254584 1.3627896
#> Calou-Chou  6.855002e-04 0.000000000 1.4136411
#> Calou-Jean  1.561361e-01 0.007155960 1.2990284
#> Chou-Jean   8.893844e-01 1.068232524 0.4700799
summary(kerneloverlap(puechabonsp$relocs[,1], grid = 200, percent = 50))
#>                  HR12     HR21        PHR12     PHR21           VI           BA
#> Brock-Calou 0.0000000 0.000000 3.624405e-02 0.1242054 0.2800219962 5.103714e-01
#> Brock-Chou  0.0000000 0.000000 0.000000e+00 0.0000000 0.0000268396 9.862805e-05
#> Brock-Jean  0.0000000 0.000000 6.735677e-05 0.0000000 0.0328342595 7.127024e-02
#> Calou-Chou  0.0000000 0.000000 0.000000e+00 0.0000000 0.0001922746 6.855002e-04
#> Calou-Jean  0.0000000 0.000000 1.712514e-02 0.0000000 0.0332083362 1.561361e-01
#> Chou-Jean   0.4655172 0.525974 3.866889e-01 0.3345926 0.6699438552 8.893844e-01
#>                  UDOI        HD
#> Brock-Calou 0.0000000 0.9894451
#> Brock-Chou  0.0000000 1.4140523
#> Brock-Jean  0.0000000 1.3627896
#> Calou-Chou  0.0000000 1.4136411
#> Calou-Jean  0.0000000 1.2990284
#> Chou-Jean   0.1362627 0.4700799
```
