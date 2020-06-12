#Creating lotteries for experiment

#clear workspace
rm(list = ls(all = TRUE))

library(ggplot2)
library(readxl)
library(RColorBrewer)
library(ggthemes)
library(reshape2)
library(dplyr)

#plot from data 
Lotteries_Code_2 <- read_excel("Lotteries_Code_2.xlsx")

#create new data frame  with only lottery and p1
lottery <- Lotteries_Code_2 %>% select(Lottery, p1) 

#rename coloumns
lottery <- lottery %>% rename(roll=Lottery, payoff=p1)

#use median/average to label boxes (creates a new table)
medians <- lottery %>% group_by(payoff) %>% summarize(loc=median(roll), min=min(roll), max=max(roll))

ggplot() +
    # Draw the rectangles
    geom_rect(data=medians,
              mapping=aes(xmin=min, xmax=max, ymin=0, ymax=10, fill=payoff),
              show.legend=FALSE) +
    # Suppress axis labels
    labs(title="", x="", y="") +
    # Suppress the axis labels and borders
    theme_solid() +
    # Fix the aspect ratio so we can get long, thin strips
    # Shape of the graph will be determined by ratio of ymax as passed to
    # geom_rect and the maximum roll
    coord_fixed() +
    geom_text(aes(x=loc, y=5, label=payoff), data=medians)

ggsave("plot.pdf", width=5, height=1, units="in")
