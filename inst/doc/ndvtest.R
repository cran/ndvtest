## -----------------------------------------------------------------------------
Vuong <- ndvtest::sim_lm(N = 100, R = 1000, Kf = 15, Kg = 1, a = 0.5)
head(Vuong)
mean(Vuong)
mean(abs(Vuong) > 1.96)

## -----------------------------------------------------------------------------
library("ggplot2")
ggplot(data = data.frame(Vuong = Vuong)) + geom_density(aes(x = Vuong)) +
    geom_function(fun = dnorm, linetype = "dotted")

## -----------------------------------------------------------------------------
library("ndvtest")
test <- ndvtest(turnout$group, turnout$intens, size = 0.05, pval = FALSE)
test

## -----------------------------------------------------------------------------
ndvtest(turnout$group, turnout$intens, nd = FALSE)

## -----------------------------------------------------------------------------
test <- ndvtest(turnout$group, turnout$intens, pval = TRUE)
test

## -----------------------------------------------------------------------------
data("NMES1988", package = "AER")
zi <- pscl::zeroinfl(visits ~ hospital + health + chronic + gender + school + insurance,
                     data = NMES1988)
hl <- pscl::hurdle(visits ~ hospital + health + chronic + gender + school + insurance,
                   data = NMES1988)

## -----------------------------------------------------------------------------
pscl::vuong(zi, hl)

## -----------------------------------------------------------------------------
nonnest2::vuongtest(zi, hl)

## -----------------------------------------------------------------------------
ndvtest(zi, hl)

## -----------------------------------------------------------------------------
library("mlogit")
data("ModeCanada")
MC <- mlogit.data(ModeCanada, subset = noalt == 4, chid.var = "case",
                  alt.var = "alt", drop.index = TRUE)

## -----------------------------------------------------------------------------
ml <- mlogit(choice ~ freq + cost + ivt + ovt | urban + income, MC, 
             reflevel = 'car', alt.subset = c("car", "train", "air"))

## -----------------------------------------------------------------------------
hl <- mlogit(choice ~ freq + cost + ivt + ovt | urban + income, MC, 
             reflevel = 'car', alt.subset = c("car", "train", "air"),
             heterosc = TRUE)
coef(summary(hl))

## -----------------------------------------------------------------------------
lmtest::waldtest(hl, heterosc = FALSE)
scoretest(ml, heterosc = TRUE)
lmtest::lrtest(hl, ml)

## -----------------------------------------------------------------------------
ndvtest(hl, ml, nested = TRUE)

## -----------------------------------------------------------------------------
library("mlogit")
data("RiskyTransport")
RT <- mlogit.data(RiskyTransport, shape = "long", choice = "choice",
                  chid.var = "chid", alt.var = "mode", id.var = "id")

## -----------------------------------------------------------------------------
ml <- mlogit(choice ~ cost, data = RT)
hl <- mlogit(choice ~ cost , data = RT, heterosc = TRUE)
nl <- mlogit(formula = choice ~ cost, data = RT,
             nests = list(fast = c("Helicopter", "Hovercraft"),
                          slow = c("WaterTaxi", "Ferry")),
             un.nest.el = TRUE)
modelsummary::msummary(list(multinomial = ml, heteroscedastic = hl, nested =  nl))

## -----------------------------------------------------------------------------
ndvtest(nl, hl, vartest = TRUE)

## -----------------------------------------------------------------------------
ndvtest(hl, nl)

