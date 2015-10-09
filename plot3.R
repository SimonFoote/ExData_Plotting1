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
png(filename = "plot3.png", width = 480, height = 480, units = "px")

## Plot to graph
with(data, plot(DateTime, Sub_metering_1, type = "l", xlab = "", 
                ylab = "Energy sub metering"))
with(data, points(DateTime, Sub_metering_2, type = "l", xlab = "", 
                  ylab = "Energy sub metering", col = "red"))
with(data, points(DateTime, Sub_metering_3, type = "l", xlab = "", 
                  ylab = "Energy sub metering", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close Graphics Device
dev.off()