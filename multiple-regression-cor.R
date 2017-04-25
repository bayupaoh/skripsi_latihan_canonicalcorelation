getwd();
setwd("~/Desktop/skripsi_latihan_canonicalcorelation/");
#import data
data <- read.csv("data-skripsi.csv",sep = ";")
colnames(data)<- c("suhu", "berat", "kelembapan", "amonia", "kematian", "ip","fcr", "hargajual")

variabely=data[,5]
