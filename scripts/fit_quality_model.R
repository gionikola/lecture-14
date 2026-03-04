#!/usr/bin/env Rscript
# Fit multinomial logistic regression (quality ~ all other features), assess via 5-fold CV.
# Run from project root.

source("src/load_packages.R")

set.seed(42)

processed_dir <- "data/processed"
train_path    <- file.path(processed_dir, "train.csv")

train <- read_delim(train_path, delim = ";", show_col_types = FALSE) %>%
  mutate(quality = factor(quality))

recipe_spec <- recipe(quality ~ ., data = train) %>%
  step_normalize(all_predictors())

model_spec <- multinom_reg() %>%
  set_engine("nnet")

workflow_spec <- workflow() %>%
  add_recipe(recipe_spec) %>%
  add_model(model_spec)

folds <- vfold_cv(train, v = 5, strata = quality)

fit_cv <- fit_resamples(
  workflow_spec,
  folds,
  metrics = metric_set(accuracy),
  control = control_resamples(save_pred = TRUE)
)

metrics <- collect_metrics(fit_cv)
print(metrics)

cat("\n5-fold CV accuracy: mean = ", round(metrics$mean, 4), ", std_err = ", round(metrics$std_err, 4), "\n", sep = "")
