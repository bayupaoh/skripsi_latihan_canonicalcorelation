#install packages
install.packages("RMySQL")
library(RMySQL)

#get data from mysql
connection = dbConnect(MySQL(), user='root', password='', dbname='analisis_korelasi', host='localhost')
query <- dbSendQuery(connection, "SELECT suhu,kelembapan,amonia,kematian,ip,hargaJual FROM dataset;")
data <- fetch(query)
colnames(data)<- c("suhu", "kelembapan", "amonia", "kematian", "ip","hargajual")

#variabel x1,x2, dan x3
suhu=data[,1]
kelembapan=data[,2]
amonia=data[,3]
x<- matrix(c(rep(1,length(suhu)),suhu,kelembapan,amonia),ncol = 4, byrow = FALSE)
#variabel y
kematian=data[,4]
y<- matrix(c(kematian),ncol = 1)
#hitung vector b
b<-solve(t(x)%*%(x))%*%(t(x)%*%(y))
hasil<- data.frame(Koefisien=c("intercept","suhu","kelembapan","amonia"),b=c(b))
