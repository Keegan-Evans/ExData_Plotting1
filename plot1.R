#plot1.R

#estimate size of file 
estimated_size <- 2075259 * 9 * 8
estimated_mb <- estimated_size/2^20
estimated_mb

#read in data

alldata <- data.frame(data.table::fread("household_power_consumption.txt",
							header = TRUE,
							sep = ";"))
					
#fix na values from "?" to NA
alldata[alldata == "?"] <- NA

#add variables to hold start and end_date days
begin_date <- strptime("2007-02-01", format = "%Y-%m-%d")
end_date <- strptime("2007-02-03", format = "%Y-%m-%d")

#create datetime column from date and time
alldata$datetime <- strptime(paste(alldata$Date, alldata$Time), 
							format = "d/%m/%Y %H:%M:%S")
alldata$dt <- strptime(paste(alldata$Date, alldata$Time), format = "%d/%m/%Y %H:%M:%S")
			

#remove date and time columns, change type for others from character to numeric
alldata[,3:9] <- lapply(alldata[, 3:9], as.numeric)
alldata <- alldata[,-c(1,2)]

#subset to get only the selected days
selected_days <- subset(alldata, 
						alldata$dt >= begin_date & alldata$dt < end_date)
						
#now plot the graph
#png graphics device
png(filename = "plot1.png",
	width = 480,
	height = 480,
	units = "px")
#plot
hist(selected_days$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power(kilowatts)",
     col = "red")
#close device
dev.off()



