# Module 7 - Capstone: reproducible end-to-end cleaning pipeline
suppressPackageStartupMessages({
  library(here); library(readr); library(dplyr)
  library(edgeR); library(sva); library(naniar)
})
set.seed(42)
log_step <- function(msg, x) cat(sprintf("[%s] %s: %d rows\n", Sys.time(), msg, nrow(x)))

# 1. LOAD - safe I/O, explicit types (Modules 4)
counts <- read_csv(here("data","raw_counts.csv"), show_col_types = FALSE)
meta   <- read_csv(here("data","clinical.csv"),
                   col_types = cols(gene_symbol = col_character()))
log_step("loaded", counts)

# 2. HARMONIZE metadata + IDs (Module 5)
meta <- meta %>% mutate(tissue = tolower(trimws(tissue)))

# 3. MISSINGNESS - diagnose then handle appropriately (Module 1)
miss <- rowMeans(is.na(counts)); counts <- counts[miss <= 0.5, ]
log_step("after missing-filter", counts)

# 4. NORMALIZE (Module 2)
mat <- as.matrix(counts[,-1]); rownames(mat) <- counts[[1]]
dge <- calcNormFactors(DGEList(mat), method = "TMM")
logCPM <- cpm(dge, log = TRUE)

# 5. BATCH detect + correct, preserving biology (Module 6)
mod <- model.matrix(~ condition, meta)
adj <- ComBat(logCPM, batch = meta$batch, mod = mod)

# 6. VALIDATE - assertions before anything ships
stopifnot(!any(is.na(adj)), ncol(adj) == nrow(meta))
saveRDS(list(expr = adj, meta = meta), here("out","analysis_ready.rds"))

# 7. REPRODUCIBILITY footer
writeLines(capture.output(sessionInfo()), here("out","sessionInfo.txt"))
