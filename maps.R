#########

# Maps

#########

library(dplyr)
library(tidyverse)
library(readxl)
library(ggplot2)
library(usmap)
library(patchwork)
library(scales)

#read in datasets

maps.all <- read_excel("//cdc.gov/project/CCID_NCPDCID_NHSN_SAS/Data/work/_Projects/LTC/COVID-19/Codes/Jason/Mary_Projects/booster_maps/mapall_0915.xlsx")
maps.ltc <- read_excel("//cdc.gov/project/CCID_NCPDCID_NHSN_SAS/Data/work/_Projects/LTC/COVID-19/Codes/Jason/Mary_Projects/booster_maps/map_ltc0915.xlsx")
maps.acute <- read_excel("//cdc.gov/project/CCID_NCPDCID_NHSN_SAS/Data/work/_Projects/LTC/COVID-19/Codes/Jason/Mary_Projects/booster_maps/map_acute0915.xlsx")

# Creating Scale Interval Points
maps.all$bin1 <- cut(maps.all$percentflu, breaks = c(0, 0.45, 0.6, 0.75, 0.9, 1))
maps.all$bin2 <- cut(maps.all$percentutd, breaks = c(0,0.1, 0.2, 0.3, 0.4, 0.5))
maps.ltc$bin3 <- cut(maps.ltc$percentflu, breaks = c(0, 0.45, 0.6, 0.75, 0.9, 1))
maps.ltc$bin4 <- cut(maps.ltc$percentutd, breaks = c(0,0.1, 0.2, 0.3, 0.4, 0.5))
maps.acute$bin5 <- cut(maps.acute$percentflu, breaks = c(0, 0.45, 0.6, 0.75, 0.9, 1))
maps.acute$bin6 <- cut(maps.acute$percentutd, breaks = c(0,0.1, 0.2, 0.3, 0.4, 0.5))


######################
#  All Facilites
######################

mapa <- plot_usmap(data = maps.all, values = "bin1", color = "black") + 
  labs(title = "Percent Flu - All Facilities") +
  scale_fill_brewer(
    palette = "Blues",
    aesthetics = "fill",
    na.value = "grey50",
    drop = FALSE
  ) + theme(legend.position = "null") +
  ggeasy::easy_center_title()

mapa


mapb <- plot_usmap(data = maps.all, values = "bin2", color = "black") + 
  labs(title = "COVID-19 UTD coverage - All Facilities") +
  scale_fill_brewer(
    palette = "Greys",
    aesthetics = "fill",
    na.value = "grey50",
    drop = FALSE
  ) + theme(legend.position = "null")
ggeasy::easy_center_title()

mapb



######################
#  LTC Facilites
######################

mapc <- plot_usmap(data = maps.ltc, values = "bin3", color = "black") +
  labs(title = "Percent Flu - LTC") +
  scale_fill_brewer(name = "% Flu",
    labels = c("0.0%-44.9%","45.0%-59.9%","60.0%-74.9%","75.0%-89.9%","\u226590.0%"),
    palette = "Blues",
    breaks = levels(maps.ltc$bin3),
    aesthetics = "fill",
    na.value = "grey50",
    drop = FALSE
  ) + theme(legend.position = "left") +
ggeasy::easy_center_title()

mapc



mapd <- plot_usmap(data = maps.ltc, values = "bin4", color = "black") + 
  labs(title = "COVID-19 UTD coverage - LTC") +
  scale_fill_brewer(name = "% UTD Booster",
    labels = c("0.0%-0.9%","10.0%-19.9%","20.0%-29.9%","30.0%-39.9%","\u226540.0%"),
    palette = "Greys",
    breaks = levels(maps.ltc$bin4),
    aesthetics = "fill",
    na.value = "grey50",
    drop = FALSE
  ) + theme(legend.position = "right")+
  ggeasy::easy_center_title()

mapd



######################
#  Acute Facilites
######################

mape <- plot_usmap(data = maps.acute, values = "bin5", color = "black") + 
  labs(title = "Percent Flu - ACH") +
  scale_fill_brewer(
    palette = "Blues",
    aesthetics = "fill",
    na.value = "grey50",
    drop = FALSE
  ) + theme(legend.position = "null") +
ggeasy::easy_center_title()


mape

mapf <- plot_usmap(data = maps.acute, values = "bin6", color = "black") + 
  labs(title = "COVID-19 UTD coverage - ACH") +
  scale_fill_brewer(
    palette = "Greys",
    aesthetics = "fill",
    na.value = "grey50",
    drop = FALSE
  ) + theme(legend.position = "null") +
ggeasy::easy_center_title()

mapf

# Panels Using Patchwork 
mapa + mapb + mapc + mapd + mape + mapf + plot_layout(nrow = 3, byrow = TRUE)




