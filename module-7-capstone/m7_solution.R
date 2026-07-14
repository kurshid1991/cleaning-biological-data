# Solution sketch - Module 7 (capstone)
# The 'solution' is the full pipeline in m7_capstone_pipeline.R, plus:
#  - a short README documenting each decision and why
#  - row-count log proving what each filter removed
#  - sessionInfo.txt capturing package versions
# Grading rubric: does it RERUN from scratch and produce the same object?
# If a colleague can clone the repo, run one script, and reproduce your
# analysis_ready.rds, you have passed the capstone.
source("m7_capstone_pipeline.R")
stopifnot(file.exists("out/analysis_ready.rds"))
cat("Capstone pipeline reproduced successfully.\n")