############################################################
# Module 1 — Handling Missing Values in Omics Data
############################################################

#-----------------------------------------------------------
# 1. Install packages (only if not already installed)
#-----------------------------------------------------------

packages <- c(
  "naniar",
  "missForest",
  "dplyr",
  "ggplot2"
)

missing_packages <- setdiff(packages, rownames(installed.packages()))

if(length(missing_packages) > 0){
  install.packages(missing_packages)
}

#-----------------------------------------------------------
# 2. Load libraries
#-----------------------------------------------------------

library(naniar)
library(missForest)
library(dplyr)
library(ggplot2)

#-----------------------------------------------------------
# 3. Load expression matrix and metadata
#-----------------------------------------------------------

expr <- read.csv(
  "GSE_expression.csv",
  row.names = 1,
  check.names = FALSE
)

meta <- read.csv(
  "GSE_metadata.csv",
  check.names = FALSE
)

#-----------------------------------------------------------
# 4. Overall missingness
#-----------------------------------------------------------

pct_missing <- mean(is.na(expr)) * 100

cat(sprintf(
  "\nOverall Missing Values = %.2f%%\n\n",
  pct_missing
))

#-----------------------------------------------------------
# 5. Missing values per gene
#-----------------------------------------------------------

miss_var_summary(as.data.frame(t(expr)))

#-----------------------------------------------------------
# 6. Visualize missingness
#-----------------------------------------------------------

gg_miss_var(as.data.frame(t(expr))) +
  ggtitle("Missing Values Per Gene")

#-----------------------------------------------------------
# 7. Check whether missingness depends on expression
#    (MNAR diagnostic)
#-----------------------------------------------------------

gene_mean <- rowMeans(expr, na.rm = TRUE)

gene_miss <- rowMeans(is.na(expr))

plot(
  gene_mean,
  gene_miss,
  pch = 16,
  col = "steelblue",
  xlab = "Mean Expression",
  ylab = "Fraction Missing",
  main = "MNAR Check: Missingness vs Expression"
)

#-----------------------------------------------------------
# 8. Remove genes having >50% missing values
#-----------------------------------------------------------

keep <- gene_miss <= 0.50

expr_f <- expr[keep, ]

cat(
  "\nGenes before filtering :",
  nrow(expr),
  "\n"
)

cat(
  "Genes after filtering  :",
  nrow(expr_f),
  "\n\n"
)

#-----------------------------------------------------------
# 9. Half-Minimum Imputation
#-----------------------------------------------------------

half_min_impute <- function(x){

  m <- min(x, na.rm = TRUE)

  x[is.na(x)] <- m / 2

  return(x)
}

expr_hm <- t(
  apply(
    expr_f,
    1,
    half_min_impute
  )
)

#-----------------------------------------------------------
# 10. Missing-value indicator matrix
#-----------------------------------------------------------

missing_flag <- is.na(expr_f)

#-----------------------------------------------------------
# 11. Check remaining missing values
#-----------------------------------------------------------

cat(
  "Missing values before imputation :",
  sum(is.na(expr_f)),
  "\n"
)

cat(
  "Missing values after imputation  :",
  sum(is.na(expr_hm)),
  "\n\n"
)

#-----------------------------------------------------------
# 12. Compare distributions
#-----------------------------------------------------------

par(mfrow = c(1,2))

hist(
  as.numeric(as.matrix(expr_f)),
  breaks = 40,
  main = "Before Imputation",
  xlab = "Expression Values",
  col = "tomato"
)

hist(
  as.numeric(as.matrix(expr_hm)),
  breaks = 40,
  main = "After Half-Min Imputation",
  xlab = "Expression Values",
  col = "seagreen"
)

par(mfrow = c(1,1))

#-----------------------------------------------------------
# 13. Compare missing values before vs after
#-----------------------------------------------------------

barplot(
  c(
    sum(is.na(expr_f)),
    sum(is.na(expr_hm))
  ),
  names.arg = c(
    "Before",
    "After"
  ),
  col = c(
    "red",
    "darkgreen"
  ),
  ylab = "Number of Missing Values",
  main = "Missing Values Before vs After Imputation"
)

#-----------------------------------------------------------
# 14. Preview cleaned dataset
#-----------------------------------------------------------

head(expr_hm)

#-----------------------------------------------------------
# 15. Save cleaned expression matrix
#-----------------------------------------------------------

write.csv(
  expr_hm,
  "GSE_expression_half_min_imputed.csv"
)

cat("\nAnalysis Complete!\n")
