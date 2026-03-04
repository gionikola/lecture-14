# Install and load packages. Source from project root or set R script dir accordingly.

packages <- c("tidyverse", "tidymodels")

for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg, repos = "https://cloud.r-project.org/")
  }
  library(pkg, character.only = TRUE)
}
