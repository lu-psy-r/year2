
# Generate an artifical data set for the grouping example

# Dependencies
library("truncnorm")
library("tidyverse")
library("tidyr")

# Set randomisation seed
set.seed(6)
groupingData  = tibble(
  Participant = c(1:90),
  Condition   = c(replicate(30,"Ungrouped"),replicate(30,"2-2-2"),replicate(30,"3-3")),
  Accuracy    = c(rtruncnorm(30, a = 0, b = 100, mean = 60, sd = 10),
                  rtruncnorm(30, a = 0, b = 100, mean = 65, sd = 10),
                  rtruncnorm(30, a = 0, b = 100, mean = 74, sd = 10))
)
groupingData$Condition = factor(groupingData$Condition, levels = c("Ungrouped","2-2-2","3-3"))


set.seed(6)
wLengthData  = tibble(
  Participant = c(1:75),
  ShortWords  = rtruncnorm(75, a = 0, b = 100, mean = 76.6, sd = 12),
  MediumWords = rtruncnorm(75, a = 0, b = 100, mean = 71.6, sd = 12),
  LongWords   = rtruncnorm(75, a = 0, b = 100, mean = 66.6, sd = 12)
)




# Get descriptive statistics
descriptives = groupingData %>%
  group_by(Condition) %>%
  get_summary_stats(Accuracy, show = c("mean", "sd"))
(descriptives)

# Levene's test for homogeneity of variance
groupingData %>% 
  levene_test(Accuracy ~ Condition)
max(descriptives$sd)/min(descriptives$sd)

# Shapiro Wilk test for normality
groupingData %>%
  group_by(Condition) %>%
  shapiro_test(Accuracy)

# Check for outliers and extreme values
groupingData %>%
  group_by(Condition) %>%
  identify_outliers("Accuracy")

# Run ANOVA - Check this is between-participants
groupingModel = aov(data = groupingData, Accuracy ~ Condition)
summary(groupingModel)
effectSize(groupingModel)


