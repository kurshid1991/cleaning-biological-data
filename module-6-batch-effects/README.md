# Module 6 — Outliers & Batch Effects

Distinguishing biological signal from technical artifact - and correcting it.

## Dataset
Public dataset with a known batch effect (samples processed in 2+ batches)

Files in this folder:
- `data/expr_normalized.csv`
- `data/sample_meta.csv`

## Tutorial
Run the code-along script: [`m6_batch_effects.R`](./m6_batch_effects.R)

## Exercise
1. Load the normalized expression matrix and its batch/condition metadata.
2. Run PCA and color the plot by batch; describe what you see.
3. Statistically confirm the batch effect (e.g., ANOVA of PC1 on batch).
4. Check the batch-by-condition table for confounding.
5. Apply ComBat with a model matrix that preserves condition.
6. Re-run PCA and show batch separation is gone while condition is retained.

## Solution
Reveal only after attempting: [`m6_solution.R`](./m6_solution.R)

---
Part of **Cleaning Biological Data** · MultiBiomics · ties into *Computational Genomics with R*.
