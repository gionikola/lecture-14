#!/usr/bin/env Rscript
# Create a frequency plot for each variable in train.csv; save as PDFs in outputs/figures/.
# Run from project root.

processed_dir <- "data/processed"
fig_dir       <- "outputs/figures"
train_path    <- file.path(processed_dir, "train.csv")

dir.create(fig_dir, showWarnings = FALSE, recursive = TRUE)
data <- read.csv(train_path, sep = ";")

for (col in names(data)) {
  x <- data[[col]]
  out_file <- file.path(fig_dir, paste0(col, ".pdf"))

  pdf(out_file, width = 6, height = 4)

  if (length(unique(x)) <= 12) {
    # Discrete: bar plot of counts
    barplot(table(x), main = col, xlab = col, ylab = "Frequency", col = "steelblue")
  } else {
    # Continuous: histogram
    hist(x, main = col, xlab = col, ylab = "Frequency", col = "steelblue")
  }

  dev.off()
  cat("Wrote", out_file, "\n")
}

cat("Done. ", ncol(data), " figures in ", fig_dir, "\n", sep = "")
