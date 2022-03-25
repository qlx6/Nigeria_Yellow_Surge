## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## TITLE: Yellow States target consolidation
## AUTHOR: Femi Akinmade (qlx6@cdc.gov)
## CREATION DATE: 10/28/2020
## UPDATE:
## Outputs: Consolidated target dataset for FY 
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library(tidyverse)
library(readxl)
library(tidyr)
library(dplyr)

setwd("~/general dynamics - icpi/datasets/data_ng_yellow/state_submissions/tar")

# == READ XLS FILES FROM SET DIR == #
dir_files <- list.files(pattern = "*xls")
dir_files

# == READ ONLY "target_dct" SHEET FROM DCT == #
FYtar <- lapply(dir_files, function(i){
  x = read_excel(i, sheet = "target_dct")}
)

# == BIND INDIVIDUAL FILES TO ONE DF == #
FYtar <- bind_rows(FYtar)

# == REMOVE EMPTY ROWS == #
# == Regular expressions do not function == #
FYtar <- FYtar[!duplicated(FYtar), ]

# == ADD THE "WK_REPORT_DATE" & "FY" TO DF == #
FYtar$WK_Report_Date <- c("10/01/2020")

# == REFORMAT THE DATE == #
FYtar$WK_Report_Date <- as.Date(FYtar$WK_Report_Date, "%m/%d/%y")
FYtar$WK_Report_Date <- format(FYtar$WK_Report_Date, format = "%m/%d/%y")

FYtar$FY <- c("Tar")
FYtar$Month <- c("Tar")
FYtar$Qtr <- c("Tar")
FYtar$Week_No <- c("0")

names(FYtar)


# == ROUND UP DECIMALS == #
FYtar$TX_CURR_t <- round(as.numeric(FYtar$TX_CURR_t), 0)
FYtar$HTS_POS_t <- round(as.numeric(FYtar$HTS_POS_t), 0)
FYtar$TX_NET_NEW_t <- round(as.numeric(FYtar$TX_NET_NEW_t), 0)
FYtar$TX_NEW_t <- round(as.numeric(FYtar$TX_NEW_t), 0)

FYtar$TX_CURR_t <- as.numeric(FYtar$TX_CURR_t)
FYtar$HTS_POS_t <- as.numeric(FYtar$HTS_POS_t)
FYtar$TX_NET_NEW_t <- as.numeric(FYtar$TX_NET_NEW_t)
FYtar$TX_NEW_t <- as.numeric(FYtar$TX_NEW_t)

FYtar <- select(FYtar, State, LGA, Facility_name, TX_CURR_t, HTS_POS_t, TX_NET_NEW_t, 
                TX_NEW_t, FY, Target_Period, WK_Report_Date, Month, Qtr, Week_No, 
                Prime_Partner, Facility_UnitUID) %>%
  drop_na(State)

head(FYtar, 5)

write_csv(FYtar, 
          path = "~/general dynamics - icpi/datasets/data_ng_yellow/products_outputs/FY21tar.csv")

# == OU SUBSETS TARGET DATASET INTO STATE TARGETS == #
EkitiTargets <- filter(FYtar, State == "Ekiti")
KadunaTargets <- filter(FYtar, State == "Kaduna")
KatsinaTargets <- filter(FYtar, State == "Katsina")
KogiTargets <- filter(FYtar, State == "Kogi")
OgunTargets <- filter(FYtar, State == "Ogun")
OyoTargets <- filter(FYtar, State == "Oyo")
OsunTargets <- filter(FYtar, State == "Osun")
OndoTargets <- filter(FYtar, State == "Ondo")
PlateauTargets <- filter(FYtar, State == "Plateau")

write_csv(EkitiTargets, 
          path = "~/general dynamics - icpi/datasets/data_ng_yellow/products_outputs/EK21tar.csv")

write_csv(KadunaTargets, 
          path = "~/general dynamics - icpi/datasets/data_ng_yellow/products_outputs/KD21tar.csv")

write_csv(KatsinaTargets, 
          path = "~/general dynamics - icpi/datasets/data_ng_yellow/products_outputs/KT21tar.csv")

write_csv(OgunTargets, 
          path = "~/general dynamics - icpi/datasets/data_ng_yellow/products_outputs/OG21tar.csv")

write_csv(OyoTargets, 
          path = "~/general dynamics - icpi/datasets/data_ng_yellow/products_outputs/OY21tar.csv")

write_csv(OsunTargets, 
          path = "~/general dynamics - icpi/datasets/data_ng_yellow/products_outputs/OS21tar.csv")

write_csv(OndoTargets, 
          path = "~/general dynamics - icpi/datasets/data_ng_yellow/products_outputs/OD21tar.csv")

write_csv(PlateauTargets, 
          path = "~/general dynamics - icpi/datasets/data_ng_yellow/products_outputs/PL21tar.csv")

