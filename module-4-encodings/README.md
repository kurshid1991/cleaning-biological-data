# Module 4 — Character Encodings & File Format Chaos

UnicodeDecodeErrors, FASTA/FASTQ/VCF quirks, and the SEPT1->date bug.

## Dataset
Corrupted gene-annotation file (non-UTF-8 + Excel-mangled symbols) + a small FASTA

Files in this folder:
- `data/annotation.tsv`
- `data/sequences.fasta`

## Tutorial
Run the code-along script: [`m4_encodings.R`](./m4_encodings.R)

## Exercise
1. Detect the encoding of the annotation file with stringi.
2. Read it forcing the correct encoding and gene symbols as character.
3. Scan for Excel date-mangled gene symbols and count them.
4. Repair the mangled symbols using an HGNC-based lookup.
5. Write a structure-aware FASTA reader and load the provided sequences.
6. Save a clean, UTF-8, tab-separated annotation file.

## Solution
Reveal only after attempting: [`m4_solution.R`](./m4_solution.R)

---
Part of **Cleaning Biological Data** · MultiBiomics · ties into *Computational Genomics with R*.
