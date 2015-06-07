#Download the file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

#Unzip and read in
data <- read.csv(unz(temp, "household_power_consumption.txt"), sep = ";", stringsAsFactors=FALSE)
unlink(temp)

#Clean up
rm(temp)

#Numeric fields came in as strings, convert these to numerics 
data[,c(3:9)]<-sapply(data[,c(3:9)], as.numeric)

#Convert dates and times to new format
data$DateTime<-strptime(paste(data$Date,data$Time),format='%d/%m/%Y %H:%M:%S')

#Subset for only 2/1/2007-2/2/2007
data<-subset(data, DateTime > strptime("01/02/2007 00:00:00",format='%d/%m/%Y %H:%M:%S') &
                      DateTime < strptime("03/02/2007",format='%d/%m/%Y'))

#Plot3

png(filename='plot3.png', width = 480, height = 480)

with(data,plot(DateTime,Sub_metering_1, type='l',col='black',
               ylab="Energy sub metering",
               xlab=""))
with(data,lines(DateTime,Sub_metering_2,col='red'))
with(data,lines(DateTime,Sub_metering_3,col='blue'))
legend("topright",
       lty=1, 
       col=c('black','red','blue'),
       cex=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
