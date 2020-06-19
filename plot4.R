# Use Tidyverse for this project
library(tidyverse)
library(lubridate)

# --- Plot. 4 multichannel plot ---

# After inspecting first 10 rows of the data using readLines, delim of the file is ";" and Date is in format dd/mm/YYYY.
df <- read_delim("household_power_consumption.txt",delim = ";",na="?") %>%
  mutate(Date = parse_date(Date, format = "%d/%m/%Y")) %>%
  filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Convert date + time into DateTime for plotting
# Using lubridate function
df <- df %>%
  mutate(datetime = ymd_hms(paste(Date, Time)))
png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

# Plot (1,1) - copied from plot2.R
plot(x = df$datetime, y = df$Global_active_power, type = "l",
     xlab = NA,
     ylab = "Global Active Power (kilowatts)")

# Plot (1,2) - just change y-axis to Voltage
plot(x = df$datetime, y = df$Voltage, type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Plot (2,1) - copied from plot3.R
df2 <- df %>%
  select(datetime, Sub_metering_1, Sub_metering_2, Sub_metering_3) %>%
  pivot_longer(contains("Sub_metering"), names_to = "meter", values_to = "power")
with(df2, plot(datetime, power, type = "n",
              xlab = NA, ylab = "Energy sub metering"))
with(df2 %>% filter(meter == "Sub_metering_1"), lines(datetime,power, col = "black"))
with(df2 %>% filter(meter == "Sub_metering_2"), lines(datetime,power, col = "red"))
with(df2 %>% filter(meter == "Sub_metering_3"), lines(datetime,power, col = "blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1, lwd = 1, bty = "n")

# Plot (2,2) - similar to Plot (1,2), just change y-axis to reactive power
plot(x = df$datetime, y = df$Global_reactive_power, type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()