#ggplot practice

x<-c('dplyr','ggplot2','ggmap')
lapply(x,library,character.only=TRUE)

data(economics,package='ggplot2')
head(economics)
ggplot(data=economics,aes(date,unemploy)) +geom_line(col="black") +geom_col()


keyword<-'½É½ÉÇØ'
keyword<-enc2utf8(keyword)
  
twt<-searchTwitter(keyword,n=8000,since = '2017-03-21',until='2017-03-22')
#str(twt)
twt_df<-twListToDF(twt)
#str(twt_df)
head(twt_df$text)

twt_df$created<-as.POSIXlt(twt_df$created)
time<-twt_df$created[[3]]
tbl<-as.data.frame(table(time))
tbl
mean(tbl$Freq)
ggplot(data=tbl,aes(time,Freq)) +geom_bar(stat = "identity", color = "black", fill = "grey") +
  labs(title = "Frequency by Time\n", x = "\nTime", y = "Frequency\n") +
  theme_classic() +
  geom_abline(slope=0,intercept=median(tbl$Freq))
