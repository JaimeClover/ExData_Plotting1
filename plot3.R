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

# open png device and create a 3-line graph of sub-meters:
png('plot3.png')
with(data, plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red","blue"), lty=c(1,1,1))
dev.off()
