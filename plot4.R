# IMPORTANT: Set working directory to the directory containing 'household_power_consumption.txt'

# read data from the approximate desired date range:
data <- read.table('household_power_consumption.txt', sep=';', na.strings='?', skip=65000, nrows = 5000)

# read the first line to get variable names:
heading <- read.table('household_power_consumption.txt', sep=';', nrows=1)

# rename variables using the values from heading:
names(data) <- t(heading)

# combine Date and Time into a single DateTime variable:
data$DateTime <- paste(data$Date, data$Time)

# convert data$DateTime to POSIXlt:
data$DateTime <- strptime(data$DateTime, format="%d/%m/%Y %H:%M:%S")

# convert data$Date to Date class:
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# subset data to include only the desired date range:
data <- data[data$Date > as.Date('2007-1-31') & data$Date < as.Date('2007-2-3'),]

# open png device and create the image with 4 plots:
png('plot4.png')
par(mfrow = c(2,2), cex=0.8)
with(data,{
    plot(DateTime, Global_active_power, type="l", ylab="Global Active Power", xlab="")
    plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime")
    plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col=c("black","red","blue"), lty=c(1,1,1), bty="n")
    plot(DateTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
})
dev.off()
