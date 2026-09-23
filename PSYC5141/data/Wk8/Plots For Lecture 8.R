
##########################################
#                                        #
# INTERACTION PLOTS FOR LECTURE 8 SLIDES #
#                                        #
##########################################


################
# Dependencies #
################

library(tidyverse)
library(ggplot2)


########################
# STROOP EXAMPLE MIXED #
########################

stroop_mixed = tibble(
  Group     = c("Healthy","Healthy","Schizophrenia","Schizophrenia"),  
  TrialType = c("Congruent","Incongruent","Congruent","Incongruent"),
  RT        = c(630,766,635,886)
)

ggplot(data = stroop_mixed, mapping = aes(x = Group, y = RT, group = TrialType)) +
  geom_line(size = 1, aes(color = TrialType)) +
  geom_point(size = 3, aes(color = TrialType)) +
  #scale_x_discrete(labels = c(expression(paste("Level (", B[1],")")), 
  #  expression(paste("Level (", B[2],")")))) +
  scale_color_manual(values=c("#355C7D", "#F67280")) +
  ylim(450,950) +
  labs(x = "Group", y = "Response Time (ms)", color = "Trial Type") +
  theme_bw() +
  theme(panel.grid.major      = element_blank(),
        panel.grid.minor      = element_blank(),
        panel.background      = element_blank(),
        panel.border          = element_rect(colour = "black", fill=NA),
        axis.line             = element_blank(),
        axis.title.x          = element_text(size = 14, face = "bold"),
        axis.text.x           = element_text(size = 12, color = "black"),
        axis.title.y          = element_text(size = 14, face = "bold"),
        axis.text.y           = element_text(size = 12, color = "black"),
        legend.title          = element_text(size = 14, face = "bold"),
        legend.background     = element_blank(),
        legend.box.background = element_rect(colour = "black"),
        legend.text           = element_text(size = 12),
        legend.position       = "bottom",
        legend.direction      = "vertical"
  )
ggsave("StroopMixed.pdf", width = 5, height = 6)


#########################
# STROOP EXAMPLE WITHIN #
#########################

stroop_within = tibble(
  Block       = c("1","1","2","2","3","3"),  
  TrialType   = c("Congruent","Incongruent","Congruent","Incongruent","Congruent","Incongruent"),
  RT          = c(626,776,632,731,613,683)
)

ggplot(data = stroop_within, mapping = aes(x = Block, y = RT, group = TrialType)) +
  geom_line(size = 1, aes(color = TrialType)) +
  geom_point(size = 3, aes(color = TrialType)) +
  scale_color_manual(values=c("#355C7D", "#F67280")) +
  ylim(575,825) +
  labs(x = "Block", y = "Response Time (ms)", color = "Trial Type") +
  theme_bw() +
  theme(panel.grid.major      = element_blank(),
        panel.grid.minor      = element_blank(),
        panel.background      = element_blank(),
        panel.border          = element_rect(colour = "black", fill=NA),
        axis.line             = element_blank(),
        axis.title.x          = element_text(size = 14, face = "bold"),
        axis.text.x           = element_text(size = 12, color = "black"),
        axis.title.y          = element_text(size = 14, face = "bold"),
        axis.text.y           = element_text(size = 12, color = "black"),
        legend.title          = element_text(size = 14, face = "bold"),
        legend.background     = element_blank(),
        legend.box.background = element_rect(colour = "black"),
        legend.text           = element_text(size = 12),
        legend.position       = "bottom",
        legend.direction      = "vertical"
  )
ggsave("StroopWithin.pdf", width = 5, height = 6)