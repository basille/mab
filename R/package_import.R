## Import all functions from adehabitatLT and adehabitatHR
#' @import adehabitatLT
#' @import adehabitatHR
NULL

## Import specific non-exported functions from adehabitat:
.checkp4 <- utils::getFromNamespace(".checkp4", "adehabitatLT")
.makegridUD <- utils::getFromNamespace(".makegridUD", "adehabitatHR")
.boundaryk <- utils::getFromNamespace(".boundaryk", "adehabitatHR")
.kernelUDs <- utils::getFromNamespace(".kernelUDs", "adehabitatHR")
.fbboun <- utils::getFromNamespace(".fbboun", "adehabitatHR")
