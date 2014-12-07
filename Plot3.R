## Retrieve the full dataset
complete_data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                          nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
complete_data$Date <- as.Date(complete_data$Date, format="%d/%m/%Y")

## Subset the data
feb_data <- subset(complete_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(complete_data)

## Convert the Date and Time variables to Date/Time classes
DT <- paste(as.Date(feb_data$Date), feb_data$Time)
feb_data$DT <- as.POSIXct(DT)

## Create the plot
with(data, {
        plot(Sub_metering_1~Datetime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save the plot to a file
dev.copy(png, file="Plot3.png", height=480, width=480)
dev.off()