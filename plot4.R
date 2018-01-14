#######################  R Code for produding the Plot 3 and copy in png file ####################

getwd()
#set your working directory if you want to save your work and data in some other location

datafile <- "./Data_HPC/household_power_consumption.txt"

## Reading and subsetting the Power cosumption data 
data <- read.table(datafile, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = '.', na.strings = "?" )

data = data[data$Date %in% c("1/2/2007","2/2/2007"),]
View(data)
names(data)
str(data)

### Transforming the Date and adding a new variable datatime (combination of Date and Time) 
data$Date <- as.Date(data$Date, format= "%d/%m/%Y")
data$datetime <- as.POSIXct(strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S"))


# Creating the png file, plotting the multiple plots of global active power, sub metering type 1/2/3 and global reactive power against datetime and closing the png file
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow= c(2,2)) #2 rows and 2 columns

# 1st graph
with(data, plot(datetime,Global_active_power,type= "l", xlab="", ylab = "Global Active Power"))

# 2nd graph
with(data, plot(datetime,Voltage, type ="l"))
 
#3rd graph
with(data,plot(datetime,Sub_metering_1,type="l", xlab = "", ylab = "Energy sub metering"))
lines(data$datetime,data$Sub_metering_2,type="l", col="red")
lines(data$datetime,data$Sub_metering_3,type = "l", col = "blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty ="n", pt.cex = 2)
# bty is set as n to remove teh border of the legend box

#4th graph
with(data, plot(datetime,Global_reactive_power, type ="l"))

dev.off()

