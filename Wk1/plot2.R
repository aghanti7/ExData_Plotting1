##
##plot2.R -- outputs plot2.png in current directory
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
png(filename = "plot2.png", width = 480, height = 480, units = "px")

##plot a scatterplot of global active power over date-time
with(df, plot(Date_time, Global_active_power, type = "l",
              xlab = "", ylab = "Global Active Power (kilowatts)"))

##close the png device to save the file
dev.off()
