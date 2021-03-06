% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/break_down.R
\name{break_down}
\alias{break_down}
\alias{break_down.explainer}
\alias{break_down.default}
\title{Model Agnostic Sequential Variable Attributions}
\usage{
break_down(x, ..., interactions = FALSE)

\method{break_down}{explainer}(x, new_observation, ...,
  interactions = FALSE)

\method{break_down}{default}(x, data, predict_function = predict,
  new_observation, keep_distributions = FALSE, order = NULL,
  label = class(x)[1], ..., interactions = FALSE)
}
\arguments{
\item{x}{an explainer created with function \code{\link[DALEX]{explain}} or a model.}

\item{...}{parameters passed to `local_*` functions.}

\item{interactions}{shall interactions be included?}

\item{new_observation}{a new observation with columns that correspond to variables used in the model.}

\item{data}{validation dataset, will be extracted from `x` if it is an explainer.}

\item{predict_function}{predict function, will be extracted from `x` if it's an explainer.}

\item{keep_distributions}{if `TRUE`, then distribution of partial predictions is stored and can be plotted with the generic `plot()`.}

\item{order}{if not `NULL`, then it will be a fixed order of variables. It can be a numeric vector or vector with names of variables.}

\item{label}{name of the model. By default it is extracted from the 'class' attribute of the model.}
}
\value{
an object of the `break_down` class.
}
\description{
This function finds Variable Attributions via Sequential Variable Conditioning.
It calls either \code{\link{local_attributions}} for additive attributions
or \code{\link{local_interactions}} for attributions with interactions.
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
bd_rf <- break_down(explain_titanic_glm, titanic_small[1, ])
bd_rf
plot(bd_rf, max_features = 3)

\donttest{
## Not run:
library("randomForest")
set.seed(1313)
# example with interaction
# classification for HR data
model <- randomForest(status ~ . , data = HR)
new_observation <- HR_test[1,]

explainer_rf <- explain(model,
                        data = HR[1:1000,1:5],
                        y = HR$status[1:1000])

bd_rf <- break_down(explainer_rf,
                           new_observation)
bd_rf
plot(bd_rf)
}
}
\references{
Predictive Models: Visual Exploration, Explanation and Debugging \url{https://pbiecek.github.io/PM_VEE}
}
\seealso{
\code{\link{local_attributions}}, \code{\link{local_interactions}}
}
