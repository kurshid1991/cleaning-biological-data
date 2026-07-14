# Solution sketch - Module 6
library(sva)
expr <- as.matrix(read.csv("expr_normalized.csv", row.names=1))
meta <- read.csv("sample_meta.csv")

pca <- prcomp(t(expr), scale.=TRUE)
summary(aov(pca$x[,1] ~ factor(meta$batch)))   # p << 0.05 confirms batch drives PC1
print(table(meta$batch, meta$condition))       # ensure no empty cells (confounding)

mod <- model.matrix(~ condition, meta)
adj <- ComBat(expr, batch=meta$batch, mod=mod)

pca2 <- prcomp(t(adj), scale.=TRUE)
# Compare: batch grouping dissolves; condition grouping remains. Report both PCAs.