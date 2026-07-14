# Cleaning Biological Data — From Raw Files to Analysis-Ready

A hands-on **R** course by **MultiBiomics** that grounds every data-cleaning skill in real
omics and clinical data. For students, researchers, and biotech/pharma. Ties into the
*Computational Genomics with R* series.

> Course site (videos + lessons): built on Google Sites.
> This repo holds the **exercise datasets and R scripts** for each module.

## Modules

| # | Module | Video |
|---|--------|-------|
| 1 | [Handling Missing Values in Omics Data](./module-1-missing-values/) | 10 min |
| 2 | [Scaling & Normalization for Biological Assays](./module-2-normalization/) | 11 min |
| 3 | [Parsing Dates & Clinical Metadata](./module-3-clinical-dates/) | 10 min |
| 4 | [Character Encodings & File Format Chaos](./module-4-encodings/) | 10 min |
| 5 | [Inconsistent Data Entry in Biological Metadata](./module-5-metadata-ids/) | 11 min |
| 6 | [Outliers & Batch Effects](./module-6-batch-effects/) | 11 min |
| 7 | [Capstone - End-to-End Cleaning Pipeline](./module-7-capstone/) | 12 min |

## How to use
1. Open a module folder (e.g. `module-1-missing-values/`).
2. Read its `README.md` for the dataset and exercise steps.
3. Run the tutorial `.R` against the files in that module's `data/` folder — they are named
   exactly as the scripts expect, so everything runs out of the box.
4. Try the exercise, then check the solution `.R`.

## Requirements
R (>= 4.1) with Bioconductor. Packages used across modules include:
`naniar`, `missForest`, `edgeR`, `DESeq2`, `lubridate`, `survival`, `readr`, `stringi`,
`stringdist`, `org.Hs.eg.db`, `biomaRt`, `sva`, `dplyr`, `here`.

## Note on the datasets
The `data/` files are **small synthetic datasets** built to mirror the real problems
(scRNA-seq dropout, library-size variation, mixed date formats, Excel-mangled gene names,
inconsistent tissue labels, batch effects). Swap in real GEO/GDC data anytime — the column
names match common public formats.

---
© 2026 MultiBiomics
