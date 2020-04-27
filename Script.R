
install.packages("ggplot2")
library(ggplot2)


#Set a plot Region to define lottery rectangle
plot(c(10, 100), c(0, 30), type = "n",
     main = "Lottery Choices")
i <- 4*(0:10)

#Example
## set up the plot region:
plot(c(100, 250), c(300, 450), type = "n",
     main = "2 x 11 rectangles; `rect(100+i,300+i,  150+i,380+i)'")
i <- 4*(0:10)
## draw rectangles with bottom left (100, 300)+i  and top right (150, 380)+i
rect(100+i, 300+i, 150+i, 380+i, col=rainbow(11, start=.7,end=.1))
rect(240-i, 320+i, 250-i, 410+i, col=heat.colors(11), lwd=i/5)

#Example line segment 
x <- runif(12); y <- rnorm(12)
i <- order(x,y); x <- x[i]; y <- y[i]
plot(x,y, main="arrows(.) and segments(.)")
## draw arrows from point to point :
s <- seq(length(x)-1)# one shorter than data
arrows(x[s], y[s], x[s+1], y[s+1], col= 1:3)
s <- s[-length(s)]
segments(x[s], y[s], x[s+2], y[s+2], col= 'pink')

#Example of rectangles (using a data frame)
df <- data.frame(
  x = rep(c(0, 20, 50, 75, 100), 2),
  y = rep(c(1, 1), each = 5),
  z = factor(rep(1:5, each = 5)),
  w = rep(diff(c(0, 20, 60, 80, 100)), 2)
)
ggplot(df, aes(x, y)) +
  geom_tile(aes(fill = z), colour = "grey50")
#another example
ggplot(df, aes(x, y, width = w)) +
  geom_tile(aes(fill = z), colour = "grey50")


