#' Conversion of the class \code{ltraj} to the package \code{sp}
#'
#' Modified versions of \code{\link[adehabitatLT]{ltraj2spdf}} and
#' \code{\link[adehabitatLT]{ltraj2sldf}}, which allows to aggregate by burst
#' (default), id, or step (parameter \code{"by"}).
#'
#' @note The conversion to SLDF using \code{by = "step"} is significantly
#'     longer, of a factor of ~50, than the other two (it takes about 10 sec for
#'     each 10,000 steps on a modern computer).
#' @param ltr An object of class \code{ltraj}.
#' @param by Sets the level of aggregation: if \code{id}, one object of class
#'     \code{Lines} corresponds to one animal; if \code{burst} (default), it
#'     corresponds to one burst; if \code{step}, it corresponds to one step.
#' @param strict Logical (\code{TRUE} by default). See \code{\link{ld}}. For
#'     \code{ltraj2sldf}, only applies to \code{by = "step"}.
#' @seealso See \code{\link[adehabitatLT]{ltraj2spdf}} for further details on
#'     the function and all available arguments.
#' @author Modified by Mathieu Basille \email{mathieu@@basille.org}
#' @export
#' @importFrom sp SpatialPointsDataFrame
#' @examples
#' ## Load puechcirc data, and add some random infolocs:
#' data(puechcirc)
#' info <- list(data.frame(A = rnorm(80), B = runif(80), C = rpois(80,
#'     1)), data.frame(A = rnorm(69, 10), B = runif(69, 10, 11),
#'     C = rpois(69, 10)), data.frame(A = rnorm(66, -10), B = runif(66,
#'     -10, -9), C = rpois(66, 100)))
#' ## Watch the row names (for a reason, 'puechcirc[[2]]' starts with line 2):
#' info <- mapply(function(x, y) {
#'     row.names(x) <- row.names(y)
#'     return(x)
#' }, info, puechcirc, SIMPLIFY = FALSE)
#' infolocs(puechcirc) <- info
#'
#' ## Conversion to SPDF:
#' summary(adehabitatLT::ltraj2spdf(puechcirc))
#' summary(mab::ltraj2spdf(puechcirc, strict = FALSE))
#'
#' ## Conversion to SLDF:
#' summary(adehabitatLT::ltraj2sldf(puechcirc, byid = TRUE))
#' summary(mab::ltraj2sldf(puechcirc, by = "id"))
#' summary(mab::ltraj2sldf(puechcirc))
#' summary(mab::ltraj2sldf(puechcirc, strict = FALSE, by = "step"))
ltraj2spdf <- function (ltr, strict = TRUE)
{
    if (!inherits(ltr, "ltraj"))
        stop("ltr should be of class \"ltraj\"")
    ## Use ld to retrieve id/burst/infolocs at once
    ## tr <- do.call("rbind", ltr)
    ## if (!is.null(infolocs(ltr))) {
    ##     tr2 <- do.call("rbind", infolocs(ltr))
    ##     tr <- cbind(tr, tr2)
    ## }
    ## class(tr) <- "data.frame"
    tr <- ld(ltr, strict = strict)
    ## EOM
    ## Remove NAs on x & y together
    ## xy <- tr[!is.na(tr$x), c("x", "y")]
    ## tr <- tr[!is.na(tr$x), ]
    ## tr$y <- tr$x <- NULL
    tr <- tr[!(is.na(tr$x) | is.na(tr$y)), ]
    ## EOM
    ## Converts to SPDF
    ## res <- SpatialPointsDataFrame(xy, tr, proj4string = .checkp4(ltr))
    ## return(res)
    tr <- SpatialPointsDataFrame(tr[, c("x", "y")], tr[, !(colnames(tr) %in%
        c("x", "y"))], proj4string = .checkp4(ltr))
    return(tr)
    ## EOM
}

#' @rdname ltraj2spdf
#' @export
#' @importFrom sp Line Lines SpatialLines SpatialLinesDataFrame
ltraj2sldf <- function (ltr, by = c("burst", "id", "step"), strict = TRUE)
{
    if (!inherits(ltr, "ltraj"))
        stop("ltr should be of class \"ltraj\"")
    ## Match the 'by' argument
    by <- match.arg(by)
    ## EOM
    ## Embed id/burst in a 'if' statement
    if (by == "id" | by == "burst") {
    ## EOM
        ## Remove NAs on x & y together
        ## lixy <- lapply(ltr, function(x) Line(as.matrix(x[!is.na(x$x),
        ##     c("x", "y")])))
        lixy <- lapply(ltr, function(x) Line(as.matrix(x[!(is.na(x$x) | is.na(x$y)),
            c("x", "y")])))
        ## EOM
        id <- unlist(lapply(ltr, function(x) attr(x, "id")))
        bu <- unlist(lapply(ltr, function(x) attr(x, "burst")))
        ## 'by' is now a character, not a logical ('id')
        ## if (byid) {
        if (by == "id") {
        ## EOM
            lev <- levels(factor(id))
            ## Replace 're1' by 'res' for consistency and memory
            ## usage, and keep the conversion in SpatialLines for
            ## later
            ## re1 <- lapply(lev, function(x) Lines(lixy[id == x], ID = x))
            ## res <- SpatialLines(re1)
            res <- lapply(lev, function(x) Lines(lixy[id == x],
                ID = x))
            ## EOM
            df <- data.frame(id = lev)
            row.names(df) <- lev
        }
        ## 'by' is now a character, not a logical ('burst')
        ## else {
        if (by == "burst") {
        ## EOM
            res <- lapply(1:length(lixy), function(i) Lines(list(lixy[[i]]),
                ID = bu[i]))
            ## Keep the conversion in SpatialLines for later
            ## res <- SpatialLines(res, proj4string=.checkp4(ltr))
            ## EOM
            df <- data.frame(id = id, burst = bu)
            row.names(df) <- bu
        }
    }
    ## Add the 'step' solution
    if (by == "step") {
        ## We first convert the ltraj to a dataframe
        df <- ld(ltr, strict = strict)
        ## We remove NAs in dist, which actually removes NAs in x/y +
        ## dx/dy (required for steps)
        df <- subset(df, !is.na(df$dist))
        ## We extract only x/y/dx/dy and create an 'id' numeric field
        ## (it has to be numeric for the apply call, otherwise
        ## everything is converted to character)
        coords <- data.frame(df[, c("x", "y", "dx", "dy")], id = as.numeric(row.names(df)))
        ## Each row of the data frame (i.e. each step) forms a
        ## Lines(Line); note the use of 'format(..., scientific =
        ## FALSE')' to ensure that the textual representation of the
        ## 'id' corresponds exactly to the full numeric representation
        res <- apply(coords, 1, function(dfi) Lines(Line(matrix(c(dfi["x"],
            dfi["y"], dfi["x"] + dfi["dx"], dfi["y"] + dfi["dy"]),
            ncol = 2, byrow = TRUE)), ID = format(dfi["id"],
            scientific = FALSE, trim = TRUE)))
    }
    ## EOM
    ## Convert to SpatialLines and SLDF in a one shot
    ## res <- SpatialLinesDataFrame(res, data = df)
    res <- SpatialLinesDataFrame(SpatialLines(res, proj4string = .checkp4(ltr)),
        data = df)
    ## EOM
    return(res)
}
