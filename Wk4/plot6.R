library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

sub <- NEI[NEI$type == "ON-ROAD" & NEI$fips %in% c("24510", "06037"),] %>%
    group_by(fips, year) %>%
    summarise(Emissions = sum(Emissions))

sub$fips[sub$fips == "24510"] <- "Baltimore"
sub$fips[sub$fips == "06037"] <- "Los Angeles"

##open a png device
png(filename = "plot6.png")

g <- ggplot(sub, aes(year, Emissions)) +
    facet_grid(.~fips) + geom_point() + geom_line() +
    scale_x_continuous(breaks = c(1999, 2002, 2005, 2008)) +
    labs(x = "Year") + labs(y = "PM2.5 Emissions (in tons)") +
    labs(title = "PM2.5 Emissions from Motor Vehicle Sources [1999-2008]")

print(g)

##close the png device to save the file
dev.off()
