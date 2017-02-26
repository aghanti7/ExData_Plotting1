library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coalSources <- SCC[grep("coal", SCC$Short.Name, ignore.case = TRUE), ]

neiCoal <- NEI[NEI$SCC %in% coalSources$SCC, ]

neiCoalOverYears <- neiCoal %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))

##open a png device
png(filename = "plot4.png")

g <- ggplot(neiCoalOverYears, aes(year, Emissions)) +
    geom_line() + geom_point() +
    scale_x_continuous(breaks = c(1999, 2002, 2005, 2008)) +
    labs(x = "Year") +
    labs(y = "PM2.5 Emissions (in tons)") +
    labs(title = "PM2.5 Emissions From Coal Combustion Related Sources [1999-2008]")

print(g)

##close the png device to save the file
dev.off()
