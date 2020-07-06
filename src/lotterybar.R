#Creating lotteries for experiment

#clear workspace
rm(list = ls(all = TRUE))

library(tidyverse)
library(ggthemes)

make_figure <- function(lottery) {
  # Compute coordinates for graph elements
  coordinates <-
      lottery %>% group_by(payoff) %>%
      summarize(outcome=median(roll), min=min(roll), max=max(roll))

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
                data=coordinates, size=6) +
      # Add minimum rolls for each outcome
      geom_text(aes(x=min, y=-2, label=min, hjust="left"),
                data=coordinates, size=3, colour="gray50") +
      # Allow space for the roll numbers below the bars
      ylim(-3, 10) +
      # Add maximum rolls for each outcome
      geom_text(aes(x=max, y=-2, label=max, hjust="right"),
                data=coordinates, size=3, colour="gray50")

  ggsave("plot.pdf", width=5, height=1, units="in")
}

# For now - plot lottery p1 only
lottery <-
    read_csv("data/lotteries.csv") %>%
    select(roll, p1) %>%
    rename(payoff=p1)
make_figure(lottery)

