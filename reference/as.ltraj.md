# Working with Trajectories in 2D Space: the Class ltraj

Faster version of
[`as.ltraj`](https://rdrr.io/pkg/adehabitatLT/man/as.ltraj.html), which
can be up to 5-10 times faster.

## Usage

``` r
as.ltraj(
  xy,
  date = NULL,
  id,
  burst = id,
  typeII = TRUE,
  slsp = c("remove", "missing"),
  infolocs = data.frame(pkey = paste(id, date, sep = "."), row.names = row.names(xy)),
  proj4string = CRS()
)
```

## Arguments

- xy:

  A data.frame containing the x and y coordinates of the relocations.

- date:

  For trajectories of type II, a vector of class `POSIXct` giving the
  date for each relocation. For trajectories of type I, this argument is
  not taken into account.

- id:

  Either a character string indicating the identity of the animal or a
  factor with length equal to `nrow(xy)`/

- burst:

  Either a character string indicating the identity of the burst of
  relocations or a factor with length equal to `nrow(xy)`.

- typeII:

  Logical. `TRUE` indicates a trajectory of type II (time recorded, e.g.
  radio-tracking), whereas `FALSE` indicates a trajectory of type I
  (time not recorded, e.g. sampling of tracks in the snow).

- slsp:

  A character string used for the computation of the turning angles.

- infolocs:

  If not `NULL`, a data frame containing additionnal information on the
  relocations (e.g., precision). By default, a primary key is generated.

- proj4string:

  An object of class CRS storing the projection information of the
  relocations.

## See also

See [`ld`](https://rdrr.io/pkg/adehabitatLT/man/ld.html) for further
details on the function and all available arguments.

## Author

Modified by Mathieu Basille <mathieu@basille.org>

## Examples

``` r
data(puechabonsp)
locs <- puechabonsp$relocs
xy <- coordinates(locs)
df <- as.data.frame(locs)
id <- df[,1]
da <- as.POSIXct(strptime(as.character(df$Date), "%y%m%d"))
ltr1 <- adehabitatLT::as.ltraj(xy, da, id = id)
ltr2 <- mab::as.ltraj(xy, da, id = id)
all.equal(ltr1, ltr2)
#> [1] TRUE
```
