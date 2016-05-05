### plot3.R
## Of the four types of sources indicated by the type (point, nonpoint, onroad, 
## nonroad) variable, which of these four sources have seen decreases in 
## emissions from 1999-2008 for Baltimore City? Which have seen increases in 
## emissions from 1999-2008? Use the ggplot2 plotting system to make a plot 
## answer this question.
    library(tidyr)
    library(dplyr)
    library(ggplot2)
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    NEI$sourcetype <- as.character(SCC$EI.Sector[match(NEI$SCC, SCC$SCC)])
    
    plot3df <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>% summarise(totalemissions = sum(Emissions))
    p <- ggplot(plot3df, aes(year, totalemissions)) + geom_line(aes(col = type)) + 
        labs(title = "Total PM2.5 Emissions in Baltimore City by Type")
    ggsave(filename = "plot3.png", plot = p)
