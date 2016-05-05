### plot1.R
## Have total emissions from PM2.5 decreased in the United States from 1999 to 
## 2008? Using the base plotting system, make a plot showing the total PM2.5 
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.
    library(tidyr)
    library(dplyr)
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    NEI$sourcetype <- as.character(SCC$EI.Sector[match(NEI$SCC, SCC$SCC)])
    
    plot1df <- NEI %>% group_by(year) %>% summarise(sum(Emissions))
    png(filename = "plot1.png")
    plot(plot1df, type = "l", main = "Total PM2.5 Emissions in the United States")
    dev.off()