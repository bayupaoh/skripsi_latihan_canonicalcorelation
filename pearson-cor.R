getwd();
setwd("~/Desktop/skripsi_latihan_canonicalcorelation/");
#import data
data <- read.csv("data-skripsi.csv",sep = ";")
colnames(data)<- c("suhu", "berat", "kelembapan", "amonia", "kematian", "ip","fcr", "hargajual")
#hitung nilai korelasi
hasil=cor(data[,1],data[,5])
#pengujian hasil
hasiluji=cor.test(data[,1],data[,5])
