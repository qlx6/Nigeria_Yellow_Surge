## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## TITLE: Yellow States DCT consolidation & Analysis (for V1.5 DCT)
## AUTHOR: Femi Akinmade (qlx6@cdc.gov)
## CREATION DATE: 10/28/2020
## UPDATE:
## Outputs: Consolidated state CQI data & analysis of consolidated data
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library(tidyverse)
library(readxl)
library(tidyr)
library(dplyr)

# == Set to directory you keep the state data submissions == #
setwd("~/general dynamics - icpi/datasets/data_ng_yellow/state_submissions/res")


# == Read your files from dedicated directory above == #
dir_files <- list.files(pattern = "*xls")
dir_files

# == Read only "dct" sheet from DCT == #
# == MAKE SURE ALL THE FILES YOU ARE READING IN ARE CLOSED == #
yellow_files <- lapply(dir_files, function(i){
  x = read_excel(i, sheet = "dct")}
)
str(yellow_files)
#yellow_files$WK_Report_Date <- as.Date(yellow_files$WK_Report_Date)


# == Append DCT == #
yellow_files <- bind_rows(yellow_files) 

Target_Period <- c("Week")
yellow_files <- cbind(yellow_files, Target_Period)

# == Remove duplicate rows == #
yellow_files <- yellow_files[!duplicated(yellow_files), ]

# == REORDER COLS, REMOVE NAs IN "State" COL == #
yellow_files <- yellow_files %>%
  select(State, Facility_name, WK_Report_Date, TX_CURR_r, HTS_POS_r, TX_NEW_r, TX_NET_NEW_r,
         hts_OPD_attendance, hts_OPD_Screened, hts_OPD_eligible4Testing, hts_OPD_Tested, hts_OPD_Positive, 
         hts_OPD_linked2ART, indx_case, indx_Eligible4Index, indx_offered_Index, 
         indx_accepted_Index, indx_Elicited, indx_Tested, indx_Positive, indx_linked2ART,
         otps_clients_seen, otps_screened, otps_eligible4Testing, otps_Tested, otps_Positive, 
         otps_linked2ART, ret_appt_scheduled, ret_missed_their_appt, ret_texted_or_called, ret_visited, 
         ret_official_transfer_outs, ret_declined_ReturntoART, ret_reported_died, 
         ret_reported_self_transferred, ret_not_located, ret_returned2care,
         mmd_seen_ARTRefill, mmd_stable_on_ART, mmd_received_3mth_mmd, Target_Period, Week_No, 
         Month, Qtr, FY, LGA, Facility_UnitUID, Prime_Partner) %>%
  drop_na(State)


# == SOME QC OF DATA ==#
# = Change date format  = #
yellow_files$WK_Report_Date <- format(yellow_files$WK_Report_Date, format = "%m/%d/%y")
names(yellow_files)

which(is.na(yellow_files))



# == Write consolidated dataset into directory of choice. This is dataset for the dashboard == #
write_csv(yellow_files, 
          path = "~/general dynamics - icpi/datasets/data_ng_yellow/products_outputs/allResults.csv")
str(yellow_files)
## ==============================================================
## ==================== DATA ANALYSIS SCRIPT ====================
## ==============================================================

