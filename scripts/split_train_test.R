#!/usr/bin/env Rscript
# Split combined wine data into 80% train and 20% test. Run from project root.

set.seed(42)

processed_dir <- "data/processed"
input_path    <- file.path(processed_dir, "winequality-combined.csv")
train_path    <- file.path(processed_dir, "train.csv")
test_path     <- file.path(processed_dir, "test.csv")

data <- read.csv(input_path, sep = ";")
n    <- nrow(data)
idx  <- sample.int(n, size = round(0.8 * n))
train <- data[idx, ]
test  <- data[-idx, ]

write.table(train, train_path, sep = ";", row.names = FALSE)
write.table(test, test_path, sep = ";", row.names = FALSE)

cat("Train:", nrow(train), "rows ->", train_path, "\n")
cat("Test:", nrow(test), "rows ->", test_path, "\n")
