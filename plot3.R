library(plyr)
library(ggplot2)
library(reshape2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_Baltimore <- subset(NEI,NEI$fips == "24510")

type1 <- subset(NEI_Baltimore,NEI_Baltimore$type == "POINT")
type2 <- subset(NEI_Baltimore,NEI_Baltimore$type == "NONPOINT")
type3 <- subset(NEI_Baltimore,NEI_Baltimore$type == "ON-ROAD")
type4 <- subset(NEI_Baltimore,NEI_Baltimore$type == "NON-ROAD")

v1<-ddply(type1,.(year),summarise,tot=sum(Emissions))
v2 <-ddply(type2,.(year),summarise,tot=sum(Emissions))
v3 <-ddply(type3,.(year),summarise,tot=sum(Emissions))
v4 <-ddply(type4,.(year),summarise,tot=sum(Emissions))
type_sources <- data.frame(v1$year,v1$tot,v2$tot,v3$tot,v4$tot)
colnames(type_sources) <- c("Year","Point","NonPoint","ON-ROAD","NON-ROAD")

type_sources_long <- melt(type_sources, id="Year")
colnames(type_sources_long) <- c("Year","Type","Emission_Value")

png("plot3.png", width=480, height=480)

ggplot(data=type_sources_long,ylab = "Sources Type",
       aes(x=Year, y=Emission_Value, colour=Type)) +
  geom_line()


dev.off()

