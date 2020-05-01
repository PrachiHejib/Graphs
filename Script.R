
install.packages("ggplot2")
library(ggplot2)

#Set a plot Region to define lottery rectangle
plot(c(10, 100), c(0, 30), type = "n",
     main = "Lottery Choices")
i <- 4*(0:10)
abline(v=c(15,20), col=c("blue", "red"), lty=c(1,2), lwd=c(1, 3))
       
