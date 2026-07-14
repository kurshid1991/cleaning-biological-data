# Module 7 — Capstone - End-to-End Cleaning Pipeline

One messy real dataset from raw to analysis-ready, as a reproducible script.

## Dataset
One messy real cohort (TCGA or GEO) - counts + clinical + batch info

Files in this folder:
- `data/raw_counts.csv`
- `data/clinical.csv (in data/)`

## Tutorial
Run the code-along script: [`m7_capstone_pipeline.R`](./m7_capstone_pipeline.R)

## Exercise
1. Set up a reproducible project (here::here, a data/ and out/ folder, a seed).
2. Load raw files with safe I/O and explicit column types.
3. Harmonize metadata and gene IDs; log row counts at each step.
4. Diagnose and handle missingness with the method the data demands.
5. Normalize, then detect and correct any batch effect (preserving condition).
6. Validate with assertions, save the analysis-ready object, and write sessionInfo().

## Solution
Reveal only after attempting: [`m7_solution.R`](./m7_solution.R)

---
Part of **Cleaning Biological Data** · MultiBiomics · ties into *Computational Genomics with R*.
