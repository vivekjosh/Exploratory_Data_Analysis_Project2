library(plyr)
library(ggplot2)
library(reshape2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_Baltimore <- subset(NEI,NEI$fips == "24510")
result <- SCC[ grep("Vehicles",SCC$EI.Sector ) , ]
MotorData  <-  NEI[NEI_Baltimore$SCC %in% result$SCC, ]
v1_Baltimore<-ddply(MotorData,.(year),summarise,tot=sum(Emissions))


NEI_LA <- subset(NEI,NEI$fips == "06037")
result_2 <- SCC[ grep("Vehicles",SCC$EI.Sector ) , ]
MotorData_2  <-  NEI[NEI_LA$SCC %in% result_2$SCC, ]
v1_LA<-ddply(MotorData_2,.(year),summarise,tot=sum(Emissions))


type_sources <- data.frame(v1_Baltimore$year,v1_Baltimore$tot,v1_LA$tot)
colnames(type_sources) <- c("Year","Baltimore","LA")
type_sources

type_sources_long <- melt(type_sources, id="Year")
type_sources_long
colnames(type_sources_long) <- c("Year","City","Emission_Value")

png("plot6.png", width=480, height=480)

ggplot(data=type_sources_long,
       aes(x=Year, y=Emission_Value, colour=City)) +
  geom_line()
dev.off()


