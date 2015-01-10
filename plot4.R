# Script to generate Plot 4

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
dt1$datetime<-strptime(paste(dt1$Date,dt1$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")

png(filename="./plot4.png",width=480, height=480)

## Make 2 row, 2 column layout
par(mfrow = c(2,2), mar=c(4,4,1,2), oma=c(1,2,1,1))
with(dt1,{
        
        ## Row 1 Col 1
        plot(datetime,Global_active_power,type="l",ylab="Global Active Power",
             xlab="", cex.lab=1, cex.axis=1)
        ## Row 1 Col 2
        plot(datetime,Voltage,type="l", cex.lab=1, cex.axis=1)
        ## Row 2 Col 1
        {plot(datetime,Sub_metering_1,type="l",ylab="Energy sub metering",
                xlab="", col="black", cex = 1, cex.lab=1,cex.axis=1)
        lines(datetime,Sub_metering_2,type="l",col="red")
        lines(datetime,Sub_metering_3,type="l",col="blue")
        legend("topright", legend=names(dt1)[7:9], col=c("black","red","blue"),lwd=1,
                bty="n", cex=0.85)} ##xjust=1, yjust=1
        
        ## Row 2 Col 2
        plot(datetime,Global_reactive_power,type="l", cex.lab=1, cex.axis=1)
        })

## force the dev to create the png by turning off
dev.off()