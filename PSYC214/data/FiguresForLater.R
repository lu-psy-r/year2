```{r, echo = FALSE, message = FALSE}
# jitt is used later to add a small amount of spatial jitter to our lines, data points, and error bars to prevent them from overlapping
jitt = position_dodge(0.1)
# Using the dataframe called descriptives, place "Fear" on the x-axis, "mean" on the y-axis, and group the data
# according to the two levels of the "Efficacy" factor
ggplot(data = mixedDescriptives, mapping = aes(x = Group, y = mean, group = TrialType)) +
  # geom_line produces two lines: one for "no efficacy message" and one for "efficacy message"
  geom_line(size = 1, position = jitt, aes(color = TrialType)) +
  # geom_point adds mean data points to our lines
  geom_point(size = 3, position = jitt, aes(color = TrialType)) +
  # geom_errorbar adds error bars to our geom_points - here we are using the standard error
  geom_errorbar(position = jitt, mapping = aes(ymin = mean - ci, ymax = mean + ci, color = TrialType), size = 1, width = .1) +
  # Here we are manually setting the colour of the lines, data points, and error bars
  scale_color_manual(values=c("#355C7D", "#F67280")) +
  # Change y-axis lower and upper limits
  ylim(500,1000) +
  # Manually set the x- and y-axis titles
  labs(x = "Group", y = "Mean RT") +
  # Use black and white theme for background
  theme_bw() +
  # The theme function allows us to set various properties of our figure manually
  theme(panel.grid.major = element_blank(), # Removes the major gridlines
        panel.grid.minor = element_blank(), # Removes the minor gridlines
        legend.box.background = element_rect(colour = "black"), # Adds a black border around the legend
        legend.position = "bottom", # Positions the legend at the bottom of the graph
        legend.direction = "vertical",
        axis.title.x = element_text(size = 14, face = "bold"), # Adjusts font style and size of x-axis label
        axis.text.x = element_text(size = 12, color = "black"), # Adjusts size and colour of x-axis text
        axis.title.y = element_text(size = 14, face = "bold"), # Adjusts font style and size of y-axis label
        axis.text.y = element_text(size = 12, color = "black"), # Adjusts size and colour of y-axis text
        legend.title = element_text(size = 14, face = "bold")) # Adjusts font style and size of legend title
ggsave("StroopMixed.png", height = 6, width = 5, dpi = 300)
```

```{r, echo = FALSE, message = FALSE}
# jitt is used later to add a small amount of spatial jitter to our lines, data points, and error bars to prevent them from overlapping
jitt = position_dodge(0.1)
# Using the dataframe called descriptives, place "Fear" on the x-axis, "mean" on the y-axis, and group the data
# according to the two levels of the "Efficacy" factor
ggplot(data = withinDescriptives, mapping = aes(x = Block, y = mean, group = TrialType)) +
  # geom_line produces two lines: one for "no efficacy message" and one for "efficacy message"
  geom_line(size = 1, position = jitt, aes(color = TrialType)) +
  # geom_point adds mean data points to our lines
  geom_point(size = 3, position = jitt, aes(color = TrialType)) +
  # geom_errorbar adds error bars to our geom_points - here we are using the standard error
  geom_errorbar(position = jitt, mapping = aes(ymin = mean -ci, ymax = mean + ci, color = TrialType), size = 1, width = .1) +
  # Here we are manually setting the colour of the lines, data points, and error bars
  scale_color_manual(values=c("#355C7D", "#F67280")) +
  # Change y-axis lower and upper limits
  ylim(500,850) +
  # Manually set the x- and y-axis titles
  labs(x = "Block", y = "Mean RT") +
  # Use black and white theme for background
  theme_bw() +
  # The theme function allows us to set various properties of our figure manually
  theme(panel.grid.major = element_blank(), # Removes the major gridlines
        panel.grid.minor = element_blank(), # Removes the minor gridlines
        legend.box.background = element_rect(colour = "black"), # Adds a black border around the legend
        legend.position = "bottom", # Positions the legend at the bottom of the graph
        legend.direction = "vertical",
        axis.title.x = element_text(size = 14, face = "bold"), # Adjusts font style and size of x-axis label
        axis.text.x = element_text(size = 12, color = "black"), # Adjusts size and colour of x-axis text
        axis.title.y = element_text(size = 14, face = "bold"), # Adjusts font style and size of y-axis label
        axis.text.y = element_text(size = 12, color = "black"), # Adjusts size and colour of y-axis text
        legend.title = element_text(size = 14, face = "bold")) # Adjusts font style and size of legend title
ggsave("StroopWithin.png", height = 6, width = 5, dpi = 300)
```