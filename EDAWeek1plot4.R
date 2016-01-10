### *********************************************************************************
### Paul R. Hausheer
### Jan 2016
### Local Location -  C:\Users\p622403\gitEDA\EDA_PlottingW1
### File Name - EDAWeek1plot4.R 
### *********************************************************************************
runWeek1Plot4 <- function() {
  strFileNa <- "./data/household_power_consumption.txt"
  ##########################################################
  print(paste0("Reading File:", strFileNa) )
  ##########################################################
  dfData <- read.table(strFileNa, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
  require("dplyr")
  require("sqldf")
  
  ##########################################################
  print("Selecting ONLY 2 days of data" )
  ##########################################################
  dfFilter <- filter(dfData, Date %in% c("1/2/2007","2/2/2007"))
  print(paste0("number of rows:", nrow(dfFilter)))
  
  ##########################################################
  print("Selecting ONLY 6 columns of data" )
  ##########################################################
  dfSelectCols <- sqldf("select Date||Time as strBoth, Sub_metering_1, Sub_metering_2, Sub_metering_3, Global_active_power, Global_reactive_power, Voltage from dfFilter")
  print(paste("     number of rows dfSelectCols:", nrow(dfSelectCols)))
  print(paste("     number of colss dfSelectCols:", ncol(dfSelectCols)))

  ##########################################################
  print("Fixing the column data types" )
  ##########################################################
  dfSelectCols$Global_active_power <- as.numeric(dfSelectCols$Global_active_power)
  dfSelectCols$Global_reactive_power <- as.numeric(dfSelectCols$Global_reactive_power)
  dfSelectCols$Voltage <- as.numeric(dfSelectCols$Voltage)
  dfSelectCols$Sub_metering_1 <-  as.numeric(dfSelectCols$Sub_metering_1)
  dfSelectCols$Sub_metering_2 <-  as.numeric(dfSelectCols$Sub_metering_2)
  dfSelectCols$Sub_metering_3 <-  as.numeric(dfSelectCols$Sub_metering_3)
  dfSelectCols$PosixltDateTime <- strptime(dfSelectCols$strBoth, format="%d/%m/%Y %H:%M:%S") 
  
  ##########################################################
  ### Debug viewing and double check
  ##########################################################
  # View(colnames(df3))
  # str(dfSelectCols)
  # print(dfSelectCols[12:15,])
  # subSetData <- data[data$ ,]
  
  ##########################################################
  print("Plot and save to file device" )
  ##########################################################
  png("plot4.png", width=480, height=480)
  par(mfrow=c(2,2) )
  with(dfSelectCols, {
    ### Plot2
    plot(dfSelectCols$PosixltDateTime, dfSelectCols$Global_active_power, type="l", xlab="", ylab="Global Active Power")
    ### Plot2A
    plot(dfSelectCols$PosixltDateTime, dfSelectCols$Voltage, type="l", xlab="datetime", ylab="Voltage")
    ### Plot3
    plot(dfSelectCols$PosixltDateTime, dfSelectCols$Sub_metering_1, type="l", xlab="", ylab="Energy Sub metering")
    lines(dfSelectCols$PosixltDateTime, dfSelectCols$Sub_metering_2, type="l", col="red")
    lines(dfSelectCols$PosixltDateTime, dfSelectCols$Sub_metering_3, type="l", col="blue")
    vcLegendColors <- c("black", "blue","red")
    vcLegendKey <- c("Sub_metering_1", "Sub_metering_1", "Sub_metering_3")
    legend("topright",  col=vcLegendColors, lty=c(1,1,1), legend=vcLegendKey)
    ### Plot4
    plot(dfSelectCols$PosixltDateTime, dfSelectCols$Global_reactive_power, type="l", xlab="datetime", ylab="Globalreactive_power")
    
  })
  
  
  dev.off()
}
