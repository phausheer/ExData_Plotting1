### *********************************************************************************
### Paul R. Hausheer
### Jan 2016
### Local Location -  C:\Users\p622403\gitEDA\EDA_PlottingW1
### File Name - EDAWeek1plot1.R 
### *********************************************************************************
runWeek1Plot1 <- function() {
  strFileNa <- "./data/household_power_consumption.txt"
  print(paste0("Reading File:", strFileNa) )
  data <- read.table(strFileNa, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
  print(class(data))
  print("Selecting ONLY 2 days" )
  subSetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
  
  #str(subSetData)
  globalActivePower <- as.numeric(subSetData$Global_active_power)
  png("plot1.png", width=480, height=480)
  hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
  dev.off()
}