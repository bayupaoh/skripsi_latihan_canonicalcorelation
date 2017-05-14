#install packages
install.packages("RMySQL")
library(RMySQL)

connection = dbConnect(MySQL(), user='root', password='', dbname='analisis_korelasi', host='localhost')
#cleaning
query <- dbSendQuery(connection, "DELETE FROM dataset WHERE (suhu <= 0) or (kelembapan <= 0 ) or (amonia <= 0 ) or (ip <= 0 ) or (hargaJual <= 0 );")
#filtering
query <- dbSendQuery(connection, "DELETE FROM dataset WHERE (suhu NOT BETWEEN 18 and 30) or (kelembapan NOT BETWEEN 60 and 80) or (amonia NOT BETWEEN 0 and 20);")

