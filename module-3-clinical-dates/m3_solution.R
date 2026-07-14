# Solution sketch - Module 3
library(lubridate); library(dplyr); library(survival)
clin <- read.csv("clinical_raw.csv", stringsAsFactors=FALSE)

pf <- function(x) as_date(parse_date_time(x, c("ymd","dmy","mdy")))
clin <- clin %>% mutate(dx=pf(diagnosis_date), last=pf(last_contact_date),
                        death=pf(death_date),
                        event=as.integer(!is.na(death)),
                        end=coalesce(death,last),
                        months=interval(dx,end)/months(1))

problems <- clin %>% filter(is.na(months) | months < 0)
print(problems)          # data-entry errors: death before dx, typos in year

fit <- survfit(Surv(months, event) ~ 1, data = clin)
plot(fit, xlab="Months", ylab="Survival probability")