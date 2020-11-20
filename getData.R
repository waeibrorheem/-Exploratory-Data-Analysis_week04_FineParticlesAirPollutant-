# Peer Graded Assignment: Exploratory Data Analysis Course Project 2 (week 4)
# https://github.com/merlotpa/Exploratory-Data-Analysis_week04_FineParticlesAirPollutant

setwd("F:/Data raw/Exploratory-Data-Analysis_week04_FineParticlesAirPollutant-")

getData <- function() {
  mainDir <- getwd()
  rawDir <- paste(mainDir, "rawData", sep = "/")
  
  ## DOWNLOAD THE DATASET (if not there already)
  destfile <- file.path(paste(rawDir, "exdata_data_NEI_data.zip", sep = "/"))
  if(!file.exists(destfile)){
    dir.create(file.path(rawDir))
    setwd(file.path(rawDir))
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    res <- tryCatch(download.file(url, destfile),
                    error=function(e) 1)
  }
  unzip("exdata_data_NEI_data.zip", exdir = "./")
  dir()
  setwd(file.path(mainDir))
  dataDir <- rawDir
  
  
  ## READ THE FILES
  ### This first line will likely take a few seconds. Be patient!
  if(!exists("NEI")){
    NEI <- readRDS(paste(rawDir, "summarySCC_PM25.rds", sep = "/"))
  }
  if(!exists("SCC")){
    SCC <- readRDS(paste(rawDir, "Source_Classification_Code.rds", sep = "/"))
  }
}