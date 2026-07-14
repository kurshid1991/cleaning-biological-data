# Module 3 - Clinical dates -> survival dataset
library(lubridate)
library(dplyr)

clin <- read.csv("clinical_raw.csv", stringsAsFactors = FALSE)

# 1. Dates arrive in mixed formats; parse_date_time tries several orders
parse_flex <- function(x) parse_date_time(x, orders = c("ymd","dmy","mdy","Ymd"))
clin <- clin %>% mutate(
  dx_date   = as_date(parse_flex(diagnosis_date)),
  last_date = as_date(parse_flex(last_contact_date)),
  death_date= as_date(parse_flex(death_date))
)

# 2. Build event indicator and the end-of-follow-up date
clin <- clin %>% mutate(
  event   = ifelse(!is.na(death_date), 1L, 0L),            # 1=death, 0=censored
  end_date= coalesce(death_date, last_date)
)

# 3. Derive survival time (in months) and VALIDATE
clin <- clin %>% mutate(
  surv_months = interval(dx_date, end_date) / months(1)
)

# 4. Sanity checks - data entry errors surface here
stopifnot(all(clin$surv_months >= 0, na.rm = TRUE))        # no time travel
bad <- clin %>% filter(is.na(surv_months) | surv_months < 0)
cat("Rows needing review:", nrow(bad), "\n")

# 5. Analysis-ready survival object
library(survival)
surv_obj <- Surv(time = clin$surv_months, event = clin$event)
