getwd();
setwd("~/Desktop/skripsi_latihan_canonicalcorelation/");
#import data
data <- read.csv("data-skripsi.csv",sep = ",")
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
