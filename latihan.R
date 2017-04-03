setwd("~/Desktop/skripsi-practice-canonicalcorelation/")
install.packages("ggplot2")
install.packages("GGally")
install.packages("CCA")
library(ggplot2)
library(GGally)
library(CCA)
mm <- read.csv("mmreg.csv")
colnames(mm)<- c("Control", "Concept", "Motivation", "Read", "Write", "Math","Science", "Sex")
summary(mm)
psych <- mm[, 1:3]
acad <- mm[, 4:8]
matcor(psych, acad)
cc(psych,acad)
res.cc$cor
plt.cc(res.cc)
plot(res.cc$cor,type="b")

#==================================================
cc1 <- cc(psych, acad)
cc1$cor
cc1[3:4]
cc2 <- comput(psych, acad, cc1)
cc2[3:6]
# tests of canonical dimensions
ev <- (1 - cc1$cor^2)

n <- dim(psych)[1]
p <- length(psych)
q <- length(acad)
k <- min(p, q)
m <- n - 3/2 - (p + q)/2

w <- rev(cumprod(rev(ev)))

# initialize
d1 <- d2 <- f <- vector("numeric", k)

for (i in 1:k) {
  s <- sqrt((p^2 * q^2 - 4)/(p^2 + q^2 - 5))
  si <- 1/s
  d1[i] <- p * q
  d2[i] <- m * s - p * q/2 + 1
  r <- (1 - w[i]^si)/w[i]^si
  f[i] <- r * d2[i]/d1[i]
  p <- p - 1
  q <- q - 1
}

pv <- pf(f, d1, d2, lower.tail = FALSE)
(dmat <- cbind(WilksL = w, F = f, df1 = d1, df2 = d2, p = pv))