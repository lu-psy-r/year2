
##########################################
#                                        #
# INTERACTION PLOTS FOR LECTURE 7 SLIDES #
#                                        #
##########################################


################
# Dependencies #
################

library(tidyverse)
library(ggplot2)


#######################################
# ILLUSTRATION OF SIMPLE MAIN EFFECTS #
#######################################

simple_main_effects = tibble(
  Effect = c("One Significant Effect","One Significant Effect",
             "One Significant Effect","One Significant Effect",
             "Two Significant Effects","Two Significant Effects",
             "Two Significant Effects","Two Significant Effects"),
  A     = c("Level A1","Level A1","Level A2","Level A2","Level A1","Level A1","Level A2","Level A2"),  
  B     = c("Level B1","Level B2","Level B1","Level B2","Level B1","Level B2","Level B1","Level B2"),
  Mean  = c(4.5,8,4,4, 5,3.5,3,7)
)

ggplot(data = simple_main_effects, mapping = aes(x = B, y = Mean, group = A)) +
  geom_line(size = 1, aes(color = A)) +
  geom_point(size = 3, aes(color = A)) +
  scale_x_discrete(labels = c(expression(paste("Level (", B[1],")")), 
      expression(paste("Level (", B[2],")")))) +
  scale_color_manual(values=c("#000000", "#ff0000"), labels = c(expression(paste("Level (", A[1],")")), 
      expression(paste("Level (", A[2],")")))) +
  facet_wrap(~Effect, nrow = 1) +
  ylim(0,10) +
  labs(x = "Factor B", y = "", color = "Factor A") +
  theme_bw() +
  theme(strip.text            = element_text(size = 14, face = "bold"),
        panel.grid.major      = element_blank(),
        panel.grid.minor      = element_blank(),
        panel.background      = element_blank(),
        panel.border          = element_rect(colour = "black", fill=NA),
        axis.line             = element_blank(),
        axis.title.x          = element_text(size = 14, face = "bold"),
        axis.text.x           = element_text(size = 12, color = "black"),
        axis.text.y           = element_blank(),
        axis.title.y          = element_text(size = 14, face = "bold"),
        axis.ticks.y          = element_blank(),
        legend.title          = element_text(size = 14, face = "bold"),
        legend.background     = element_blank(),
        legend.box.background = element_rect(colour = "black"),
        legend.text           = element_text(size = 12),
        legend.position       = "bottom",
        legend.direction      = "vertical"
  ) 
ggsave("Figure1.pdf", width = 8, height = 6)


#######################################
# ALL SIMPLE MAIN EFFECTS SIGNIFICANT #
#######################################

all_effects_sig = tibble(
  A     = c("Level A1","Level A1","Level A2","Level A2"),  
  B     = c("Level B1","Level B2","Level B1","Level B2"),
  Mean  = c(10,6,5,3.5)
)

ggplot(data = all_effects_sig, mapping = aes(x = B, y = Mean, group = A)) +
  geom_line(size = 1, aes(color = A)) +
  geom_point(size = 3, aes(color = A)) +
  scale_x_discrete(labels = c(expression(paste("Level (", B[1],")")), 
    expression(paste("Level (", B[2],")")))) +
  scale_color_manual(values=c("#000000", "#ff0000"), labels = c(expression(paste("Level (", A[1],")")), 
    expression(paste("Level (", A[2],")")))) +
  ylim(0,12) +
  labs(x = "Factor B", y = "", color = "Factor A") +
  theme_bw() +
  theme(panel.grid.major      = element_blank(),
        panel.grid.minor      = element_blank(),
        panel.background      = element_blank(),
        panel.border          = element_rect(colour = "black", fill=NA),
        axis.line             = element_blank(),
        axis.title.x          = element_text(size = 14, face = "bold"),
        axis.text.x           = element_text(size = 12, color = "black"),
        axis.text.y           = element_blank(),
        axis.title.y          = element_text(size = 14, face = "bold"),
        axis.ticks.y          = element_blank(),
        legend.title          = element_text(size = 14, face = "bold"),
        legend.background     = element_blank(),
        legend.box.background = element_rect(colour = "black"),
        legend.text           = element_text(size = 12),
        legend.position       = "bottom",
        legend.direction      = "vertical"
  )
ggsave("Figure2.pdf", width = 5, height = 6)


#################################
# HYPOTHETICAL DATA FOR EXAMPLE #
#################################

covid_data = tibble(
  Fear = c("No Fear Appeal","No Fear Appeal","Fear Appeal","Fear Appeal"),  
  Efficacy  = c("No Efficacy Message","Efficacy Message","No Efficacy Message","Efficacy Message"),
  Mean  = c(5,5.17,5,8.17)
)
covid_data$Fear <- factor(covid_data$Fear, levels = c("No Fear Appeal","Fear Appeal"))
covid_data$Efficacy <- factor(covid_data$Efficacy, levels = c("No Efficacy Message","Efficacy Message"))

ggplot(data = covid_data, mapping = aes(x = Fear, y = Mean, group = Efficacy)) +
  geom_line(size = 1, aes(color = Efficacy)) +
  geom_point(size = 3, aes(color = Efficacy)) +
  scale_x_discrete(labels = c(expression(paste("No Fear Appeal (", A[1],")")), 
                              expression(paste("Fear Appeal (", A[2],")")))) +
  scale_color_manual(values=c("#000000", "#ff0000"), labels = c(expression(paste("No Efficacy Message (", B[1],")")), 
                                                                expression(paste("Efficacy Message (", B[2],")")))) +
  ylim(0,10) +
  labs(x = "Fear", y = "Vaccination Likelihood") +
  theme_bw() +
  theme(panel.grid.major      = element_blank(),
        panel.grid.minor      = element_blank(),
        panel.background      = element_blank(),
        panel.border          = element_rect(colour = "black", fill=NA),
        axis.line             = element_blank(),
        axis.title.x          = element_text(size = 14, face = "bold"),
        axis.text.x           = element_text(size = 12, face = "bold", color = "black"),
        axis.text.y           = element_blank(),
        axis.title.y          = element_text(size = 14, face = "bold"),
        axis.ticks.y          = element_blank(),
        legend.title          = element_text(size = 14, face = "bold"),
        legend.background     = element_blank(),
        legend.box.background = element_rect(colour = "black"),
        legend.text           = element_text(size = 12),
        legend.position       = "bottom",
        legend.direction      = "vertical"
  ) 
ggsave("Figure3.pdf", width = 5, height = 6)

