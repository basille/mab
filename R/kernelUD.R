#' Estimation of Kernel Home-Range
#'
#' Modified version of \code{\link[adehabitatHR]{kernelUD}}, which fixes the bug
#' when using \code{same4all = TRUE} together with a single \code{SpatialPixels}
#' as a \code{grid}.
#'
#' @param xy An object inheriting the class \code{SpatialPoints} containing the
#'     x and y relocations of the animal.  If \code{xy} inherits the class
#'     \code{SpatialPointsDataFrame}, it should contain only one column (factor)
#'     corresponding to the identity of the animals for each relocation.
#' @param h A character string or a number.  If \code{h} is set to
#'     \code{"href"}, the ad hoc method is used for the smoothing parameter (see
#'     details).  If \code{h} is set to \code{"LSCV"}, the least-square cross
#'     validation method is used. Note that \code{"LSCV"} is not available if
#'     \code{kern = "epa"}. Alternatively, \code{h} may be set to any given
#'     numeric value.
#' @param grid A number giving the size of the grid on which the UD should be
#'     estimated.  Alternatively, this parameter may be an object inheriting the
#'     class \code{SpatialPixels}, that will be used for all animals.  For the
#'     function \code{kernelUD}, it may in addition be a list of objects of
#'     class \code{SpatialPixels}, with named elements corresponding to each
#'     level of the factor id.
#' @param same4all Logical. If \code{TRUE}, the same grid is used for all
#'     animals.  If \code{FALSE}, one grid per animal is used.
#' @param hlim A numeric vector of length two.  If \code{h = "LSCV"}, the
#'     function minimizes the cross-validation criterion for values of h ranging
#'     from \code{hlim[1]*href} to \code{hlim[2]*href}, where \code{href} is the
#'     smoothing parameter computed with the ad hoc method (see details in
#'     \code{\link[adehabitatHR]{kernelUD}}).
#' @param kern A character string.  If \code{"bivnorm"}, a bivariate normal
#'     kernel is used.  If \code{"epa"}, an Epanechnikov kernel is used.
#' @param extent A value controlling the extent of the grid used for the
#'     estimation (the extent of the grid on the abscissa is equal to
#'     \code{(min(abscissa.relocations) + extent *
#'     diff(range(abscissa.relocations)))}, and similarly for the ordinate).
#' @param boundary If not \code{NULL}, an object inheriting the class
#'     \code{SpatialLines} defining a barrier that cannot be crossed by the
#'     animals.  There are constraints on the shape of the barrier that depend
#'     on the smoothing parameter \code{h} (see details in
#'     \code{\link[adehabitatHR]{kernelUD}}).
#' @seealso See \code{\link[adehabitatHR]{kernelUD}} for further details on the
#'     function.
#' @author Clement Calenge, modified by Mathieu Basille
#'     \email{mathieu@@basille.org}
#' @export
#' @importFrom sp proj4string "proj4string<-" SpatialPoints
#' @importFrom methods "slot<-"
#' @examples
#' ## Prepare the data:
#' data(puechabonsp, package = "adehabitatMA")
#' loc <- puechabonsp$relocs
#' elev <- puechabonsp$map
#'
#' ## Compute the kernel estimation
#' ker1 <- kernelUD(puechabonsp$relocs[,1], grid = elev, same4all = TRUE)
#'
#' ## Summarizing the overlaps
#' summary(kerneloverlap(ker1, conditional = TRUE))
kernelUD <- function (xy, h = "href", grid = 60, same4all = FALSE, hlim = c(0.1,
    1.5), kern = c("bivnorm", "epa"), extent = 1, boundary = NULL)
{
    if (!inherits(xy, "SpatialPoints"))
        stop("xy should inherit the class SpatialPoints")
    if (ncol(coordinates(xy)) > 2)
        stop("xy should be defined in two dimensions")
    pfs1 <- proj4string(xy)
    if (inherits(xy, "SpatialPointsDataFrame")) {
        if (ncol(xy) != 1) {
            warning("xy should contain only one column (the id of the animals)\nid ignored")
            id <- rep("a", nrow(as.data.frame(xy)))
            m <- 2
        } else {
            id <- xy[[1]]
            m <- 1
        }
    } else {
        id <- rep("a", nrow(as.data.frame(xy)))
        m <- 2
    }
    if (!is.null(boundary)) {
        if (!inherits(boundary, "SpatialLines"))
            stop("the boundary should be an object of class SpatialLines")
    }
    if (min(table(id)) < 5)
        stop("At least 5 relocations are required to fit an home range")
    id <- factor(id)
    xy <- as.data.frame(coordinates(xy))
    ## If called with a single SPDF, it switches same4all to TRUE without error
    ## (fix the bug with same4all=TRUE and a single SPDF)
    ## if (same4all) {
    ##     if (inherits(grid, "SpatialPoints"))
    ##         stop("when same4all is TRUE, grid should be a number")
    ##     grid <- .makegridUD(xy, grid, extent)
    ## }
    if (inherits(grid, "SpatialPixels"))
        same4all <- TRUE
    if (same4all) {
        if (!(is.numeric(grid) | inherits(grid, "SpatialPixels")))
            stop("when same4all is TRUE, grid should be a number or inherits SpatialPixels")
        if (is.numeric(grid))
            grid <- .makegridUD(xy, grid, extent)
    }
    ## EOM
    lixy <- split(xy, id)
    res <- lapply(1:length(lixy), function(i) {
        if (is.list(grid)) {
            grida <- grid[names(lixy)[i]][[1]]
        } else {
            grida <- grid
        }
        x <- lixy[names(lixy)[i]][[1]]
        if (!is.null(boundary)) {
            bdrk <- .boundaryk(SpatialPoints(x, proj4string = CRS(as.character(pfs1))),
                boundary, h)
            if (!is.null(bdrk)) {
                sigg <- attr(bdrk, "sign")
                bdrk <- as.data.frame(coordinates(bdrk))
                names(bdrk) <- names(x)
                x <- rbind(x, bdrk)
            }
        }
        ud <- .kernelUDs(SpatialPoints(x, proj4string = CRS(as.character(pfs1))),
            h = h, grid = grida, hlim = hlim, kern = kern, extent = extent)
        if (!is.null(boundary)) {
            if (!is.null(bdrk)) {
                ud <- .fbboun(ud, boundary, sigg, h)
                slot(ud, "data")[, 1] <- slot(ud, "data")[, 1]/(sum(slot(ud,
                  "data")[, 1]) * gridparameters(ud)[1, 2]^2)
            }
        }
        if (!is.na(pfs1))
            proj4string(ud) <- CRS(pfs1)
        return(ud)
    })
    names(res) <- names(lixy)
    class(res) <- "estUDm"
    if (m == 2) {
        res <- res[[1]]
    }
    return(res)
}
