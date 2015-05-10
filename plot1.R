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
#start Plotting
png(filename="plot1.png", width=480, height=480)
hist(pwr_data$Global_active_power, main="Global Active Power",
          xlab="Global Active Power (kilowatts)", col="red")
dev.off()
