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

#print a hist plot as requested
par(bg="transparent")
png(filename= "plot1.png", bg="transparent")
hist(hpc$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
message("'plot1.png' has been generated")
