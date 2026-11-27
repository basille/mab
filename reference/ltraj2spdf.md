# Conversion of the class `ltraj` to the package `sp`

Modified versions of
[`ltraj2spdf`](https://rdrr.io/pkg/adehabitatLT/man/ltraj2sldf.html) and
[`ltraj2sldf`](https://rdrr.io/pkg/adehabitatLT/man/ltraj2sldf.html),
which allows to aggregate by burst (default), id, or step (parameter
`"by"`).

## Usage

``` r
ltraj2spdf(ltr, strict = TRUE)

ltraj2sldf(ltr, by = c("burst", "id", "step"), strict = TRUE)
```

## Arguments

- ltr:

  An object of class `ltraj`.

- strict:

  Logical (`TRUE` by default). See
  [`ld`](http://basille.github.io/mab/reference/ld.md). For
  `ltraj2sldf`, only applies to `by = "step"`.

- by:

  Sets the level of aggregation: if `id`, one object of class `Lines`
  corresponds to one animal; if `burst` (default), it corresponds to one
  burst; if `step`, it corresponds to one step.

## Note

The conversion to SLDF using `by = "step"` is significantly longer, of a
factor of ~50, than the other two (it takes about 10 sec for each 10,000
steps on a modern computer).

## See also

See [`ltraj2spdf`](https://rdrr.io/pkg/adehabitatLT/man/ltraj2sldf.html)
for further details on the function and all available arguments.

## Author

Clement Calenge, modified by Mathieu Basille <mathieu@basille.org>

## Examples

``` r
## Load puechcirc data, and add some random infolocs:
data(puechcirc, package = "adehabitatLT")
info <- list(data.frame(A = rnorm(80), B = runif(80), C = rpois(80,
    1)), data.frame(A = rnorm(69, 10), B = runif(69, 10, 11),
    C = rpois(69, 10)), data.frame(A = rnorm(66, -10), B = runif(66,
    -10, -9), C = rpois(66, 100)))
## Watch the row names (for a reason, 'puechcirc[[2]]' starts with line 2):
info <- mapply(function(x, y) {
    row.names(x) <- row.names(y)
    return(x)
}, info, puechcirc, SIMPLIFY = FALSE)
infolocs(puechcirc) <- info

## Conversion to SPDF:
summary(adehabitatLT::ltraj2spdf(puechcirc))
#> Object of class SpatialPointsDataFrame
#> Coordinates:
#>       min     max
#> x  699502  702042
#> y 3156993 3158943
#> Is projected: NA 
#> proj4string : [NA]
#> Number of points: 163
#> Data attributes:
#>       date                           dx                 dy           
#>  Min.   :1993-08-24 17:00:00   Min.   :-477.000   Min.   :-365.0000  
#>  1st Qu.:1993-08-25 01:25:00   1st Qu.: -54.500   1st Qu.: -67.0000  
#>  Median :1993-08-27 22:00:00   Median :   0.000   Median :   0.0000  
#>  Mean   :1993-08-26 20:15:38   Mean   :   4.659   Mean   :   0.9037  
#>  3rd Qu.:1993-08-28 02:30:00   3rd Qu.:  43.500   3rd Qu.:  57.5000  
#>  Max.   :1993-08-28 06:30:00   Max.   : 495.000   Max.   : 417.0000  
#>                                NAs    :28         NAs    :28         
#>       dist              dt           R2n            abs.angle       
#>  Min.   :  0.00   Min.   :600   Min.   :      0   Min.   :-3.09587  
#>  1st Qu.: 59.52   1st Qu.:600   1st Qu.: 115787   1st Qu.:-1.41709  
#>  Median :107.80   Median :600   Median : 337361   Median : 0.04121  
#>  Mean   :140.14   Mean   :600   Mean   : 571008   Mean   : 0.17585  
#>  3rd Qu.:181.29   3rd Qu.:600   3rd Qu.: 996558   3rd Qu.: 1.89609  
#>  Max.   :571.64   Max.   :600   Max.   :2922746   Max.   : 3.09876  
#>  NAs    :28       NAs    :3                       NAs    :30        
#>    rel.angle             A                  B                C         
#>  Min.   :-3.1057   Min.   :-12.3755   Min.   :-9.976   Min.   :  0.00  
#>  1st Qu.:-1.4575   1st Qu.: -8.6666   1st Qu.:-9.108   1st Qu.:  1.00  
#>  Median : 0.2406   Median : -0.1090   Median : 0.470   Median :  8.00  
#>  Mean   : 0.2009   Mean   :  0.2361   Mean   : 0.801   Mean   : 31.52  
#>  3rd Qu.: 2.0363   3rd Qu.:  9.1342   3rd Qu.:10.243   3rd Qu.: 85.00  
#>  Max.   : 3.1108   Max.   : 12.3226   Max.   :10.980   Max.   :124.00  
#>  NAs    :51                                                            
summary(mab::ltraj2spdf(puechcirc, strict = FALSE))
#> Object of class SpatialPointsDataFrame
#> Coordinates:
#>       min     max
#> x  699502  702042
#> y 3156993 3158943
#> Is projected: NA 
#> proj4string : [NA]
#> Number of points: 163
#> Data attributes:
#>       date                           dx                 dy           
#>  Min.   :1993-08-24 17:00:00   Min.   :-477.000   Min.   :-365.0000  
#>  1st Qu.:1993-08-25 01:25:00   1st Qu.: -54.500   1st Qu.: -67.0000  
#>  Median :1993-08-27 22:00:00   Median :   0.000   Median :   0.0000  
#>  Mean   :1993-08-26 20:15:38   Mean   :   4.659   Mean   :   0.9037  
#>  3rd Qu.:1993-08-28 02:30:00   3rd Qu.:  43.500   3rd Qu.:  57.5000  
#>  Max.   :1993-08-28 06:30:00   Max.   : 495.000   Max.   : 417.0000  
#>                                NAs    :28         NAs    :28         
#>       dist              dt           R2n            abs.angle       
#>  Min.   :  0.00   Min.   :600   Min.   :      0   Min.   :-3.09587  
#>  1st Qu.: 59.52   1st Qu.:600   1st Qu.: 115787   1st Qu.:-1.41709  
#>  Median :107.80   Median :600   Median : 337361   Median : 0.04121  
#>  Mean   :140.14   Mean   :600   Mean   : 571008   Mean   : 0.17585  
#>  3rd Qu.:181.29   3rd Qu.:600   3rd Qu.: 996558   3rd Qu.: 1.89609  
#>  Max.   :571.64   Max.   :600   Max.   :2922746   Max.   : 3.09876  
#>  NAs    :28       NAs    :3                       NAs    :30        
#>    rel.angle               id            burst           A           
#>  Min.   :-3.1057   Length   :163   Length   :163   Min.   :-12.3755  
#>  1st Qu.:-1.4575   N.unique :  2   N.unique :  3   1st Qu.: -8.6666  
#>  Median : 0.2406   N.blank  :  0   N.blank  :  0   Median : -0.1090  
#>  Mean   : 0.2009   Min.nchar:  4   Min.nchar:  8   Mean   :  0.2361  
#>  3rd Qu.: 2.0363   Max.nchar:  4   Max.nchar:  8   3rd Qu.:  9.1342  
#>  Max.   : 3.1108                                   Max.   : 12.3226  
#>  NAs    :51                                                          
#>        B                C         
#>  Min.   :-9.976   Min.   :  0.00  
#>  1st Qu.:-9.108   1st Qu.:  1.00  
#>  Median : 0.470   Median :  8.00  
#>  Mean   : 0.801   Mean   : 31.52  
#>  3rd Qu.:10.243   3rd Qu.: 85.00  
#>  Max.   :10.980   Max.   :124.00  
#>                                   

## Conversion to SLDF:
summary(adehabitatLT::ltraj2sldf(puechcirc, byid = TRUE))
#> Object of class SpatialLinesDataFrame
#> Coordinates:
#>       min     max
#> x  699502  702042
#> y 3156993 3158943
#> Is projected: NA 
#> proj4string : [NA]
#> Data attributes:
#>          id   
#>  Length   :2  
#>  N.unique :2  
#>  N.blank  :0  
#>  Min.nchar:4  
#>  Max.nchar:4  
summary(mab::ltraj2sldf(puechcirc, by = "id"))
#> Object of class SpatialLinesDataFrame
#> Coordinates:
#>       min     max
#> x  699502  702042
#> y 3156993 3158943
#> Is projected: NA 
#> proj4string : [NA]
#> Data attributes:
#>          id   
#>  Length   :2  
#>  N.unique :2  
#>  N.blank  :0  
#>  Min.nchar:4  
#>  Max.nchar:4  
summary(mab::ltraj2sldf(puechcirc))
#> Object of class SpatialLinesDataFrame
#> Coordinates:
#>       min     max
#> x  699502  702042
#> y 3156993 3158943
#> Is projected: NA 
#> proj4string : [NA]
#> Data attributes:
#>          id          burst  
#>  Length   :3   Length   :3  
#>  N.unique :2   N.unique :3  
#>  N.blank  :0   N.blank  :0  
#>  Min.nchar:4   Min.nchar:8  
#>  Max.nchar:4   Max.nchar:8  
summary(mab::ltraj2sldf(puechcirc, strict = FALSE, by = "step"))
#> Object of class SpatialLinesDataFrame
#> Coordinates:
#>       min     max
#> x  699502  702042
#> y 3156993 3158943
#> Is projected: NA 
#> proj4string : [NA]
#> Data attributes:
#>        x                y                date                    
#>  Min.   :699502   Min.   :3157042   Min.   :1993-08-24 17:20:00  
#>  1st Qu.:700193   1st Qu.:3157506   1st Qu.:1993-08-25 00:45:00  
#>  Median :700371   Median :3158162   Median :1993-08-27 22:10:00  
#>  Mean   :700435   Mean   :3158066   Mean   :1993-08-26 19:38:26  
#>  3rd Qu.:700732   3rd Qu.:3158486   3rd Qu.:1993-08-28 02:30:00  
#>  Max.   :702042   Max.   :3158943   Max.   :1993-08-28 06:20:00  
#>                                                                  
#>        dx                 dy                 dist              dt     
#>  Min.   :-477.000   Min.   :-365.0000   Min.   :  0.00   Min.   :600  
#>  1st Qu.: -54.500   1st Qu.: -67.0000   1st Qu.: 59.52   1st Qu.:600  
#>  Median :   0.000   Median :   0.0000   Median :107.80   Median :600  
#>  Mean   :   4.659   Mean   :   0.9037   Mean   :140.14   Mean   :600  
#>  3rd Qu.:  43.500   3rd Qu.:  57.5000   3rd Qu.:181.29   3rd Qu.:600  
#>  Max.   : 495.000   Max.   : 417.0000   Max.   :571.64   Max.   :600  
#>                                                                       
#>       R2n            abs.angle          rel.angle               id     
#>  Min.   :      0   Min.   :-3.09587   Min.   :-3.1057   Length   :135  
#>  1st Qu.: 119810   1st Qu.:-1.41709   1st Qu.:-1.4575   N.unique :  2  
#>  Median : 320212   Median : 0.04121   Median : 0.2406   N.blank  :  0  
#>  Mean   : 557971   Mean   : 0.17585   Mean   : 0.2009   Min.nchar:  4  
#>  3rd Qu.: 936010   3rd Qu.: 1.89609   3rd Qu.: 2.0363   Max.nchar:  4  
#>  Max.   :2922746   Max.   : 3.09876   Max.   : 3.1108                  
#>                    NAs    :2          NAs    :23                       
#>        burst           A                  B                 C         
#>  Length   :135   Min.   :-12.3755   Min.   :-9.9764   Min.   :  0.00  
#>  N.unique :  3   1st Qu.: -8.5326   1st Qu.:-9.0837   1st Qu.:  1.00  
#>  N.blank  :  0   Median : -0.1090   Median : 0.4702   Median :  7.00  
#>  Min.nchar:  8   Mean   :  0.3288   Mean   : 0.8738   Mean   : 30.85  
#>  Max.nchar:  8   3rd Qu.:  9.1170   3rd Qu.:10.2808   3rd Qu.: 84.50  
#>                  Max.   : 12.2730   Max.   :10.9803   Max.   :124.00  
#>                                                                       
```
