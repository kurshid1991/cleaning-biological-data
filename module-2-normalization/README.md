# Module 2 — Scaling & Normalization for Biological Assays

Why generic z-scoring breaks biology - and the right way to normalize omics.

## Dataset
Raw RNA-seq count matrix + condition metadata (e.g. airway or a GEO count set)

Files in this folder:
- `data/raw_counts.csv`
- `data/sample_meta.csv`

## Tutorial
Run the code-along script: [`m2_normalization.R`](./m2_normalization.R)

## Exercise
1. Load the raw count matrix and sample metadata.
2. Filter genes with low CPM across samples; report gene count before/after.
3. Compute logCPM with edgeR TMM and VST with DESeq2.
4. Run PCA on raw log2 counts and on normalized data.
5. Show that raw PC1 correlates with library size but normalized PC1 does not.
6. Write one paragraph: which normalization you'd use for DE vs for ML features, and why.

## Solution
Reveal only after attempting: [`m2_solution.R`](./m2_solution.R)

---
Part of **Cleaning Biological Data** · MultiBiomics · ties into *Computational Genomics with R*.
