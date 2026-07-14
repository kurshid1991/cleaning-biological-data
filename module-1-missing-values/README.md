# Module 1 — Handling Missing Values in Omics Data

Why missingness in biology isn't random — and what to do about it.

## Dataset
GEO expression matrix with dropout (e.g. GSE ~ 200 cells x 2,000 genes)

Files in this folder:
- `data/GSE_expression.csv`
- `data/GSE_metadata.csv`

## Tutorial
Run the code-along script: [`m1_missing_values.R`](./m1_missing_values.R)

## Exercise
1. Download the provided expression matrix and metadata from the course repo.
2. Compute overall and per-gene missingness with naniar.
3. Make the MNAR diagnostic plot (fraction missing vs mean expression). Is missingness random?
4. Filter genes missing in >50% of samples; report how many remain.
5. Impute the remainder with half-min AND with missForest; keep a was_missing flag.
6. Run PCA on both imputed matrices and describe how the choice changes the embedding.

## Solution
Reveal only after attempting: [`m1_solution.R`](./m1_solution.R)

---
Part of **Cleaning Biological Data** · MultiBiomics · ties into *Computational Genomics with R*.
