#############################################################
# Generate some artificial data for the fear appeal example #
#############################################################


# Dependencies
library("truncnorm")
library("tidyverse")
library("tidyr")
library("effectsize") 
library("rstatix") 
library("phia")

# Set randomisation seed
set.seed(6)

data = tibble(
  Par       = c(1:200),
  Fear      = c(replicate(100,"No Fear Appeal"),replicate(100,"Fear Appeal")),
  Efficacy  = c(replicate(50,"No Efficacy Message"),replicate(50,"Efficacy Message"),
                replicate(50,"No Efficacy Message"),replicate(50,"Efficacy Message")),
  Intention = c(rtruncnorm(50, a = 0, b = 10, mean = 5, sd = 1.5),
                rtruncnorm(50, a = 0, b = 10, mean = 5, sd = 1.5),
                rtruncnorm(50, a = 0, b = 10, mean = 5, sd = 1.5),
                rtruncnorm(50, a = 0, b = 10, mean = 8, sd = 1.5))
)
data$Fear     = factor(data$Fear, levels = c("No Fear Appeal","Fear Appeal"))
data$Efficacy = factor(data$Efficacy, levels = c("No Efficacy Message","Efficacy Message"))

#data$Intention = round(data$Intention, digits = 0)

# Get descriptive statistics
descriptives = data %>%
  group_by(Fear,Efficacy) %>%
  summarise(mean = mean(Intention, na.rm = TRUE), sd = sd(Intention, na.rm = TRUE))

# Levene's test for homogeneity of variance
data %>% levene_test(Intention ~ Fear * Efficacy)

# Shapiro Wilk test for normality
data %>%
  group_by(Fear,Efficacy) %>%
  shapiro_test(Intention)

# Check for outliers and extreme values
data %>%
  group_by(Fear,Efficacy) %>%
  identify_outliers("Intention")
  
# Run ANOVA - Check this is between-participants
model = aov(data = data, Intention ~ Fear + Efficacy + Fear:Efficacy)
summary(model)
effectsize(model)

# Test the simple effects
testInteractions(model, fixed = "Fear", across= "Efficacy")
testInteractions(model, fixed = "Efficacy", across = "Fear")














exp2Data <- read_csv("Exp2Data.csv")
exp2Data$Framing = as.factor(exp2Data$Framing)
exp2Data$Norming = as.factor(exp2Data$Norming)

exp2Model<-aov(PolicyPref ~ Framing + Norming + Framing:Norming, data = exp2Data)
summary(exp2Model)
Anova(exp2Model, type="III")

testInteractions(exp2Model, fixed="Norming", across="Framing")
testInteractions(exp2Model, fixed="Framing", across="Norming")





# For below, see: http://www.cookbook-r.com/Manipulating_data/Converting_data_between_wide_and_long_format/
olddata_wide = tibble(
  subject = c(1,2,3,4),
  sex     = c("M","F","F","M"),
  control = c(7.9,6.3,9.5,11.5),
  cond1   = c(12.3,10.6,13.1,13.4),
  cond2   = c(10.7,11.1,13.8,12.9)
)
# Make sure the subject column is a factor
olddata_wide$subject <- factor(olddata_wide$subject)


# The arguments to gather():
# - data: Data object
# - key: Name of new key column (made from names of data columns)
# - value: Name of new value column
# - ...: Names of source columns that contain values
# - factor_key: Treat the new key column as a factor (instead of character vector)
data_long <- gather(olddata_wide, condition, measurement, control:cond2, factor_key=TRUE)
data_long


olddata_long <- read.table(header=TRUE, text='
 subject sex condition measurement
       1   M   control         7.9
       1   M     cond1        12.3
       1   M     cond2        10.7
       2   F   control         6.3
       2   F     cond1        10.6
       2   F     cond2        11.1
       3   F   control         9.5
       3   F     cond1        13.1
       3   F     cond2        13.8
       4   M   control        11.5
       4   M     cond1        13.4
       4   M     cond2        12.9
')
# Make sure the subject column is a factor
olddata_long$subject <- factor(olddata_long$subject)


# The arguments to spread():
# - data: Data object
# - key: Name of column containing the new column names
# - value: Name of column containing values
data_wide <- spread(olddata_long, condition, measurement)
data_wide


# Rename cond1 to first, and cond2 to second
names(data_wide)[names(data_wide)=="cond1"] <- "first"
names(data_wide)[names(data_wide)=="cond2"] <- "second"

# Reorder the columns
data_wide <- data_wide[, c(1,2,5,3,4)]
data_wide
#>   subject sex control first second
#> 1       1   M     7.9  12.3   10.7
#> 2       2   F     6.3  10.6   11.1
#> 3       3   F     9.5  13.1   13.8
#> 4       4   M    11.5  13.4   12.9

# Repeated measures ANOVA: https://agroninfotech.blogspot.com/2020/06/one-way-repeated-measures-anova-in-r.html

