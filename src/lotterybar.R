#Creating lotteries for experiment

#clear workspace
rm(list = ls(all = TRUE))

library(tidyverse)
library(ggthemes)


make_figure <- function(lottery, filename) {
  # Compute coordinates for graph elements
  coordinates <-
      lottery %>% group_by(payoff) %>%
      summarize(outcome=median(roll), min=min(roll), max=max(roll))
  
  info <-  lottery %>% summarize(mean=mean(payoff), sd=sd(payoff))

  ggplot() +
      # Draw the rectangles
      geom_rect(data=coordinates,
                mapping=aes(xmin=min, xmax=max+1, ymin=0, ymax=10, fill=payoff),
                show.legend=FALSE) +
      # Suppress axis labels
      labs(title="", x="", y="") +
      # Suppress the axis labels and borders
      theme_solid() +
      # Fix the aspect ratio so we can get long, thin strips
      # Shape of the graph will be determined by ratio of ymax as passed to
      # geom_rect and the maximum roll
      coord_fixed() +
      # Draw the payoff labels
      geom_text(aes(x=outcome, y=5,
                    label=paste("£", as.character(payoff), sep="")),
                data=coordinates, size=6, colour="white") +
      # Add minimum rolls for each outcome
      geom_text(aes(x=min, y=-2, label=min, hjust="left"),
                data=coordinates, size=3, colour="gray50") +
      # Allow space for the roll numbers below the bars
      ylim(-3, 20) +
      # Allow space for sd label on right of bar
      xlim(-10, 130) +
      # Add maximum rolls for each outcome
      geom_text(aes(x=max, y=-2, label=max, hjust="right"),
                data=coordinates, size=3, colour="gray50") +
      #add mean label for lottery
      geom_text(aes(x=110, y=5, label=paste("£", as.character(mean), sep=""), 
                hjust="centre"), data=info, size=6, colour="gray50") +
      #add header, mean
      geom_text(aes(x=110, y=15, label="Mean", 
                  hjust="centre"), data=info, size=4, colour="black") +
      #add SD label for lottery
      geom_text(aes(x=120, y=5, label=sprintf("%10.1f", sd),
                  hjust="centre"), data=info, size=6, colour="gray50")+
      #add header, SD
      geom_text(aes(x=127, y=15, label="Risk", 
                  hjust="centre"), data=info, size=4, colour="black")
  

  ggsave(filename, width=5, height=1, units="in")
}

df <- read_csv("data/lotteries.csv")
for (col in names(df %>% select(-roll))) {
  print(str_interp("Building graphic for ${col}"))
  lottery <- df %>% select(roll, col) %>% rename(payoff=col)
  make_figure(lottery, str_interp("fig/lottery_${col}.jpg"))
}

df <- read_csv("data/Instructions.csv")
for (col in names(df %>% select(-roll))) {
  print(str_interp("Building graphic for ${col}"))
  lottery <- df %>% select(roll, col) %>% rename(payoff=col)
  make_figure(lottery, str_interp("fig/lottery_${col}.jpg"))
}