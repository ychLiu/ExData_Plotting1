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

png("plot2.png")
with(targetData,
     {plot(fullDate, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")}
)
dev.off()
