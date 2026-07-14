# Module 5 — Inconsistent Data Entry in Biological Metadata

Free-text fields, gene aliases, and the HGNC/Ensembl/Entrez ID-mapping maze.

## Dataset
Metadata sheet with inconsistent tissue labels + a gene list to map across ID systems

Files in this folder:
- `data/sample_metadata.csv`

## Tutorial
Run the code-along script: [`m5_metadata_harmonize.R`](./m5_metadata_harmonize.R)

## Exercise
1. Load the metadata and list every unique tissue label.
2. Fuzzy-map the tissue labels to a controlled vocabulary; keep the original column.
3. Print the unmatched labels and decide each by hand.
4. Map the gene symbols to Entrez and Ensembl IDs with org.Hs.eg.db or biomaRt.
5. Count rows before and after the ID join; explain any change.
6. Produce a clean metadata table with standardized tissue + a single ID per gene.

## Solution
Reveal only after attempting: [`m5_solution.R`](./m5_solution.R)

---
Part of **Cleaning Biological Data** · MultiBiomics · ties into *Computational Genomics with R*.
