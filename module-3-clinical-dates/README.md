# Module 3 — Parsing Dates & Clinical Metadata

Turning messy clinical dates into a clean time-to-event dataset.

## Dataset
Messy clinical CSV with mixed date formats and some data-entry errors

Files in this folder:
- `data/clinical_raw.csv`

## Tutorial
Run the code-along script: [`m3_clinical_dates.R`](./m3_clinical_dates.R)

## Exercise
1. Load the messy clinical CSV and inspect the date columns.
2. Parse all date fields with lubridate, handling at least three formats.
3. Build an event indicator (death = 1, censored = 0) and an end-of-follow-up date.
4. Compute survival time in months from diagnosis to end date.
5. Flag and report rows with negative or impossible durations.
6. Create a Surv() object and plot a basic Kaplan-Meier curve.

## Solution
Reveal only after attempting: [`m3_solution.R`](./m3_solution.R)

---
Part of **Cleaning Biological Data** · MultiBiomics · ties into *Computational Genomics with R*.
