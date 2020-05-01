#find the "clear" command and try to run as a whole script

install.packages("ggplot2")
library(ggplot2)
library(readxl)

#Set a plot Region to define lottery rectangle
plot(c(10, 100), c(0, 30), type = "n",
     main = "Lottery Choices")
i <- 4*(0:10)
abline(v=10, col="black")


#plot from data 
Lotteries_Code_2 <- read_excel("~/Documents/OneDrive_ University_of_East Anglia/UEA/Year_2/Paper_1 /Experiment /Lotteries_Code_2.xlsx")

View(Lotteries_Code_2)   


       
#Example of rectangles (using a data frame)
df <- data.frame(
  x = 1:100,
  y = rep(1, 100),
  z = Lotteries_Code_2$p1,
  w = rep(1, 100)
)

ggplot(df, aes(x, y, width = w)) +
  geom_tile(aes(fill = z), colour = "grey50")

