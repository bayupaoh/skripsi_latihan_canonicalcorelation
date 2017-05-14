#instal packages
install.packages("RMySQL")
library(RMySQL)

#get data from mysql
connection = dbConnect(MySQL(), user='root', password='', dbname='analisis_korelasi', host='localhost')
query <- dbSendQuery(connection, "SELECT suhu,kelembapan,amonia,kematian,ip,hargaJual FROM dataset;")
data <- fetch(query)
colnames(data)<- c("suhu", "kelembapan", "amonia", "kematian", "ip", "hargajual")

#hitung nilai korelasi
hasil=cor(data[,2],data[,3])

#pengujian hasil
hasiluji=cor.test(data[,2],data[,3])
