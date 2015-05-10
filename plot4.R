#Function For reading fileand returning data frame object
file_utl <-function(file_url,working_dir,src_zip_file_name,work_file_name)
{
  #Set the working directory
  setwd(working_dir)
  #check zip file available or not if not then download
  if (!file.exists(src_zip_file_name)) {
    
    retval = download.file(file_url,destfile = src_zip_file_name)
    
  }
  #read file and return object
  df.pwr_consumption <- read.csv(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), header=T,sep=";", stringsAsFactors=F, na.strings="?",colClasses=c("character", "character", "numeric","numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
  return (df.pwr_consumption)
  
}

pwr_data<-file_utl("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","D://Repos//ExData_Plotting1","exdata-data-household_power_consumption.zip","household_power_consumption.txt")
#take data of required date
pwr_data <- pwr_data[pwr_data$Date %in% c("1/2/2007","2/2/2007") ,]
# add date and time 
pwr_data$timestamp = strptime(paste(pwr_data$Date, pwr_data$Time),
                              format="%d/%m/%Y %H:%M:%S", tz="UTC")
#start Plotting

png(filename = "plot4.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")
par(mfrow = c(2, 2))
## Top-left
plot(pwr_data$timestamp, pwr_data$Global_active_power, 
     type = "l",
     xlab = "", ylab = "Global Active Power")
## Top-right
plot(pwr_data$timestamp, pwr_data$Voltage,
     type = "l",
     xlab = "datetime", ylab = "Voltage")
## Bottom-left
plot(pwr_data$timestamp, pwr_data$Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(pwr_data$timestamp, pwr_data$Sub_metering_2, col = "red")
lines(pwr_data$timestamp, pwr_data$Sub_metering_3, col = "blue")
# Remove the border of legend here.
legend("topright", 
       bty = "n",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
## Bottom-right
plot(pwr_data$timestamp, pwr_data$Global_reactive_power, 
     type = "l",
     col = "black",
     xlab = "datetime", ylab = colnames(pwr_data)[4])
dev.off()