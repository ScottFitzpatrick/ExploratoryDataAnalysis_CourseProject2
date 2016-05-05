### plot6.R
## Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in Los Angeles County, California 
## (fips == "06037"). Which city has seen greater changes over time in motor 
## vehicle emissions?
    library(tidyr)
    library(dplyr)
    library(ggplot2)
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    NEI$sourcetype <- as.character(SCC$EI.Sector[match(NEI$SCC, SCC$SCC)])
    
    plot6df <- NEI %>% filter(fips == "24510" | fips == "06037") %>% filter(grepl("On-Road", sourcetype)) %>% 
        group_by(year, fips) %>% summarise(totalemissions = sum(Emissions)) %>% 
        mutate(county = ifelse(fips == "06037", "LosAngeles", "BaltimoreCity"))
    p <- ggplot(plot6df, aes(year, totalemissions)) + geom_line(aes(col = county)) + 
        labs(title = "Total PM2.5 Emissions from Motor Vehicle Sources by County")
    ggsave(filename = "plot6.png", plot = p)
