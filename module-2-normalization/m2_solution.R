# Solution sketch - Module 2
library(edgeR)
counts <- as.matrix(read.csv("raw_counts.csv", row.names=1))
lib <- colSums(counts)

dge <- DGEList(counts); dge <- calcNormFactors(dge,"TMM")
logCPM <- cpm(dge, log=TRUE)

pr_raw  <- prcomp(t(log2(counts+1)), scale.=TRUE)
pr_norm <- prcomp(t(logCPM),         scale.=TRUE)

cor(pr_raw$x[,1],  lib)   # typically |r| > 0.8  -> PC1 == depth artifact
cor(pr_norm$x[,1], lib)   # drops toward 0       -> biology recovered
# Takeaway: TMM/DESeq2 size factors for DE; logCPM (or VST) for ML features.