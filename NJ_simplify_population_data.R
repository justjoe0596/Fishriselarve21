library(data.table)
library(lubridate)

nj_popdata <- fread("icthy_data_micrundu_17.csv")

nj_popdata[,Date := ymd(Date)]

nj_popdata.r <- nj_popdata[Date >= ymd(20170101) & Date < ymd(20180101)][, n := sum(Number), Date][,.(Date,n)][,region := "NJ"]


nj_popdata.final <- unique(nj_popdata.r[,.(Date,n,region)])

write.csv(nj_popdata.final, "nj_popdata.final.csv")
