
##########################################
#                                        #
# INTERACTION PLOTS FOR LECTURE 1 SLIDES #
#                                        #
##########################################


################
# Dependencies #
################

library(tidyverse)
library(ggplot2)


###############################
# NO SIGNIFICANT MAIN EFFECTS #
###############################

no_sig_effects = tibble(
  Fear = c("No Fear Appeal","No Fear Appeal","Fear Appeal","Fear Appeal"),  
  Efficacy  = c("No Efficacy Message","Efficacy Message","No Efficacy Message","Efficacy Message"),
  Mean  = c(5,5.5,5,5.5)
)
no_sig_effects$Fear <- factor(no_sig_effects$Fear, levels = c("No Fear Appeal","Fear Appeal"))
no_sig_effects$Efficacy <- factor(no_sig_effects$Efficacy, levels = c("No Efficacy Message","Efficacy Message"))

ggplot(data = no_sig_effects, mapping = aes(x = Fear, y = Mean, group = Efficacy)) +
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
ggsave("Figure1.pdf", width = 5, height = 6)


##########################################
# SIGNIFICANT EFFECT OF FEAR OR EFFICACY #
##########################################

one_sig_main_effect = tibble(
  Effect    = c("Main Effect of Efficacy","Main Effect of Efficacy","Main Effect of Efficacy","Main Effect of Efficacy","Main Effect of Fear","Main Effect of Fear","Main Effect of Fear","Main Effect of Fear"),
  Fear      = c("No Fear Appeal","No Fear Appeal","Fear Appeal","Fear Appeal","No Fear Appeal","No Fear Appeal","Fear Appeal","Fear Appeal"),  
  Efficacy  = c("No Efficacy Message","Efficacy Message","No Efficacy Message","Efficacy Message","No Efficacy Message","Efficacy Message","No Efficacy Message","Efficacy Message"),
  Mean      = c(4,9,4,9,4.5,4,9,8.5)
)
one_sig_main_effect$Effect   <- factor(one_sig_main_effect$Effect,   levels = c("Main Effect of Fear","Main Effect of Efficacy"))
one_sig_main_effect$Fear     <- factor(one_sig_main_effect$Fear,     levels = c("No Fear Appeal","Fear Appeal"))
one_sig_main_effect$Efficacy <- factor(one_sig_main_effect$Efficacy, levels = c("No Efficacy Message","Efficacy Message"))

ggplot(data = one_sig_main_effect, mapping = aes(x = Fear, y = Mean, group = Efficacy)) +
  geom_line(size = 1, aes(color = Efficacy)) +
  geom_point(size = 3, aes(color = Efficacy)) +
  scale_x_discrete(labels = c(expression(paste("No Fear Appeal (", A[1],")")), 
      expression(paste("Fear Appeal (", A[2],")")))) +
  scale_color_manual(values=c("#000000", "#ff0000"), labels = c(expression(paste("No Efficacy Message (", B[1],")")), 
      expression(paste("Efficacy Message (", B[2],")")))) +
  facet_wrap(~Effect, nrow = 1) +
  ylim(0,10) +
  labs(x = "Fear", y = "Vaccination Likelihood") +
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
ggsave("Figure2.pdf", width = 8, height = 6)


################################
# TWO SIGNIFICANT MAIN EFFECTS #
################################

sig_effect_feareff = tibble(
  Fear      = c("No Fear Appeal","No Fear Appeal","Fear Appeal","Fear Appeal"),  
  Efficacy  = c("No Efficacy Message","Efficacy Message","No Efficacy Message","Efficacy Message"),
  Mean      = c(1,5,5,9) 
)
sig_effect_feareff$Fear     <- factor(sig_effect_feareff$Fear, levels = c("No Fear Appeal","Fear Appeal"))
sig_effect_feareff$Efficacy <- factor(sig_effect_feareff$Efficacy, levels = c("No Efficacy Message","Efficacy Message"))

ggplot(data = sig_effect_feareff, mapping = aes(x = Fear, y = Mean, group = Efficacy)) +
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
ggsave("Figure3.pdf", width = 5, height = 6)


# Generic version of the above figure
sig_effect_feareff = tibble(
  Fear      = c("No Fear Appeal","No Fear Appeal","Fear Appeal","Fear Appeal"),  
  Efficacy  = c("No Efficacy Message","Efficacy Message","No Efficacy Message","Efficacy Message"),
  Mean      = c(1,6,4,9) 
)
sig_effect_feareff$Fear     <- factor(sig_effect_feareff$Fear, levels = c("No Fear Appeal","Fear Appeal"))
sig_effect_feareff$Efficacy <- factor(sig_effect_feareff$Efficacy, levels = c("No Efficacy Message","Efficacy Message"))

ggplot(data = sig_effect_feareff, mapping = aes(x = Fear, y = Mean, group = Efficacy)) +
  geom_line(size = 1, aes(color = Efficacy)) +
  geom_point(size = 3, aes(color = Efficacy)) +
  scale_x_discrete(labels = c(expression(paste("Level (", A[1],")")), 
      expression(paste("Level (", A[2],")")))) +
  scale_color_manual(values=c("#000000", "#ff0000"), labels = c(expression(paste("Level (", B[1],")")), 
      expression(paste("Level (", B[2],")")))) +
  ylim(0,10) +
  labs(x = "Factor A", y = "Dependent Measure", color = "Factor B") +
  theme_bw() +
  theme(panel.grid.major      = element_blank(),
        panel.grid.minor      = element_blank(),
        panel.background      = element_blank(),
        panel.border          = element_rect(colour = "black", fill=NA),
        axis.line             = element_blank(),
        axis.title.x          = element_text(size = 14, face = "bold"),
        axis.text.x           = element_text(size = 12, color = "black"),
        axis.text.y           = element_blank(),
        axis.title.y          = element_blank(),
        axis.ticks.y          = element_blank(),
        legend.title          = element_text(size = 14, face = "bold"),
        legend.background     = element_blank(),
        legend.box.background = element_rect(colour = "black"),
        legend.text           = element_text(size = 12),
        legend.position       = "bottom",
        legend.direction      = "vertical"
  )
ggsave("Figure3_Generic_Labels.pdf", width = 5, height = 6)


###############
# INTERACTION #
###############

interaction = tibble(
  Fear = c("No Fear Appeal","No Fear Appeal","Fear Appeal","Fear Appeal"),  
  Efficacy  = c("No Efficacy Message","Efficacy Message","No Efficacy Message","Efficacy Message"),
  Mean  = c(4,4.5,4,9)
)
interaction$Fear     <- factor(interaction$Fear, levels     = c("No Fear Appeal","Fear Appeal"))
interaction$Efficacy <- factor(interaction$Efficacy, levels = c("No Efficacy Message","Efficacy Message"))

ggplot(data = interaction, mapping = aes(x = Fear, y = Mean, group = Efficacy)) +
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
ggsave("Figure4.pdf", width = 5, height = 6)


##################################
# DIFFERENT TYPES OF INTERACTION #
##################################

interactions = tibble(
  Example = c("An Interaction","An Interaction","An Interaction","An Interaction",
              "Another Interaction","Another Interaction","Another Interaction","Another Interaction",
              "And Another Interaction","And Another Interaction","And Another Interaction",
              "And Another Interaction"),  
  A = c("Level A1","Level A1","Level A2","Level A2","Level A1","Level A1","Level A2","Level A2",
        "Level A1","Level A1","Level A2","Level A2"),
  B = c("Level B1","Level B2","Level B1","Level B2","Level B1","Level B2","Level B1","Level B2",
        "Level B1","Level B2","Level B1","Level B2"), 
  Mean  = c(4.5,9,4,4.5,4.75,5.25,1,9,2,8,8,2)
)
interactions$Example <- factor(interactions$Example,levels = c("An Interaction","Another Interaction","And Another Interaction"))

ggplot(data = interactions, mapping = aes(x = A, y = Mean, group = B)) +
  geom_line(size = 1, aes(color = B)) +
  geom_point(size = 3, aes(color = B)) +
  scale_x_discrete(labels = c(expression(paste("Level ", A[1],"")), 
      expression(paste("Level ", A[2],"")))) +
  scale_color_manual(values=c("#000000", "#ff0000"), labels = c(expression(paste("Level ", B[1],"")), 
      expression(paste("Level ", B[2],"")))) +
  facet_wrap(~Example, nrow = 1) +
  ylim(0,10) +
  labs(x = "Factor A", y = "Dependent Measure", color = "Factor B") +
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
        legend.text           = element_text(size = 12),
        legend.title          = element_text(size = 14, face = "bold"),
        legend.box.background = element_rect(colour = "black"),
        legend.position       = "bottom",
        legend.direction      = "vertical"
  ) 
ggsave("Figure5.pdf", width = 9, height = 6)


###################
# SCALING EXAMPLE #
###################

scaling = tibble(
  A = c("Level A1","Level A1","Level A2","Level A2"),
  B = c("Level B1","Level B2","Level B1","Level B2"), 
  Mean  = c(5,5.25,5.25,5)  
)

# Version 1 - Compressed Scale
ggplot(data = scaling, mapping = aes(x = A, y = Mean, group = B)) +
  geom_line(size = 1, aes(color = B)) +
  geom_point(size = 3, aes(color = B)) +
  scale_x_discrete(labels = c(expression(paste("Level ", A[1],"")), 
      expression(paste("Level ", A[2],"")))) +
  scale_color_manual(values=c("#000000", "#ff0000"), labels = c(expression(paste("Level ", B[1],"")), 
      expression(paste("Level ", B[2],"")))) +
  ylim(4.75,5.5) +
  labs(x = "Factor A", y = "Dependent Measure", color = "Factor B") +
  theme_bw() +
  theme(strip.text            = element_text(size = 14, face = "bold"),
        panel.grid.major      = element_blank(),
        panel.grid.minor      = element_blank(),
        panel.background      = element_blank(),
        panel.border          = element_rect(colour = "black", fill=NA),
        axis.line             = element_blank(),
        axis.title.x          = element_text(size = 14, face = "bold"),
        axis.text.x           = element_text(size = 12, colour = "black"),
        axis.title.y          = element_text(size = 14, face = "bold"),
        axis.text.y           = element_text(size = 12, colour = "black"),
        legend.title          = element_text(size = 14, face = "bold"),
        legend.text           = element_text(size = 12),
        legend.box.background = element_rect(colour = "black"),
        legend.position       = "bottom",
        legend.direction      = "vertical"
  ) 
ggsave("Figure6.pdf", width = 5, height = 6)

# Version 2 - Expanded Scale
ggplot(data = scaling, mapping = aes(x = A, y = Mean, group = B)) +
  geom_line(size = 1, aes(color = B)) +
  geom_point(size = 3, aes(color = B)) +
  scale_x_discrete(labels = c(expression(paste("Level ", A[1],"")), 
      expression(paste("Level ", A[2],"")))) +
  scale_color_manual(values=c("#000000", "#ff0000"), labels = c(expression(paste("Level ", B[1],"")), 
      expression(paste("Level ", B[2],"")))) +
  ylim(0,10) +
  labs(x = "Factor A", y = "Dependent Measure", color = "Factor B") +
  theme_bw() +
  theme(strip.text            = element_text(size = 14, face = "bold"),
        panel.grid.major      = element_blank(),
        panel.grid.minor      = element_blank(),
        panel.background      = element_blank(),
        panel.border          = element_rect(colour = "black", fill=NA),
        axis.line             = element_blank(),
        axis.title.x          = element_text(size = 14, face = "bold"),
        axis.text.x           = element_text(size = 12, colour = "black"),
        axis.title.y          = element_text(size = 14, face = "bold"),
        axis.text.y           = element_text(size = 12, colour = "black"),
        legend.title          = element_text(size = 14, face = "bold"),
        legend.text           = element_text(size = 12),
        legend.box.background = element_rect(colour = "black"),
        legend.position       = "bottom",
        legend.direction      = "vertical"
  ) 
ggsave("Figure7.pdf", width = 5, height = 6)


#######################################
# INDEPENDENCE OF SIMPLE MAIN EFFECTS #
#######################################


simple_effects = tibble(
  A = c("Level A1","Level A1","Level A1","Level A2","Level A2","Level A2"),
  B = c("Level B1","Level B2","Level B3","Level B1","Level B2","Level B3"), 
  Mean  = c(6,3.5,3.5,9,4,4)
)

ggplot(data = simple_effects, mapping = aes(x = B, y = Mean, group = A)) +
  geom_line(size = 1, aes(color = A)) +
  geom_point(size = 3, aes(color = A)) +
  scale_x_discrete(labels = c(expression(paste("Level ", B[1],"")),expression(paste("Level ", B[2],"")), 
        expression(paste("Level ", B[3],"")))) +
  scale_color_manual(values=c("#000000", "#ff0000"), labels = c(expression(paste("Level ", A[1],"")), 
        expression(paste("Level ", A[2],"")))) +
  ylim(0,10) +
  labs(x = "Factor B", y = "Dependent Measure", color = "Factor A") +
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
        axis.title.y          = element_blank(),
        axis.ticks.y          = element_blank(),
        legend.title          = element_text(size = 14, face = "bold"),
        legend.text           = element_text(size = 12),
        legend.box.background = element_rect(colour = "black"),
        legend.position       = "bottom",
        legend.direction      = "vertical"
  )
ggsave("Figure8.pdf", width = 5, height = 6)
