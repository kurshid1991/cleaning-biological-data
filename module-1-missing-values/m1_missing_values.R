# Module 1 — Handling Missing Values in Omics Data
# Ties into: Computational Genomics with R
library(naniar)      # visualise & summarise missingness
library(missForest)  # random-forest imputation (use with care!)
library(dplyr)

# 1. Load a GEO-style expression matrix (genes x samples)
expr <- read.csv("GSE_expression.csv", row.names = 1, check.names = FALSE)
meta <- read.csv("GSE_metadata.csv")

# 2. Look BEFORE you leap — quantify missingness
pct_missing <- mean(is.na(expr)) * 100
cat(sprintf("Overall missing: %.1f%%\n", pct_missing))
miss_var_summary(as.data.frame(t(expr)))   # per-gene missingness
gg_miss_var(as.data.frame(t(expr)))        # visualise pattern

# 3. Diagnose the pattern: is low expression linked to missingness? (MNAR check)
gene_mean <- rowMeans(expr, na.rm = TRUE)
gene_miss <- rowMeans(is.na(expr))
plot(gene_mean, gene_miss,
     xlab = "Mean expression", ylab = "Fraction missing",
     main = "MNAR check: missingness vs abundance")

# 4. Drop genes that are missing in >50% of samples (too little signal)
keep <- gene_miss <= 0.5
expr_f <- expr[keep, ]

# 5. Impute ONLY when appropriate. For MNAR LOD-style data, half-min is honest:
half_min_impute <- function(x) { m <- min(x, na.rm = TRUE); x[is.na(x)] <- m/2; x }
expr_hm <- t(apply(expr_f, 1, half_min_impute))

# 6. Always keep a 'was_missing' flag so downstream models can account for it
missing_flag <- is.na(expr_f)

# 7. When NOT to impute: survival times are censored, not missing
#    surv_time stays as-is; 'status' column encodes event vs censor.
