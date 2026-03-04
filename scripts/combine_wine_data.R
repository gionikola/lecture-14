#!/usr/bin/env Rscript
# Combine red and white wine quality CSVs and add a binary 'is_red' column.
# Run from project root.

raw_dir    <- "data/raw"
processed_dir <- "data/processed"
red_path   <- file.path(raw_dir, "winequality-red.csv")
white_path <- file.path(raw_dir, "winequality-white.csv")
output_path <- file.path(processed_dir, "winequality-combined.csv")

red   <- read.csv(red_path, sep = ";")
white <- read.csv(white_path, sep = ";")

red$is_red   <- 1L
white$is_red <- 0L

combined <- rbind(red, white)
dir.create(processed_dir, showWarnings = FALSE, recursive = TRUE)
write.table(combined, output_path, sep = ";", row.names = FALSE)

cat("Wrote", nrow(combined), "rows to", output_path, "\n")
