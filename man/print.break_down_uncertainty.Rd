% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/print_break_down_uncertainty.R
\name{print.break_down_uncertainty}
\alias{print.break_down_uncertainty}
\title{Print Generic for Break Down Uncertainty Objects}
\usage{
\method{print}{break_down_uncertainty}(x, ...)
}
\arguments{
\item{x}{an explanation created with \code{\link{break_down_uncertainty}}}

\item{...}{other parameters.}
}
\value{
a data frame.
}
\description{
Print Generic for Break Down Uncertainty Objects
}
\examples{
library("DALEX")
library("iBreakDown")
# Toy examples, because CRAN angels ask for them
titanic <- na.omit(titanic)
set.seed(1313)
titanic_small <- titanic[sample(1:nrow(titanic), 500), c(1,2,6,9)]
model_titanic_glm <- glm(survived == "yes" ~ gender + age + fare,
                       data = titanic_small, family = "binomial")
explain_titanic_glm <- explain(model_titanic_glm,
                           data = titanic_small[,-9],
                           y = titanic_small$survived == "yes")
bd_rf <- break_down_uncertainty(explain_titanic_glm, titanic_small[1, ])
bd_rf
plot(bd_rf)

\donttest{
## Not run:
library("randomForest")
set.seed(1313)
model <- randomForest(status ~ . , data = HR)
new_observation <- HR_test[1,]

explainer_rf <- explain(model,
                        data = HR[1:1000,1:5],
                        y = HR$status[1:1000])

bd_rf <- break_down_uncertainty(explainer_rf,
                           new_observation)
bd_rf

# example for regression - apartment prices
# here we do not have intreactions
model <- randomForest(m2.price ~ . , data = apartments)
explainer_rf <- explain(model,
                        data = apartments_test[1:1000,2:6],
                        y = apartments_test$m2.price[1:1000])

bd_rf <- break_down_uncertainty(explainer_rf, apartments_test[1,])
bd_rf
}
}
\references{
Predictive Models: Visual Exploration, Explanation and Debugging \url{https://pbiecek.github.io/PM_VEE}
}
