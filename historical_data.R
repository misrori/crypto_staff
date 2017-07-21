library(rvest)

my_links <-read_html('https://coinmarketcap.com/historical/')%>%
  html_nodes(".list-unstyled .text-center a") %>%
  html_attr('href')
my_links <-paste('https://coinmarketcap.com', my_links,sep = "")


get_historical_data <- function(my_url){
  oldal <-read_html(my_url)
  
  adat_help<- 
    oldal %>%
    html_nodes("table") %>%
    html_table()
    
  a <- adat_help[[1]]
  a$date <- as.Date(strsplit(my_url, "/")[[1]][5], format = '%Y%m%d')
  
 market_cap <-  
  oldal %>%
    html_nodes("#total-marketcap") %>%
    html_text()
 ez_market <- strsplit(market_cap, ":")[[1]][2]
 a$market_cap <- ez_market
 a <- a[1:10,]
  return(a)
  
}

my_full_table <- data.frame()

for(i in my_links){
  print(i)
my_temp_table <- get_historical_data(my_url = i)
my_full_table <- rbind(my_full_table, my_temp_table)
}

write.csv(my_full_table, 'historical_coin_data_1.csv', row.names = F)

my_links <- my_links[202:length(my_links)]

my_full_table2 <- data.frame()

for(i in my_links){
  print(i)
  my_temp_table <- get_historical_data(my_url = i)
  my_full_table2 <- rbind(my_full_table2, my_temp_table)
}

names(my_full_table)
names(my_full_table2) <-names(my_full_table)

final_adat <- rbind(my_full_table, my_full_table2)
final_adat <- final_adat[is.na(final_adat$Name)==F,]


write.csv(final_adat, 'historical_coin_data.csv', row.names = F)
