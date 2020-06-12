#Creating lotteries for experiment

#clear workspace
rm(list = ls(all = TRUE))

library(tidyverse)
library(ggthemes)


# For now - plot lottery p1 only
lottery <-
    read_csv("data/lotteries.csv") %>%
    select(roll, p1) %>%
    rename(payoff=p1)

# Compute coordinates for graph elements
coordinates <- lottery %>% group_by(payoff) %>%
    summarize(loc=median(roll), min=min(roll), max=max(roll))

ggplot() +
    # Draw the rectangles
    geom_rect(data=coordinates,
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
    geom_text(aes(x=loc, y=5, label=payoff), data=coordinates)

ggsave("plot.pdf", width=5, height=1, units="in")
