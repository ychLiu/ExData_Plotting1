library(dplyr)
if (!file.exists("household_power_consumption.txt")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
        unzip("household_power_consumption.zip", "household_power_consumption.txt", overwrite=TRUE)
}

fullData <- read.table("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE, stringsAsFactors = FALSE)
targetData <- filter(fullData, Date == "1/2/2007" | Date == "2/2/2007")
rm(fullData)

targetData <- transform(targetData, Date=gsub("1/2/2007", "01/02/07", Date))
targetData <- transform(targetData, Date=gsub("2/2/2007", "02/02/07", Date))
fullDate <- strptime(paste(targetData$Date, targetData$Time), "%d/%m/%y %H:%M:%S")
targetData$fullDate <- fullDate

png("plot4.png")
par(mfrow=c(2,2))
with(targetData,
     
     {plot(fullDate, Global_active_power, type="l", xlab="", ylab="Global active power")
             
             plot(fullDate, Voltage, type="l", xlab="datetime")
             
             plot(fullDate, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
             points(fullDate, Sub_metering_2, type="l", col="red")
             points(fullDate, Sub_metering_3, type="l", col="blue")
             legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, bty="n")
             
             plot(fullDate, Global_reactive_power, type="l", xlab="datetime")}
     
)
dev.off()
