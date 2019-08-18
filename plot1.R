library(dplyr)
if (!file.exists("household_power_consumption.txt")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
        unzip("household_power_consumption.zip", "household_power_consumption.txt", overwrite=TRUE)
}

fullData <- read.table("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE, stringsAsFactors = FALSE)
targetData <- filter(fullData, Date == "1/2/2007" | Date == "2/2/2007")
rm(fullData)

png("plot1.png")
with(targetData, 
     hist(Global_active_power, col="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")
)
dev.off()
