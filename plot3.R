fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "household_power_consumption.zip")

gem <- "\\b1/2/2007\\b|\\b2/2/2007\\b"

temp <- sub(";", " ", grep(gem, readLines(con = unz("household_power_consumption.zip", "household_power_consumption.txt")), value = TRUE))

col_names <- c("datetime", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

hh_power_cons2 <- data.frame(do.call(rbind, strsplit(temp, ";", fixed=TRUE)), stringsAsFactors = FALSE)

hh_power_cons2$X1 <- strptime(hh_power_cons2$X1, format = "%d/%m/%Y %H:%M:%S", tz = "UTC")

options(digits = 6)

hh_power_cons2[, c(2:8)] <- sapply(hh_power_cons2[, c(2:8)], as.numeric())

colnames(hh_power_cons2) <- col_names

png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
plot(hh_power_cons2$datetime, hh_power_cons2$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = " ", col = "black")
lines(hh_power_cons2$datetime, hh_power_cons2$Sub_metering_2,col="red")
lines(hh_power_cons2$datetime, hh_power_cons2$Sub_metering_3,col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), cex = 0.8)
dev.off()