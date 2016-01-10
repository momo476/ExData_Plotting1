## This code loads dplyr libraries
## The data file is then imported and the column classes set
## The table is converted into tbl_df format and filtered so that the data is ready to be plotted


library(dplyr)  ##load dplyr library

plotdata <- read.table("household_power_consumption.txt",sep=";", header = TRUE, colClasses = "character") ##Reads in data file
plotdata_2 <- mutate_each(plotdata,funs(as.numeric),-(1:2))
plotdata_2 <- mutate(plotdata_2, Date = as.Date(Date, "%d/%m/%Y"))
plotdatadf <- tbl_df(plotdata_2) ##converts data frame to tbl_df

plotdatadf2_filtered <- filter(plotdatadf,Date == "2007-02-01" | Date == "2007-02-02")  ##Filter out relevant dates

##Save to png file format
png("plot1.png", width = 480, height = 480)


hist(plotdatadf2_filtered$Global_active_power, col= "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")  ##plots the graph


dev.off()

  