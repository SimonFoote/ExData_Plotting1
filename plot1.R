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
png(filename = "plot1.png", width = 480, height = 480, units = "px")

## Plot to Histogram
with(data, hist(Global_active_power, col="red", main="Global Active Power", 
                xlab = "Global Active Power (kilowatts)"))

## Close Graphics Device
dev.off()