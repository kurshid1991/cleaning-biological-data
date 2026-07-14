# Module 4 - Encodings & file-format chaos
library(readr)
library(stringi)

# 1. Detect encoding before trusting a file
raw <- readBin("annotation.tsv", "raw", n = 1e5)
enc <- stri_enc_detect(raw)[[1]]$Encoding[1]
cat("Detected encoding:", enc, "\n")

# 2. Read with an explicit encoding + gene column forced to TEXT
ann <- read_tsv("annotation.tsv",
                locale = locale(encoding = enc),
                col_types = cols(gene_symbol = col_character()))

# 3. Detect Excel-mangled gene symbols (SEPT1 -> '1-Sep', etc.)
looks_like_date <- grepl("^[0-9]{1,2}-(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)$",
                         ann$gene_symbol, ignore.case = TRUE)
cat("Suspected mangled symbols:", sum(looks_like_date), "\n")

# 4. Repair known cases with a lookup ('1-Sep' -> 'SEPT1')
fix_map <- c("1-Sep"="SEPT1","2-Sep"="SEPT2","1-Mar"="MARCH1","2-Mar"="MARCH2")
hit <- ann$gene_symbol %in% names(fix_map)
ann$gene_symbol[hit] <- fix_map[ann$gene_symbol[hit]]

# 5. Parse a FASTA safely (structure-aware, not line-by-line CSV)
read_fasta <- function(path){
  lines <- readLines(path, encoding = "UTF-8")
  hdr <- grepl("^>", lines)
  ids <- sub("^>", "", lines[hdr])
  seqs <- tapply(lines[!hdr], cumsum(hdr)[!hdr], paste, collapse = "")
  data.frame(id = ids, seq = as.character(seqs))
}
