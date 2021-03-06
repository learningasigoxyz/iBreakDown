% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/describe_breakdown.R, R/describe_shap.R
\name{describe}
\alias{describe}
\alias{describe.break_down}
\alias{describe.break_down_uncertainty}
\title{Generates Textual Explanations for Predictive Models}
\usage{
describe(x, nonsignificance_treshold = 0.15, ...)

\method{describe}{break_down}(x, nonsignificance_treshold = 0.15, ...,
  label = NULL, short_description = FALSE, display_values = FALSE,
  display_numbers = FALSE, display_distribution_details = FALSE,
  display_shap = FALSE)

\method{describe}{break_down_uncertainty}(x,
  nonsignificance_treshold = 0.15, ..., label = NULL,
  short_description = FALSE, display_values = FALSE,
  display_numbers = FALSE, display_distribution_details = FALSE,
  display_shap = FALSE)
}
\arguments{
\item{x}{an explanation created with \code{\link{break_down}} or \code{\link{shap}}}

\item{nonsignificance_treshold}{a numeric specifying a treshold for variable importance}

\item{...}{other arguments}

\item{label}{a character string describing model's prediction}

\item{short_description}{a boolean, returns a short description}

\item{display_values}{a boolean, displays variables' values}

\item{display_numbers}{a boolean, displays a description containing numerical values}

\item{display_distribution_details}{a boolean, displays details about the distribution of model's predictions}

\item{display_shap}{a boolean, adds information about variables' average contribution. Use only with \code{\link{shap}} explanation.}
}
\value{
A character string of textual explanation
}
\description{
Generic function \code{describe} generates natural language explanations based on
\code{\link{break_down}} and \code{\link{shap}} explanations, what enhances their interpretability.
}
\details{
Function \code{describe} generates a textual explanations by extracting information from
a \code{\link{break_down}} or \code{\link{shap}} explanation. It makes an argument justifying why
the model's prediction is lower or higher, than it's average prediction. The description consists of
an introduction, argumenation and summary making use from the claim, support, evidence argumentation
structure, as recomended for the World Universities Debating style.

The function first selects one of four different scenarios, due to
\code{nonsignificance_treshold}. The chosen scenario can be one of the following:
1. Model's prediction for the selected instance is significantly higher than the average prediction.
2. Model's prediction is significantly lower.
3. Model's prediction is close to it's average prediction, however there are significant
variables counteracting with each other
4. Model's prediction is close to it's average prediction and all the variables are rather nonsignificant.
Then an explanation due to the chosen scenario is generated.
}
\examples{
library("DALEX")
library("randomForest")
library("iBreakDown")

titanic <- na.omit(titanic)
model_titanic_rf <- randomForest(survived == "yes" ~ gender + age + class + embarked +
                                  fare + sibsp + parch,  data = titanic)

explain_titanic_rf <- explain(model_titanic_rf,
                              data = titanic[ ,-9],
                              y = titanic$survived == "yes",
                              label = "Random Forest v7")

bd_explanation <- break_down(explain_titanic_rf, titanic[1, ], keep_distributions = TRUE)
plot(bd_explanation)

description <- describe(bd_explanation,
                        label = "the passanger will survive with probability",
                        short_description = FALSE,
                        display_values =  TRUE,
                        display_numbers = TRUE,
                        display_distribution_details = FALSE)

description

library("DALEX")
library("iBreakDown")
titanic <- na.omit(titanic)
model_titanic_glm <- glm(titanic$survived == "yes" ~ age + gender + class + fare + sibsp,
                         data = titanic[ ,-9], family = "binomial")
explain_titanic_glm <- explain(model_titanic_glm,
                              data = titanic[,-9],
                              y = titanic$survived == "yes",
                              label = "glm")
passanger <- titanic[1, -9]
shap_glm <- shap(explain_titanic_glm, passanger)
plot(shap_glm)

describe(shap_glm,
         label = "the selected passanger survives with probability",
         display_shap = TRUE,
         display_numbers = TRUE)

}
