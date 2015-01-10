# Script to generate Plot 1

## Read in power consumption file headers and then relevant data 
## to the project which is 2880 minutes (2 days) starting 2/1/2007
## Assume file is in working directory.

file1<-"./household_power_consumption.txt"
## First read is just to get header names saved
dt1<-read.table(file1,header=TRUE,sep=";", skip=0,nrows=1,na.strings=c("?"))
savedNames<-names(dt1)
## Second read gets relevant data for plots
dt1<-read.table(file1,header=TRUE,sep=";", skip=66636,nrows=2880,na.strings=c("?"))
names(dt1)<-savedNames

## Add a new column with combined Date/Time as POSIXlt class
dt1$DateTime<-strptime(paste(dt1$Date,dt1$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")

hist(dt1$Global_active_power,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)",ylim=c(0,1200))

## copy current plot to PNG file
dev.copy(png,file="./plot1.png")
dev.off()