# Use Tidyverse for this project
library(tidyverse)

# --- Plot. 1 Single Histogram ---

# After inspecting first 10 rows of the data using readLines, delim of the file is ";" and Date is in format dd/mm/YYYY.
df <- read_delim("household_power_consumption.txt",delim = ";",na="?") %>%
  mutate(Date = parse_date(Date, format = "%d/%m/%Y")) %>%
  filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))


png(file = "plot1.png", width = 480, height = 480)
hist(df$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red", border = "black")
dev.off()