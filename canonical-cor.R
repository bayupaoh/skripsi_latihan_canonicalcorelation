#install packages
install.packages("CCA")
library(CCA)
install.packages("RMySQL")
library(RMySQL)

#get data from mysql
connection = dbConnect(MySQL(), user='root', password='', dbname='analisis_korelasi', host='localhost')
query <- dbSendQuery(connection, "SELECT suhu,kelembapan,amonia,kematian,ip,hargaJual FROM dataset;")
data <- fetch(query)
colnames(data)<- c("suhu", "kelembapan", "amonia", "kematian", "ip", "hargajual")
kondisiling<- data[,1:3];
kualitasayam <- data[,5:6];

#cari matiks korelasi
matcor<-matcor(kondisiling,kualitasayam)
matcorxy <- matcor$XYcor[1:3,4:5]
matcoryx <- matcor$XYcor[4:5,1:3]

#ambil nilai lambda dan bi
bi <- eigen(solve(matcor$Ycor)%*%matcoryx%*%solve(matcor$Xcor)%*%matcorxy)
lamda <- bi$values
#ambil nilai ai
ai<-solve(matcor$Xcor)%*%matcorxy%*%bi$vectors
#nilai maks indeks
max<-which.max(lamda)

#hitung tingkat korelasi
n <- dim(kondisiling)[1]
p <- length(kondisiling)
q <- length(kualitasayam)
hasil <- (-1*(n-0.5*(p+q+1)))*(sum(log(1-lamda)))
#menggunakan loading canonical
#cor(x,ui)
corxui<-matcor$Xcor%*%ai[,max]
#cor(y,vi)
coryvi<-matcor$Ycor%*%bi$vectors[max,]

