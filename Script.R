
install.packages("ggplot2")
library(ggplot2)

#Set a plot Region to define lottery rectangle
plot(c(10, 100), c(0, 30), type = "n",
     main = "Lottery Choices")
i <- 4*(0:10)
abline(v=10, col="black")

       
