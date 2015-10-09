## Load required packages
if(!require("dplyr")) {library(dplyr)}

## Load data from text file
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")

## Manipulate Data into desired form
### Subset data to observations between 2007-02-01 and 2007-02-02
### Create a DateTime field
### Select all variables, except old date and time columns
data <- data %>% filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
    mutate(DateTime = as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S")) %>% 
    select(Global_active_power:DateTime)

## Open PNG Graphics Device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## Set par, to create panels
par(mfrow = c(2, 2))

## Plot to graph
# plot 1
with(data, plot(DateTime, Global_active_power, type = "l", 
                ylab = "Global Active Power", xlab = ""))

# plot 2
with(data, plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))

# plot 3
with(data, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", 
     xlab = "", col = "black"))
with(data, points(DateTime, Sub_metering_2, type = "l", xlab = "", 
                  ylab = "Sub_metering_2", col = "red"))
with(data, points(DateTime, Sub_metering_3, type = "l", xlab = "", 
                  ylab = "Sub_metering_3", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

# plot 4
with(data, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power", ylim = c(0, 0.5)))

## Close Graphics Device
dev.off()