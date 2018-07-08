library(installr)
library(dplyr)
library(data.table)
files_dir <- download_RStudio_CRAN_data(START = '2018-01-01',
                                        END = '2018-07-01',
                                        log_folder="./dat")

# read and process data
for (i in 1:length(files)){
  file <- files[i]
  cat(paste("Processing", file, "...\n")); flush.console()
  logfile <- read.table(file, header = TRUE, sep = ",", quote = "\"",
                        dec = ".", fill = TRUE, stringsAsFactors = FALSE,
                        comment.char = "", as.is=TRUE)
  
  ## get top 20 downloads per day
  tmp <- logfile %>% group_by(date, package) %>%
    summarize(downloads = n()) %>%
    top_n(20, downloads)
  top_downloads[[i]] <- tmp
}

dat <- rbindlist(top_downloads)
save.image("data.RData")
