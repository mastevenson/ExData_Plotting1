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


#Plot2

png(filename='plot2.png', width = 480, height = 480)

plot(data$DateTime,
     data$Global_active_power,
     type = "l",
     ylab='Global Active Power (kilowatts)',
     xlab='',
     col='black')

dev.off()
