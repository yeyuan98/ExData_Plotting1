# Use Tidyverse for this project
library(tidyverse)
library(lubridate)

# --- Plot. 2 Line only plot for Time ~ GAP ---

# After inspecting first 10 rows of the data using readLines, delim of the file is ";" and Date is in format dd/mm/YYYY.
df <- read_delim("household_power_consumption.txt",delim = ";",na="?") %>%
  mutate(Date = parse_date(Date, format = "%d/%m/%Y")) %>%
  filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Convert date + time into DateTime for plotting
# Using lubridate function
df <- df %>%
  mutate(datetime = ymd_hms(paste(Date, Time)))
png(file = "plot2.png", width = 480, height = 480)
plot(x = df$datetime, y = df$Global_active_power, type = "l",
     xlab = NA,
     ylab = "Global Active Power (kilowatts)")
dev.off()