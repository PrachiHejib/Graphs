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

# View(Lotteries_Code_2)   

#create new data frame  with only lottery and p1
lottery <- Lotteries_Code_2 %>% select(Lottery, p1) 

#rename coloumns
lottery <- lottery %>% rename(roll=Lottery, payoff=p1)

#use median/average to label boxes (creates a new table)
medians <- lottery %>% group_by(payoff) %>% summarize(loc=median(roll), min=min(roll), max=max(roll))

#create data frame for lotteries blocks 
df <- data.frame(
  x = 1:100,
  y = rep(1, 100),
  z = lottery$payoff,
  w = rep(1, 100)
)

ggplot(df, aes(x, y)) +
    geom_tile(aes(fill=z), show.legend=FALSE) +
    scale_fill_gradient(low="grey", high="grey50") +
    labs(title="", x="", y="") + theme_solid() +
    geom_text(aes(x=loc, y=1, label=payoff), data=medians)

ggsave("plot.pdf")
