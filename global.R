## global.R ##
# convert matrix to dataframe
library(shiny)
library(readxl)
library(dplyr)
library(lubridate)
library(plotly)
library(DT)

locations <- read_xlsx('locations.xlsx')


nav_fund <- data.frame(read.csv("GINGX.csv")) 
nav_fund$Date <- as.Date(nav_fund$Date, "%Y-%m-%d")
nav_stat <- data.frame(rownames(nav_fund), nav_fund)
price_choice <- colnames(nav_stat)[-1] 

bench_fund <- data.frame(read.csv("csvs/GSPC.csv")) 
return_stats <- data.frame(rownames(bench_fund), bench_fund)
return_choice <- colnames(return_stats)[-1]


locations$lat_lon = c("40.730610:-73.935242",
                      "40.792240:-73.138260",
                      "34.052235:-118.243683",
                      "41.881832:-87.623177",
                      "25.761681:-80.191788",
                      "39.952583:-75.165222"
)


walmart_equity <- data.frame(read.csv("csvs/WMT.csv"))
walmart_equity$Date <- ymd(walmart_equity$Date)
walmart_trading <- data.frame(rownames(walmart_equity), walmart_equity)
walm_series_name <- colnames(walmart_trading)[-1]

visa_equity <-data.frame(read.csv("csvs/V.csv"))
visa_equity$Date <- ymd(visa_equity$Date)
v_trading <- data.frame(rownames(visa_equity), visa_equity)
v_series_name <- colnames(v_trading)[-1]

union_pac_equity <- data.frame(read.csv("csvs/UNP.csv"))
union_pac_equity$Date <- ymd(union_pac_equity$Date)
union_trading_at <- data.frame(rownames(union_pac_equity), union_pac_equity)
union_pac_series_name <- colnames(union_trading_at)[-1]

txn_equity <- data.frame(read.csv("csvs/TXN.csv"))
txn_equity$Date <- ymd(txn_equity$Date)
txn_trading_at <- data.frame(rownames(txn_equity), txn_equity)
txn_series_name <- colnames(txn_trading_at)[-1]

msft_equity <- data.frame(read.csv("csvs/MSFT.csv"))
msft_equity$Date <- ymd(msft_equity$Date)
msft_trading_at <- data.frame(rownames(msft_equity), msft_equity)
msft_series_name <- colnames(msft_trading_at)[-1]

lly_equity <- data.frame(read.csv("csvs/LLY.csv"))
lly_equity$Date <- ymd(lly_equity$Date)
lly_trading_at <- data.frame(rownames(lly_equity), lly_equity)
lly_series_name <- colnames(lly_trading_at)[-1]

hon_equity <- data.frame(read.csv("csvs/HON.csv"))
hon_equity$Date <- ymd(hon_equity$Date)
hon_trading_at <- data.frame(rownames(hon_equity), hon_equity)
hon_series_name <- colnames(hon_trading_at)[-1]

gspc_equity <- data.frame(read.csv("csvs/GSPC.csv"))
gspc_equity$Date <- ymd(gspc_equity$Date)
gspc_trading_at <- data.frame(rownames(gspc_equity), gspc_equity)
gspc_series_name <- colnames(gspc_trading_at)[-1]

dhr_equity <- data.frame(read.csv("csvs/DHR.csv"))
dhr_equity$Date <- ymd(dhr_equity$Date)
dhr_trading_at <- data.frame(rownames(dhr_equity), dhr_equity)
dhr_series_name <- colnames(dhr_trading_at)[-1]

aapl_equity <- data.frame(read.csv("csvs/AAPL.csv"))
aapl_equity$Date <- ymd(aapl_equity$Date)
aapl_trading_at <- data.frame(rownames(aapl_equity), aapl_equity)
aapl_series_name <- colnames(aapl_trading_at)[-1]

fb_equity <- data.frame(read.csv("csvs/FB.csv"))
fb_equity$Date <- ymd(fb_equity$Date)
fb_trading_at <- data.frame(rownames(fb_equity), fb_equity)
fb_series_name <- colnames(aapl_trading_at)[-1]


data <- data.frame(Date = nav_fund$Date, Close_wal_equity = walmart_equity$Close, Close_lly_equity = lly_equity$Close, Close_dhr_equity = dhr_equity$Close,
                   Close_aapl_equity = aapl_equity$Close, Close_fb_equity= fb_equity$Close, Close_hon_equity = hon_equity$Close) 

num_wal <- select_if(walmart_equity, is.numeric)
num_lly <- select_if(lly_equity, is.numeric)
corr_vars <- cor(as.matrix(num_wal), as.matrix(num_lly), use = "pairwise.complete.obs" )

num_hon <- select_if(hon_equity, is.numeric)
num_dhr <- select_if(dhr_equity, is.numeric)
corr_var_2 <- cor(as.matrix(num_hon), as.matrix(num_dhr), use = "pairwise.complete.obs" )


# low correlations 
num_aapl <- select_if(aapl_equity, is.numeric)
num_fb <- select_if(fb_equity, is.numeric)
corr_var_tech <- cor(as.matrix(num_aapl), as.matrix(num_fb), use = "pairwise.complete.obs" )


