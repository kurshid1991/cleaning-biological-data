# Solution sketch — Module 1
library(naniar); library(ggplot2); library(missForest)
expr <- read.csv("GSE_expression.csv", row.names=1, check.names=FALSE)

gene_miss <- rowMeans(is.na(expr)); gene_mean <- rowMeans(expr, na.rm=TRUE)
# MNAR is visible: high 'fraction missing' clusters at LOW mean expression
qplot(gene_mean, gene_miss) + labs(title="MNAR: dropout hits low-expressed genes")

expr_f <- expr[gene_miss <= 0.5, ]
cat(nrow(expr_f), "genes retained\n")

# half-min
hm <- t(apply(expr_f, 1, function(x){m<-min(x,na.rm=TRUE); x[is.na(x)]<-m/2; x}))
# missForest (rows=samples for imputation)
mf <- missForest(t(as.matrix(expr_f)))$ximp

pca_hm <- prcomp(t(hm), scale.=TRUE)
pca_mf <- prcomp(mf,      scale.=TRUE)
# Compare PC1/PC2 — missForest 'borrows' structure across genes and can
# invent smooth gradients; half-min keeps true zeros distinct. Report both.