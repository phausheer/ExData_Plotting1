### *********************************************************************************
### Paul R. Hausheer
### Jan 2016
### Local Location -  C:\Users\p622403\gitEDA\EDA_PlottingW1
### File Name - EDAWeek1plot2.R 
### *********************************************************************************
runWeek1Plot2 <- function() {
  setwd("C:\\Users\\p622403\\gitEDA\\EDA_PlottingW1")
  print(getwd())
  strFileNa <- "./data/household_power_consumption.txt"
  print(paste0("Reading File:", strFileNa) )
  dfData <- read.table(strFileNa, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
  require("dplyr")
  require("sqldf")
  
  print("Selecting ONLY 2 days of data" )
  df2Days <- filter(dfData, Date %in% c("1/2/2007","2/2/2007"))
  print(paste0("number of rows:", nrow(df2Days)))
  
  print("Selecting ONLY 3 columns of data" )
  df3 <- sqldf("select Date, Time,  Global_active_power from df2Days")
  print(paste("     number of rows df3:", nrow(df3)))
  print(paste("     number of colss df3:", ncol(df3)))
  print(colnames(df3) )
  # View(vcNames)
  
  print("Fixing the column data types" )
  df3$Global_active_power <- as.numeric(df3$Global_active_power)
  df3$datetimeX <- strptime(paste(df3$Date, df3$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
  df3$dateDate <-  as.Date(df3$Date, format = "%d/%m/%Y")
  # df3$dateTime <-  as.Date(df3$Time, format = "%H:%M:%S")
  df3$PosixltDate <- strptime(df3$dateDate,  "%Y-%m-%d") 
  df3$PosixltTime <- strptime(df3$Time, "%H:%M:%S")
  df3 <- mutate(df3, dateAndTime = paste(Date, Time, sep = ' '))
  df3$PosixltDateTime <- strptime(df3$dateAndTime, format="%d/%m/%Y %H:%M:%S") 
  
  # View(colnames(df3))
  str(df3)
  print(df3[2:5,])
  # subSetData <- data[data$ ,]
  
  #str(subSetData)
  png("plot2.png", width=480, height=480)
  plot(df3$PosixltDateTime, df3$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  dev.off()
}

