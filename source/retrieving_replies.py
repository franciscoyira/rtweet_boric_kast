# Credits for this code: https://towardsdatascience.com/mining-replies-to-tweets-a-walkthrough-9a936602c4d6

# INSTALL TWITTER API (!pip install TwitterAPI) and import necessary libraries/packages
# TwitterAPI Documentation here: https://github.com/geduldig/TwitterAPI/
from TwitterAPI import TwitterAPI, TwitterOAuth, TwitterRequestError, TwitterConnectionError, TwitterPager
import pandas as pd

from dotenv import load_dotenv
from os import getenv

load_dotenv()  # take environment variables from .env.

consumer_key = getenv('consumer_key')
consumer_secret = getenv('consumer_secret')
access_token_key = getenv('access_token_key')
access_token_secret = getenv('access_token_secret')

api = TwitterAPI(consumer_key, consumer_secret, access_token_key, access_token_secret, api_version='2')

# *Find the screen name of the account that posted the tweet you want to analyze. Place it right below. This will retrieve ths first two hundred off tweets that account. 
# If the tweet you want to analyze is older- dive into the code, modify it to retrieve more tweets and follow the same script again. *

# Or, if you can retrieve the status_id/tweet_id from the link to the tweet:

# For instance: In https://twitter.com/FiveThirtyEight/status/1350118333677449220 
# the number at the end is the status id, you can look up further details about it, 
# such as the conversation id using this example: https://github.com/geduldig/TwitterAPI/blob/master/examples/v2/lookup_tweet.py

names = ["Reuters"]  # placeholder screen name for the handle you want to retrieve tweets from
# YOU CAN QUERY MULTIPLE HANDLES, BUT REMEMBER TO HANDLE TWITTER'S TIMEOUT/LIMIT CONSTRAINTS

""" Retrieves the most recent 200-ish tweets from a  list of given screen names
    Returns a data frame of the tweets with [id, screen_name, text, timestamp]
"""
def get_new_tweets(names):
    print("Retrieving tweets")
    corpus = []                                                                                        
    for name in names:
        tweets = api.user_timeline(name, include_rts=False, count=200, tweet_mode="extended")          
        time.sleep(4)
        corpus.extend(tweets)                                                                          
    data = [[tweet.id_str, tweet.user.screen_name, tweet.full_text, tweet.created_at] for tweet in corpus]
    tweets = pd.DataFrame(data, columns=['tweet_id', 'screen_name', 'text', 'timestamp'])                

    return tweets
