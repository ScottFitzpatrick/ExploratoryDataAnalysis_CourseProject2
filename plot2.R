### plot2.R
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
## plot answering this question.
    library(tidyr)
    library(dplyr)
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    NEI$sourcetype <- as.character(SCC$EI.Sector[match(NEI$SCC, SCC$SCC)])
    
    plot2df <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarise(sum(Emissions))
    png(filename = "plot2.png")
    plot(plot2df, type = "l", main = "Total PM2.5 Emissions in Baltimore City")
    dev.off()