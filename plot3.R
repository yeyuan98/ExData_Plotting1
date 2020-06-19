# Use Tidyverse for this project
library(tidyverse)
library(lubridate)

# --- Plot. 3 Sub_metering multichannel line plot ---

# After inspecting first 10 rows of the data using readLines, delim of the file is ";" and Date is in format dd/mm/YYYY.
df <- read_delim("household_power_consumption.txt",delim = ";",na="?") %>%
  mutate(Date = parse_date(Date, format = "%d/%m/%Y")) %>%
  filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Convert date + time into DateTime for plotting
# Using lubridate function
df <- df %>%
  mutate(datetime = ymd_hms(paste(Date, Time)))
png(file = "plot3.png", width = 480, height = 480)

# To plot multichannel data (spanned as multiple columns), let's first combine the three into one column
df <- df %>%
  select(datetime, Sub_metering_1, Sub_metering_2, Sub_metering_3) %>%
  pivot_longer(contains("Sub_metering"), names_to = "meter", values_to = "power")
# Then, let's plot!
with(df, plot(datetime, power, type = "n",
              xlab = NA, ylab = "Energy sub metering"))
with(df %>% filter(meter == "Sub_metering_1"), lines(datetime,power, col = "black"))
with(df %>% filter(meter == "Sub_metering_2"), lines(datetime,power, col = "red"))
with(df %>% filter(meter == "Sub_metering_3"), lines(datetime,power, col = "blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1, lwd = 1)

dev.off()