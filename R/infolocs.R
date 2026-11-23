#' Infolocs of an Object of Class ltraj
#'
#' Modified version of \code{\link[adehabitatLT]{infolocs}} that: 1) allows to
#' return a single data frame by burst or id (parameter \code{"by"}); 2) can
#' simply the output to a vector if a single column is requested (parameter
#' \code{"simplify"}); 3) returns \code{NULL} if \code{infolocs} exists, but
#' \code{which} is not a colum of it (note that \code{adehabitatLT::infolocs}
#' already returns \code{NULL} if there is no infolocs);
#'
#' @param ltraj An object of class \code{ltraj}.
#' @param which An optional character vector containing the names of the
#'     variables in the \code{infolocs} attribute to be returned.
#' @param by Character. Either \code{"burst"}, \code{"id"}, or \code{"none"} to
#'     return only one element for all bursts/id together.
#' @param simplify Logical. If a single variable is requested, should the
#'     function return 1-column data frames (\code{FALSE}, default) or vector
#'     (\code{TRUE}).
#' @seealso See \code{\link[adehabitatLT]{infolocs}} for further details on the
#'     function and all available arguments.
#' @author Modified by Mathieu Basille \email{mathieu@@basille.org}
#' @export
#' @examples
#' ## Load puechcirc data, and add some random infolocs:
#' data(puechcirc)
#' infolocs(puechcirc)
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
#' puechcirc
#'
#' ## Parameters "by" and "simplify"
#' infolocs(puechcirc, "A", simplify = TRUE)
#' infolocs(puechcirc, "A", by = "id", simplify = TRUE)
#' infolocs(puechcirc, "A", by = "none", simplify = TRUE)
#'
#' ## Try to retrieve the column `toto`:
#' infolocs(puechcirc, "toto")
infolocs <- function(ltraj, which, by = c("burst", "id", "none"),
    simplify = FALSE)
{
    if (!inherits(ltraj, "ltraj"))
        stop("ltraj should be of class ltraj")
    ## Match the 'by' argument
    by <- match.arg(by)
    ## EOM
    if (!is.null(attr(ltraj[[1]], "infolocs"))) {
        if (missing(which))
            which <- names(attr(ltraj[[1]], "infolocs"))
        ## If infolocs exists but which is not in it, returns NULL
        else if (all(!(which %in% names(attr(ltraj[[1]], "infolocs")))))
            return(NULL)
        ## EOM
        ## To simplify 1 column data frames
        drop <- ifelse(simplify & length(which) == 1, TRUE, FALSE)
        re <- lapply(ltraj, function(y) {
            res <- attr(y, "infolocs")
            return(res[, names(res) %in% which, drop = drop])
        })
        ## EOM
        ## Extract by "none" (all together)
        if (by == "none") {
            if (drop)
                re <- unlist(re)
            else re <- do.call(rbind, re)
        }
        ## EOM
        ## Extract by "id"
        if (by == "id") {
            names(re) <- id(ltraj)
            ## Binds unique animals together (bug in case of factors,
            ## returns the numeric values of the levels)
            un <- unique(names(re))
            if (drop)
                re <- lapply(un, function(n) do.call(c, re[names(re) ==
                  n]))
            else
                re <- lapply(un, function(n) do.call(rbind,
                  re[names(re) == n]))
            names(re) <- un
        }
        ## EOM
        ## Extract by "burst" or "none"
        if (by == "burst")
            names(re) <- burst(ltraj)
        ## EOM
        ## Return 're'
        return(re)
        ## EOM
    } else {
        return(NULL)
    }
}
