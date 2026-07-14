# Module 2 - Normalization for RNA-seq
library(edgeR)   # TMM, CPM
library(DESeq2)  # median-of-ratios size factors

counts <- as.matrix(read.csv("raw_counts.csv", row.names = 1))
group  <- factor(read.csv("sample_meta.csv")$condition)

# 1. Filter low-count genes (they add noise, not signal)
keep <- rowSums(cpm(counts) > 1) >= 3
counts <- counts[keep, ]

# 2. edgeR: TMM normalization (composition-aware)
dge <- DGEList(counts = counts, group = group)
dge <- calcNormFactors(dge, method = "TMM")
logCPM <- cpm(dge, log = TRUE, prior.count = 1)   # good ML feature matrix

# 3. DESeq2: median-of-ratios (parallel approach)
dds <- DESeqDataSetFromMatrix(counts, DataFrame(group), design = ~ group)
dds <- estimateSizeFactors(dds)
vsd <- vst(dds, blind = TRUE)                      # variance-stabilised

# 4. Compare PCA before vs after normalization
pca_raw  <- prcomp(t(log2(counts + 1)), scale. = TRUE)
pca_norm <- prcomp(t(logCPM),           scale. = TRUE)
# Expect: raw PC1 tracks library size; normalized PC1 tracks biology.

# 5. NEVER z-score raw counts directly:
# bad <- scale(counts)   # <- do not do this
