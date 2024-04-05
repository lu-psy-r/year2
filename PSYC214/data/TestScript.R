library("tidyverse")  
library("tidyr")      
library("rstatix")    
library("emmeans") 



memoryContext <- read_csv("memoryContext.csv") 

# Gather factors into a single column
memoryContextLong = memoryContext %>%
  gather(Group,Accuracy,Recall_Under_Under:Recognition_Land_Land,factor_key = TRUE)
(memoryContextLong)


# Now separate into separate columns for each factor
memoryContextLongSep = memoryContextLong %>%
  separate(Group, c("MemoryTask","LearningContext","TestingContext"))
(memoryContextLongSep)

# Make sure all factors are coded as such
memoryContextLongSep$Participant     = factor(memoryContextLongSep$Participant)
memoryContextLongSep$MemoryTask      = factor(memoryContextLongSep$MemoryTask)
memoryContextLongSep$LearningContext = factor(memoryContextLongSep$LearningContext)
memoryContextLongSep$TestingContext  = factor(memoryContextLongSep$TestingContext)

# Run the three-factor ANOVA
memoryContextModel <- aov(Accuracy ~ (MemoryTask * LearningContext * TestingContext) + 
  Error(Participant/(MemoryTask * LearningContext * TestingContext)), data = memoryContextLongSep)
summary(memoryContextModel)

# Recall only analysis
recallOnly = memoryContextLongSep %>%
  filter(MemoryTask == "Recall") 

recallModel <- aov(Accuracy ~ (LearningContext * TestingContext) + 
  Error(Participant/(LearningContext * TestingContext)), data = recallOnly)
summary(recallModel)

joint_tests(recallModel, by = "LearningContext")
joint_tests(recallModel, by = "TestingContext")


# Recognition only analysis
recognitionOnly = memoryContextLongSep %>%
  filter(MemoryTask == "Recognition") 
  
recognitionModel <- aov(Accuracy ~ (LearningContext * TestingContext) + 
 Error(Participant/(LearningContext * TestingContext)), data = recognitionOnly)
summary(recognitionModel)  

memoryContext = tibble(
  MemoryTask      = c("Recall","Recall","Recall","Recall","Recognition","Recognition","Recognition","Recognition"),
  LearningContext = c("Learn Under Water","Learn Under Water","Learn Land","Learn Land","Learn Under Water","Learn Under Water","Learn Land","Learn Land"),  
  TestingContext  = c("Test Under Water","Test Land","Test Under Water","Test Land","Test Under Water","Test Land","Test Under Water","Test Land"),
  MemoryScore     = c(7.6,4.6,3.4,6.8,6,5.4,5.8,5.8)
)
memoryContext$MemoryTask      <- factor(memoryContext$MemoryTask,      levels = c("Recall","Recognition"))
memoryContext$LearningContext <- factor(memoryContext$LearningContext, levels = c("Learn Under Water","Learn Land"))
memoryContext$TestingContext  <- factor(memoryContext$TestingContext,  levels = c("Test Under Water","Test Land"))

ggplot(data = memoryContext, mapping = aes(x = LearningContext, y = MemoryScore, group = TestingContext)) +
  geom_line(size = 1, aes(color = TestingContext)) +
  geom_point(size = 3, aes(color = TestingContext)) +
  #scale_x_discrete(labels = c(expression(paste("No Fear Appeal (", A[1],")")), 
  #                            expression(paste("Fear Appeal (", A[2],")")))) +
  scale_color_manual(values=c("#355C7D", "#F67280")) +#, labels = c(expression(paste("No Efficacy Message (", B[1],")")), 
                                                     #           expression(paste("Efficacy Message (", B[2],")")))) +
  facet_wrap(~MemoryTask, nrow = 1) +
  ylim(1,10) +
  labs(x = "Learning Context", y = "Memory Score", color = "Testing Context") +
  theme_bw() +
  theme(strip.text            = element_text(size = 14, face = "bold"),
        panel.grid.major      = element_blank(),
        panel.grid.minor      = element_blank(),
        panel.background      = element_blank(),
        panel.border          = element_rect(colour = "black", fill=NA),
        axis.line             = element_blank(),
        axis.title.x          = element_text(size = 14, face = "bold"),
        axis.text.x           = element_text(size = 12, color = "black"),
        axis.text.y           = element_text(size = 12, color = "black"),
        axis.title.y          = element_text(size = 14, face = "bold"),
        #axis.ticks.y          = element_blank(),
        legend.title          = element_text(size = 14, face = "bold"),
        legend.background     = element_blank(),
        legend.box.background = element_rect(colour = "black"),
        legend.text           = element_text(size = 12),
        legend.position       = "bottom",
        legend.direction      = "vertical"
  ) 
ggsave("MemoryContextData.pdf", width = 8, height = 6)


wordPronunciation = tibble(
  Age       = c("7-Year-Olds","7-Year-Olds","7-Year-Olds","7-Year-Olds","9-Year-Olds","9-Year-Olds","9-Year-Olds","9-Year-Olds"),
  Frequency = c("High","High","Low","Low","High","High","Low","Low"),  
  WordType  = c("Regular","Irregular","Regular","Irregular","Regular","Irregular","Regular","Irregular"),
  Errors    = c(6,6.2,5.6,6.6,3.8,3.6,4,7.4)
)
wordPronunciation$Age       <- factor(wordPronunciation$Age,       levels = c("7-Year-Olds","9-Year-Olds"))
wordPronunciation$Frequency <- factor(wordPronunciation$Frequency, levels = c("Low","High"))
wordPronunciation$WordType  <- factor(wordPronunciation$WordType,  levels = c("Regular","Irregular"))

ggplot(data = wordPronunciation, mapping = aes(x = Frequency, y = Errors, group = WordType)) +
  geom_line(size = 1, aes(color = WordType)) +
  geom_point(size = 3, aes(color = WordType)) +
  #scale_x_discrete(labels = c(expression(paste("No Fear Appeal (", A[1],")")), 
  #                            expression(paste("Fear Appeal (", A[2],")")))) +
  scale_color_manual(values=c("#355C7D", "#F67280")) + #, labels = c(expression(paste("No Efficacy Message (", B[1],")")), 
  #           expression(paste("Efficacy Message (", B[2],")")))) +
  facet_wrap(~Age, nrow = 1) +
  ylim(1,10) +
  labs(x = "Word Frequency", y = "Number of Errors", color = "Word Type") +
  theme_bw() +
  theme(strip.text            = element_text(size = 14, face = "bold"),
        panel.grid.major      = element_blank(),
        panel.grid.minor      = element_blank(),
        panel.background      = element_blank(),
        panel.border          = element_rect(colour = "black", fill=NA),
        axis.line             = element_blank(),
        axis.title.x          = element_text(size = 14, face = "bold"),
        axis.text.x           = element_text(size = 12, color = "black"),
        axis.text.y           = element_text(size = 12, color = "black"),
        axis.title.y          = element_text(size = 14, face = "bold"),
        #axis.ticks.y          = element_blank(),
        legend.title          = element_text(size = 14, face = "bold"),
        legend.background     = element_blank(),
        legend.box.background = element_rect(colour = "black"),
        legend.text           = element_text(size = 12),
        legend.position       = "bottom",
        legend.direction      = "vertical"
  ) 
ggsave("MemoryContextData.pdf", width = 8, height = 6)
  



