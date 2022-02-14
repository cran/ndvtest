#' Turnout
#'
#' Turnout in Texas liquor referenda
#'
#' @name turnout
#' @docType data
#' @keywords dataset
#'
#' @format a list of three fitted models:
#' - group: the group-rule-utilitarian model,
#' - intens: the intensity model,
#' - sur: the reduced form SUR model.
#'
#' @description these three models are replication in R of stata's
#'     code available on the web site of the American Economic
#'     Association. The estimation is complicated by the fact that
#'     some linear constraints are imposed. The estimation was
#'     performed using the `maxLik` package. As the Hessian is near
#'     singular, the `bread` method for `maxLik` which use the `vcov`
#'     method returns an error. Therefore, we use a new `maxLik2`
#'     class and write specific `llcont`, `estfun` and `bread` methods
#'     for this class.
#'
#' @source
#' [American Economic Association data archive](https://www.aeaweb.org/aer/).
#' @references
#' \insertRef{COAT:CONL:04}{ndvtest}
#'
#' @examples
#' \dontrun{
#' data("turnout", package = "ndvtest")
#' ndvtest(turnout$group, turnout$intens)
#' ndvtest(turnout$group, turnout$sur)
#' ndvtest(turnout$intens, turnout$sur)
#' }
NULL
