library("tidyverse")
library("tidyr")
library("rstatix")
library("truncnorm")

set.seed(6) # Set randomisation seed for reproducibility
data = tibble(
  Par       = c(1:200),
  Fear      = c(replicate(100,"No Fear Appeal"),replicate(100,"Fear Appeal")),
  # replicate is a function that can be used to repeat an element. For example, replicate(100,"No Fear Appeal") 
  # produces a column where the string "No Fear Appeal" is repeated 100 times (the first  argument represents the 
  # number of times you want to repeat the element). The command c(replicate(100,"No Fear Appeal"),replicate(100,"Fear Appeal")) above creates a column with 100 repetitions of "No Fear Appeal" followed by 100 repetitions of "Fear Appeal". 
  Efficacy  = c(replicate(50,"No Efficacy Message"),replicate(50,"Efficacy Message"),
                replicate(50,"No Efficacy Message"),replicate(50,"Efficacy Message")),
  # This generates 50 repetitions of "No Efficacy Message" followed by 50 repetitions of "Efficacy Message" 
  # followed by 50 repetitions of "No Efficacy Message" followed by 50 repetitions of "Efficacy Message". 
  # The combination of values in the Fear and Efficacy columns represent the condition our artificial 
  # participants received in the experiment.
  
  # Now, we simulate the vaccination intention scores for our four groups of participants using truncnorm:
  Intention = c(rtruncnorm(50, a = 0, b = 10, mean = 5, sd = 2), 
                # Random scores for no fear appeal/no efficacy condition
                rtruncnorm(50, a = 0, b = 10, mean = 5, sd = 2), 
                # Random scores for fear appeal/no efficacy condition
                rtruncnorm(50, a = 0, b = 10, mean = 5, sd = 2), 
                # Random scores for no fear appeal/efficacy condition
                rtruncnorm(50, a = 0, b = 10, mean = 7.5, sd = 2)) 
  # Random scores for fear appeal/efficacy condition
)
# The following ensures that "No Fear Appeal" is Level 1 of the Fear factor and "No Efficacy Message"
# is Level 1 of the Efficacy factor
data$Fear     = factor(data$Fear, levels = c("No Fear Appeal","Fear Appeal"))
data$Efficacy = factor(data$Efficacy, levels = c("No Efficacy Message","Efficacy Message"))

# Round the values in "Intention" to 0 decimal places
data$Intention = round(data$Intention, digits = 0)

descriptives = data %>%
  group_by(Fear,Efficacy) %>%
  get_summary_stats(Intention, show = c("mean", "sd", "se", "ci"))

# First line plot
jitt = position_dodge(0.1) # Jitter to prevent data points from overlapping
myGraph1 <- ggplot(data = descriptives, mapping = aes(x = Fear, y = mean, group = Efficacy)) 
myGraph1
myGraph1 <- myGraph + geom_line(size = 1, position = jitt, aes(color = Efficacy))
myGraph1
myGraph1 <- myGraph + geom_point(size = 3, position = jitt, aes(color = Efficacy)) 
myGraph1
myGraph1 <- myGraph + geom_errorbar(position = jitt, mapping = aes(ymin = mean - se, ymax = mean + se, color = Efficacy), size = 1, width = .05)  
myGraph1
myGraph1 <- myGraph + scale_color_manual(values=c("#355C7D", "#F67280")) 
myGraph1
myGraph1 <- myGraph + ylim(0,10) 
myGraph1
myGraph1 <- myGraph + labs(x = "Fear", y = "Vaccination Intention") 
myGraph1
myGraph1 <- myGraph + theme_bw() 
myGraph1
myGraph1 <- myGraph + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
myGraph
myGraph1 <- myGraph + theme(legend.box.background = element_rect(colour = "black"), legend.position = "bottom", legend.direction = "vertical")
myGraph1

# legend title bold
# Horizontal axis title bold
ggsave("myGraph1.png", height = 6, width = 5, dpi = 300)

# Line graph 2
jitt = position_dodge(0.1) 

myGraph2 <- ggplot(data = descriptives, mapping = aes(x = Fear, y = mean, group = Efficacy)) 
myGraph2

myGraph2 <- myGraph2 + geom_line(size = 1, position = jitt, aes(shape = Efficacy))  
myGraph2

myGraph2 <- myGraph2 + geom_point(size = 3, position = jitt, aes(shape = Efficacy)) 
myGraph2

myGraph2 <- myGraph2 + scale_shape_manual(values = c(15, 16)) 
myGraph2

myGraph2 <- myGraph2 + geom_errorbar(position = jitt, mapping = aes(ymin = mean - se, ymax = mean + se, color = Efficacy), size = 1, width = .05) 
myGraph2

myGraph2 <- myGraph2 + scale_color_manual(values=c("#000000", "#000000")) 
myGraph2

myGraph2 <- myGraph2 + ylim(0,10) 
myGraph2

myGraph2 <- myGraph2 + labs(x = "Fear", y = "Vaccination Intention") 
myGraph2

myGraph2 <- myGraph2 + theme_bw()
myGraph2

myGraph2 <- myGraph2 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
myGraph2

myGraph2 <- myGraph2 + theme(legend.box.background = element_rect(colour = "black"), legend.position = "bottom", legend.direction = "vertical")
myGraph2

ggsave("myGraph2.png", height = 6, width = 5, dpi = 300)

# Bar Graph
myGraph3 <- ggplot(data = descriptives, mapping = aes(x = Fear, y = mean, fill = Efficacy)) 
myGraph3

myGraph3 <- myGraph3 + geom_col(width = 0.45, position = position_dodge(0.55))  
myGraph3  
  
myGraph3 <- myGraph3 + geom_errorbar(mapping = aes(ymin = mean - se, ymax = mean + se), 
    size = .5, width = .1, position = position_dodge(.55)) 
myGraph3

myGraph3 <- myGraph3 + scale_fill_manual(values = c("#355C7D", "#F67280")) 
myGraph3

myGraph3 <- myGraph3 + scale_y_continuous(limits = c(0,10.5), expand = c(0,0)) 
myGraph3

myGraph3 <- myGraph3 + labs(x = "Fear", y = "Vaccination Intention") 
myGraph3

myGraph3 <- myGraph3 + theme_bw() 
myGraph3

myGraph3 <- myGraph3 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
myGraph3

myGraph3 <- myGraph3 + theme(legend.box.background = element_rect(colour = "black"), legend.position = "bottom", legend.direction = "vertical")
myGraph3

ggsave("myGraph3.png", height = 6, width = 5, dpi = 300)





