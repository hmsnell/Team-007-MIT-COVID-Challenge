library(tidyverse)
# load libraries
library(dplyr)
library(rgdal)
library(ggplot2)
library(leaflet)
library(ggmap)
# set factors to false
options(stringsAsFactors = FALSE)

cvs <- read.csv("cvsaddress.txt", header=F)
colnames(cvs) <- c("address1", "city", "statezip")
head(cvs)
cvs.data <- mutate(cvs, zipcode = trimws(substr(statezip, 4, 9)))
head(cvs.data)

require(zipcode)
data(zipcode)
cvs.zips <- merge(cvs.data, zipcode, by.x='zipcode', by.y='zip')

cvs_locations_df <- as.data.frame(cvs.zips)
cvs_CA_locations_df <- cvs_locations_df[cvs_locations_df$state=="CA",]

register_google(key="AIzaSyD-eVdSIEHkvdlM7VzczauC6ho0LDl8BKo")
cvs_CA_locations_df <- mutate(cvs_CA_locations_df, address=paste(address1, city.x, statezip, sep=" "), exact_lat=geocode(address,output="latlona", source="google")$lat, exact_lon=geocode(address,output="latlona", source="google")$lon)
