# mab 2.0.0

Major cleanup for 2.0, with a new name to reflect the emphasis on movement:
`mab`.

# hab 1.20.4

## Bug fixes

* Fixed NAMESPACE: adehabitatLT and adehabitatHR are now completely imported; no
  need for `adehabitatLT::id` for example.

# hab 1.20.3

## New features

* `closest`: Argument `ref` to compute distances from the start or the end of
  the step.

# hab 1.20.2

## New features

* `makeSeq`: now works on a ltraj object + argument `na.omit` to remove missing
  locations to form the sequence.

# hab 1.20.1

## Minor changes

* `infolocs`: `by` replaces `perani` (by burst, id or none) + updated examples.
* `closest`: Minor changes in `closest` (no warnings, documentation).

# hab 1.20

## New features

* `closest`: Find closest relocation from ltraj objects.

# hab 1.19.3

## Bug fixes

* Fixed namespace for `kfold` and `QIC`.

# hab 1.19.2

## Minor changes

* `plot.ltraj`: New argument `by` that replaces `perani`, and allows the plot of
  all bursts at once.

# hab 1.19.1

## Bug fixes

* `trajdyn`: Use of 'adehabitatLT::id' to avoid conflicts with other packages.

# hab 1.19

## New features

* `makeSeq`: Define sequences of a trajectory.

# hab 1.18

## New features

* `rdSteps`: New argument `strata` to define strata names.
* `rdSteps`: New argument `mask` to redraw steps that end outside of a polygon.

# hab 1.17

## New features

* `rdSteps`: New argument `rand.dis` to explicitly provide random distributions
  for step lengths and turning angles.

# hab 1.16

## New features

* `rdSteps`: Draw random steps.

# hab 1.15

## New features

* `na.omit.ltraj`: Argument `complete.steps` to keep only complete steps,
  i.e. steps characterized by start and end points, with turning angle
  (i.e. relative angle to the previous step).

## Bug fixes

* Fixed namespaces and S3 methods.
* `trajdyn`: Fixed example.

# hab 1.14

## New features

* `subset`: Subsetting a ltraj

## Bug fixes

* `rec`: Throws an error if the \code{row.names} are different between the ltraj
  and its infolocs.
* `plot.ltraj`: Check the length of list parameters.
* `plot.ltraj`: Use of 'adehabitatLT::id' to avoid conflicts.
* `plot.ltraj`: Fixed bug on the use of `perani`.
* `plot.ltraj`: Fixed row names in example.

# hab 1.13

## New features

* `trajdyn`: New parameter `addvec` to hihglight the current location, the
  current step or nothing.

## Bug fix

* `trajdyn`: Individual point/line parameters are changed when the burst is
  changed (Linux only).

# hab 1.12

## New features

* `na.omit.ltraj`: Handle Missing Values in Objects of Class 'ltraj'
* `infolocs`: Allows to simplify 1 column data frames into vectors
* `infolocs`: Returns one element per burst or per animal
* `plot.ltraj`: Give control over the removal of missing locations (paramter
  `na.rm`)
* `plot.ltraj`: Allows to have individual point parameters, using nested lists
  in `ppar`
* `plot.ltraj`: Allows to have individual step parameters, using nested lists in
  `lpar`
* `trajdyn`: Give control over the removal of missing locations (paramter
  `na.rm`)
* `trajdyn`: Allows to have individual point parameters, using nested lists in
  `ppar`
* `trajdyn`: Allows to have individual step parameters, using nested lists in
  `lpar`

## Bug fixes

* `plot.ltraj` + `ld`: Changed id() to adehabitatLT::id() to avoid ambiguity
* `plot.ltraj`: `perani` is now set to FALSE by default, using burst as the
  basic bloc
* `plot.ltraj`: parameters now use `id = unique(adehabitatLT::id(x)), burst =
  adehabitatLT::burst(x)` (does not change behavior)
* `infolocs`: Now returns a list with id/burst as names
* `trajdyn`: Bug with 's'how when only 1 variable in infolocs

# hab 1.11

## New features

* `rec`: Modified version of `rec` that keeps the original `row.names`.
* `trajdyn`: If a `nvar` is requested, now returns the original `ltraj` with
  updated values in `infolocs(nvar)`.
* `trajdyn`: Allows to show the current step as a vector (key 'v').

# hab 1.10.1

## New features

* `trajdyn`: Show the current burst/loc/(infolocs)

## Bug fixes

* `trajdyn`: Fixed problem when using `nvar` on several bursts.

# hab 1.10

## New features

* `infolocs`: Modified version of `infolocs` that returns `NULL` if `infolocs`
 exists, but `which` is not a colum of it (fixes a bug in `trajdyn` when
 `infolocs` exists but `nvar` is not in it).

## Bug fixes

* `trajdyn`: Fixed problem when using `nvar` and row.names are different than
  1:nrow.

# hab 1.9.3

## New features

* `trajdyn`: New argument `by` to modify the number of previous points/steps
  incremented at each step.

## Bug fixes

* `trajdyn`: corrects bug when a `nvar` is requested and infolocs(ltraj) is
  NULL.

# hab 1.9.2

## New features

* `plot.ltraj`: New arguments `spotdf` to plot a SpatialPoints in the
  background, and `center` to center each plot around the current burst (default
  is the same xlim/ylim for each burst).
* `trajdyn`: New argument `only` to display k previous points/steps.
* `trajdyn`: Allow user to modify point and line display.

## Bug fixes

* `trajdyn`:`nvar` is retrieved from `infolocs` if it exists.

# hab 1.9.1

## Bug fixes

* `plot.ltraj`: Allow user-defined margins when `length(id) == 1` (`plot.ltraj`
  can now be used in `trajdyn`).

# hab 1.9

## New features

* `trajdyn`: Modified version of `trajdyn`, which allows to store interactively
  a new variable `nvar` (for instance to be used later in `infolocs`).

# hab 1.8

## New features

* `kerneloverlap`: Modified version of `kerneloverlap` which now allows to
  select several methods at once, and works on `SpatialPointsDataFrame` or
  `estUDm` in the same function.
* `kernelUD`: Modified version of `kernelUD`, which silences the use of
  `same4all` when working on a `SpatialPixels` as a `grid`.

# hab 1.7

## New features

* `kfold`: Cross-validation for regression models (currently `coxph` and
  `clogit` models).

# hab 1.6.1

## New features

* `QIC` now provides the difference with the smallest QIC, when several models
  are compared.

# hab 1.6

## New features

* `lincircor` & `lincircor.test`: Linear-circular correlation.

# hab 1.5

## New features

* `acf.test`: Test of autocorrelation in SSFs.
* `makeCluster`: Create independent clusters.
* `QIC` & `QIC.coxph`: QIC: Quasi-likelihood under Independence Criterion.
* `modWeights`: Model weights using Information Theory.

# hab 1.4.1

## Bug fixes

* `ltraj2sldf`: Solved a bug in the use of `format`.

# hab 1.4

## New features

* `as.ltraj`: Faster version of `as.ltraj`.

# hab 1.3

## New features

* `dl`: Faster version of `dl`, with argument `strict`.

## Minor changes 

* `ld`, `ltraj2spdf` and `ltraj2sldf`: `mode` is replaced by `strict`, which
  defaults to `TRUE` (i.e. use regular adehabitatLT functions) to make sure it
  does not break older code.

# hab 1.2

## Minor changes

* `ld`: Avoid conflicts with 'id' from other packages.
* `ltraj2sldf`: New algorithm, faster and more reliable, to build
  steps.

# hab 1.1

## New features

* `ld`: Faster version of `ld`, with argument `mode`.
* `ltraj2spdf`: Use now `mode == "fast"` by default.
* `ltraj2sldf`: Use now `mode == "fast"` by default + faster algorithm to build
  steps.

# hab 1.0

Version with a new name, from `adehabitatLTmod` to `hab`.

## New features

* `ltraj2spdf`: Add a `proj4string` argument, and keeps `id` and `burst` in the
  result.
* `ltraj2sldf`: Add a `proj4string` argument, and `by` is now a character, which
  accepts `id`, `burst` (default) and `step`.

# adehabitatLTmod 0.3

## New features

* `plotNAltraj`: Add `perani`, `addlines`, `mfrow`, `ppar` and `lpar` arguments.
* `setNA`: Checks on `date.ref` + main function named for debugging.

# adehabitatLTmod 0.2

## New features

* `plotltr`: Keep `burst` and `id` attributes in case of `infolocs`.

# adehabitatLTmod 0.1

## New features

* `plot.ltraj`: Add `mfrow`, `ppar`, `lpar`, `spixdfpar` and `spoldfpar`
  arguments.
* `plotltr`: Add `perani`, `mfrow`, `ppar` and `lpar` arguments.
