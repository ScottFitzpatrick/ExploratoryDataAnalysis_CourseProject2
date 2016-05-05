### plot5.R
## How have emissions from motor vehicle sources changed from 1999-2008 in 
## Baltimore City?
    library(tidyr)
    library(dplyr)
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    NEI$sourcetype <- as.character(SCC$EI.Sector[match(NEI$SCC, SCC$SCC)])
    
    plot5df <- NEI %>% filter(fips == "24510" & grepl("On-Road", sourcetype)) %>% group_by(year) %>% summarise(sum(Emissions))
    png(filename = "plot5.png")
    plot(plot5df, type = "l", main = "Total PM2.5 Emissions in Baltimore City from Motor Vehicle Sources")
    dev.off()