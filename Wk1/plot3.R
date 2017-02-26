##
##plot3.R -- outputs plot3.png in current directory
##

##read the entire data set into a data frame - took about ~10s
##';' separated, '?' as NA
df <- read.table("household_power_consumption.txt", sep = ";",
                 header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

##subset only data for 2007-02-01 and 2007-02-02
df <- df[grep("^[12]/2/2007", df$Date),]


##add a 10th column - by combining Date & Time in POSIXct format
df[,10] <- as.POSIXct(strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S"))
names(df)[10] <- "Date_time"

##open a png device
png(filename = "plot3.png", width = 480, height = 480, units = "px")

##plot a scatterplot of energy sub metering #1 over date-time
with(df, plot(Date_time, Sub_metering_1, type = "l",
              xlab = "", ylab = "Energy sub metering"))

##add energy sub metering #2 over date time (in)
with(df, lines(Date_time, Sub_metering_2, col = "red"))

##add energy sub metering #3 over date time (in blue)
with(df, lines(Date_time, Sub_metering_3, col = "blue"))

##add a legend at top right corner
legend("topright", col = c("black", "red", "blue"), lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##close the png device to save the file
dev.off()
