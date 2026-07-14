# Solution sketch - Module 5
library(dplyr); library(stringdist); library(org.Hs.eg.db)
meta <- read.csv("sample_metadata.csv", stringsAsFactors=FALSE)

vocab <- c("lung","breast","colon","liver","kidney")
meta$tissue_std <- vocab[amatch(tolower(trimws(meta$tissue_raw)), vocab, maxDist=3)]
meta %>% filter(is.na(tissue_std)) %>% distinct(tissue_raw) %>% print()

ids <- AnnotationDbi::select(org.Hs.eg.db, keys=unique(meta$gene_symbol),
        keytype="SYMBOL", columns=c("ENTREZID","ENSEMBL"))
j <- left_join(meta, ids, by=c("gene_symbol"="SYMBOL"))
cat("before", nrow(meta), "after", nrow(j), "\n")   # note one-to-many
# Keep a mapping log so a reviewer can audit every merge decision.