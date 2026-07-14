# Module 5 - Harmonizing messy metadata & gene IDs
library(dplyr)
library(stringdist)
library(org.Hs.eg.db)

meta <- read.csv("sample_metadata.csv", stringsAsFactors = FALSE)

# 1. Standardize free-text tissue labels to a controlled vocabulary
controlled <- c("lung","breast","colon","liver","kidney")
map_tissue <- function(x){
  x <- tolower(trimws(x))
  idx <- amatch(x, controlled, maxDist = 3)     # fuzzy nearest match
  ifelse(is.na(idx), NA, controlled[idx])
}
meta <- meta %>% mutate(tissue_std = map_tissue(tissue_raw))

# 2. ALWAYS keep the original and review unmatched rows
unmatched <- meta %>% filter(is.na(tissue_std)) %>% distinct(tissue_raw)
print(unmatched)   # hand-review these; don't auto-guess

# 3. Map gene SYMBOLS -> ENTREZ (source of truth = org.Hs.eg.db)
symbols <- unique(meta$gene_symbol)
id_map <- AnnotationDbi::select(org.Hs.eg.db, keys = symbols,
                                keytype = "SYMBOL",
                                columns = c("ENTREZID","ENSEMBL"))

# 4. Guard against many-to-many blow-up: count rows before/after join
before <- nrow(meta)
meta2  <- left_join(meta, id_map, by = c("gene_symbol" = "SYMBOL"))
cat("rows before:", before, " after:", nrow(meta2),
    " (>before means one-to-many expansion)\n")

# 5. Collapse one-to-many if a unique ID is required
meta_unique <- meta2 %>% group_by(gene_symbol) %>% slice(1) %>% ungroup()
