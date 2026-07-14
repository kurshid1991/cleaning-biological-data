# Module 6 - Outliers & batch effects
library(sva)      # ComBat
library(ggplot2)

expr <- as.matrix(read.csv("expr_normalized.csv", row.names = 1))
meta <- read.csv("sample_meta.csv")   # has 'batch' and 'condition'

# 1. Detect: PCA colored by BATCH, not condition
pca <- prcomp(t(expr), scale. = TRUE)
df  <- data.frame(PC1 = pca$x[,1], PC2 = pca$x[,2],
                  batch = factor(meta$batch), condition = meta$condition)
ggplot(df, aes(PC1, PC2, color = batch)) + geom_point(size = 3) +
  labs(title = "If points separate by BATCH, you have a batch effect")

# 2. Confirm: does a PC correlate with the technical covariate?
summary(aov(pca$x[,1] ~ factor(meta$batch)))   # significant -> batch drives PC1

# 3. Correct with ComBat, PRESERVING biology via model matrix
mod <- model.matrix(~ condition, data = meta)   # protect the signal you care about
expr_adj <- ComBat(dat = expr, batch = meta$batch, mod = mod)

# 4. Re-check PCA after correction
pca2 <- prcomp(t(expr_adj), scale. = TRUE)
# Expect: batch separation gone, condition separation preserved.

# 5. Guard: if batch is confounded with condition, DO NOT correct blindly
print(table(meta$batch, meta$condition))   # look for empty cells = confounding
