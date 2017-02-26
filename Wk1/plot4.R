##
##plot4.R -- outputs plot4.png in current directory
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
png(filename = "plot4.png", width = 480, height = 480, units = "px")

##we need to create 4 plots (2x2)
par(mfcol = c(2, 2))

##plot 4 scatterplots
with(df, {
     #global active power over date-time
     plot(Date_time, Global_active_power, type = "l",
          xlab = "", ylab = "Global Active Power")
     #energy sub metering 1,2,3 over date-time
     plot(Date_time, Sub_metering_1, type = "l",
          xlab = "", ylab = "Energy sub metering")
     lines(Date_time, Sub_metering_2, col = "red")
     lines(Date_time, Sub_metering_3, col = "blue")
     legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n",
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     #voltage over date-time
     plot(Date_time, Voltage, type = "l",
          xlab = "datetime", ylab = "Voltage")
     #global reactive power over date-time
     plot(Date_time, Global_reactive_power, type = "l",
          xlab = "datetime", ylab = "Global_reactive_power")
})

##close the png device to save the file
dev.off()
