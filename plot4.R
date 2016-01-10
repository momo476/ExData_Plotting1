## This code loads lubridate and dplyr libraries
## The data file is then imported and the column classes set
## The table is converted into tbl_df format and filtered so that the data is ready to be plotted

## load libridate and dplyr libraries
library(lubridate)
library(dplyr)

## Reads intable and converts the table into a dataframe
## Updates column variable types and then filters data to 2007-02-01 and 2007-02-02

plotdata <- read.table("household_power_consumption.txt",sep=";", header = TRUE)
plotdata_2 <- mutate_each(plotdata,funs(as.numeric),-(1:2))
plotdata_2 <- mutate(plotdata_2, Date = as.Date(Date, "%d/%m/%Y"))
plotdatadf <- tbl_df(plotdata_2) ##converts data frame to tbl_df

plotdatadf2_filtered <- filter(plotdatadf,Date == "2007-02-01" | Date == "2007-02-02")  ##Filter out relevant dates


## The following code creates a new column named timestamp, where date and time are combined
## timestamp values are then converted into datetime variable

plotdatadf2_filtered <- mutate(plotdatadf2_filtered,timestamp = format(as.POSIXct(paste(Date,Time)),"%Y/%m/%d %H:%M:%S"))
plotdatadf2_filtered <- mutate(plotdatadf2_filtered,timestamp = ymd_hms(timestamp))

## Plots charts in a 2x2 matrix
par(mfrow = c(2, 2))


## Plots to be plotted

##1
with(plotdatadf2_filtered, plot(timestamp,Global_active_power,ylab = "Global Active Power", xlab = NA, type= "l"))

##2
with(plotdatadf2_filtered, plot(timestamp,Voltage,xlab = "datetime", type= "l"))

##3
with(plotdatadf2_filtered, plot(timestamp, Sub_metering_1, type = "l", xlab = NA, ylab = "Energy sub metering"))
with(plotdatadf2_filtered, lines(timestamp, Sub_metering_2, type = "l", col = "red"))
with(plotdatadf2_filtered, lines(timestamp, Sub_metering_3, type = "l", col = "blue"))
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black","red","blue"), ncol =1)

##4
with(plotdatadf2_filtered, plot(timestamp,Global_reactive_power,ylab = "Global Rective Power", xlab = "datetime", type= "l"))


##Save to png file format
png("plot3.png", width = 480, height = 480)
