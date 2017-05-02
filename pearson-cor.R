getwd();
setwd("~/Desktop/skripsi_latihan_canonicalcorelation/");
#import data
data <- read.csv("data-skripsi.csv",sep = ",")
colnames(data)<- c("suhu", "kelembapan", "amonia", "kematian", "ip", "hargajual")
#hitung nilai korelasi
hasil=cor(data[,2],data[,3])
#pengujian hasil
hasiluji=cor.test(data[,2],data[,3])