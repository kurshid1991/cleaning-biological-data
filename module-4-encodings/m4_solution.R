# Solution sketch - Module 4
library(readr); library(stringi)
raw <- readBin("annotation.tsv","raw",n=1e5)
enc <- stri_enc_detect(raw)[[1]]$Encoding[1]
ann <- read_tsv("annotation.tsv", locale=locale(encoding=enc),
                col_types=cols(gene_symbol=col_character()))

mangled <- grepl("^[0-9]{1,2}-[A-Za-z]{3}$", ann$gene_symbol)
cat("mangled:", sum(mangled), "\n")
# join to an HGNC alias table to restore true symbols, then:
write_tsv(ann, "annotation_clean.tsv")   # UTF-8 by default
# Lesson: never open gene lists in Excel; if you must, set the column to Text FIRST.