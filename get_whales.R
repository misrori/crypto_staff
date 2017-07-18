library(rvest)
library(data.table)
my_url_list<- paste("https://steemwhales.com/?p=",c(1:1000),"&s=total", sep = "")

adat <- data.table()
for(i in 1:1000){
  print(i)
  adat_help <-read_html(my_url_list[i])%>%
    html_nodes("table") %>%
    html_table()
  t<- adat_help[[1]]
  adat <- rbind(adat,t)
} 

names(adat) <- c('Rank',	'Name',	'Rep',	'Post_Count',	'Followers',	'Following',	'Posting',	'Curation',
                  'Steem',	'Steem_Power',	'Steem_Dollars',	'Estimated_Value')
  
write.csv(adat, 'top_25000.csv', row.names = F)



#################################################################################################
###################################         elemzes       #######################################



adat <- data.table(read.csv('top_25000.csv', stringsAsFactors = F))
str(adat)
names(adat)


