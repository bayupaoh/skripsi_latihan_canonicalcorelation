#instal packages
install.packages("RMySQL")
library(RMySQL)

#get data from mysql
connection = dbConnect(MySQL(), user='b21e15fd828e18', password='7b69de92', dbname='analisis_korelasi', host='ap-cdbr-azure-southeast-b.cloudapp.net')
query <- dbSendQuery(connection, "SELECT suhu,kelembapan,amonia,kematian,ip,hargaJual FROM dataset;")
data <- fetch(query)
colnames(data)<- c("suhu", "kelembapan", "amonia", "kematian", "ip", "hargajual")

##============================= Momen Pearson
#hitung nilai korelasi
hasilmomenpearson=cor(data[,2],data[,3])

##=============================regresi berganda
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
hasilmultiple<- data.frame(Koefisien=c("intercept","suhu","kelembapan","amonia"),b=c(b))



##=================================korelasi kanonik
install.packages("CCA")
library(CCA)

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



##============================= penentuan kriteria korelasi
#penentuan kriteria korelasi
summary <- function(koefisien,ind,dep) {
  hubungan="positif"
  keeratan=""
  kondisi="kenaikan"
  if(koefisien == 0){
    return("tidak terdapat korelasi")
  }else if(koefisien < 0){
    hubungan="negatif"
    kondisi="penurunan"
  }
  
  if(abs(koefisien) > 0 & abs(koefisien) <= 0.2){
    keeratan="sangat lemah"  
  }else if(abs(koefisien) > 0.2 & abs(koefisien) <= 0.4){
    keeratan="lemah"  
  }else if(abs(koefisien) > 0.4 & abs(koefisien) <= 0.6){
    keeratan="sedang"  
  }else if(abs(koefisien) > 0.6 & abs(koefisien) <= 0.8){
    keeratan="kuat"  
  }else if(abs(koefisien) > 0.8 & abs(koefisien) <= 1){
    keeratan="sangat kuat"  
  }
  
  return(paste(ind,"memiliki pengaruh",keeratan,"terhadap",dep,"dan bernilai",hubungan,"(",koefisien,").Sehinnga",kondisi,ind,"akan mengakibatkan kenaikan",dep))
}

##=====================================input data to mysql in result table
query=paste("truncate result")
dbSendQuery(connection, query)

#momen pearson
query=paste("insert into result values(null,1,'",summary(hasilmomenpearson,"kelembapan","amonia"),"',",hasilmomenpearson,");")
dbSendQuery(connection, query)
#regresi berganda
query=paste("insert into result values(null,2,'",summary(abs(hasilmultiple[2,2]),"suhu","kematian"),"',",abs(hasilmultiple[2,2]),");")
dbSendQuery(connection, query)

query=paste("insert into result values(null,2,'",summary(abs(hasilmultiple[3,2]),"kelembaban","kematian"),"',",abs(hasilmultiple[3,2]),");")
dbSendQuery(connection, query)

query=paste("insert into result values(null,2,'",summary(abs(hasilmultiple[4,2]),"amonia","kematian"),"',",abs(hasilmultiple[4,2]),");")
dbSendQuery(connection, query)

#korelasi kanonik
query=paste("insert into result values(null,2,'",summary(0,"suhu","kematian"),"',",abs(hasilmultiple[2,2]),");")
dbSendQuery(connection, query)

query=paste("insert into result values(null,3,'",summary(0,"kelembaban","kematian"),"',",abs(hasilmultiple[3,2]),");")
dbSendQuery(connection, query)

query=paste("insert into result values(null,3,'",summary(0,"amonia","kematian"),"',",abs(hasilmultiple[4,2]),");")
dbSendQuery(connection, query)

query=paste("insert into result values(null,3,'",summary(0,"suhu","kematian"),"',",abs(hasilmultiple[2,2]),");")
dbSendQuery(connection, query)

query=paste("insert into result values(null,3,'",summary(0,"kelembaban","kematian"),"',",abs(hasilmultiple[3,2]),");")
dbSendQuery(connection, query)

query=paste("insert into result values(null,3,'",summary(0,"amonia","kematian"),"',",abs(hasilmultiple[4,2]),");")
dbSendQuery(connection, query)

#matikan konek
dbDisconnect(connection)