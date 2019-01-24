#plot4.r

#data
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
png(filename = "plot4.png",
	height = 480,
	width = 480,
	units = "px")

#set grid to layout plots in.
par(mfrow = c(2,2))

with(selected_days,
     plot(dt, 
          Global_active_power, 
          ylab = "Global Active Power(Kilowatts)",
          type = "l"))
with(selected_days,
     plot(dt,
          Voltage,
          xlab = "datetime",
          type = "l"))
with(selected_days,
     plot(dt,
          Sub_metering_1,
          ylab = "Energy sub metering",
          type = "n"))
with(selected_days,
     lines(dt, Sub_metering_1, col = "black"))
with(selected_days,
     lines(dt, Sub_metering_2, col = "red"))
with(selected_days,
     lines(dt, Sub_metering_3, col = "blue"))
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n",
       cex = 0.85)

with(selected_days,
     plot(dt,
          Global_reactive_power,
          type = "l"
          ))

dev.off()