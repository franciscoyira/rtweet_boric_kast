# Goal of this script: Retrieving the replies to the top 10 tweets of G. Boric
# and J. A. Kast
library(rtweet)
library(tidyverse)
library(here)
library(reticulate)

tweets_for_plot2 <- read_rds(here("cache", "tweets_for_plot2.rds"))

# The hacky way: getting followers or Boric and Kast
boric_followers <- xfun::cache_rds({
  rtweet::get_followers("gabrielboric",
                        n = 1600000,
                        retryonratelimit = TRUE)
},
file = "boric_followers.rds")
