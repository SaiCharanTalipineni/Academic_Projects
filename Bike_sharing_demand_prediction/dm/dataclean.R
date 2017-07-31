library(splitstackshape)

df1 <- read.csv("C:/Users/Sai Rakesh Ghanta/Desktop/2015Q2/HealthyRide Rentals 2015 Q2.csv", header=T)
df2 <- read.csv("C:/Users/Sai Rakesh Ghanta/Desktop/2015Q3/HealthyRide Rentals 2015 Q3.csv", header=T)
df3 <- read.csv("C:/Users/Sai Rakesh Ghanta/Desktop/2015Q4/HealthyRide Rentals 2015 Q4.csv", header=T)
df4 <- read.csv("C:/Users/Sai Rakesh Ghanta/Desktop/2016Q1/HealthyRide Rentals 2016 Q1.csv", header=T)
df5 <- read.csv("C:/Users/Sai Rakesh Ghanta/Desktop/2016Q2/HealthyRide Rentals 2016 Q2.csv", header=T)
df6 <- read.csv("C:/Users/Sai Rakesh Ghanta/Desktop/2016Q3/HealthyRide Rentals 2016 Q3.csv", header=T)
df7 <- read.csv("C:/Users/Sai Rakesh Ghanta/Desktop/2016Q4/HealthyRide Rentals 2016 Q4.csv", header=T)
df <- rbind(df1, df2, df3, df4, df5, df6, df7)
df$Usertype <- NULL

df <- cSplit(df, "Starttime", " ")
df <- cSplit(df, "Stoptime", " ")

names(df)[names(df) == 'Starttime_1'] <- 'StartDate'
names(df)[names(df) == 'Stoptime_1'] <- 'EndDate'

df <- cSplit(df, "Starttime_2", ":")
df <- cSplit(df, "Stoptime_2", ":")

names(df)[names(df) == 'Starttime_2_1'] <- 'SHour'
names(df)[names(df) == 'Starttime_2_2'] <- 'SMin'
names(df)[names(df) == 'Stoptime_2_1'] <- 'EHour'
names(df)[names(df) == 'Stoptime_2_2'] <- 'EMin'

df = cbind(df,StartDate2=rep(df$StartDate))
df <- cSplit(df, "StartDate2", "/")

names(df)[names(df) == 'StartDate2_1'] <- 'SMonth'
names(df)[names(df) == 'StartDate2_2'] <- 'SDay'
names(df)[names(df) == 'StartDate2_3'] <- 'SYear'

df = cbind(df,EndDate2=rep(df$EndDate))
df <- cSplit(df, "EndDate2", "/")

names(df)[names(df) == 'EndDate2_1'] <- 'EMonth'
names(df)[names(df) == 'EndDate2_2'] <- 'EDay'
names(df)[names(df) == 'EndDate2_3'] <- 'EYear'

temp.df <- read.csv("C:/Users/Sai Rakesh Ghanta/Desktop/915662.csv", header=T)
temp.df<-temp.df[(temp.df$STATION_NAME=="PITTSBURGH ALLEGHENY CO AIRPORT PA US"),]

keeps <- c("DATE", "TMAX", "TMIN")
temp.df <- temp.df[keeps]

temp.df$DATE <- as.Date(as.character(temp.df$DATE), '%Y%m%d' )
temp.df = cbind(temp.df,Date2=rep(temp.df$DATE))
temp.df <- cSplit(temp.df, "Date2", "-")

names(temp.df)[names(temp.df) == 'Date2_1'] <- 'SYear'
names(temp.df)[names(temp.df) == 'Date2_2'] <- 'SMonth'
names(temp.df)[names(temp.df) == 'Date2_3'] <- 'SDay'

temp.df$TAVG <- (temp.df$TMAX + temp.df$TMIN)/2

df <- merge(df, temp.df,by=c("SYear","SMonth", "SDay"))
df$DATE <- NULL

df <- subset(df, select=c(4,5,6,7,8,9,10,11,1,2,3,13,14,12,19,17,18,15,16,20,21,22))

write.csv(df, "C:/Users/Sai Rakesh Ghanta/Desktop/finaldataset.csv")

dataset <- read.csv("C:/Users/Sai Rakesh Ghanta/Desktop/finaldataset.csv")

dataset$temp<-ifelse(dataset$TAVG<45,1,
                    ifelse(dataset$TAVG>=45 & dataset$TAVG<70,2,3
                                  ))

dataset$temp[dataset$temp=='1'] <- 'low'
dataset$temp[dataset$temp=='2'] <- 'medium'
dataset$temp[dataset$temp=='3'] <- 'high'

write.csv(dataset, "C:/Users/Sai Rakesh Ghanta/Desktop/finaldataset.csv")

df.2<-read.csv("C:/Users/sat122/Downloads/finaldataset.csv", header = T, stringsAsFactors = F)
df.2$Trip.id<-NULL
df.2$Bikeid<-NULL
df.2$From.station.name<-NULL
df.2$To.station.name<-NULL
df.2$SMin<-NULL
df.2$EMin<-NULL
df.2$TMAX<-NULL
df.2$TMIN<-NULL

write.csv(df.2, "C:/Users/sat122/Downloads/finaldataset2.csv", row.names = F)
