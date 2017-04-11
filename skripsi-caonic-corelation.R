getwd();
setwd("E:/skripsi_latihan_canonicalcorelation");

install.packages("ggplot2")
install.packages("GGally")
install.packages("CCA")
library(ggplot2)
library(GGally)
library(CCA)

data <- read.csv("data-skripsi.csv",sep = ";")
colnames(data)<- c("suhu", "berat", "kelembapan", "amonia", "kematian", "ip","fcr", "hargajual")
summary(data);
kondisiling<- data[,1:5];
kualitasayam <- data[,6:8];
matcor(kondisiling,kualitasayam);
cc(kondisiling,kualitasayam);
res.cc
