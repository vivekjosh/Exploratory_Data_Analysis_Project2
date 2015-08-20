library(plyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

result <- SCC[ grep("Coal",SCC$EI.Sector ) , ]
CoalData  <-  NEI[NEI$SCC %in% result$SCC, ]
v1<-ddply(CoalData,.(year),summarise,tot=sum(Emissions))
v1
png("plot4.png", width=480, height=480)
plot(v1$year,v1$tot,type="l",
     xlab="Year", ylab=expression("Total Coal" ~ "Emissions (tons)"),
     main=expression("Total Coal"  ~ "Emissions by Year"))
dev.off()