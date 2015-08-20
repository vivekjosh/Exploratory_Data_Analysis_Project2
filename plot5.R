library(plyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_Baltimore <- subset(NEI,NEI$fips == "24510")

result <- SCC[ grep("Vehicles",SCC$EI.Sector ) , ]

MotorData  <-  NEI[NEI_Baltimore$SCC %in% result$SCC, ]
v1<-ddply(MotorData,.(year),summarise,tot=sum(Emissions))


png("plot5.png", width=480, height=480)
plot(v1$year,v1$tot,type="l",
     xlab="Year", ylab=expression("Total Motor" ~ "Emissions (tons)"),
     main=expression("Total Motor"  ~ "Emissions in Baltimore by Year"))
dev.off()