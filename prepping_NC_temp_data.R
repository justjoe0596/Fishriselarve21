library(data.table)
library(ggplot2)
library(lubridate)

nc_temp <- fread("NOAA_beaufort_temp.csv")
head(nc_temp)
summary(nc_temp)

#only keep important columns (year month date time and WTMP)
nc_temp.r <- nc_temp[,c("#YY","MM","DD","hh","mm","WTMP")][,date := ymd(paste(`#YY`,MM,DD,sep = "-"))]

#take average temp value between 9pm and 6am
nc_temp.r_night <- nc_temp.r[hh >21 | hh <6,]

nc_temp.r_night[,WTMP_avg := mean(WTMP), .(date)]


nc_temp.final <- nc_temp.r_night[,.(date,WTMP_avg)]

write.csv(nc_temp.final, "nc_temp_final.csv")
