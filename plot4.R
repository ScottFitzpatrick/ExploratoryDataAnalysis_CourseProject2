### plot4.R
## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999-2008?
    library(tidyr)
    library(dplyr)
    library(ggplot2)
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    NEI$sourcetype <- as.character(SCC$EI.Sector[match(NEI$SCC, SCC$SCC)])
    
    plot4df <- NEI %>% filter(grepl("Coal", sourcetype)) %>% group_by(year) %>% summarise(totalemissions = sum(Emissions))
    p <- ggplot(plot4df, aes(year, totalemissions)) + geom_line() + 
        labs(title = "Total PM2.5 Emissions in the United States from Coal Combustion-Related Sources")
    ggsave(filename = "plot4.png", plot = p)