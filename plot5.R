library(ggplot2)

## Move files to directory to read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 5 How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# unique(SCC[grepl("vehicle|road",SCC$EI.Sector, ignore.case=TRUE),]$EI.Sector)
data_sector <- SCC[grepl("mobile",SCC$EI.Sector, ignore.case=TRUE),]
scc_list <- data_sector[grep("vehicle",data_sector$SCC.Level.Two, ignore.case=TRUE),]

filteredSCC <- SCC[scc_list$SCC,]$SCC
filteredNEI <- NEI[NEI$SCC %in% filteredSCC,]
filteredNEI$year <- as.factor(filteredNEI$year)
baltimore <- subset(filteredNEI, fips=="24510")
agg <- aggregate(Emissions~year, filteredNEI, sum)

png("plot5.png", width=480, height=480)
ggplot(data=agg, aes(y=Emissions/10^6, x=year)) + 
  geom_bar(stat="identity") +
  ggtitle("Total PM2.5 Emissions - Baltimore City, MD", subtitle = "By Motor Vehicles") +
  labs(x = "Year", y = "PM2.5 Emissions (10^6 Tons)")
dev.off()