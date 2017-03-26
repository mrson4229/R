#  install.packages("twitteR")
#  install.packages("RCurl")
#  install.packages("tm")
#  install.packages("wordcloud")
#  install.packages("SnowballC")
# install.packages('httr')
 library("twitteR")
 library("RCurl")
 library("tm")
 library("wordcloud")
 library("SnowballC")
library('httr')

consumer_key <- '5uMNSslEffnq5WIS0tk2ng5t7'
consumer_secret <- 'WF1u5XnFktTQN02YEyalVIR847nDOmrMQugDR1KgwTittV4X6X'
access_token <- '843117860830429185-F4wOJKeg3eTnqYeB5tpuRRRye0CNEnM'
access_token_secret <- 'cePzoWV2htufGRpezQqDH46OvmCsYoperxzkOZdLlkb6G'

setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_token_secret)

#netflix_tweets <- searchTwitter("netflix", n=20, lang = "en")
#netflix_tweets
d.trump<- searchTwitter('Trump',n=3000,lang = 'en')

  #save text
#netflix_tweets_text <- sapply(netflix_tweets, function(x) x$getText() )
trump.tweets<-sapply(d.trump, function(x) x$getText() )
  #The below would be the same
  #Analyze review
#docs <- Corpus(VectorSource(netflix_tweets_text))
docs<-Corpus(VectorSource(trump.tweets))
  #If using Mac OS run this
  #netflix_tweets_text2 <- sapply(netflix_tweets_text,function(row) iconv(row,"latin1","ASCII",""))
  #docs <- Corpus(VectorSource(netflix_tweets_text2))


toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

#  Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))

  #Remove numbers
docs <- tm_map(docs, removeNumbers)

  #Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))

  #Remove your own stop word
  #specify your stopwords as a character vector
docs <- tm_map(docs, removeWords,'https')
docs <- tm_map(docs, removeWords,'tco')
docs <- tm_map(docs, removeWords,'donald')
docs <- tm_map(docs, removeWords,'trump')
useless<-c('the','want','thing','just','you')
docs <- tm_map(docs, removeWords,useless)


  #Remove punctuations
docs <- tm_map(docs, removePunctuation)

  #Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)

  #Text stemming
docs <- tm_map(docs, stemDocument)

  #Word counts
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)
hist(d$freq)
d[which(d$fre>100),]
d<-d[-1:-2,]
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,max.words=200, random.order=FALSE, rot.per=0.35,colors=brewer.pal(8, "Dark2"))


ahj<-getUser('steelroot')
ahj_followers_IDs<-ahj$getFollowers(retryOnRateLimit=300)


lucaspuente <- getUser("lucaspuente")
location(lucaspuente)

lucaspuente_follower_IDs<-lucaspuente$getFollowers(retryOnRateLimit=300)
length(lucaspuente_follower_IDs)
lucaspuente_follower_df<-twListToDF(lucaspuente_follower_IDs)

str(lucaspuente_follower_df)

lucaspuente_follower_df$location
lucaspuente_follower_df<-subset(lucaspuente_follower_df,location!="")

install.packages('ggmap')




