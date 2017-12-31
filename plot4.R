#ask the user to select the file 'household_power_consumption.txt'
message("please, provide input file 'household_power_consumption.txt'")
inputfile<-file.choose()

#read a subsetting of the dataset
message("Reading data...")
suppressWarnings(hpc<-read.table(file = inputfile, header = F, sep = ";", na.strings = "?", skip=grep("\\b1/2/2007\\b", readLines("household_power_consumption.txt")), nrows = 48*60))
colnames(hpc)<-c("Date", "Time","Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity","Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#formatting Data and Time variables properly
hpc$Date<-as.Date(hpc$Date, "%d/%m/%Y")
hpc$Time<-as.POSIXct(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S")

#set global graphs parameter
png(filename= "plot4.png", bg="transparent")
par(bg="transparent", mfcol=c(2,2))

#print Plot1: scatterplot 'Global Active'
plot(hpc$Time, hpc$Global_active_power, type ="l", ylab = "Global Active Power (kilowatts)", xlab = NA)

#print Plot2: scatterplot 'Energy Sub metering'
plot(hpc$Time, hpc$Sub_metering_1, type ="l", ylab = "Energy sub metering", xlab = NA)
points(x=hpc$Time, y=hpc$Sub_metering_2, col= "red", type="l")
points(x= hpc$Time, y=hpc$Sub_metering_3, col="blue", type="l")
legend("topright", lty = c(1,1,1), col=c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.col = "transparent" )

#print Plot3: scatterplot 'Voltage'
plot(hpc$Time, hpc$Voltage, type ="l", ylab = "Voltage", xlab="datetime")

#print Plot4: scatterplot 'Global_reactive_power'
plot(hpc$Time, hpc$Global_reactive_power, type ="l", ylab = "Global_reactive_power", xlab="datetime")

#quit from graphic device
dev.off()
message("'plot4.png' has been generated")
