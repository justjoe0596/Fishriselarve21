library(data.table)
library(lubridate)

nc_popdata <- fread("NC_Fish_Spp_ID_2017_Micrundu.csv")

nc_popdata[,Date := mdy(Date)]

nc_popdata.r <- nc_popdata[, n := sum(Count), Date][,.(Date,n)][,region := "NC"]


nc_popdata.final <- unique(nc_popdata.r[,.(Date,n,region)])

write.csv(nc_popdata.final, "nc_popdata.final.csv")
