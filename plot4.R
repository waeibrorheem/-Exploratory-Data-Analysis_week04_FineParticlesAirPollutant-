library(dplyr)
library(ggplot2)

## Move files to directory to read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 4 Across the United States, how have emissions from coal combustion-related sources 
#   changed from 1999–2008?

# How relevant columns were determined:
# data only exists for "coal" in the third and fourth level and Sector
# since levels go from generic to specific, we choose to filter
# short name by combustion and four as coal (there are other types of combustion than coal)
data_comb_coal_short_nm <- SCC[grepl("coal|comb",SCC$Short.Name, ignore.case=TRUE),]
scc_list <- data_comb_coal_short_nm[grepl("coal",data_comb_coal_short_nm$SCC.Level.Four, ignore.case=TRUE),]

# see which short names we filtered out the second time
# d <- setdiff(data_comb_coal_short_nm, scc_list)
# unique(d$Short.Name)

filteredSCC <- SCC[scc_list$SCC,]$SCC
filteredNEI <- NEI[NEI$SCC %in% filteredSCC,]
filteredNEI$year <- as.factor(filteredNEI$year)
agg <- aggregate(Emissions~year, filteredNEI, sum)

png("plot4.png", width=480, height=480)
ggplot(data=agg, aes(y=Emissions/10^6, x=year)) + 
  geom_bar(stat="identity") +
  ggtitle("Total PM2.5 Emissions - All United States", subtitle = "By Coal Comsumption") +
  labs(x = "Year", y = "PM2.5 Emissions (10^6 Tons)")+
  scale_y_continuous(breaks=seq(0,0.6,by=0.1), limits=c(0,0.6)) 
dev.off()