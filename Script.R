#Creating lotteries for experiment

#clear workspace
rm(list = ls(all = TRUE))

library(ggplot2)
library(readxl)
library("RColorBrewer", lib.loc="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library("ggthemes", lib.loc="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library(reshape2)
library(dplyr)

#plot from data 
Lotteries_Code_2 <- read_excel("~/Documents/OneDrive_ University_of_East Anglia/UEA/Year_2/Paper_1 /Experiment /Lotteries_Code_2.xlsx")

View(Lotteries_Code_2)   

#create new data frame  with only lottery and p1
lottery <- Lotteries_Code_2 %>% select(Lottery, p1) 

#rename coloumns
lottery <- lottery %>% rename(roll=Lottery, payoff=p1)

#
df <- data.frame(
  x = 1:100,
  y = rep(1, 100),
  z = lottery$payoff,
  w = rep(1, 100)
)

a <- ggplot(df, aes(x, y, width = w))

b <- a + geom_tile(aes(fill = z), show.legend = FALSE)
c <- b + scale_fill_gradient(low="grey", high="grey50")
c + labs(title ="", x = "", y = "") + theme_solid() 

#use median/average to label boxes 
medians <- lottery %>% group_by(payoff) %>% summarize(loc=median(roll), min=min(roll), max=max(roll))
  
#Find name/call/save graph/plot command

