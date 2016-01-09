### *********************************************************************************
### Paul R. Hausheer
### Jan 2016
### Local Location -  C:\Users\p622403\gitEDA\EDA_PlottingW1
### File Name - EDAWeek1plot2.R 
### *********************************************************************************
runWeek1Plot2 <- function() {
  strFileNa <- "./data/household_power_consumption.txt"
  print(paste0("Reading File:", strFileNa) )
  dfData <- read.table(strFileNa, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
  require("dplyr")
  require("sqldf")
  
  print("Selecting ONLY 2 days of data" )
  df2Days <- filter(dfData, Date %in% c("1/2/2007","2/2/2007"))
  print(paste0("number of rows:", nrow(df2Days)))
  
  print("Selecting ONLY 2 columns of data" )
  df3 <- sqldf("select Date, Global_active_power from df2Days")
  print(paste0("number of rowsdf3:", nrow(df3)))
  print(paste0("number of colssdf3:", ncol(df3)))
  # vcNames <- colnames(df2Days)
  # View(vcNames)
  df2Days$Global_active_power <- as.numeric(df2Days$Global_active_power)
  df2Days$Date <-  as.Date(df2Days$Date, "%Y-%m-%d")
  df2Days$Time <-  as.Date(df2Days$Time, "%H-%M-%S")
  df2Days2 <- mutate(df2Days, dateAndTime = paste(Date, Time, sep = ' '))
  df2Days2$datetimeX <- strptime(paste(df2Days2$Date, df2Days2$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
  
  # str(df2Days2)
  print(df2Days[1000:1013,])
  # subSetData <- data[data$ ,]
  
  #str(subSetData)
  # png("plot2.png", width=480, height=480)
  # hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
  # dev.off()
}
