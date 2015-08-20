
library(plyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
v <-ddply(NEI,.(year),summarise,tot=sum(Emissions))
png("plot1.png", width=480, height=480)
plot(v$year,v$tot,type="l",
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()

