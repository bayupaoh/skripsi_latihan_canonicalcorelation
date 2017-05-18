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
  
 return(paste(ind,"memiliki pengaruh",keeratan,"terhadap",dep,"dan bernilai",hubungan,".Sehinnga",kondisi,ind,"akan mengakibatkan kenaikan",dep))
}
 