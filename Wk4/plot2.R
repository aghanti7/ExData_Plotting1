library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

totPm25OverYearsBalt <- NEI[NEI$fips == "24510",] %>%
                        group_by(year) %>%
                        summarise(Emissions = sum(Emissions))

##open a png device
png(filename = "plot2.png")

with(totPm25OverYearsBalt,
     plot(year, Emissions, type = "b", xlab = "Year",
          pch = 19, xaxt = "n",
          ylab = "PM2.5 Emissions (in tons)",
          main = "PM2.5 Emissions in Baltimore [1999-2008]"))
axis(1, at = c(1999, 2002, 2005, 2008))

##close the png device to save the file
dev.off()
