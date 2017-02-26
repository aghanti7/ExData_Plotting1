##
##plot1.R -- outputs plot1.png in current directory
##

##read the entire data set into a data frame - took about ~10s
##';' separated, '?' as NA
df <- read.table("household_power_consumption.txt", sep = ";",
                 header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

##subset only data for 2007-02-01 and 2007-02-02
df <- df[grep("^[12]/2/2007", df$Date),]

##convert the first column to date format
df[,1] <- as.Date(df[,1], "%d/%m/%Y")


##open a png device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

##plot a histogram of global active power
hist(df$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", col = "red")

##close the png device to save the file
dev.off()
