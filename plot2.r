#plot2.r

#read data in, convert ? to NA, set begin and end dates, create datetime colum
#convert other columns to numeric, subset
alldata <- data.frame(data.table::fread("household_power_consumption.txt",
										header = TRUE,
										sep = ";"))
alldata[alldata == "?"] <- NA

begin_date <- strptime("2007-02-01", format = "%Y-%m-%d")
end_date <- strptime("2007-02-03", format = "%Y-%m-%d")
alldata$dt <- strptime(paste(alldata$Date, alldata$Time), 
						format = "%d/%m/%Y %H:%M:%S")
alldata[,3:9] <- lapply(alldata[,3:9], as.numeric)

selected_days <-subset(alldata, alldata$dt >= begin_date & alldata$dt < end_date)
selected_days <- selected_days[,-c(1,2)]

#graphics device
png(filename = "plot2.png",
	width = 480,
	height = 480,
	units = "px")
	
with(selected_days,
	plot(selected_days$dt, selected_days$Global_active_power,
		type = "l")
		)

#close graphics device
dev.off()
