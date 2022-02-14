#' Simulated pdfs for the Vuong statistics using linear models
#'
#' This function can be used to reproduce the examples given of Shi (2015) which illustrate the fact that the distribution of the Vuong statistic may be very different from a standard normal
#' 
#' @aliases sim_lm
#' @param N sample size
#' @param R the number of replications
#' @param Kf the number of covariates for the first model
#' @param Kg the number of covariates for the second model
#' @param a the share of the variance of `y` explained by the two
#'     competing models
#' @return a numeric of length `N` containing the values of the Vuong statistic
#'
#' @importFrom stats lm.fit
#' 
#' @references
#'
#' \insertRef{SHI:15}{ndvtest}
#'
#' @examples
#' sim_lm(N = 100, R = 10, Kf = 10, Kg = 2, a = 0.5)
#' @export
sim_lm <- function(N = 1E03, R = 1E03, Kf = 15, Kg = 1, a = 0.125){
    Zf <- array(rnorm(R * Kf * N, sd = a / sqrt(Kf)), dim = c(N, Kf, R))
    Zg <- array(rnorm(R * Kg * N, sd = a / sqrt(Kg)), dim = c(N, Kg, R))
    eps <- matrix(rnorm(R * N, sd = sqrt(1 - a ^ 2)), N, R)
    y <- apply(Zf, c(1, 3), sum) + apply(Zg, c(1, 3), sum) + eps
    get_lnl <- function(x){
        res <- x$residuals
        N <- length(res)
        s2 <- sum(res ^ 2) / N
        - 1 / 2 * log(2 * pi) - 1 / 2 * log(s2) - 1 / 2 * res ^ 2 / s2
    }
    res_f <- sapply(1:R, function(i) get_lnl(lm.fit(Zf[,, i], y[, i])))
    res_g <- sapply(1:R, function(i) get_lnl(lm.fit(Zg[,, i, drop = FALSE], y[, i])))
    LR <- apply(res_f - res_g, 2, mean)
    w2 <- apply( (res_f - res_g) ^ 2, 2, mean) - LR ^ 2
    Vuong <- sqrt(N) * LR / sqrt(w2)
    Vuong
}



