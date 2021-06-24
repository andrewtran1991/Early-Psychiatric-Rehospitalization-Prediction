use Anasazi_Common
go

-- add 7,30,90 for 24 hour services

drop table if exists #tmp_c
drop table if exists #tmp_s
drop table if exists #tmp_loc_code
drop table if exists #tmp_svc
drop table if exists #tmp_svc_list
drop table if exists #tmp_loc
drop table if exists #tmp_svc_loc
drop table if exists #tmp_svc_loc_7days
drop table if exists #tmp_svc_loc_30days
drop table if exists #tmp_svc_loc_60days
drop table if exists #tmp_svc_loc_90days
drop table if exists #tmp_dx
drop table if exists #tmp_min_level
go

create table #tmp_c(
--declare #tmp_c table (
id int identity(1,1),
client_id int default 0,
case_number int default 0,
assign_id int default 0,
new char(1) default 0,
new_3 char(1) default 0,
as_recnum int default 0,
as_date_opened date,
as_date_closed date,
as_date_prev date,
as_date_next date,
as_length_IP int default 0,
as_gap_between_IP int default 0,
as_pop char(1),
as_loc varchar(20),
as_unit varchar(10),
as_subunit varchar(10),
as_name varchar(max),
as_close varchar(max),
svc_pre_all int default 0,
svc_pre int default 0,
svc_pre_sub int default 0,
svc_during int default 0,
svc_post_sub int default 0,
svc_post int default 0,
svc_post_all int default 0,
svc_op_7days_pre int default 0,
svc_op_30days_pre int default 0,
svc_op_60days_pre int default 0,
svc_op_90days_pre int default 0,
svc_es_7days_pre int default 0,
svc_es_30days_pre int default 0,
svc_es_60days_pre int default 0,
svc_es_90days_pre int default 0,
svc_ip_7days_pre int default 0,
svc_ip_30days_pre int default 0,
svc_ip_60days_pre int default 0,
svc_ip_90days_pre int default 0,
svc_op_7days_postdc int default 0,
svc_op_30days_postdc int default 0,
svc_op_60days_postdc int default 0,
svc_op_90days_postdc int default 0,
svc_es_7days_postdc int default 0,
svc_es_30days_postdc int default 0,
svc_es_60days_postdc int default 0,
svc_es_90days_postdc int default 0,
svc_ip_7days_postdc int default 0,
svc_ip_30days_postdc int default 0,
svc_ip_60days_postdc int default 0,
svc_ip_90days_postdc int default 0,
loc_pre_7days_ACT int default 0,
loc_pre_30days_ACT int default 0,
loc_pre_60days_ACT int default 0,
loc_pre_90days_ACT int default 0,
loc_pre_7days_CM int default 0,
loc_pre_30days_CM int default 0,
loc_pre_60days_CM int default 0,
loc_pre_90days_CM int default 0,
loc_pre_7days_CMINST int default 0,
loc_pre_30days_CMINST int default 0,
loc_pre_60days_CMINST int default 0,
loc_pre_90days_CMINST int default 0,
loc_pre_7days_CMSTR int default 0,
loc_pre_30days_CMSTR int default 0,
loc_pre_60days_CMSTR int default 0,
loc_pre_90days_CMSTR int default 0,
loc_pre_7days_CMTRAN int default 0,
loc_pre_30days_CMTRAN int default 0,
loc_pre_60days_CMTRAN int default 0,
loc_pre_90days_CMTRAN int default 0,
loc_pre_7days_WRAP int default 0,
loc_pre_30days_WRAP int default 0, 
loc_pre_60days_WRAP int default 0, 
loc_pre_90days_WRAP int default 0, 
loc_pre_7days_TBS int default 0,
loc_pre_30days_TBS int default 0, 
loc_pre_60days_TBS int default 0, 
loc_pre_90days_TBS int default 0, 
loc_pre_7days_FFS int default 0,
loc_pre_30days_FFS int default 0,
loc_pre_60days_FFS int default 0,
loc_pre_90days_FFS int default 0,
loc_pre_7days_OP int default 0,
loc_pre_30days_OP int default 0,
loc_pre_60days_OP int default 0,
loc_pre_90days_OP int default 0,
loc_pre_7days_OPLIHP int default 0,
loc_pre_30days_OPLIHP int default 0,
loc_pre_60days_OPLIHP int default 0,
loc_pre_90days_OPLIHP int default 0,
loc_pre_7days_OPR int default 0,
loc_pre_30days_OPR int default 0,
loc_pre_60days_OPR int default 0,
loc_pre_90days_OPR int default 0,
loc_pre_7days_PREV int default 0,
loc_pre_30days_PREV int default 0,
loc_pre_60days_PREV int default 0,
loc_pre_90days_PREV int default 0,
loc_pre_7days_CO int default 0,
loc_pre_30days_CO int default 0,
loc_pre_60days_CO int default 0,
loc_pre_90days_CO int default 0,
loc_pre_7days_CR int default 0,
loc_pre_30days_CR int default 0,
loc_pre_60days_CR int default 0,
loc_pre_90days_CR int default 0,
loc_pre_7days_CS int default 0,
loc_pre_30days_CS int default 0,
loc_pre_60days_CS int default 0,
loc_pre_90days_CS int default 0,
loc_pre_7days_ESU int default 0,
loc_pre_30days_ESU int default 0,
loc_pre_60days_ESU int default 0,
loc_pre_90days_ESU int default 0,
loc_pre_7days_PERT int default 0,
loc_pre_30days_PERT int default 0, 
loc_pre_60days_PERT int default 0,
loc_pre_90days_PERT int default 0,
loc_pre_7days_UO int default 0,
loc_pre_30days_UO int default 0,
loc_pre_60days_UO int default 0,
loc_pre_90days_UO int default 0,
loc_pre_7days_IP int default 0,
loc_pre_30days_IP int default 0,
loc_pre_60days_IP int default 0,
loc_pre_90days_IP int default 0,
loc_pre_7days_IPCAPS int default 0,
loc_pre_30days_IPCAPS int default 0,
loc_pre_60days_IPCAPS int default 0,
loc_pre_90days_IPCAPS int default 0,
loc_pre_7days_IPCNTY int default 0,
loc_pre_30days_IPCNTY int default 0,
loc_pre_60days_IPCNTY int default 0,
loc_pre_90days_IPCNTY int default 0,
loc_pre_7days_IPFFS int default 0,
loc_pre_30days_IPFFS int default 0,
loc_pre_60days_IPFFS int default 0,
loc_pre_90days_IPFFS int default 0,
loc_pre_7days_IPLIHP int default 0,
loc_pre_30days_IPLIHP int default 0,
loc_pre_60days_IPLIHP int default 0,
loc_pre_90days_IPLIHP int default 0,
loc_pre_7days_IPST int default 0,
loc_pre_30days_IPST int default 0,
loc_pre_60days_IPST int default 0,
loc_pre_90days_IPST int default 0,
loc_pre_7days_JAIL int default 0,
loc_pre_30days_JAIL int default 0,
loc_pre_60days_JAIL int default 0,
loc_pre_90days_JAIL int default 0,
loc_pre_7days_JFS int default 0,
loc_pre_30days_JFS int default 0,
loc_pre_60days_JFS int default 0,
loc_pre_90days_JFS int default 0,
loc_pre_7days_EDG int default 0,
loc_pre_30days_EDG int default 0,
loc_pre_60days_EDG int default 0,
loc_pre_90days_EDG int default 0,
loc_pre_7days_LTC int default 0,
loc_pre_30days_LTC int default 0,
loc_pre_60days_LTC int default 0,
loc_pre_90days_LTC int default 0,
loc_pre_7days_LTCINST int default 0,
loc_pre_30days_LTCINST int default 0,
loc_pre_60days_LTCINST int default 0,
loc_pre_90days_LTCINST int default 0,
loc_pre_7days_LTCRES int default 0,
loc_pre_30days_LTCRES int default 0,
loc_pre_60days_LTCRES int default 0,
loc_pre_90days_LTCRES int default 0,
loc_pre_7days_RES int default 0,
loc_pre_30days_RES int default 0,
loc_pre_60days_RES int default 0,
loc_pre_90days_RES int default 0,
loc_pre_7days_BHC int default 0,
loc_pre_30days_BHC int default 0,
loc_pre_60days_BHC int default 0,
loc_pre_90days_BHC int default 0,
loc_pre_7days_DTC int default 0,
loc_pre_30days_DTC int default 0, 
loc_pre_60days_DTC int default 0, 
loc_pre_90days_DTC int default 0, 
loc_pre_7days_DTCTF int default 0,
loc_pre_30days_DTCTF int default 0, 
loc_pre_60days_DTCTF int default 0, 
loc_pre_90days_DTCTF int default 0, 
loc_pre_7days_DTR int default 0,
loc_pre_30days_DTR int default 0, 
loc_pre_60days_DTR int default 0, 
loc_pre_90days_DTR int default 0,
loc_pre_7days_STRTP int default 0,
loc_pre_30days_STRTP int default 0, 
loc_pre_60days_STRTP int default 0, 
loc_pre_90days_STRTP int default 0, 
loc_post_7days_ACT int default 0,
loc_post_30days_ACT int default 0,
loc_post_60days_ACT int default 0,
loc_post_90days_ACT int default 0,
loc_post_7days_CM int default 0,
loc_post_30days_CM int default 0,
loc_post_60days_CM int default 0,
loc_post_90days_CM int default 0,
loc_post_7days_CMINST int default 0,
loc_post_30days_CMINST int default 0,
loc_post_60days_CMINST int default 0,
loc_post_90days_CMINST int default 0,
loc_post_7days_CMSTR int default 0,
loc_post_30days_CMSTR int default 0,
loc_post_60days_CMSTR int default 0,
loc_post_90days_CMSTR int default 0,
loc_post_7days_CMTRAN int default 0,
loc_post_30days_CMTRAN int default 0,
loc_post_60days_CMTRAN int default 0,
loc_post_90days_CMTRAN int default 0,
loc_post_7days_WRAP int default 0,
loc_post_30days_WRAP int default 0, 
loc_post_60days_WRAP int default 0, 
loc_post_90days_WRAP int default 0, 
loc_post_7days_TBS int default 0,
loc_post_30days_TBS int default 0, 
loc_post_60days_TBS int default 0, 
loc_post_90days_TBS int default 0, 
loc_post_7days_FFS int default 0,
loc_post_30days_FFS int default 0,
loc_post_60days_FFS int default 0,
loc_post_90days_FFS int default 0,
loc_post_7days_OP int default 0,
loc_post_30days_OP int default 0,
loc_post_60days_OP int default 0,
loc_post_90days_OP int default 0,
loc_post_7days_OPLIHP int default 0,
loc_post_30days_OPLIHP int default 0,
loc_post_60days_OPLIHP int default 0,
loc_post_90days_OPLIHP int default 0,
loc_post_7days_OPR int default 0,
loc_post_30days_OPR int default 0,
loc_post_60days_OPR int default 0,
loc_post_90days_OPR int default 0,
loc_post_7days_PREV int default 0,
loc_post_30days_PREV int default 0,
loc_post_60days_PREV int default 0,
loc_post_90days_PREV int default 0,
loc_post_7days_CO int default 0,
loc_post_30days_CO int default 0,
loc_post_60days_CO int default 0,
loc_post_90days_CO int default 0,
loc_post_7days_CR int default 0,
loc_post_30days_CR int default 0,
loc_post_60days_CR int default 0,
loc_post_90days_CR int default 0,
loc_post_7days_CS int default 0,
loc_post_30days_CS int default 0,
loc_post_60days_CS int default 0,
loc_post_90days_CS int default 0,
loc_post_7days_ESU int default 0,
loc_post_30days_ESU int default 0,
loc_post_60days_ESU int default 0,
loc_post_90days_ESU int default 0,
loc_post_7days_PERT int default 0,
loc_post_30days_PERT int default 0, 
loc_post_60days_PERT int default 0,
loc_post_90days_PERT int default 0,
loc_post_7days_UO int default 0,
loc_post_30days_UO int default 0,
loc_post_60days_UO int default 0,
loc_post_90days_UO int default 0,
loc_post_7days_IP int default 0,
loc_post_30days_IP int default 0,
loc_post_60days_IP int default 0,
loc_post_90days_IP int default 0,
loc_post_7days_IPCAPS int default 0,
loc_post_30days_IPCAPS int default 0,
loc_post_60days_IPCAPS int default 0,
loc_post_90days_IPCAPS int default 0,
loc_post_7days_IPCNTY int default 0,
loc_post_30days_IPCNTY int default 0,
loc_post_60days_IPCNTY int default 0,
loc_post_90days_IPCNTY int default 0,
loc_post_7days_IPFFS int default 0,
loc_post_30days_IPFFS int default 0,
loc_post_60days_IPFFS int default 0,
loc_post_90days_IPFFS int default 0,
loc_post_7days_IPLIHP int default 0,
loc_post_30days_IPLIHP int default 0,
loc_post_60days_IPLIHP int default 0,
loc_post_90days_IPLIHP int default 0,
loc_post_7days_IPST int default 0,
loc_post_30days_IPST int default 0,
loc_post_60days_IPST int default 0,
loc_post_90days_IPST int default 0,
loc_post_7days_JAIL int default 0,
loc_post_30days_JAIL int default 0,
loc_post_60days_JAIL int default 0,
loc_post_90days_JAIL int default 0,
loc_post_7days_JFS int default 0,
loc_post_30days_JFS int default 0,
loc_post_60days_JFS int default 0,
loc_post_90days_JFS int default 0,
loc_post_7days_EDG int default 0,
loc_post_30days_EDG int default 0,
loc_post_60days_EDG int default 0,
loc_post_90days_EDG int default 0,
loc_post_7days_LTC int default 0,
loc_post_30days_LTC int default 0,
loc_post_60days_LTC int default 0,
loc_post_90days_LTC int default 0,
loc_post_7days_LTCINST int default 0,
loc_post_30days_LTCINST int default 0,
loc_post_60days_LTCINST int default 0,
loc_post_90days_LTCINST int default 0,
loc_post_7days_LTCRES int default 0,
loc_post_30days_LTCRES int default 0,
loc_post_60days_LTCRES int default 0,
loc_post_90days_LTCRES int default 0,
loc_post_7days_RES int default 0,
loc_post_30days_RES int default 0,
loc_post_60days_RES int default 0,
loc_post_90days_RES int default 0,
loc_post_7days_BHC int default 0,
loc_post_30days_BHC int default 0,
loc_post_60days_BHC int default 0,
loc_post_90days_BHC int default 0,
loc_post_7days_DTC int default 0,
loc_post_30days_DTC int default 0, 
loc_post_60days_DTC int default 0, 
loc_post_90days_DTC int default 0, 
loc_post_7days_DTCTF int default 0,
loc_post_30days_DTCTF int default 0, 
loc_post_60days_DTCTF int default 0, 
loc_post_90days_DTCTF int default 0, 
loc_post_7days_DTR int default 0,
loc_post_30days_DTR int default 0, 
loc_post_60days_DTR int default 0, 
loc_post_90days_DTR int default 0,
loc_post_7days_STRTP int default 0,
loc_post_30days_STRTP int default 0, 
loc_post_60days_STRTP int default 0, 
loc_post_90days_STRTP int default 0, 
day_loc_pre_7days_CR int default 0,
day_loc_pre_30days_CR int default 0,
day_loc_pre_60days_CR int default 0,
day_loc_pre_90days_CR int default 0,
day_loc_pre_7days_EDG int default 0,
day_loc_pre_30days_EDG int default 0,
day_loc_pre_60days_EDG int default 0,
day_loc_pre_90days_EDG int default 0,
day_loc_pre_7days_LTC int default 0,
day_loc_pre_30days_LTC int default 0,
day_loc_pre_60days_LTC int default 0,
day_loc_pre_90days_LTC int default 0,
day_loc_pre_7days_LTCINST int default 0,
day_loc_pre_30days_LTCINST int default 0,
day_loc_pre_60days_LTCINST int default 0,
day_loc_pre_90days_LTCINST int default 0,
day_loc_pre_7days_LTCRES int default 0,
day_loc_pre_30days_LTCRES int default 0,
day_loc_pre_60days_LTCRES int default 0,
day_loc_pre_90days_LTCRES int default 0,
day_loc_pre_7days_RES int default 0,
day_loc_pre_30days_RES int default 0,
day_loc_pre_60days_RES int default 0,
day_loc_pre_90days_RES int default 0,
day_loc_pre_7days_DTC int default 0,
day_loc_pre_30days_DTC int default 0, 
day_loc_pre_60days_DTC int default 0, 
day_loc_pre_90days_DTC int default 0, 
day_loc_pre_7days_DTCTF int default 0,
day_loc_pre_30days_DTCTF int default 0, 
day_loc_pre_60days_DTCTF int default 0, 
day_loc_pre_90days_DTCTF int default 0, 
day_loc_pre_7days_DTR int default 0,
day_loc_pre_30days_DTR int default 0, 
day_loc_pre_60days_DTR int default 0, 
day_loc_pre_90days_DTR int default 0,
day_loc_post_7days_CR int default 0,
day_loc_post_30days_CR int default 0,
day_loc_post_60days_CR int default 0,
day_loc_post_90days_CR int default 0,
day_loc_post_7days_EDG int default 0,
day_loc_post_30days_EDG int default 0,
day_loc_post_60days_EDG int default 0,
day_loc_post_90days_EDG int default 0,
day_loc_post_7days_LTC int default 0,
day_loc_post_30days_LTC int default 0,
day_loc_post_60days_LTC int default 0,
day_loc_post_90days_LTC int default 0,
day_loc_post_7days_LTCINST int default 0,
day_loc_post_30days_LTCINST int default 0,
day_loc_post_60days_LTCINST int default 0,
day_loc_post_90days_LTCINST int default 0,
day_loc_post_7days_LTCRES int default 0,
day_loc_post_30days_LTCRES int default 0,
day_loc_post_60days_LTCRES int default 0,
day_loc_post_90days_LTCRES int default 0,
day_loc_post_7days_RES int default 0,
day_loc_post_30days_RES int default 0,
day_loc_post_60days_RES int default 0,
day_loc_post_90days_RES int default 0,
day_loc_post_7days_DTC int default 0,
day_loc_post_30days_DTC int default 0, 
day_loc_post_60days_DTC int default 0, 
day_loc_post_90days_DTC int default 0, 
day_loc_post_7days_DTCTF int default 0,
day_loc_post_30days_DTCTF int default 0, 
day_loc_post_60days_DTCTF int default 0, 
day_loc_post_90days_DTCTF int default 0, 
day_loc_post_7days_DTR int default 0,
day_loc_post_30days_DTR int default 0, 
day_loc_post_60days_DTR int default 0, 
day_loc_post_90days_DTR int default 0,
svc_AOA_op_7days_pre int default 0,
svc_AOA_op_30days_pre int default 0,
svc_AOA_op_60days_pre int default 0,
svc_AOA_op_90days_pre int default 0,
svc_AOA_es_7days_pre int default 0,
svc_AOA_es_30days_pre int default 0,
svc_AOA_es_60days_pre int default 0,
svc_AOA_es_90days_pre int default 0,
svc_AOA_fs_7days_pre int default 0,
svc_AOA_fs_30days_pre int default 0,
svc_AOA_fs_60days_pre int default 0,
svc_AOA_fs_90days_pre int default 0,
svc_AOA_24h_7days_pre int default 0,
svc_AOA_24h_30days_pre int default 0,
svc_AOA_24h_60days_pre int default 0,
svc_AOA_24h_90days_pre int default 0,
svc_AOA_ip_7days_pre int default 0,
svc_AOA_ip_30days_pre int default 0,
svc_AOA_ip_60days_pre int default 0,
svc_AOA_ip_90days_pre int default 0,
svc_AOA_op_7days_postdc int default 0,
svc_AOA_op_30days_postdc int default 0,
svc_AOA_op_60days_postdc int default 0,
svc_AOA_op_90days_postdc int default 0,
svc_AOA_es_7days_postdc int default 0,
svc_AOA_es_30days_postdc int default 0,
svc_AOA_es_60days_postdc int default 0,
svc_AOA_es_90days_postdc int default 0,
svc_AOA_fs_7days_postdc int default 0,
svc_AOA_fs_30days_postdc int default 0,
svc_AOA_fs_60days_postdc int default 0,
svc_AOA_fs_90days_postdc int default 0,
svc_AOA_24h_7days_postdc int default 0,
svc_AOA_24h_30days_postdc int default 0,
svc_AOA_24h_60days_postdc int default 0,
svc_AOA_24h_90days_postdc int default 0,
svc_AOA_ip_7days_postdc int default 0,
svc_AOA_ip_30days_postdc int default 0,
svc_AOA_ip_60days_postdc int default 0,
svc_AOA_ip_90days_postdc int default 0,
svc_CYF_op_7days_pre int default 0,
svc_CYF_op_30days_pre int default 0,
svc_CYF_op_60days_pre int default 0,
svc_CYF_op_90days_pre int default 0,
svc_CYF_es_7days_pre int default 0,
svc_CYF_es_30days_pre int default 0,
svc_CYF_es_60days_pre int default 0,
svc_CYF_es_90days_pre int default 0,
svc_CYF_dt_7days_pre int default 0,
svc_CYF_dt_30days_pre int default 0,
svc_CYF_dt_60days_pre int default 0,
svc_CYF_dt_90days_pre int default 0,
svc_CYF_ip_7days_pre int default 0,
svc_CYF_ip_30days_pre int default 0,
svc_CYF_ip_60days_pre int default 0,
svc_CYF_ip_90days_pre int default 0,
svc_CYF_op_7days_postdc int default 0,
svc_CYF_op_30days_postdc int default 0,
svc_CYF_op_60days_postdc int default 0,
svc_CYF_op_90days_postdc int default 0,
svc_CYF_es_7days_postdc int default 0,
svc_CYF_es_30days_postdc int default 0,
svc_CYF_es_60days_postdc int default 0,
svc_CYF_es_90days_postdc int default 0,
svc_CYF_dt_7days_postdc int default 0,
svc_CYF_dt_30days_postdc int default 0,
svc_CYF_dt_60days_postdc int default 0,
svc_CYF_dt_90days_postdc int default 0,
svc_CYF_ip_7days_postdc int default 0,
svc_CYF_ip_30days_postdc int default 0,
svc_CYF_ip_60days_postdc int default 0,
svc_CYF_ip_90days_postdc int default 0,
loc10_pre varchar(max),
loc9_pre varchar(max),
loc8_pre varchar(max),
loc7_pre varchar(max),
loc6_pre varchar(max),
loc5_pre varchar(max),
loc4_pre varchar(max),
loc3_pre varchar(max),
loc2_pre varchar(max),
loc1_pre varchar(max),
loc1_post varchar(max),
loc2_post varchar(max),
loc3_post varchar(max),
loc4_post varchar(max),
loc5_post varchar(max),
loc6_post varchar(max),
loc7_post varchar(max),
loc8_post varchar(max),
loc9_post varchar(max),
loc10_post varchar(max),
svc10_pre_date date,
svc10_pre_days int,
svc10_pre_loc varchar(max),
svc10_pre_unit varchar(max),
svc10_pre_subunit varchar(max),
svc10_pre_su_name varchar(max),
svc10_pre_desc varchar(max),
svc10_pre_group varchar(max),
svc9_pre_date date,
svc9_pre_days int,
svc9_pre_loc varchar(max),
svc9_pre_unit varchar(max),
svc9_pre_subunit varchar(max),
svc9_pre_su_name varchar(max),
svc9_pre_desc varchar(max),
svc9_pre_group varchar(max),
svc8_pre_date date,
svc8_pre_days int,
svc8_pre_loc varchar(max),
svc8_pre_unit varchar(max),
svc8_pre_subunit varchar(max),
svc8_pre_su_name varchar(max),
svc8_pre_desc varchar(max),
svc8_pre_group varchar(max),
svc7_pre_date date,
svc7_pre_days int,
svc7_pre_loc varchar(max),
svc7_pre_unit varchar(max),
svc7_pre_subunit varchar(max),
svc7_pre_su_name varchar(max),
svc7_pre_desc varchar(max),
svc7_pre_group varchar(max),
svc6_pre_date date,
svc6_pre_days int,
svc6_pre_loc varchar(max),
svc6_pre_unit varchar(max),
svc6_pre_subunit varchar(max),
svc6_pre_su_name varchar(max),
svc6_pre_desc varchar(max),
svc6_pre_group varchar(max),
svc5_pre_date date,
svc5_pre_days int,
svc5_pre_loc varchar(max),
svc5_pre_unit varchar(max),
svc5_pre_subunit varchar(max),
svc5_pre_su_name varchar(max),
svc5_pre_desc varchar(max),
svc5_pre_group varchar(max),
svc4_pre_date date,
svc4_pre_days int,
svc4_pre_loc varchar(max),
svc4_pre_unit varchar(max),
svc4_pre_subunit varchar(max),
svc4_pre_su_name varchar(max),
svc4_pre_desc varchar(max),
svc4_pre_group varchar(max),
svc3_pre_date date,
svc3_pre_days int,
svc3_pre_loc varchar(max),
svc3_pre_unit varchar(max),
svc3_pre_subunit varchar(max),
svc3_pre_su_name varchar(max),
svc3_pre_desc varchar(max),
svc3_pre_group varchar(max),
svc2_pre_date date,
svc2_pre_days int,
svc2_pre_loc varchar(max),
svc2_pre_unit varchar(max),
svc2_pre_subunit varchar(max),
svc2_pre_su_name varchar(max),
svc2_pre_desc varchar(max),
svc2_pre_group varchar(max),
svc1_pre_date date,
svc1_pre_days int,
svc1_pre_loc varchar(max),
svc1_pre_unit varchar(max),
svc1_pre_subunit varchar(max),
svc1_pre_su_name varchar(max),
svc1_pre_desc varchar(max),
svc1_pre_group varchar(max),
svc1_post_date date,
svc1_post_days int,
svc1_post_loc varchar(max),
svc1_post_unit varchar(max),
svc1_post_subunit varchar(max),
svc1_post_su_name varchar(max),
svc1_post_desc varchar(max),
svc1_post_group varchar(max),
svc2_post_date date,
svc2_post_days int,
svc2_post_loc varchar(max),
svc2_post_unit varchar(max),
svc2_post_subunit varchar(max),
svc2_post_su_name varchar(max),
svc2_post_desc varchar(max),
svc2_post_group varchar(max),
svc3_post_date date,
svc3_post_days int,
svc3_post_loc varchar(max),
svc3_post_unit varchar(max),
svc3_post_subunit varchar(max),
svc3_post_su_name varchar(max),
svc3_post_desc varchar(max),
svc3_post_group varchar(max),
svc4_post_date date,
svc4_post_days int,
svc4_post_loc varchar(max),
svc4_post_unit varchar(max),
svc4_post_subunit varchar(max),
svc4_post_su_name varchar(max),
svc4_post_desc varchar(max),
svc4_post_group varchar(max),
svc5_post_date date,
svc5_post_days int,
svc5_post_loc varchar(max),
svc5_post_unit varchar(max),
svc5_post_subunit varchar(max),
svc5_post_su_name varchar(max),
svc5_post_desc varchar(max),
svc5_post_group varchar(max),
svc6_post_date date,
svc6_post_days int,
svc6_post_loc varchar(max),
svc6_post_unit varchar(max),
svc6_post_subunit varchar(max),
svc6_post_su_name varchar(max),
svc6_post_desc varchar(max),
svc6_post_group varchar(max),
svc7_post_date date,
svc7_post_days int,
svc7_post_loc varchar(max),
svc7_post_unit varchar(max),
svc7_post_subunit varchar(max),
svc7_post_su_name varchar(max),
svc7_post_desc varchar(max),
svc7_post_group varchar(max),
svc8_post_date date,
svc8_post_days int,
svc8_post_loc varchar(max),
svc8_post_unit varchar(max),
svc8_post_subunit varchar(max),
svc8_post_su_name varchar(max),
svc8_post_desc varchar(max),
svc8_post_group varchar(max),
svc9_post_date date,
svc9_post_days int,
svc9_post_loc varchar(max),
svc9_post_unit varchar(max),
svc9_post_subunit varchar(max),
svc9_post_su_name varchar(max),
svc9_post_desc varchar(max),
svc9_post_group varchar(max),
svc10_post_date date,
svc10_post_days int,
svc10_post_loc varchar(max),
svc10_post_unit varchar(max),
svc10_post_subunit varchar(max),
svc10_post_su_name varchar(max),
svc10_post_desc varchar(max),
svc10_post_group varchar(max),
dob date,
age int,
age_group varchar(max),
gender varchar(max),
race varchar(max),
eth varchar(max),
lang varchar(max),
dx varchar(max),
dx_desc varchar(max),
dx_group varchar(max),
ddx varchar(max),
co varchar(max),
sub varchar(max),
ins varchar(max),
medi_cal varchar(max),
medicare  varchar(max),
private_ins varchar(max),
educ varchar(max),
emp varchar(max),
liv varchar(max),
sexorient varchar(max),
justice varchar(max),
dv varchar(max),
trauma varchar(max),
regional varchar(max),
vet varchar(max),
mar varchar(max)
)



create table #tmp_s(
--declare #tmp_s table (
id int,
num int default 0,
client_id int,
case_number int, 
assign_id int,
recnum int,
as_date date,
dc_date date,
beg_date date, 
end_date date,
days_svc int, 
days_svc_min1 int, 
hrs_svc int, 
mins_svc int,
pop char(1),
loc	varchar(20),
unit varchar(10), 
subunit varchar(10), 
su_name	varchar(max),
svc_code varchar(10), 
svc_desc varchar(30),
svc_category varchar(30),
svc_group varchar(30)
)

truncate table #tmp_c
go

--pull target assignment
insert into #tmp_c (client_id, case_number, assign_id, as_recnum, as_date_opened, as_date_closed, as_date_prev, as_date_next, as_length_IP, as_gap_between_IP, as_pop, as_loc, as_unit, as_subunit, as_name, as_close, dob)
select distinct cast(a.client_id as int) client_id, cast(case_num as int) case_number, cast(a.id as int) assign_id, cast(a.recnum as int) recnum, 
cast(date_opened as date) as_date_opened, cast(date_closed as date) as_date_closed, 
cast(LAG(date_opened , 1, Null) OVER (PARTITION BY c.CASE_NUM ORDER BY date_opened) as date) AS as_date_prev, 
cast(LEAD(date_opened , 1, Null) OVER (PARTITION BY c.CASE_NUM ORDER BY date_opened) as date) AS as_date_next,
datediff(d,cast(date_opened as date),cast(date_closed as date)),
datediff(d,cast(date_closed as date),cast(cast(LEAD(date_opened , 1, Null) OVER (PARTITION BY c.CASE_NUM ORDER BY date_opened) as date) as date)), 
population, loc +  loc_sub as_loc, unit, subunit, su_name, ac.description, cast(dob as date)
from Anasazi_Load..CDASSIGN a
inner join Anasazi_Load..CDCLIENT c on a.CLIENT_ID = c.id
inner join Anasazi_Common..subunits_LOC su on a.sub_unit_id = su.subunit and su.LOC in ('IP') 
inner join Anasazi_Common..assign_close_codes ac on a.REAS_ID = ac.id
where (left(date_opened, 10) between '2008-07-01' and '2020-06-30'
    or left(date_closed, 10) between '2008-07-01' and '2020-06-30')
and isnull(entered_date, date_opened) <= '2020-10-20'
and isnull(void_flag, '') = '' and isnull(admit_flag, '') = 'A'
and cast(c.CASE_NUM as int) > '3'
order by client_id, date_opened

truncate table #tmp_s
go

--pull services
insert into #tmp_s
select distinct c.id, '0', c.client_id, case_number, s.ASSIGN_ID, s.RECNUM, as_date_opened as_date, as_date_closed dc_date, cast(s.beg_date as date) beg_date, cast(s.end_date as date) end_date, datediff(d,cast(s.beg_date as date),cast(s.end_date as date)) days_svc,
case when datediff(d,cast(s.beg_date as date),cast(s.end_date as date)) = '0' then '1' else datediff(d,cast(s.beg_date as date),cast(s.end_date as date)) end days_svc_min1, hrs, mins, 
population, loc + loc_sub as loc, unit, subunit, su_name, service_code, description, service_category, service_group
from Anasazi_load..CDCLSVC s
inner join #tmp_c c on s.CLIENT_ID = c.client_id
inner join Anasazi_Common..subunits_loc l on s.SUB_UNIT_ID = l.subunit
inner join Anasazi_Common..Service_Codes sc on s.SVC_ID = sc.service_code
where ISNULL(void_flag,'')='' and APPTYP_ID in (1,2) 
and CNTTYP_ID not in ('C','N')
and loc <> 'NR' and service_group not in ('Administrative','Other Service', 'Inpatient Phys', 'Inpatient - FFS') and service_category not in ('Bed Day','MediCal AdministrativeActivity','NR','Other Service Non-Billable')
order by c.id, cast(s.beg_date as date)

--select loc, pop, svc_group, count(distinct client_id), count(*) from #tmp_s group by loc, pop, svc_group order by loc, pop, svc_group

--add inpatient
insert into #tmp_s
select distinct c.id, '0', c.client_id, case_number, s.ID, s.RECNUM, as_date_opened as_date, as_date_closed dc_date, cast(s.DATE_OPENED as date), cast(s.DATE_CLOSED as date), datediff(d,cast(s.DATE_OPENED as date),cast(s.DATE_CLOSED as date)) days_svc, 
case when datediff(d,cast(s.DATE_OPENED as date),cast(s.DATE_CLOSED as date)) = '0' then '1' else datediff(d,cast(s.DATE_OPENED as date),cast(s.DATE_CLOSED as date)) end , '0','0',
population, l.loc + l.loc_sub as loc, unit, subunit, su_name, l.loc + l.loc_sub, lc.LOC_Desc, lc.databook_category, lc.LOC_Desc
from Anasazi_load..CDASSIGN s
inner join #tmp_c c on s.CLIENT_ID = c.client_id
inner join Anasazi_Common..subunits_loc l on s.SUB_UNIT_ID = l.subunit
inner join Anasazi_Common..LOC_Codes lc on l.loc = lc.loc and l.loc_sub = lc.loc_sub
where ISNULL(void_flag,'')='' 
and l.loc in ('IP','LTC','CR','RES','EDG')
order by c.id, cast(s.date_opened as date)


--add ranks
update s set s.num = s2.num from #tmp_s s inner join (
	select id, DENSE_RANK() OVER (PARTITION BY a.id ORDER BY a.id, beg_date, l.level, g.level, recnum ASC) AS num, recnum, beg_date
	from #tmp_s a 
	left join Anasazi_Common..LOC_Codes l on a.loc = l.loc+l.loc_sub 
	left join Anasazi_Common..Service_Group_Level g on a.svc_group = g.service_group
	) s2 on s.id = s2.id and s.recnum = s2.recnum and s.beg_date = s2.beg_date

select top 5 * from #tmp_c
select top 5 * from #tmp_s where hrs_svc>0 order by id, num 

--select distinct loc from #tmp_s order by loc

--update #tmp_c set svc_pre_all = 0, svc_pre_sub = 0, svc_during = 0, svc_post_all = 0, svc_post_sub = 0
--services pre all
update c set c.svc_pre_all = s.svc from #tmp_c c 
inner join (select c.id, count(*) svc from #tmp_c c inner join #tmp_s s on c.id = s.id where beg_date < as_date_opened group by c.id) s on c.id = s.id
--services pre since last assignment
update c set c.svc_pre = s.svc from #tmp_c c 
inner join (select c.id, count(*) svc from #tmp_c c inner join #tmp_s s on c.id = s.id where beg_date < as_date_opened and beg_date >= isnull(as_date_prev, '2008-07-01') group by c.id) s on c.id = s.id
--services pre since last assignment same sub
update c set c.svc_pre_sub = s.svc from #tmp_c c 
inner join (select c.id, count(*) svc from #tmp_c c inner join #tmp_s s on c.id = s.id where beg_date < as_date_opened and beg_date >= isnull(as_date_prev, '2008-07-01') and s.subunit = c.as_subunit group by c.id) s on c.id = s.id
--services during
update c set c.svc_during = s.svc from #tmp_c c 
inner join (select c.id, count(*) svc from #tmp_c c inner join #tmp_s s on c.id = s.id where (beg_date between as_date_opened and as_date_closed) or (beg_date = as_date_opened) group by c.id) s on c.id = s.id
--services post before next assignment same_sub
update c set c.svc_post_sub = s.svc from #tmp_c c 
inner join (select c.id, count(*) svc from #tmp_c c inner join #tmp_s s on c.id = s.id where beg_date > as_date_closed and beg_date <= isnull(as_date_next, '2020-06-30') and s.subunit = c.as_subunit group by c.id) s on c.id = s.id
--services post before next assignment
update c set c.svc_post = s.svc from #tmp_c c 
inner join (select c.id, count(*) svc from #tmp_c c inner join #tmp_s s on c.id = s.id where beg_date > as_date_closed and beg_date <= isnull(as_date_next, '2020-06-30') group by c.id) s on c.id = s.id
--services post all
update c set c.svc_post_all = s.svc from #tmp_c c 
inner join (select c.id, count(*) svc from #tmp_c c inner join #tmp_s s on c.id = s.id where beg_date > as_date_closed group by c.id) s on c.id = s.id

--update #tmp_c set new = 0, new_3 = 0

--new all
update #tmp_c set new = 1 where svc_pre_all = 0

--new 3 year
update #tmp_c set new_3 = 1 where id not in (select distinct c.id from #tmp_c c inner join #tmp_s s on c.id = s.id where beg_date >= dateadd(d,-1095,as_date_opened))

--select * from #tmp_c order by id

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- engagement rate with OP clinic within 7, 30, 60, 90 days before assignment
-- 7 day counts
create table #tmp_svc (
--declare @svc table (
id int,
svc int default 0,)

--7 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dateadd(d,-7, as_date) and as_date
and c.databook_category = 'Outpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_op_7days_pre = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--30 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dateadd(d,-30, as_date) and as_date
and c.databook_category = 'Outpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_op_30days_pre = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--60 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dateadd(d,-60, as_date) and as_date
and c.databook_category = 'Outpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_op_60days_pre = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--90 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dateadd(d,-90, as_date) and as_date
and c.databook_category = 'Outpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_op_90days_pre = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--es 7,30, 60,90
--7 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dateadd(d,-7, as_date) and as_date
and c.databook_category = 'Emergency/Crisis Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_es_7days_pre = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--30 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dateadd(d,-30, as_date) and as_date
and c.databook_category = 'Emergency/Crisis Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_es_30days_pre = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--60 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dateadd(d,-60, as_date) and as_date
and c.databook_category = 'Emergency/Crisis Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_es_60days_pre = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--90 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dateadd(d,-90, as_date) and as_date
and c.databook_category = 'Emergency/Crisis Services' and svc_group <> 'Inpatient Phys' group by id order by id

--update #tmp_c set svc_es_90days_pre = 0
update c set c.svc_es_90days_pre = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--ip 7,30,60,90
--7 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dateadd(d,-7, as_date) and as_date
and c.databook_category = 'Inpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_ip_7days_pre = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--30 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dateadd(d,-30, as_date) and as_date
and c.databook_category = 'Inpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_ip_30days_pre = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--60 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dateadd(d,-60, as_date) and as_date
and c.databook_category = 'Inpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_ip_60days_pre = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--90 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dateadd(d,-90, as_date) and as_date
and c.databook_category = 'Inpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

--update #tmp_c set svc_ip_90days_pre = 0
update c set c.svc_ip_90days_pre = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- engagement rate with OP clinic within 7, 30, 60, 90 days of discharge
--7 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dc_date and dateadd(d,7, dc_date)
and c.databook_category = 'Outpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_op_7days_postdc = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--30 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dc_date and dateadd(d,30, dc_date)
and c.databook_category = 'Outpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_op_30days_postdc = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--60 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dc_date and dateadd(d,60, dc_date)
and c.databook_category = 'Outpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_op_60days_postdc = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--90 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dc_date and dateadd(d,90, dc_date)
and c.databook_category = 'Outpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_op_90days_postdc = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--es 7,30,60,90
--7 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dc_date and dateadd(d,7, dc_date)
and c.databook_category = 'Emergency/Crisis Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_es_7days_postdc = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--30 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dc_date and dateadd(d,30, dc_date)
and c.databook_category = 'Emergency/Crisis Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_es_30days_postdc = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--60 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dc_date and dateadd(d,60, dc_date)
and c.databook_category = 'Emergency/Crisis Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_es_60days_postdc = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--90 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dc_date and dateadd(d,90, dc_date)
and c.databook_category = 'Emergency/Crisis Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_es_90days_postdc = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--ip 7,30,60,90
--7 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dc_date and dateadd(d,7, dc_date)
and c.databook_category = 'Inpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_ip_7days_postdc = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--30 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dc_date and dateadd(d,30, dc_date)
and c.databook_category = 'Inpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_ip_30days_postdc = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--60 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dc_date and dateadd(d,60, dc_date)
and c.databook_category = 'Inpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_ip_60days_postdc = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--90 days
truncate table #tmp_svc
insert into #tmp_svc
select id, count(*) from #tmp_s s inner join Anasazi_Common..LOC_Codes c on s.loc = c.loc + c.loc_sub where beg_date between dc_date and dateadd(d,90, dc_date)
and c.databook_category = 'Inpatient Services' and svc_group <> 'Inpatient Phys' group by id order by id

update c set c.svc_ip_90days_postdc = s.svc from #tmp_c c inner join #tmp_svc s on c.id = s.id

--------------------------------------------------------------------------------------------------------------
--Add 7,30,60,90 days services for each LOC - pre

--loc svc count table_7 days
create table #tmp_svc_loc_7days (
id int,
loc varchar(max),
svc int
)

truncate table #tmp_svc_loc_7days
insert into #tmp_svc_loc_7days
select c.id, loc, count(*)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where beg_date between dateadd(d,-7, c.as_date_opened) AND c.as_date_opened
group by c.id, loc
order by c.id, loc


update c set c.loc_pre_7days_ACT = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'ACT'
update c set c.loc_pre_7days_CM = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CM'
update c set c.loc_pre_7days_CMINST = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CMINST'
update c set c.loc_pre_7days_CMSTR = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CMSTR'
update c set c.loc_pre_7days_CMTRAN = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CMTRAN'
update c set c.loc_pre_7days_WRAP = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'WRAP'
update c set c.loc_pre_7days_TBS = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'TBS'
update c set c.loc_pre_7days_FFS = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'FFS'
update c set c.loc_pre_7days_OP = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'OP'
update c set c.loc_pre_7days_OPLIHP = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'OPLIHP'
update c set c.loc_pre_7days_OPR = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'OPR'
update c set c.loc_pre_7days_PREV = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'PREV'
update c set c.loc_pre_7days_CO = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CO'
update c set c.loc_pre_7days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CR'
update c set c.loc_pre_7days_CS = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CS'
update c set c.loc_pre_7days_ESU = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'ESU'
update c set c.loc_pre_7days_PERT = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'PERT'
update c set c.loc_pre_7days_UO = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'UO'
update c set c.loc_pre_7days_IP = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'IP'
update c set c.loc_pre_7days_IPCAPS = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'IPCAPS'
update c set c.loc_pre_7days_IPCNTY = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'IPCNTY'
update c set c.loc_pre_7days_IPFFS = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'IPFFS'
update c set c.loc_pre_7days_IPLIHP = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'IPLIHP'
update c set c.loc_pre_7days_IPST = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'IPST'
update c set c.loc_pre_7days_JAIL = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'JAIL'
update c set c.loc_pre_7days_JFS = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'JFS'
update c set c.loc_pre_7days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'EDG'
update c set c.loc_pre_7days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'LTC'
update c set c.loc_pre_7days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.loc_pre_7days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.loc_pre_7days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'RES'
update c set c.loc_pre_7days_BHC = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'BHC'
update c set c.loc_pre_7days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'DTC'
update c set c.loc_pre_7days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.loc_pre_7days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'DTR'
update c set c.loc_pre_7days_STRTP = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'STRTP'


--loc svc count table_30 days
create table #tmp_svc_loc_30days (
id int,
loc varchar(max),
svc int
)

truncate table #tmp_svc_loc_30days
insert into #tmp_svc_loc_30days
select c.id, loc, count(*)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where beg_date between dateadd(d,-30, c.as_date_opened) AND c.as_date_opened
group by c.id, loc
order by c.id, loc

update c set c.loc_pre_30days_ACT = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'ACT'
update c set c.loc_pre_30days_CM = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CM'
update c set c.loc_pre_30days_CMINST = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CMINST'
update c set c.loc_pre_30days_CMSTR = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CMSTR'
update c set c.loc_pre_30days_CMTRAN = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CMTRAN'
update c set c.loc_pre_30days_WRAP = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'WRAP'
update c set c.loc_pre_30days_TBS = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'TBS'
update c set c.loc_pre_30days_FFS = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'FFS'
update c set c.loc_pre_30days_OP = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'OP'
update c set c.loc_pre_30days_OPLIHP = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'OPLIHP'
update c set c.loc_pre_30days_OPR = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'OPR'
update c set c.loc_pre_30days_PREV = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'PREV'
update c set c.loc_pre_30days_CO = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CO'
update c set c.loc_pre_30days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CR'
update c set c.loc_pre_30days_CS = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CS'
update c set c.loc_pre_30days_ESU = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'ESU'
update c set c.loc_pre_30days_PERT = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'PERT'
update c set c.loc_pre_30days_UO = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'UO'
update c set c.loc_pre_30days_IP = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'IP'
update c set c.loc_pre_30days_IPCAPS = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'IPCAPS'
update c set c.loc_pre_30days_IPCNTY = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'IPCNTY'
update c set c.loc_pre_30days_IPFFS = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'IPFFS'
update c set c.loc_pre_30days_IPLIHP = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'IPLIHP'
update c set c.loc_pre_30days_IPST = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'IPST'
update c set c.loc_pre_30days_JAIL = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'JAIL'
update c set c.loc_pre_30days_JFS = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'JFS'
update c set c.loc_pre_30days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'EDG'
update c set c.loc_pre_30days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'LTC'
update c set c.loc_pre_30days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.loc_pre_30days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.loc_pre_30days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'RES'
update c set c.loc_pre_30days_BHC = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'BHC'
update c set c.loc_pre_30days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'DTC'
update c set c.loc_pre_30days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.loc_pre_30days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'DTR'
update c set c.loc_pre_30days_STRTP = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'STRTP'

--loc svc count table_60 days
create table #tmp_svc_loc_60days (
id int,
loc varchar(max),
svc int
)

truncate table #tmp_svc_loc_60days
insert into #tmp_svc_loc_60days
select c.id, loc, count(*)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where beg_date between dateadd(d,-60, c.as_date_opened) AND c.as_date_opened
group by c.id, loc
order by c.id, loc

update c set c.loc_pre_60days_ACT = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'ACT'
update c set c.loc_pre_60days_CM = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CM'
update c set c.loc_pre_60days_CMINST = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CMINST'
update c set c.loc_pre_60days_CMSTR = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CMSTR'
update c set c.loc_pre_60days_CMTRAN = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CMTRAN'
update c set c.loc_pre_60days_WRAP = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'WRAP'
update c set c.loc_pre_60days_TBS = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'TBS'
update c set c.loc_pre_60days_FFS = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'FFS'
update c set c.loc_pre_60days_OP = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'OP'
update c set c.loc_pre_60days_OPLIHP = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'OPLIHP'
update c set c.loc_pre_60days_OPR = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'OPR'
update c set c.loc_pre_60days_PREV = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'PREV'
update c set c.loc_pre_60days_CO = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CO'
update c set c.loc_pre_60days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CR'
update c set c.loc_pre_60days_CS = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CS'
update c set c.loc_pre_60days_ESU = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'ESU'
update c set c.loc_pre_60days_PERT = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'PERT'
update c set c.loc_pre_60days_UO = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'UO'
update c set c.loc_pre_60days_IP = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'IP'
update c set c.loc_pre_60days_IPCAPS = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'IPCAPS'
update c set c.loc_pre_60days_IPCNTY = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'IPCNTY'
update c set c.loc_pre_60days_IPFFS = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'IPFFS'
update c set c.loc_pre_60days_IPLIHP = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'IPLIHP'
update c set c.loc_pre_60days_IPST = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'IPST'
update c set c.loc_pre_60days_JAIL = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'JAIL'
update c set c.loc_pre_60days_JFS = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'JFS'
update c set c.loc_pre_60days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'EDG'
update c set c.loc_pre_60days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'LTC'
update c set c.loc_pre_60days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.loc_pre_60days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.loc_pre_60days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'RES'
update c set c.loc_pre_60days_BHC = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'BHC'
update c set c.loc_pre_60days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'DTC'
update c set c.loc_pre_60days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.loc_pre_60days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'DTR'
update c set c.loc_pre_60days_STRTP = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'STRTP'


--loc svc count table_90 days
create table #tmp_svc_loc_90days (
id int,
loc varchar(max),
svc int
)

truncate table #tmp_svc_loc_90days
insert into #tmp_svc_loc_90days
select c.id, loc, count(*)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where beg_date between dateadd(d,-90, c.as_date_opened) AND c.as_date_opened
group by c.id, loc
order by c.id, loc

update c set c.loc_pre_90days_ACT = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'ACT'
update c set c.loc_pre_90days_CM = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CM'
update c set c.loc_pre_90days_CMINST = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CMINST'
update c set c.loc_pre_90days_CMSTR = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CMSTR'
update c set c.loc_pre_90days_CMTRAN = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CMTRAN'
update c set c.loc_pre_90days_WRAP = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'WRAP'
update c set c.loc_pre_90days_TBS = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'TBS'
update c set c.loc_pre_90days_FFS = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'FFS'
update c set c.loc_pre_90days_OP = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'OP'
update c set c.loc_pre_90days_OPLIHP = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'OPLIHP'
update c set c.loc_pre_90days_OPR = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'OPR'
update c set c.loc_pre_90days_PREV = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'PREV'
update c set c.loc_pre_90days_CO = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CO'
update c set c.loc_pre_90days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CR'
update c set c.loc_pre_90days_CS = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CS'
update c set c.loc_pre_90days_ESU = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'ESU'
update c set c.loc_pre_90days_PERT = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'PERT'
update c set c.loc_pre_90days_UO = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'UO'
update c set c.loc_pre_90days_IP = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'IP'
update c set c.loc_pre_90days_IPCAPS = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'IPCAPS'
update c set c.loc_pre_90days_IPCNTY = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'IPCNTY'
update c set c.loc_pre_90days_IPFFS = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'IPFFS'
update c set c.loc_pre_90days_IPLIHP = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'IPLIHP'
update c set c.loc_pre_90days_IPST = case when s.svc = 0 then 0 else s.svc - 1 end from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'IPST'
update c set c.loc_pre_90days_JAIL = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'JAIL'
update c set c.loc_pre_90days_JFS = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'JFS'
update c set c.loc_pre_90days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'EDG'
update c set c.loc_pre_90days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'LTC'
update c set c.loc_pre_90days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.loc_pre_90days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.loc_pre_90days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'RES'
update c set c.loc_pre_90days_BHC = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'BHC'
update c set c.loc_pre_90days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'DTC'
update c set c.loc_pre_90days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.loc_pre_90days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'DTR'
update c set c.loc_pre_90days_STRTP = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'STRTP'


------------------------------------------------------------------
--Add 7,30,60,90 days services for each LOC - post (up to before the next IP)

--loc svc count table_7 days


truncate table #tmp_svc_loc_7days
insert into #tmp_svc_loc_7days
select c.id, loc, count(*)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where (datediff(d, beg_date, c.as_date_next) > 0 AND (beg_date between c.as_date_closed AND dateadd(d,7, c.as_date_closed))) OR
											(beg_date between c.as_date_closed AND dateadd(d,7, c.as_date_closed))
group by c.id, loc
order by c.id, loc


update c set c.loc_post_7days_ACT = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'ACT'
update c set c.loc_post_7days_CM = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CM'
update c set c.loc_post_7days_CMINST = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CMINST'
update c set c.loc_post_7days_CMSTR = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CMSTR'
update c set c.loc_post_7days_CMTRAN = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CMTRAN'
update c set c.loc_post_7days_WRAP = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'WRAP'
update c set c.loc_post_7days_TBS = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'TBS'
update c set c.loc_post_7days_FFS = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'FFS'
update c set c.loc_post_7days_OP = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'OP'
update c set c.loc_post_7days_OPLIHP = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'OPLIHP'
update c set c.loc_post_7days_OPR = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'OPR'
update c set c.loc_post_7days_PREV = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'PREV'
update c set c.loc_post_7days_CO = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CO'
update c set c.loc_post_7days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CR'
update c set c.loc_post_7days_CS = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CS'
update c set c.loc_post_7days_ESU = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'ESU'
update c set c.loc_post_7days_PERT = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'PERT'
update c set c.loc_post_7days_UO = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'UO'
update c set c.loc_post_7days_IP = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'IP'
update c set c.loc_post_7days_IPCAPS = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'IPCAPS'
update c set c.loc_post_7days_IPCNTY = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'IPCNTY'
update c set c.loc_post_7days_IPFFS = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'IPFFS'
update c set c.loc_post_7days_IPLIHP = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'IPLIHP'
update c set c.loc_post_7days_IPST = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'IPST'
update c set c.loc_post_7days_JAIL = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'JAIL'
update c set c.loc_post_7days_JFS = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'JFS'
update c set c.loc_post_7days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'EDG'
update c set c.loc_post_7days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'LTC'
update c set c.loc_post_7days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.loc_post_7days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.loc_post_7days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'RES'
update c set c.loc_post_7days_BHC = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'BHC'
update c set c.loc_post_7days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'DTC'
update c set c.loc_post_7days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.loc_post_7days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'DTR'
update c set c.loc_post_7days_STRTP = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'STRTP'


--loc svc count table_30 days

truncate table #tmp_svc_loc_30days
insert into #tmp_svc_loc_30days
select c.id, loc, count(*)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where (datediff(d, beg_date, c.as_date_next) > 0 AND (beg_date between c.as_date_closed AND dateadd(d,30, c.as_date_closed))) OR
											(beg_date between c.as_date_closed AND dateadd(d,30, c.as_date_closed))
group by c.id, loc
order by c.id, loc

update c set c.loc_post_30days_ACT = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'ACT'
update c set c.loc_post_30days_CM = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CM'
update c set c.loc_post_30days_CMINST = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CMINST'
update c set c.loc_post_30days_CMSTR = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CMSTR'
update c set c.loc_post_30days_CMTRAN = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CMTRAN'
update c set c.loc_post_30days_WRAP = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'WRAP'
update c set c.loc_post_30days_TBS = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'TBS'
update c set c.loc_post_30days_FFS = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'FFS'
update c set c.loc_post_30days_OP = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'OP'
update c set c.loc_post_30days_OPLIHP = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'OPLIHP'
update c set c.loc_post_30days_OPR = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'OPR'
update c set c.loc_post_30days_PREV = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'PREV'
update c set c.loc_post_30days_CO = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CO'
update c set c.loc_post_30days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CR'
update c set c.loc_post_30days_CS = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CS'
update c set c.loc_post_30days_ESU = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'ESU'
update c set c.loc_post_30days_PERT = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'PERT'
update c set c.loc_post_30days_UO = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'UO'
update c set c.loc_post_30days_IP = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'IP'
update c set c.loc_post_30days_IPCAPS = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'IPCAPS'
update c set c.loc_post_30days_IPCNTY = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'IPCNTY'
update c set c.loc_post_30days_IPFFS = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'IPFFS'
update c set c.loc_post_30days_IPLIHP = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'IPLIHP'
update c set c.loc_post_30days_IPST = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'IPST'
update c set c.loc_post_30days_JAIL = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'JAIL'
update c set c.loc_post_30days_JFS = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'JFS'
update c set c.loc_post_30days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'EDG'
update c set c.loc_post_30days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'LTC'
update c set c.loc_post_30days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.loc_post_30days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.loc_post_30days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'RES'
update c set c.loc_post_30days_BHC = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'BHC'
update c set c.loc_post_30days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'DTC'
update c set c.loc_post_30days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.loc_post_30days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'DTR'
update c set c.loc_post_30days_STRTP = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'STRTP'

--loc svc count table_60 days

truncate table #tmp_svc_loc_60days
insert into #tmp_svc_loc_60days
select c.id, loc, count(*)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where (datediff(d, beg_date, c.as_date_next) > 0 AND (beg_date between c.as_date_closed AND dateadd(d,60, c.as_date_closed))) OR
											(beg_date between c.as_date_closed AND dateadd(d,60, c.as_date_closed))
group by c.id, loc
order by c.id, loc

update c set c.loc_post_60days_ACT = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'ACT'
update c set c.loc_post_60days_CM = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CM'
update c set c.loc_post_60days_CMINST = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CMINST'
update c set c.loc_post_60days_CMSTR = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CMSTR'
update c set c.loc_post_60days_CMTRAN = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CMTRAN'
update c set c.loc_post_60days_WRAP = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'WRAP'
update c set c.loc_post_60days_TBS = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'TBS'
update c set c.loc_post_60days_FFS = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'FFS'
update c set c.loc_post_60days_OP = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'OP'
update c set c.loc_post_60days_OPLIHP = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'OPLIHP'
update c set c.loc_post_60days_OPR = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'OPR'
update c set c.loc_post_60days_PREV = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'PREV'
update c set c.loc_post_60days_CO = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CO'
update c set c.loc_post_60days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CR'
update c set c.loc_post_60days_CS = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CS'
update c set c.loc_post_60days_ESU = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'ESU'
update c set c.loc_post_60days_PERT = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'PERT'
update c set c.loc_post_60days_UO = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'UO'
update c set c.loc_post_60days_IP = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'IP'
update c set c.loc_post_60days_IPCAPS = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'IPCAPS'
update c set c.loc_post_60days_IPCNTY = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'IPCNTY'
update c set c.loc_post_60days_IPFFS = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'IPFFS'
update c set c.loc_post_60days_IPLIHP = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'IPLIHP'
update c set c.loc_post_60days_IPST = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'IPST'
update c set c.loc_post_60days_JAIL = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'JAIL'
update c set c.loc_post_60days_JFS = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'JFS'
update c set c.loc_post_60days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'EDG'
update c set c.loc_post_60days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'LTC'
update c set c.loc_post_60days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.loc_post_60days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.loc_post_60days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'RES'
update c set c.loc_post_60days_BHC = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'BHC'
update c set c.loc_post_60days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'DTC'
update c set c.loc_post_60days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.loc_post_60days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'DTR'
update c set c.loc_post_60days_STRTP = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'STRTP'


--loc svc count table_90 days

truncate table #tmp_svc_loc_90days
insert into #tmp_svc_loc_90days
select c.id, loc, count(*)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where (datediff(d, beg_date, c.as_date_next) > 0 AND (beg_date between c.as_date_closed AND dateadd(d,90, c.as_date_closed))) OR
											(beg_date between c.as_date_closed AND dateadd(d,90, c.as_date_closed))
group by c.id, loc
order by c.id, loc

update c set c.loc_post_90days_ACT = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'ACT'
update c set c.loc_post_90days_CM = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CM'
update c set c.loc_post_90days_CMINST = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CMINST'
update c set c.loc_post_90days_CMSTR = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CMSTR'
update c set c.loc_post_90days_CMTRAN = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CMTRAN'
update c set c.loc_post_90days_WRAP = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'WRAP'
update c set c.loc_post_90days_TBS = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'TBS'
update c set c.loc_post_90days_FFS = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'FFS'
update c set c.loc_post_90days_OP = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'OP'
update c set c.loc_post_90days_OPLIHP = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'OPLIHP'
update c set c.loc_post_90days_OPR = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'OPR'
update c set c.loc_post_90days_PREV = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'PREV'
update c set c.loc_post_90days_CO = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CO'
update c set c.loc_post_90days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CR'
update c set c.loc_post_90days_CS = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CS'
update c set c.loc_post_90days_ESU = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'ESU'
update c set c.loc_post_90days_PERT = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'PERT'
update c set c.loc_post_90days_UO = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'UO'
update c set c.loc_post_90days_IP = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'IP'
update c set c.loc_post_90days_IPCAPS = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'IPCAPS'
update c set c.loc_post_90days_IPCNTY = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'IPCNTY'
update c set c.loc_post_90days_IPFFS = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'IPFFS'
update c set c.loc_post_90days_IPLIHP = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'IPLIHP'
update c set c.loc_post_90days_IPST = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'IPST'
update c set c.loc_post_90days_JAIL = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'JAIL'
update c set c.loc_post_90days_JFS = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'JFS'
update c set c.loc_post_90days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'EDG'
update c set c.loc_post_90days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'LTC'
update c set c.loc_post_90days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.loc_post_90days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.loc_post_90days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'RES'
update c set c.loc_post_90days_BHC = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'BHC'
update c set c.loc_post_90days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'DTC'
update c set c.loc_post_90days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.loc_post_90days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'DTR'
update c set c.loc_post_90days_STRTP = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'STRTP'

---------------------------------------------------
--Upadte the day of residential loc
--Add 7,30,60,90-day service days for each residential LOC - pre

--loc svc count table_7 days
truncate table #tmp_svc_loc_7days
insert into #tmp_svc_loc_7days
select c.id, loc, sum(days_svc_min1)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where beg_date between dateadd(d,-7, c.as_date_opened) AND c.as_date_opened
group by c.id, loc
order by c.id, loc

update c set c.day_loc_pre_7days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CR'
update c set c.day_loc_pre_7days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'EDG'
update c set c.day_loc_pre_7days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'LTC'
update c set c.day_loc_pre_7days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.day_loc_pre_7days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.day_loc_pre_7days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'RES'
update c set c.day_loc_pre_7days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'DTC'
update c set c.day_loc_pre_7days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.day_loc_pre_7days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'DTR'

truncate table #tmp_svc_loc_30days
insert into #tmp_svc_loc_30days
select c.id, loc, sum(days_svc_min1)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where beg_date between dateadd(d,-30, c.as_date_opened) AND c.as_date_opened
group by c.id, loc
order by c.id, loc

update c set c.day_loc_pre_30days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CR'
update c set c.day_loc_pre_30days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'EDG'
update c set c.day_loc_pre_30days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'LTC'
update c set c.day_loc_pre_30days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.day_loc_pre_30days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.day_loc_pre_30days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'RES'
update c set c.day_loc_pre_30days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'DTC'
update c set c.day_loc_pre_30days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.day_loc_pre_30days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'DTR'


truncate table #tmp_svc_loc_60days
insert into #tmp_svc_loc_60days
select c.id, loc, sum(days_svc_min1)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where beg_date between dateadd(d,-60, c.as_date_opened) AND c.as_date_opened
group by c.id, loc
order by c.id, loc

update c set c.day_loc_pre_60days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CR'
update c set c.day_loc_pre_60days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'EDG'
update c set c.day_loc_pre_60days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'LTC'
update c set c.day_loc_pre_60days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.day_loc_pre_60days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.day_loc_pre_60days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'RES'
update c set c.day_loc_pre_60days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'DTC'
update c set c.day_loc_pre_60days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.day_loc_pre_60days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'DTR'


truncate table #tmp_svc_loc_90days
insert into #tmp_svc_loc_90days
select c.id, loc, sum(days_svc_min1)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where beg_date between dateadd(d,-90, c.as_date_opened) AND c.as_date_opened
group by c.id, loc
order by c.id, loc

update c set c.day_loc_pre_90days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CR'
update c set c.day_loc_pre_90days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'EDG'
update c set c.day_loc_pre_90days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'LTC'
update c set c.day_loc_pre_90days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.day_loc_pre_90days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.day_loc_pre_90days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'RES'
update c set c.day_loc_pre_90days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'DTC'
update c set c.day_loc_pre_90days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.day_loc_pre_90days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'DTR'


--Add 7,30,60,90-day service days for each residential LOC - post

truncate table #tmp_svc_loc_7days
insert into #tmp_svc_loc_7days
select c.id, loc, sum(days_svc_min1)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where (datediff(d, beg_date, c.as_date_next) > 0 AND (beg_date between c.as_date_closed AND dateadd(d,7, c.as_date_closed))) OR
											(beg_date between c.as_date_closed AND dateadd(d,7, c.as_date_closed))
group by c.id, loc
order by c.id, loc

update c set c.day_loc_post_7days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'CR'
update c set c.day_loc_post_7days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'EDG'
update c set c.day_loc_post_7days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'LTC'
update c set c.day_loc_post_7days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.day_loc_post_7days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.day_loc_post_7days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'RES'
update c set c.day_loc_post_7days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'DTC'
update c set c.day_loc_post_7days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.day_loc_post_7days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_7days s on c.id = s.id and s.loc = 'DTR'


truncate table #tmp_svc_loc_30days
insert into #tmp_svc_loc_30days
select c.id, loc, sum(days_svc_min1)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where (datediff(d, beg_date, c.as_date_next) > 0 AND (beg_date between c.as_date_closed AND dateadd(d,30, c.as_date_closed))) OR
											(beg_date between c.as_date_closed AND dateadd(d,30, c.as_date_closed))
group by c.id, loc
order by c.id, loc

update c set c.day_loc_post_30days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'CR'
update c set c.day_loc_post_30days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'EDG'
update c set c.day_loc_post_30days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'LTC'
update c set c.day_loc_post_30days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.day_loc_post_30days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.day_loc_post_30days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'RES'
update c set c.day_loc_post_30days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'DTC'
update c set c.day_loc_post_30days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.day_loc_post_30days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_30days s on c.id = s.id and s.loc = 'DTR'

truncate table #tmp_svc_loc_60days
insert into #tmp_svc_loc_60days
select c.id, loc, sum(days_svc_min1)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where (datediff(d, beg_date, c.as_date_next) > 0 AND (beg_date between c.as_date_closed AND dateadd(d,60, c.as_date_closed))) OR
											(beg_date between c.as_date_closed AND dateadd(d,60, c.as_date_closed))
group by c.id, loc
order by c.id, loc

update c set c.day_loc_post_60days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'CR'
update c set c.day_loc_post_60days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'EDG'
update c set c.day_loc_post_60days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'LTC'
update c set c.day_loc_post_60days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.day_loc_post_60days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.day_loc_post_60days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'RES'
update c set c.day_loc_post_60days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'DTC'
update c set c.day_loc_post_60days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.day_loc_post_60days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_60days s on c.id = s.id and s.loc = 'DTR'

truncate table #tmp_svc_loc_90days
insert into #tmp_svc_loc_90days
select c.id, loc, sum(days_svc_min1)
from #tmp_c c
inner join #tmp_s s on c.id = s.id
where (datediff(d, beg_date, c.as_date_next) > 0 AND (beg_date between c.as_date_closed AND dateadd(d,90, c.as_date_closed))) OR
											(beg_date between c.as_date_closed AND dateadd(d,90, c.as_date_closed))
group by c.id, loc
order by c.id, loc

update c set c.day_loc_post_90days_CR = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'CR'
update c set c.day_loc_post_90days_EDG = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'EDG'
update c set c.day_loc_post_90days_LTC = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'LTC'
update c set c.day_loc_post_90days_LTCINST = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'LTCINST'
update c set c.day_loc_post_90days_LTCRES = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'LTCRES'
update c set c.day_loc_post_90days_RES = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'RES'
update c set c.day_loc_post_90days_DTC = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'DTC'
update c set c.day_loc_post_90days_DTCTF = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'DTCTF'
update c set c.day_loc_post_90days_DTR = s.svc from #tmp_c c inner join #tmp_svc_loc_90days s on c.id = s.id and s.loc = 'DTR'

-----------------------------------------------------------------------------------------------
--Update the databook group services
--AOA pre
update #tmp_c set svc_AOA_op_7days_pre = loc_pre_7days_ACT + loc_pre_7days_CM + loc_pre_7days_CMINST +loc_pre_7days_CMSTR + loc_pre_7days_CMTRAN + loc_pre_7days_FFS + loc_pre_7days_OP + loc_pre_7days_PREV WHERE as_pop = 'A'
update #tmp_c set svc_AOA_es_7days_pre = loc_pre_7days_CO + loc_pre_7days_CR + loc_pre_7days_CS + loc_pre_7days_PERT + loc_pre_7days_UO WHERE as_pop = 'A'
update #tmp_c set svc_AOA_fs_7days_pre = loc_pre_7days_JAIL WHERE as_pop = 'A'
update #tmp_c set svc_AOA_24h_7days_pre = loc_pre_7days_EDG + loc_pre_7days_LTC + loc_pre_7days_LTCINST + loc_pre_7days_LTCRES + loc_pre_7days_RES WHERE as_pop = 'A'
update #tmp_c set svc_AOA_ip_7days_pre = loc_pre_7days_IP +loc_pre_7days_IPCNTY + loc_pre_7days_IPFFS + loc_pre_7days_IPST WHERE as_pop = 'A'

update #tmp_c set svc_AOA_op_30days_pre = loc_pre_30days_ACT + loc_pre_30days_CM + loc_pre_30days_CMINST +loc_pre_30days_CMSTR + loc_pre_30days_CMTRAN + loc_pre_30days_FFS + loc_pre_30days_OP + loc_pre_30days_PREV WHERE as_pop = 'A'
update #tmp_c set svc_AOA_es_30days_pre = loc_pre_30days_CO + loc_pre_30days_CR + loc_pre_30days_CS + loc_pre_30days_PERT + loc_pre_30days_UO WHERE as_pop = 'A'
update #tmp_c set svc_AOA_fs_30days_pre = loc_pre_30days_JAIL WHERE as_pop = 'A'
update #tmp_c set svc_AOA_24h_30days_pre = loc_pre_30days_EDG + loc_pre_30days_LTC + loc_pre_30days_LTCINST + loc_pre_30days_LTCRES + loc_pre_30days_RES WHERE as_pop = 'A'
update #tmp_c set svc_AOA_ip_30days_pre = loc_pre_30days_IP +loc_pre_30days_IPCNTY + loc_pre_30days_IPFFS + loc_pre_30days_IPST WHERE as_pop = 'A'

update #tmp_c set svc_AOA_op_60days_pre = loc_pre_60days_ACT + loc_pre_60days_CM + loc_pre_60days_CMINST +loc_pre_60days_CMSTR + loc_pre_60days_CMTRAN + loc_pre_60days_FFS + loc_pre_60days_OP + loc_pre_60days_PREV WHERE as_pop = 'A'
update #tmp_c set svc_AOA_es_60days_pre = loc_pre_60days_CO + loc_pre_60days_CR + loc_pre_60days_CS + loc_pre_60days_PERT + loc_pre_60days_UO WHERE as_pop = 'A'
update #tmp_c set svc_AOA_fs_60days_pre = loc_pre_60days_JAIL WHERE as_pop = 'A'
update #tmp_c set svc_AOA_24h_60days_pre = loc_pre_60days_EDG + loc_pre_60days_LTC + loc_pre_60days_LTCINST + loc_pre_60days_LTCRES + loc_pre_60days_RES WHERE as_pop = 'A'
update #tmp_c set svc_AOA_ip_60days_pre = loc_pre_60days_IP +loc_pre_60days_IPCNTY + loc_pre_60days_IPFFS + loc_pre_60days_IPST WHERE as_pop = 'A'

update #tmp_c set svc_AOA_op_90days_pre = loc_pre_90days_ACT + loc_pre_90days_CM + loc_pre_90days_CMINST +loc_pre_90days_CMSTR + loc_pre_90days_CMTRAN + loc_pre_90days_FFS + loc_pre_90days_OP + loc_pre_90days_PREV WHERE as_pop = 'A'
update #tmp_c set svc_AOA_es_90days_pre = loc_pre_90days_CO + loc_pre_90days_CR + loc_pre_90days_CS + loc_pre_90days_PERT + loc_pre_90days_UO WHERE as_pop = 'A'
update #tmp_c set svc_AOA_fs_90days_pre = loc_pre_90days_JAIL WHERE as_pop = 'A'
update #tmp_c set svc_AOA_24h_90days_pre = loc_pre_90days_EDG + loc_pre_90days_LTC + loc_pre_90days_LTCINST + loc_pre_90days_LTCRES + loc_pre_90days_RES WHERE as_pop = 'A'
update #tmp_c set svc_AOA_ip_90days_pre = loc_pre_90days_IP +loc_pre_90days_IPCNTY + loc_pre_90days_IPFFS + loc_pre_90days_IPST WHERE as_pop = 'A'


--CYF pre
update #tmp_c set svc_CYF_op_7days_pre =  loc_pre_7days_FFS + loc_pre_7days_OP + loc_pre_7days_OPR + loc_pre_7days_OPR + loc_pre_7days_JFS + loc_pre_7days_WRAP + loc_pre_7days_TBS  WHERE as_pop = 'C'
update #tmp_c set svc_CYF_es_7days_pre =  loc_pre_7days_ESU + loc_pre_7days_CS + loc_pre_7days_UO WHERE as_pop = 'C'
update #tmp_c set svc_CYF_dt_7days_pre =  loc_pre_7days_DTC + loc_pre_7days_DTR + loc_pre_7days_DTCTF WHERE as_pop = 'C'
update #tmp_c set svc_CYF_ip_7days_pre =  loc_pre_7days_IPCAPS + loc_pre_7days_IPFFS WHERE as_pop = 'C'

update #tmp_c set svc_CYF_op_30days_pre =  loc_pre_30days_FFS + loc_pre_30days_OP + loc_pre_30days_OPR + loc_pre_30days_OPR + loc_pre_30days_JFS + loc_pre_30days_WRAP + loc_pre_30days_TBS  WHERE as_pop = 'C'
update #tmp_c set svc_CYF_es_30days_pre =  loc_pre_30days_ESU + loc_pre_30days_CS + loc_pre_30days_UO WHERE as_pop = 'C'
update #tmp_c set svc_CYF_dt_30days_pre =  loc_pre_30days_DTC + loc_pre_30days_DTR + loc_pre_30days_DTCTF WHERE as_pop = 'C'
update #tmp_c set svc_CYF_ip_30days_pre =  loc_pre_30days_IPCAPS + loc_pre_30days_IPFFS WHERE as_pop = 'C'

update #tmp_c set svc_CYF_op_60days_pre =  loc_pre_60days_FFS + loc_pre_60days_OP + loc_pre_60days_OPR + loc_pre_60days_OPR + loc_pre_60days_JFS + loc_pre_60days_WRAP + loc_pre_60days_TBS  WHERE as_pop = 'C'
update #tmp_c set svc_CYF_es_60days_pre =  loc_pre_60days_ESU + loc_pre_60days_CS + loc_pre_60days_UO WHERE as_pop = 'C'
update #tmp_c set svc_CYF_dt_60days_pre =  loc_pre_60days_DTC + loc_pre_60days_DTR + loc_pre_60days_DTCTF WHERE as_pop = 'C'
update #tmp_c set svc_CYF_ip_60days_pre =  loc_pre_60days_IPCAPS + loc_pre_60days_IPFFS WHERE as_pop = 'C'

update #tmp_c set svc_CYF_op_90days_pre =  loc_pre_90days_FFS + loc_pre_90days_OP + loc_pre_90days_OPR + loc_pre_90days_OPR + loc_pre_90days_JFS + loc_pre_90days_WRAP + loc_pre_90days_TBS  WHERE as_pop = 'C'
update #tmp_c set svc_CYF_es_90days_pre =  loc_pre_90days_ESU + loc_pre_90days_CS + loc_pre_90days_UO WHERE as_pop = 'C'
update #tmp_c set svc_CYF_dt_90days_pre =  loc_pre_90days_DTC + loc_pre_90days_DTR + loc_pre_90days_DTCTF WHERE as_pop = 'C'
update #tmp_c set svc_CYF_ip_90days_pre =  loc_pre_90days_IPCAPS + loc_pre_90days_IPFFS WHERE as_pop = 'C'


--AOA post
update #tmp_c set svc_AOA_op_7days_postdc = loc_post_7days_ACT + loc_post_7days_CM + loc_post_7days_CMINST +loc_post_7days_CMSTR + loc_post_7days_CMTRAN + loc_post_7days_FFS + loc_post_7days_OP + loc_post_7days_PREV WHERE as_pop = 'A'
update #tmp_c set svc_AOA_es_7days_postdc = loc_post_7days_CO + loc_post_7days_CR + loc_post_7days_CS + loc_post_7days_PERT + loc_post_7days_UO WHERE as_pop = 'A'
update #tmp_c set svc_AOA_fs_7days_postdc = loc_post_7days_JAIL WHERE as_pop = 'A'
update #tmp_c set svc_AOA_24h_7days_postdc = loc_post_7days_EDG + loc_post_7days_LTC + loc_post_7days_LTCINST + loc_post_7days_LTCRES + loc_post_7days_RES WHERE as_pop = 'A'
update #tmp_c set svc_AOA_ip_7days_postdc = loc_post_7days_IP +loc_post_7days_IPCNTY + loc_post_7days_IPFFS + loc_post_7days_IPST WHERE as_pop = 'A'

update #tmp_c set svc_AOA_op_30days_postdc = loc_post_30days_ACT + loc_post_30days_CM + loc_post_30days_CMINST +loc_post_30days_CMSTR + loc_post_30days_CMTRAN + loc_post_30days_FFS + loc_post_30days_OP + loc_post_30days_PREV WHERE as_pop = 'A'
update #tmp_c set svc_AOA_es_30days_postdc = loc_post_30days_CO + loc_post_30days_CR + loc_post_30days_CS + loc_post_30days_PERT + loc_post_30days_UO WHERE as_pop = 'A'
update #tmp_c set svc_AOA_fs_30days_postdc = loc_post_30days_JAIL WHERE as_pop = 'A'
update #tmp_c set svc_AOA_24h_30days_postdc = loc_post_30days_EDG + loc_post_30days_LTC + loc_post_30days_LTCINST + loc_post_30days_LTCRES + loc_post_30days_RES WHERE as_pop = 'A'
update #tmp_c set svc_AOA_ip_30days_postdc = loc_post_30days_IP +loc_post_30days_IPCNTY + loc_post_30days_IPFFS + loc_post_30days_IPST WHERE as_pop = 'A'

update #tmp_c set svc_AOA_op_60days_postdc = loc_post_60days_ACT + loc_post_60days_CM + loc_post_60days_CMINST +loc_post_60days_CMSTR + loc_post_60days_CMTRAN + loc_post_60days_FFS + loc_post_60days_OP + loc_post_60days_PREV WHERE as_pop = 'A'
update #tmp_c set svc_AOA_es_60days_postdc = loc_post_60days_CO + loc_post_60days_CR + loc_post_60days_CS + loc_post_60days_PERT + loc_post_60days_UO WHERE as_pop = 'A'
update #tmp_c set svc_AOA_fs_60days_postdc = loc_post_60days_JAIL WHERE as_pop = 'A'
update #tmp_c set svc_AOA_24h_60days_postdc = loc_post_60days_EDG + loc_post_60days_LTC + loc_post_60days_LTCINST + loc_post_60days_LTCRES + loc_post_60days_RES WHERE as_pop = 'A'
update #tmp_c set svc_AOA_ip_60days_postdc = loc_post_60days_IP +loc_post_60days_IPCNTY + loc_post_60days_IPFFS + loc_post_60days_IPST WHERE as_pop = 'A'

update #tmp_c set svc_AOA_op_90days_postdc = loc_post_90days_ACT + loc_post_90days_CM + loc_post_90days_CMINST +loc_post_90days_CMSTR + loc_post_90days_CMTRAN + loc_post_90days_FFS + loc_post_90days_OP + loc_post_90days_PREV WHERE as_pop = 'A'
update #tmp_c set svc_AOA_es_90days_postdc = loc_post_90days_CO + loc_post_90days_CR + loc_post_90days_CS + loc_post_90days_PERT + loc_post_90days_UO WHERE as_pop = 'A'
update #tmp_c set svc_AOA_fs_90days_postdc = loc_post_90days_JAIL WHERE as_pop = 'A'
update #tmp_c set svc_AOA_24h_90days_postdc = loc_post_90days_EDG + loc_post_90days_LTC + loc_post_90days_LTCINST + loc_post_90days_LTCRES + loc_post_90days_RES WHERE as_pop = 'A'
update #tmp_c set svc_AOA_ip_90days_postdc = loc_post_90days_IP +loc_post_90days_IPCNTY + loc_post_90days_IPFFS + loc_post_90days_IPST WHERE as_pop = 'A'


--CYF post
update #tmp_c set svc_CYF_op_7days_postdc =  loc_post_7days_FFS + loc_post_7days_OP + loc_post_7days_OPR + loc_post_7days_OPR + loc_post_7days_JFS + loc_post_7days_WRAP + loc_post_7days_TBS  WHERE as_pop = 'C'
update #tmp_c set svc_CYF_es_7days_postdc =  loc_post_7days_ESU + loc_post_7days_CS + loc_post_7days_UO WHERE as_pop = 'C'
update #tmp_c set svc_CYF_dt_7days_postdc =  loc_post_7days_DTC + loc_post_7days_DTR + loc_post_7days_DTCTF WHERE as_pop = 'C'
update #tmp_c set svc_CYF_ip_7days_postdc =  loc_post_7days_IPCAPS + loc_post_7days_IPFFS WHERE as_pop = 'C'

update #tmp_c set svc_CYF_op_30days_postdc =  loc_post_30days_FFS + loc_post_30days_OP + loc_post_30days_OPR + loc_post_30days_OPR + loc_post_30days_JFS + loc_post_30days_WRAP + loc_post_30days_TBS  WHERE as_pop = 'C'
update #tmp_c set svc_CYF_es_30days_postdc =  loc_post_30days_ESU + loc_post_30days_CS + loc_post_30days_UO WHERE as_pop = 'C'
update #tmp_c set svc_CYF_dt_30days_postdc =  loc_post_30days_DTC + loc_post_30days_DTR + loc_post_30days_DTCTF WHERE as_pop = 'C'
update #tmp_c set svc_CYF_ip_30days_postdc =  loc_post_30days_IPCAPS + loc_post_30days_IPFFS WHERE as_pop = 'C'

update #tmp_c set svc_CYF_op_60days_postdc =  loc_post_60days_FFS + loc_post_60days_OP + loc_post_60days_OPR + loc_post_60days_OPR + loc_post_60days_JFS + loc_post_60days_WRAP + loc_post_60days_TBS  WHERE as_pop = 'C'
update #tmp_c set svc_CYF_es_60days_postdc =  loc_post_60days_ESU + loc_post_60days_CS + loc_post_60days_UO WHERE as_pop = 'C'
update #tmp_c set svc_CYF_dt_60days_postdc =  loc_post_60days_DTC + loc_post_60days_DTR + loc_post_60days_DTCTF WHERE as_pop = 'C'
update #tmp_c set svc_CYF_ip_60days_postdc =  loc_post_60days_IPCAPS + loc_post_60days_IPFFS WHERE as_pop = 'C'

update #tmp_c set svc_CYF_op_90days_postdc =  loc_post_90days_FFS + loc_post_90days_OP + loc_post_90days_OPR + loc_post_90days_OPR + loc_post_90days_JFS + loc_post_90days_WRAP + loc_post_90days_TBS  WHERE as_pop = 'C'
update #tmp_c set svc_CYF_es_90days_postdc =  loc_post_90days_ESU + loc_post_90days_CS + loc_post_90days_UO WHERE as_pop = 'C'
update #tmp_c set svc_CYF_dt_90days_postdc =  loc_post_90days_DTC + loc_post_90days_DTR + loc_post_90days_DTCTF WHERE as_pop = 'C'
update #tmp_c set svc_CYF_ip_90days_postdc =  loc_post_90days_IPCAPS + loc_post_90days_IPFFS WHERE as_pop = 'C'



--declare svc tables
create table #tmp_svc_list (
--declare @svc table (
id int,
num int,
assign_id int,
recnum int,
svc_date date,
svc_days int,
svc_loc varchar(20),
svc_unit varchar(20),
svc_subunit varchar(20),
svc_su_name varchar(max),
svc_desc varchar(max),
svc_group varchar(max)
)

--select * from #tmp_s

--load previous 10 services
truncate table #tmp_svc_list
insert into #tmp_svc_list
select c.id, '0', c.assign_id, recnum, beg_date, days_svc_min1, loc, unit, subunit, su_name, svc_desc, svc_group from #tmp_s s inner join #tmp_c c on s.id = c.id where beg_date < as_date_opened and c.assign_id <> s.assign_id order by c.id, beg_date desc

update s set s.num = s2.num from #tmp_svc_list s inner join (
	select id, DENSE_RANK() OVER (PARTITION BY a.id ORDER BY a.id, svc_date desc, l.level, g.level, recnum) AS num, recnum, svc_date
	from #tmp_svc_list a left join Anasazi_Common..LOC_Codes l on a.svc_loc = l.loc+l.loc_sub left join Anasazi_Common..Service_Group_Level g on a.svc_group = g.service_group
	) s2 on s.id = s2.id and s.recnum = s2.recnum and s.svc_date = s2.svc_date

delete from #tmp_svc_list where num > 10

--previous 10 services
update c set svc1_pre_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_pre_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_pre_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_pre_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_pre_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_pre_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_pre_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_pre_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1'  

update c set svc2_pre_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_pre_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_pre_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_pre_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_pre_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_pre_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_pre_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_pre_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2'  

update c set svc3_pre_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_pre_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_pre_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_pre_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_pre_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_pre_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_pre_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_pre_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3'  

update c set svc4_pre_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_pre_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_pre_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_pre_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_pre_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_pre_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_pre_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_pre_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4'  

update c set svc5_pre_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_pre_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_pre_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_pre_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_pre_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_pre_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_pre_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_pre_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5'  

update c set svc6_pre_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_pre_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_pre_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_pre_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_pre_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_pre_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_pre_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_pre_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6'  

update c set svc7_pre_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_pre_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_pre_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_pre_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_pre_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_pre_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_pre_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_pre_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7'  

update c set svc8_pre_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_pre_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_pre_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_pre_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_pre_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_pre_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_pre_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_pre_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8'  

update c set svc9_pre_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_pre_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_pre_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_pre_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_pre_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_pre_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_pre_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_pre_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9'  

update c set svc10_pre_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_pre_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_pre_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_pre_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_pre_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_pre_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_pre_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_pre_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10'  

create table #tmp_loc (
--declare @loc table(
id int,
num int default 0,
loc varchar(20)
)

truncate table #tmp_loc
insert into #tmp_loc
select id, row_number() over(partition by id order by max(svc_date) desc, min(l.level), min(g.level)) num, svc_loc from #tmp_svc_list a
left join Anasazi_Common..LOC_Codes l on a.svc_loc = l.loc+l.loc_sub left join Anasazi_Common..Service_Group_Level g on a.svc_group = g.service_group group by id, svc_loc order by id, num

--previous 10 loc
update c set loc1_pre = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '1'
update c set loc2_pre = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '2'
update c set loc3_pre = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '3'
update c set loc4_pre = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '4'
update c set loc5_pre = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '5'
update c set loc6_pre = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '6'
update c set loc7_pre = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '7'
update c set loc8_pre = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '8'
update c set loc9_pre = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '9'
update c set loc10_pre = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '10'

--load next 10 services
truncate table #tmp_svc_list
insert into #tmp_svc_list
select c.id, '0', s.assign_id, recnum, beg_date, days_svc_min1, loc, unit, subunit, su_name, svc_desc, svc_group from #tmp_s s inner join #tmp_c c on s.id = c.id 
where beg_date > as_date_closed and s.assign_id <> c.assign_id order by c.id, beg_date

update s set s.num = s2.num from #tmp_svc_list s inner join (
	select id, DENSE_RANK() OVER (PARTITION BY a.id ORDER BY a.id, svc_date, l.level, g.level) AS num, recnum, svc_date
	from #tmp_svc_list a left join Anasazi_Common..LOC_Codes l on a.svc_loc = l.loc+l.loc_sub left join Anasazi_Common..Service_Group_Level g on a.svc_group = g.service_group
	) s2 on s.id = s2.id and s.recnum = s2.recnum and s.svc_date = s2.svc_date

delete from #tmp_svc_list where num > 10

truncate table #tmp_loc
insert into #tmp_loc
select id, row_number() over(partition by id order by min(svc_date), min(l.level), min(g.level)) num, svc_loc from #tmp_svc_list a
left join Anasazi_Common..LOC_Codes l on a.svc_loc = l.loc+l.loc_sub left join Anasazi_Common..Service_Group_Level g on a.svc_group = g.service_group group by id, svc_loc order by id, num

--next 10 loc
update c set loc1_post = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '1'
update c set loc2_post = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '2'
update c set loc3_post = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '3'
update c set loc4_post = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '4'
update c set loc5_post = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '5'
update c set loc6_post = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '6'
update c set loc7_post = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '7'
update c set loc8_post = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '8'
update c set loc9_post = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '9'
update c set loc10_post = s.loc from #tmp_c c inner join #tmp_loc s on c.id = s.id and num = '10'

--next 10 services
update c set svc1_post_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_post_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_post_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_post_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_post_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_post_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_post_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1' 
update c set svc1_post_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '1'  

update c set svc2_post_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_post_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_post_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_post_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_post_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_post_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_post_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2' 
update c set svc2_post_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '2'  

update c set svc3_post_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_post_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_post_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_post_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_post_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_post_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_post_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3' 
update c set svc3_post_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '3'  

update c set svc4_post_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_post_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_post_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_post_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_post_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_post_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_post_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4' 
update c set svc4_post_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '4'  

update c set svc5_post_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_post_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_post_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_post_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_post_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_post_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_post_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5' 
update c set svc5_post_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '5'  

update c set svc6_post_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_post_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_post_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_post_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_post_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_post_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_post_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6' 
update c set svc6_post_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '6'  

update c set svc7_post_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_post_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_post_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_post_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_post_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_post_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_post_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7' 
update c set svc7_post_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '7'  

update c set svc8_post_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_post_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_post_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_post_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_post_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_post_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_post_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8' 
update c set svc8_post_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '8'  

update c set svc9_post_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_post_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_post_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_post_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_post_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_post_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_post_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9' 
update c set svc9_post_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '9'  

update c set svc10_post_date = s.svc_date from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_post_days = s.svc_days from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_post_loc = s.svc_loc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_post_unit = s.svc_unit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_post_subunit = s.svc_subunit from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_post_su_name = s.svc_su_name from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_post_desc = s.svc_desc from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10' 
update c set svc10_post_group = s.svc_group from #tmp_c c inner join #tmp_svc_list s on c.id = s.id where s.num = '10'  


--demographics

update a set gender = b.gender, race = b.race, eth = b.ethnicity, lang = b.planguage, educ = b.educ_id, emp = b.employment_id, liv = b.live_arrange_id, medi_cal = b.medi_cal, medicare = b.medicare, private_ins = b.private_ins
from #tmp_c a inner join Anasazi_FY0809_Final..clients b on a.case_number = b.case_number
where as_date_opened between '2008-07-01' and '2009-06-30'

update a set gender = b.gender, race = b.race, eth = b.ethnicity, lang = b.planguage, educ = b.educ_id, emp = b.employment_id, liv = b.live_arrange_id, medi_cal = b.medi_cal, medicare = b.medicare, private_ins = b.private_ins
from #tmp_c a inner join Anasazi_FY0910_Final..clients b on a.client_id = b.client_id
where as_date_opened between '2009-07-01' and '2010-06-30'

update a set gender = b.gender, race = b.race, eth = b.ethnicity, lang = b.planguage, educ = b.educ_id, emp = b.employment_id, liv = b.live_arrange_id, medi_cal = b.medi_cal, medicare = b.medicare, private_ins = b.private_ins
from #tmp_c a inner join Anasazi_FY1011_Final..clients b on a.client_id = b.client_id
where as_date_opened between '2010-07-01' and '2011-06-30'

update a set gender = b.gender, race = b.race, eth = b.ethnicity, lang = b.planguage, educ = b.educ_id, emp = b.employment_id, liv = b.live_arrange_id, medi_cal = b.medi_cal, medicare = b.medicare, private_ins = b.private_ins
from #tmp_c a inner join Anasazi_FY1112_Final..clients b on a.client_id = b.client_id
where as_date_opened between '2011-07-01' and '2012-06-30'

update a set gender = b.gender, race = b.race, eth = b.ethnicity, lang = b.planguage, educ = b.educ_id, emp = b.employment_id, liv = b.live_arrange_id, medi_cal = b.medi_cal, medicare = b.medicare, private_ins = b.private_ins
from #tmp_c a inner join Anasazi_FY1213_Final..clients b on a.client_id = b.client_id
where as_date_opened between '2012-07-01' and '2013-06-30'

update a set gender = b.gender, race = b.race, eth = b.ethnicity, lang = b.planguage, educ = b.educ_id, emp = b.employment_id, liv = b.live_arrange_id, medi_cal = b.medi_cal, medicare = b.medicare, private_ins = b.private_ins
from #tmp_c a inner join Anasazi_FY1314_Final..clients b on a.client_id = b.client_id
where as_date_opened between '2013-07-01' and '2014-06-30'

update a set gender = b.gender, race = b.race, eth = b.ethnicity, lang = b.planguage, educ = b.educ_id, emp = b.employment_id, liv = b.live_arrange_id, medi_cal = b.medi_cal, medicare = b.medicare, private_ins = b.private_ins
from #tmp_c a inner join Anasazi_FY1415_Final..clients b on a.client_id = b.client_id
where as_date_opened between '2014-07-01' and '2015-06-30'

update a set gender = b.gender, race = b.race, eth = b.ethnicity, lang = b.planguage, educ = b.educ_id, emp = b.employment_id, liv = b.live_arrange_id, medi_cal = b.medi_cal, medicare = b.medicare, private_ins = b.private_ins
from #tmp_c a inner join CCBH_FY1516_Final..clients b on a.client_id = b.client_id
where as_date_opened between '2015-07-01' and '2016-06-30'

update a set gender = b.gender, race = b.race, eth = b.ethnicity, lang = b.planguage, educ = b.educ_id, emp = b.employment_id, liv = b.live_arrange_id, medi_cal = b.medi_cal, medicare = b.medicare, private_ins = b.private_ins
from #tmp_c a inner join CCBH_FY1617_Final..clients b on a.client_id = b.client_id
where as_date_opened between '2016-07-01' and '2017-06-30'

update a set gender = b.gender, race = b.race, eth = b.ethnicity, lang = b.planguage, educ = b.educ_id, emp = b.employment_id, liv = b.live_arrange_id, medi_cal = b.medi_cal, medicare = b.medicare, private_ins = b.private_ins
from #tmp_c a inner join CCBH_FY1718_Final..clients b on a.client_id = b.client_id
where as_date_opened between '2017-07-01' and '2018-06-30'

update a set gender = b.gender, race = b.race, eth = b.ethnicity, lang = b.planguage, educ = b.educ_id, emp = b.employment_id, liv = b.live_arrange_id, medi_cal = b.medi_cal, medicare = b.medicare, private_ins = b.private_ins
from #tmp_c a inner join CCBH_FY1819_Final..clients b on a.client_id = b.client_id
where as_date_opened between '2018-07-01' and '2019-06-30'

update a set gender = b.gender, race = b.race, eth = b.ethnicity, lang = b.planguage, educ = b.educ_id, emp = b.employment_id, liv = b.live_arrange_id, medi_cal = b.medi_cal, medicare = b.medicare, private_ins = b.private_ins
from #tmp_c a inner join CCBH_FY1920_Final..clients b on a.client_id = b.client_id
where as_date_opened between '2019-07-01' and '2020-06-30'
--age

update #tmp_c set age = common.dbo.getage(left(dob, 10), as_date_opened)

--select * from #tmp_c

update #tmp_c
set age_group = 
case
	when age < 6 then 'Age 0-5'
	when age between 6 and 11 then 'Age 6-11'
	when age between 12 and 15 then 'Age 12-15'
	when age between 16 and 17 then 'Age 16-17'
	when age between 18 and 26 then 'Age 18-25'
	when age between 26 and 59 then 'Age 26-59'
	when age > 59 then 'Age 60+'
end

--gender
update #tmp_c
set gender = 
case
	when gender = 'F' then 'Female'
	when gender = 'M' then 'Male'
	when gender = 'A' then 'Another Gender Identity'
	when gender = 'D' then 'Decline to state'
	when gender = 'G' then 'Genderqueer'
	when gender = 'Q' then 'Questioning/Unsure'
	when gender = 'T' then 'Transgender'
else 'Other/Unknown'
end

--language
update #tmp_c
set lang = language_group
--select * 
from #tmp_c i
inner join Anasazi_Common..language_codes l on i.lang = l.ID

update #tmp_c set lang = 'Other Asian' where lang = 'Asian'
update #tmp_c set lang = 'Other Middle Eastern' where lang = 'Middle Eastern'
update #tmp_c set lang = 'Other/Unknown' where lang in ('Other','Unknown')

--race
update c
set race = 'Hispanic'
from #tmp_c c
where eth between 2 and 7

update c
set race = race_lat
from #tmp_c c
inner join Anasazi_Common..race_codes r on c.race = r.ID
where eth not between 2 and 7

update #tmp_c set race = 'Asian/Pacific Islander' where race = 'Asian'
update #tmp_c set race = 'Unknown' where race is null

--ethnicity
update c
set eth = e.Description
from #tmp_c c
inner join Anasazi_Common..ethnicity_codes e on c.eth = e.ID

--education
update #tmp_c set educ = 'High School Diploma/GED' where educ in ('12', '95')
update #tmp_c set educ = 'Some College/Vocational Training' where educ in ('13','98')
update #tmp_c set educ = 'Associates Degree' where educ in ('14','15')
update #tmp_c set educ = 'Bachelors Degree' where educ in ('16','17')
update #tmp_c set educ = 'Masters Degree' where educ in ('18','19')
update #tmp_c set educ = 'Doctoral Degree' where educ in ('20')
update #tmp_c set educ = 'High School Not Completed' where educ in ('1','2','3','4','5','6','7','8','9','10','11','96','97')
update #tmp_c set educ = 'Unknown/Not Reported' where educ in ('0','92', '93', '94', '99', '')

--substance
update c set c.ddx = cl.dx, c.co = cl.co, c.sub = cl.us from #tmp_c c inner join Anasazi_FY0809_Final..clients_sub cl on c.client_id = cl.client_id
where as_date_opened between '2008-07-01' and '2009-06-30'

update c set c.ddx = cl.dx, c.co = cl.co, c.sub = cl.us from #tmp_c c inner join Anasazi_FY0910_Final..clients_sub cl on c.client_id = cl.client_id
where as_date_opened between '2009-07-01' and '2010-06-30'

update c set c.ddx = cl.dx, c.co = cl.co, c.sub = cl.us from #tmp_c c inner join Anasazi_FY1011_Final..clients_sub cl on c.client_id = cl.client_id
where as_date_opened between '2010-07-01' and '2011-06-30'

update c set c.ddx = cl.dx, c.co = cl.co, c.sub = cl.us from #tmp_c c inner join Anasazi_FY1112_Final..clients_sub cl on c.client_id = cl.client_id
where as_date_opened between '2011-07-01' and '2012-06-30'

update c set c.ddx = cl.dx, c.co = cl.co, c.sub = cl.us from #tmp_c c inner join Anasazi_FY1213_Final..clients_sub cl on c.client_id = cl.client_id
where as_date_opened between '2012-07-01' and '2013-06-30'

update c set c.ddx = cl.dx, c.co = cl.co, c.sub = cl.us from #tmp_c c inner join Anasazi_FY1314_Final..clients_sub cl on c.client_id = cl.client_id
where as_date_opened between '2013-07-01' and '2014-06-30'

update c set c.ddx = cl.dx, c.co = cl.co, c.sub = cl.us from #tmp_c c inner join Anasazi_FY1415_Final..clients_sub cl on c.client_id = cl.client_id
where as_date_opened between '2014-07-01' and '2015-06-30'

update c set c.ddx = cl.dx, c.co = cl.co, c.sub = cl.us from #tmp_c c inner join CCBH_FY1516_Final..clients_sub cl on c.client_id = cl.client_id
where as_date_opened between '2015-07-01' and '2016-06-30'

update c set c.ddx = cl.dx, c.co = cl.co, c.sub = cl.us from #tmp_c c inner join CCBH_FY1617_Final..clients_sub cl on c.client_id = cl.client_id
where as_date_opened between '2016-07-01' and '2017-06-30'

update c set c.ddx = cl.dx, c.co = cl.co, c.sub = cl.us from #tmp_c c inner join CCBH_FY1718_Final..clients_sub cl on c.client_id = cl.client_id
where as_date_opened between '2017-07-01' and '2018-06-30'

update c set c.ddx = cl.dx, c.co = cl.co, c.sub = cl.us from #tmp_c c inner join CCBH_FY1819_Final..clients_sub cl on c.client_id = cl.client_id
where as_date_opened between '2018-07-01' and '2019-06-30'

update c set c.ddx = cl.dx, c.co = cl.co, c.sub = cl.us from #tmp_c c inner join CCBH_FY1920_Final..clients_sub cl on c.client_id = cl.client_id
where as_date_opened between '2019-07-01' and '2020-06-30'

--insurance
update #tmp_c set ins = 'Uninsured/Unknown' 
from #tmp_c i 
where medi_cal = 0 and medicare = 0 and private_ins = 0

update #tmp_c set ins = 'Medi-Cal Only' 
from #tmp_c i 
where medi_cal = 1 and medicare = 0 and private_ins = 0

update #tmp_c set ins = 'Medi-Cal + Medicare' 
from #tmp_c i 
where medi_cal = 1 and medicare = 1 and private_ins = 0

update #tmp_c set ins = 'Medicare Only' 
from #tmp_c i 
where medi_cal = 0 and medicare = 1 and private_ins = 0

update #tmp_c set ins = 'Private' 
from #tmp_c i 
where private_ins = 1

--employment
update #tmp_c set emp = category from #tmp_c i inner join Anasazi_Common..employment_status_codes c on i.emp = c.id

update #tmp_c set emp = 'Other'
where emp in ('Supported Employment', 'School', 'Volunteer', 'Homemaker', 'Retired', 'Training')

--living arangement
update #tmp_c set liv = adult_category from #tmp_c i inner join Anasazi_Common..living_arrangement_codes c on i.liv = c.id

update #tmp_c set liv = 'Other/Unknown' where liv in ('Other', 'Unknown', '')

--diagnosis
select c.id, c.client_id, c.case_number, min(level_nbr) as min_level_2
into #tmp_min_level
from Anasazi_Load..TRCLDIAG cdx
inner join #tmp_c c on cdx.client_id = c.client_id and axis = 1
inner join anasazi_common..dx_codes_10 dx on cdx.diag_id = dx.id
where cast(c.case_number as int) > 3
and axis = 1 and priority = 1
and level_nbr <= 9
and cast(BEG_DATE as date) <= as_date_closed and cast(END_DATE as date) >= as_date_opened
group by c.id, c.client_id, c.case_number
order by c.id, c.client_id, c.case_number

--select distinct cdx.client_id, diag_id, cast(BEG_DATE as date) BEG_DATE, cast(END_DATE as date) END_DATE, dx.dx_desc, dx.level_desc, dx.level_desc_kid
--from Anasazi_Load..TRCLDIAG cdx
--inner join #tmp_c c on cdx.client_id = c.client_id and axis = 1
--inner join anasazi_common..dx_codes_10 dx on cdx.diag_id = dx.id
--where cast(c.case_number as int) > 3
--and axis = 1 and priority = 1
--and level_nbr <= 9
--and cast(BEG_DATE as date) <= as_date_closed and cast(END_DATE as date) >= as_date_opened
--order by cdx.client_id


-- all dx that match min level
select distinct cast(cdx.client_id as int) as client_id, c.[case_number], level_desc, level_nbr, id_w_dot
into #tmp_dx
from Anasazi_Load..TRCLDIAG cdx
inner join #tmp_c c on cdx.client_id = c.client_id
inner join anasazi_common..dx_codes_10 dx on cdx.diag_id = dx.id
inner join #tmp_min_level l2 on cdx.client_id = l2.client_id and dx.level_nbr = l2.min_level_2
where axis = 1 and priority = 1
order by cast(cdx.client_id as int)


update #tmp_c
set dx = id_w_dot, dx_group = level_nbr
from #tmp_dx d1
where #tmp_c.client_id = d1.client_id
and d1.id_w_dot in (select top 1 d2.id_w_dot from #tmp_dx d2 where d1.client_id = d2.client_id)

update a set dx_desc = b.dx_desc from #tmp_c a inner join DX_Codes_10 b on a.dx = b.id_w_dot

update a set dx_group = b.level_desc from #tmp_c a inner join DX_Codes_10 b on a.dx = b.id_w_dot

update #tmp_c set dx = 'Other/Excluded' where dx in ('Other','Excluded')
update #tmp_c set dx = 'Invalid/Missing' where dx = 'Invalid' or dx is null


update a set sexorient = pos_sex, justice = b.legal_act, dv = viol_fam, trauma = abused_as_child
from #tmp_c a inner join Anasazi_FY1112_Final..bha b on a.client_id = b.client_id 
where as_date_opened between '2011-07-01' and '2012-06-30'

update a set sexorient = pos_sex, justice = b.legal_act, dv = viol_fam, trauma = abused_as_child
from #tmp_c a inner join Anasazi_FY1213_Final..bha b on a.client_id = b.client_id
where as_date_opened between '2012-07-01' and '2013-06-30'

update a set sexorient = pos_sex, justice = b.legal_act, dv = viol_fam, trauma = abused_as_child, regional = regional_center
from #tmp_c a inner join Anasazi_FY1314_Final..bha b on a.client_id = b.client_id
where as_date_opened between '2013-07-01' and '2014-06-30'

update a set sexorient = pos_sex, justice = b.legal_act, dv = viol_fam, trauma = abused_as_child, regional = regional_center
from #tmp_c a inner join Anasazi_FY1415_Final..bha b on a.client_id = b.client_id
where as_date_opened between '2014-07-01' and '2015-06-30'

update a set sexorient = pos_sex, justice = b.justice, dv = viol_fam, trauma = abused_as_child, regional = regional_center, vet = military, mar = mar_status
from #tmp_c a inner join CCBH_FY1516_Final..bha b on a.client_id = b.client_id
where as_date_opened between '2015-07-01' and '2016-06-30'

update a set sexorient = pos_sex, justice = b.legal_act, dv = viol_fam, trauma = abused_as_child, regional = regional_center, vet = military, mar = mar_status
from #tmp_c a inner join CCBH_FY1617_Final..bha b on a.client_id = b.client_id
where as_date_opened between '2016-07-01' and '2017-06-30'

update a set sexorient = pos_sex, justice = b.justice, dv = viol_fam, trauma = abused_as_child, regional = regional_center, vet = military, mar = mar_status
from #tmp_c a inner join CCBH_FY1718_Final..bha b on a.client_id = b.client_id
where as_date_opened between '2017-07-01' and '2018-06-30'

update a set sexorient = pos_sex, justice = b.justice, dv = viol_fam, trauma = abused_as_child, regional = regional_center, vet = military, mar = mar_status
from #tmp_c a inner join CCBH_FY1819_Final..bha b on a.client_id = b.client_id
where as_date_opened between '2018-07-01' and '2019-06-30'

update a set sexorient = pos_sex, justice = b.justice, dv = viol_fam, trauma = abused_as_child, regional = regional_center, vet = military, mar = mar_status
from #tmp_c a inner join CCBH_FY1920_Final..bha b on a.client_id = b.client_id
where as_date_opened between '2019-07-01' and '2020-06-30'


update c set sexorient = s.description from #tmp_c c inner join sexual_orientation_codes s on c.sexorient = s.code

update #tmp_c set justice = case when justice = 'Y' then '1' else '0' end
update #tmp_c set dv = case when dv = 'Y' then '1' when dv = 'N' then '0' else '' end
update #tmp_c set trauma = case when trauma = 'Y' then '1' when trauma = 'N' then '0' else '' end
update #tmp_c set regional = case when regional = 'Y' then '1' when regional = 'N' then '0' else '' end
update #tmp_c set vet = case when vet = 'Y' then '1' when vet = 'N' then '0' else '' end

update c set mar = s.description from #tmp_c c inner join marital_status_codes s on c.mar = s.ID

select as_pop, count(*) from #tmp_c group by as_pop

/*
drop table SDBHS_ML..paths_IP_08_20_210329
go
select * into SDBHS_ML..paths_IP_08_20_210329 from #tmp_c

select * from #tmp_c
where as_length_IP > 365

select client_id, age, age_group, gender, race, eth, lang, dx, dx_desc, dx_group, sub, ins, educ, emp, liv, sexorient, justice, dv, trauma, regional, vet, mar, goals from #tmp_c 

--counts
select age_group, count(*) from #tmp_c group by age_group -- off because of new age as of date
select gender, count(*) from #tmp_c group by gender 
select lang, count(*) from #tmp_c group by lang 
select race, count(*) from #tmp_c group by race 
select educ, count(*) from #tmp_c group by educ 
select dx, count(*) from #tmp_c group by dx 
select sub, count(*) from #tmp_c group by sub 
select ins, count(*) from #tmp_c group by ins 
select emp, count(*) from #tmp_c group by emp 
select liv, count(*) from #tmp_c group by liv 




select loc_pre_7days_ACT, count(*) from #tmp_c group by loc_pre_7days_ACT order by loc_pre_7days_ACT
select loc_pre_7days_CM, count(*) from #tmp_c group by loc_pre_7days_CM order by loc_pre_7days_CM
select loc_pre_7days_CMINST, count(*) from #tmp_c group by loc_pre_7days_CMINST order by loc_pre_7days_CMINST
select loc_pre_7days_CMSTR, count(*) from #tmp_c group by loc_pre_7days_CMSTR order by loc_pre_7days_CMSTR
select loc_pre_7days_CMTRAN, count(*) from #tmp_c group by loc_pre_7days_CMTRAN order by loc_pre_7days_CMTRAN
select loc_pre_7days_WRAP, count(*) from #tmp_c group by loc_pre_7days_WRAP order by loc_pre_7days_WRAP
select loc_pre_7days_FFS, count(*) from #tmp_c group by loc_pre_7days_FFS order by loc_pre_7days_FFS
select loc_pre_7days_OP, count(*) from #tmp_c group by loc_pre_7days_OP order by loc_pre_7days_OP
select loc_pre_7days_OPLIHP, count(*) from #tmp_c group by loc_pre_7days_OPLIHP order by loc_pre_7days_OPLIHP
select loc_pre_7days_OPR, count(*) from #tmp_c group by loc_pre_7days_OPR order by loc_pre_7days_OPR
select loc_pre_7days_PREV, count(*) from #tmp_c group by loc_pre_7days_PREV order by loc_pre_7days_PREV
select loc_pre_7days_CO, count(*) from #tmp_c group by loc_pre_7days_CO order by loc_pre_7days_CO
select loc_pre_7days_CR, count(*) from #tmp_c group by loc_pre_7days_CR order by loc_pre_7days_CR
select loc_pre_7days_CS, count(*) from #tmp_c group by loc_pre_7days_CS order by loc_pre_7days_CS
select loc_pre_7days_ESU, count(*) from #tmp_c group by loc_pre_7days_ESU order by loc_pre_7days_ESU
select loc_pre_7days_PERT, count(*) from #tmp_c group by loc_pre_7days_PERT order by loc_pre_7days_PERT
select loc_pre_7days_UO, count(*) from #tmp_c group by loc_pre_7days_UO order by loc_pre_7days_UO
select loc_pre_7days_IP, count(*) from #tmp_c group by loc_pre_7days_IP order by loc_pre_7days_IP
select loc_pre_7days_IPCAPS, count(*) from #tmp_c group by loc_pre_7days_IPCAPS order by loc_pre_7days_IPCAPS
select loc_pre_7days_IPCNTY, count(*) from #tmp_c group by loc_pre_7days_IPCNTY order by loc_pre_7days_IPCNTY
select loc_pre_7days_IPFFS, count(*) from #tmp_c group by loc_pre_7days_IPFFS order by loc_pre_7days_IPFFS
select loc_pre_7days_IPLIHP, count(*) from #tmp_c group by loc_pre_7days_IPLIHP order by loc_pre_7days_IPLIHP
select loc_pre_7days_IPST, count(*) from #tmp_c group by loc_pre_7days_IPST order by loc_pre_7days_IPST
select loc_pre_7days_JAIL, count(*) from #tmp_c group by loc_pre_7days_JAIL order by loc_pre_7days_JAIL
select loc_pre_7days_JFS, count(*) from #tmp_c group by loc_pre_7days_JFS order by loc_pre_7days_JFS
select loc_pre_7days_EDG, count(*) from #tmp_c group by loc_pre_7days_EDG order by loc_pre_7days_EDG
select loc_pre_7days_LTC, count(*) from #tmp_c group by loc_pre_7days_LTC order by loc_pre_7days_LTC
select loc_pre_7days_LTCINST, count(*) from #tmp_c group by loc_pre_7days_LTCINST order by loc_pre_7days_LTCINST
select loc_pre_7days_LTCRES, count(*) from #tmp_c group by loc_pre_7days_LTCRES order by loc_pre_7days_LTCRES
select loc_pre_7days_RES, count(*) from #tmp_c group by loc_pre_7days_RES order by loc_pre_7days_RES
select loc_pre_7days_BHC, count(*) from #tmp_c group by loc_pre_7days_BHC order by loc_pre_7days_BHC
select loc_pre_7days_DTC, count(*) from #tmp_c group by loc_pre_7days_DTC order by loc_pre_7days_DTC
select loc_pre_7days_TBS, count(*) from #tmp_c group by loc_pre_7days_TBS order by loc_pre_7days_TBS
select loc_pre_7days_DTCTF, count(*) from #tmp_c group by loc_pre_7days_DTCTF order by loc_pre_7days_DTCTF
select loc_pre_7days_DTR, count(*) from #tmp_c group by loc_pre_7days_DTR order by loc_pre_7days_DTR
select loc_pre_7days_STRTP, count(*) from #tmp_c group by loc_pre_7days_STRTP order by loc_pre_7days_STRTP

select loc_pre_30days_ACT, count(*) from #tmp_c group by loc_pre_30days_ACT order by loc_pre_30days_ACT
select loc_pre_30days_CM, count(*) from #tmp_c group by loc_pre_30days_CM order by loc_pre_30days_CM
select loc_pre_30days_CMINST, count(*) from #tmp_c group by loc_pre_30days_CMINST order by loc_pre_30days_CMINST
select loc_pre_30days_CMSTR, count(*) from #tmp_c group by loc_pre_30days_CMSTR order by loc_pre_30days_CMSTR
select loc_pre_30days_CMTRAN, count(*) from #tmp_c group by loc_pre_30days_CMTRAN order by loc_pre_30days_CMTRAN
select loc_pre_30days_WRAP, count(*) from #tmp_c group by loc_pre_30days_WRAP order by loc_pre_30days_WRAP
select loc_pre_30days_FFS, count(*) from #tmp_c group by loc_pre_30days_FFS order by loc_pre_30days_FFS
select loc_pre_30days_OP, count(*) from #tmp_c group by loc_pre_30days_OP order by loc_pre_30days_OP
select loc_pre_30days_OPLIHP, count(*) from #tmp_c group by loc_pre_30days_OPLIHP order by loc_pre_30days_OPLIHP
select loc_pre_30days_OPR, count(*) from #tmp_c group by loc_pre_30days_OPR order by loc_pre_30days_OPR
select loc_pre_30days_PREV, count(*) from #tmp_c group by loc_pre_30days_PREV order by loc_pre_30days_PREV
select loc_pre_30days_CO, count(*) from #tmp_c group by loc_pre_30days_CO order by loc_pre_30days_CO
select loc_pre_30days_CR, count(*) from #tmp_c group by loc_pre_30days_CR order by loc_pre_30days_CR
select loc_pre_30days_CS, count(*) from #tmp_c group by loc_pre_30days_CS order by loc_pre_30days_CS
select loc_pre_30days_ESU, count(*) from #tmp_c group by loc_pre_30days_ESU order by loc_pre_30days_ESU
select loc_pre_30days_PERT, count(*) from #tmp_c group by loc_pre_30days_PERT order by loc_pre_30days_PERT
select loc_pre_30days_UO, count(*) from #tmp_c group by loc_pre_30days_UO order by loc_pre_30days_UO
select loc_pre_30days_IP, count(*) from #tmp_c group by loc_pre_30days_IP order by loc_pre_30days_IP
select loc_pre_30days_IPCAPS, count(*) from #tmp_c group by loc_pre_30days_IPCAPS order by loc_pre_30days_IPCAPS
select loc_pre_30days_IPCNTY, count(*) from #tmp_c group by loc_pre_30days_IPCNTY order by loc_pre_30days_IPCNTY
select loc_pre_30days_IPFFS, count(*) from #tmp_c group by loc_pre_30days_IPFFS order by loc_pre_30days_IPFFS
select loc_pre_30days_IPLIHP, count(*) from #tmp_c group by loc_pre_30days_IPLIHP order by loc_pre_30days_IPLIHP
select loc_pre_30days_IPST, count(*) from #tmp_c group by loc_pre_30days_IPST order by loc_pre_30days_IPST
select loc_pre_30days_JAIL, count(*) from #tmp_c group by loc_pre_30days_JAIL order by loc_pre_30days_JAIL
select loc_pre_30days_JFS, count(*) from #tmp_c group by loc_pre_30days_JFS order by loc_pre_30days_JFS
select loc_pre_30days_EDG, count(*) from #tmp_c group by loc_pre_30days_EDG order by loc_pre_30days_EDG
select loc_pre_30days_LTC, count(*) from #tmp_c group by loc_pre_30days_LTC order by loc_pre_30days_LTC
select loc_pre_30days_LTCINST, count(*) from #tmp_c group by loc_pre_30days_LTCINST order by loc_pre_30days_LTCINST
select loc_pre_30days_LTCRES, count(*) from #tmp_c group by loc_pre_30days_LTCRES order by loc_pre_30days_LTCRES
select loc_pre_30days_RES, count(*) from #tmp_c group by loc_pre_30days_RES order by loc_pre_30days_RES
select loc_pre_30days_BHC, count(*) from #tmp_c group by loc_pre_30days_BHC order by loc_pre_30days_BHC
select loc_pre_30days_TBS, count(*) from #tmp_c group by loc_pre_30days_TBS order by loc_pre_30days_TBS
select loc_pre_30days_DTC, count(*) from #tmp_c group by loc_pre_30days_DTC order by loc_pre_30days_DTC
select loc_pre_30days_DTCTF, count(*) from #tmp_c group by loc_pre_30days_DTCTF order by loc_pre_30days_DTCTF
select loc_pre_30days_DTR, count(*) from #tmp_c group by loc_pre_30days_DTR order by loc_pre_30days_DTR
select loc_pre_30days_STRTP, count(*) from #tmp_c group by loc_pre_30days_STRTP order by loc_pre_30days_STRTP

select loc_pre_60days_ACT, count(*) from #tmp_c group by loc_pre_60days_ACT order by loc_pre_60days_ACT
select loc_pre_60days_CM, count(*) from #tmp_c group by loc_pre_60days_CM order by loc_pre_60days_CM
select loc_pre_60days_CMINST, count(*) from #tmp_c group by loc_pre_60days_CMINST order by loc_pre_60days_CMINST
select loc_pre_60days_CMSTR, count(*) from #tmp_c group by loc_pre_60days_CMSTR order by loc_pre_60days_CMSTR
select loc_pre_60days_CMTRAN, count(*) from #tmp_c group by loc_pre_60days_CMTRAN order by loc_pre_60days_CMTRAN
select loc_pre_60days_WRAP, count(*) from #tmp_c group by loc_pre_60days_WRAP order by loc_pre_60days_WRAP
select loc_pre_60days_FFS, count(*) from #tmp_c group by loc_pre_60days_FFS order by loc_pre_60days_FFS
select loc_pre_60days_OP, count(*) from #tmp_c group by loc_pre_60days_OP order by loc_pre_60days_OP
select loc_pre_60days_OPLIHP, count(*) from #tmp_c group by loc_pre_60days_OPLIHP order by loc_pre_60days_OPLIHP
select loc_pre_60days_OPR, count(*) from #tmp_c group by loc_pre_60days_OPR order by loc_pre_60days_OPR
select loc_pre_60days_PREV, count(*) from #tmp_c group by loc_pre_60days_PREV order by loc_pre_60days_PREV
select loc_pre_60days_CO, count(*) from #tmp_c group by loc_pre_60days_CO order by loc_pre_60days_CO
select loc_pre_60days_CR, count(*) from #tmp_c group by loc_pre_60days_CR order by loc_pre_60days_CR
select loc_pre_60days_CS, count(*) from #tmp_c group by loc_pre_60days_CS order by loc_pre_60days_CS
select loc_pre_60days_ESU, count(*) from #tmp_c group by loc_pre_60days_ESU order by loc_pre_60days_ESU
select loc_pre_60days_PERT, count(*) from #tmp_c group by loc_pre_60days_PERT order by loc_pre_60days_PERT
select loc_pre_60days_UO, count(*) from #tmp_c group by loc_pre_60days_UO order by loc_pre_60days_UO
select loc_pre_60days_IP, count(*) from #tmp_c group by loc_pre_60days_IP order by loc_pre_60days_IP
select loc_pre_60days_IPCAPS, count(*) from #tmp_c group by loc_pre_60days_IPCAPS order by loc_pre_60days_IPCAPS
select loc_pre_60days_IPCNTY, count(*) from #tmp_c group by loc_pre_60days_IPCNTY order by loc_pre_60days_IPCNTY
select loc_pre_60days_IPFFS, count(*) from #tmp_c group by loc_pre_60days_IPFFS order by loc_pre_60days_IPFFS
select loc_pre_60days_IPLIHP, count(*) from #tmp_c group by loc_pre_60days_IPLIHP order by loc_pre_60days_IPLIHP
select loc_pre_60days_IPST, count(*) from #tmp_c group by loc_pre_60days_IPST order by loc_pre_60days_IPST
select loc_pre_60days_JAIL, count(*) from #tmp_c group by loc_pre_60days_JAIL order by loc_pre_60days_JAIL
select loc_pre_60days_JFS, count(*) from #tmp_c group by loc_pre_60days_JFS order by loc_pre_60days_JFS
select loc_pre_60days_EDG, count(*) from #tmp_c group by loc_pre_60days_EDG order by loc_pre_60days_EDG
select loc_pre_60days_LTC, count(*) from #tmp_c group by loc_pre_60days_LTC order by loc_pre_60days_LTC
select loc_pre_60days_LTCINST, count(*) from #tmp_c group by loc_pre_60days_LTCINST order by loc_pre_60days_LTCINST
select loc_pre_60days_LTCRES, count(*) from #tmp_c group by loc_pre_60days_LTCRES order by loc_pre_60days_LTCRES
select loc_pre_60days_RES, count(*) from #tmp_c group by loc_pre_60days_RES order by loc_pre_60days_RES
select loc_pre_60days_BHC, count(*) from #tmp_c group by loc_pre_60days_BHC order by loc_pre_60days_BHC
select loc_pre_60days_DTC, count(*) from #tmp_c group by loc_pre_60days_DTC order by loc_pre_60days_DTC
select loc_pre_60days_DTCTF, count(*) from #tmp_c group by loc_pre_60days_DTCTF order by loc_pre_60days_DTCTF
select loc_pre_60days_DTR, count(*) from #tmp_c group by loc_pre_60days_DTR order by loc_pre_60days_DTR
select loc_pre_60days_STRTP, count(*) from #tmp_c group by loc_pre_60days_STRTP order by loc_pre_60days_STRTP

select loc_pre_90days_ACT, count(*) from #tmp_c group by loc_pre_90days_ACT order by loc_pre_90days_ACT
select loc_pre_90days_CM, count(*) from #tmp_c group by loc_pre_90days_CM order by loc_pre_90days_CM
select loc_pre_90days_CMINST, count(*) from #tmp_c group by loc_pre_90days_CMINST order by loc_pre_90days_CMINST
select loc_pre_90days_CMSTR, count(*) from #tmp_c group by loc_pre_90days_CMSTR order by loc_pre_90days_CMSTR
select loc_pre_90days_CMTRAN, count(*) from #tmp_c group by loc_pre_90days_CMTRAN order by loc_pre_90days_CMTRAN
select loc_pre_90days_WRAP, count(*) from #tmp_c group by loc_pre_90days_WRAP order by loc_pre_90days_WRAP
select loc_pre_90days_FFS, count(*) from #tmp_c group by loc_pre_90days_FFS order by loc_pre_90days_FFS
select loc_pre_90days_OP, count(*) from #tmp_c group by loc_pre_90days_OP order by loc_pre_90days_OP
select loc_pre_90days_OPLIHP, count(*) from #tmp_c group by loc_pre_90days_OPLIHP order by loc_pre_90days_OPLIHP
select loc_pre_90days_OPR, count(*) from #tmp_c group by loc_pre_90days_OPR order by loc_pre_90days_OPR
select loc_pre_90days_PREV, count(*) from #tmp_c group by loc_pre_90days_PREV order by loc_pre_90days_PREV
select loc_pre_90days_CO, count(*) from #tmp_c group by loc_pre_90days_CO order by loc_pre_90days_CO
select loc_pre_90days_CR, count(*) from #tmp_c group by loc_pre_90days_CR order by loc_pre_90days_CR
select loc_pre_90days_CS, count(*) from #tmp_c group by loc_pre_90days_CS order by loc_pre_90days_CS
select loc_pre_90days_ESU, count(*) from #tmp_c group by loc_pre_90days_ESU order by loc_pre_90days_ESU
select loc_pre_90days_PERT, count(*) from #tmp_c group by loc_pre_90days_PERT order by loc_pre_90days_PERT
select loc_pre_90days_UO, count(*) from #tmp_c group by loc_pre_90days_UO order by loc_pre_90days_UO
select loc_pre_90days_IP, count(*) from #tmp_c group by loc_pre_90days_IP order by loc_pre_90days_IP
select loc_pre_90days_IPCAPS, count(*) from #tmp_c group by loc_pre_90days_IPCAPS order by loc_pre_90days_IPCAPS
select loc_pre_90days_IPCNTY, count(*) from #tmp_c group by loc_pre_90days_IPCNTY order by loc_pre_90days_IPCNTY
select loc_pre_90days_IPFFS, count(*) from #tmp_c group by loc_pre_90days_IPFFS order by loc_pre_90days_IPFFS
select loc_pre_90days_IPLIHP, count(*) from #tmp_c group by loc_pre_90days_IPLIHP order by loc_pre_90days_IPLIHP
select loc_pre_90days_IPST, count(*) from #tmp_c group by loc_pre_90days_IPST order by loc_pre_90days_IPST
select loc_pre_90days_JAIL, count(*) from #tmp_c group by loc_pre_90days_JAIL order by loc_pre_90days_JAIL
select loc_pre_90days_JFS, count(*) from #tmp_c group by loc_pre_90days_JFS order by loc_pre_90days_JFS
select loc_pre_90days_EDG, count(*) from #tmp_c group by loc_pre_90days_EDG order by loc_pre_90days_EDG
select loc_pre_90days_LTC, count(*) from #tmp_c group by loc_pre_90days_LTC order by loc_pre_90days_LTC
select loc_pre_90days_LTCINST, count(*) from #tmp_c group by loc_pre_90days_LTCINST order by loc_pre_90days_LTCINST
select loc_pre_90days_LTCRES, count(*) from #tmp_c group by loc_pre_90days_LTCRES order by loc_pre_90days_LTCRES
select loc_pre_90days_RES, count(*) from #tmp_c group by loc_pre_90days_RES order by loc_pre_90days_RES
select loc_pre_90days_BHC, count(*) from #tmp_c group by loc_pre_90days_BHC order by loc_pre_90days_BHC
select loc_pre_90days_DTC, count(*) from #tmp_c group by loc_pre_90days_DTC order by loc_pre_90days_DTC
select loc_pre_90days_DTCTF, count(*) from #tmp_c group by loc_pre_90days_DTCTF order by loc_pre_90days_DTCTF
select loc_pre_90days_DTR, count(*) from #tmp_c group by loc_pre_90days_DTR order by loc_pre_90days_DTR
select loc_pre_90days_STRTP, count(*) from #tmp_c group by loc_pre_90days_STRTP order by loc_pre_90days_STRTP

select loc_post_7days_ACT, count(*) from #tmp_c group by loc_post_7days_ACT order by loc_post_7days_ACT
select loc_post_7days_CM, count(*) from #tmp_c group by loc_post_7days_CM order by loc_post_7days_CM
select loc_post_7days_CMINST, count(*) from #tmp_c group by loc_post_7days_CMINST order by loc_post_7days_CMINST
select loc_post_7days_CMSTR, count(*) from #tmp_c group by loc_post_7days_CMSTR order by loc_post_7days_CMSTR
select loc_post_7days_CMTRAN, count(*) from #tmp_c group by loc_post_7days_CMTRAN order by loc_post_7days_CMTRAN
select loc_post_7days_WRAP, count(*) from #tmp_c group by loc_post_7days_WRAP order by loc_post_7days_WRAP
select loc_post_7days_FFS, count(*) from #tmp_c group by loc_post_7days_FFS order by loc_post_7days_FFS
select loc_post_7days_OP, count(*) from #tmp_c group by loc_post_7days_OP order by loc_post_7days_OP
select loc_post_7days_OPLIHP, count(*) from #tmp_c group by loc_post_7days_OPLIHP order by loc_post_7days_OPLIHP
select loc_post_7days_OPR, count(*) from #tmp_c group by loc_post_7days_OPR order by loc_post_7days_OPR
select loc_post_7days_PREV, count(*) from #tmp_c group by loc_post_7days_PREV order by loc_post_7days_PREV
select loc_post_7days_CO, count(*) from #tmp_c group by loc_post_7days_CO order by loc_post_7days_CO
select loc_post_7days_CR, count(*) from #tmp_c group by loc_post_7days_CR order by loc_post_7days_CR
select loc_post_7days_CS, count(*) from #tmp_c group by loc_post_7days_CS order by loc_post_7days_CS
select loc_post_7days_ESU, count(*) from #tmp_c group by loc_post_7days_ESU order by loc_post_7days_ESU
select loc_post_7days_PERT, count(*) from #tmp_c group by loc_post_7days_PERT order by loc_post_7days_PERT
select loc_post_7days_UO, count(*) from #tmp_c group by loc_post_7days_UO order by loc_post_7days_UO
select loc_post_7days_IP, count(*) from #tmp_c group by loc_post_7days_IP order by loc_post_7days_IP
select loc_post_7days_IPCAPS, count(*) from #tmp_c group by loc_post_7days_IPCAPS order by loc_post_7days_IPCAPS
select loc_post_7days_IPCNTY, count(*) from #tmp_c group by loc_post_7days_IPCNTY order by loc_post_7days_IPCNTY
select loc_post_7days_IPFFS, count(*) from #tmp_c group by loc_post_7days_IPFFS order by loc_post_7days_IPFFS
select loc_post_7days_IPLIHP, count(*) from #tmp_c group by loc_post_7days_IPLIHP order by loc_post_7days_IPLIHP
select loc_post_7days_IPST, count(*) from #tmp_c group by loc_post_7days_IPST order by loc_post_7days_IPST
select loc_post_7days_JAIL, count(*) from #tmp_c group by loc_post_7days_JAIL order by loc_post_7days_JAIL
select loc_post_7days_JFS, count(*) from #tmp_c group by loc_post_7days_JFS order by loc_post_7days_JFS
select loc_post_7days_EDG, count(*) from #tmp_c group by loc_post_7days_EDG order by loc_post_7days_EDG
select loc_post_7days_LTC, count(*) from #tmp_c group by loc_post_7days_LTC order by loc_post_7days_LTC
select loc_post_7days_LTCINST, count(*) from #tmp_c group by loc_post_7days_LTCINST order by loc_post_7days_LTCINST
select loc_post_7days_LTCRES, count(*) from #tmp_c group by loc_post_7days_LTCRES order by loc_post_7days_LTCRES
select loc_post_7days_RES, count(*) from #tmp_c group by loc_post_7days_RES order by loc_post_7days_RES
select loc_post_7days_BHC, count(*) from #tmp_c group by loc_post_7days_BHC order by loc_post_7days_BHC
select loc_post_7days_DTC, count(*) from #tmp_c group by loc_post_7days_DTC order by loc_post_7days_DTC
select loc_post_7days_DTCTF, count(*) from #tmp_c group by loc_post_7days_DTCTF order by loc_post_7days_DTCTF
select loc_post_7days_DTR, count(*) from #tmp_c group by loc_post_7days_DTR order by loc_post_7days_DTR
select loc_post_7days_STRTP, count(*) from #tmp_c group by loc_post_7days_STRTP order by loc_post_7days_STRTP

select loc_post_30days_ACT, count(*) from #tmp_c group by loc_post_30days_ACT order by loc_post_30days_ACT
select loc_post_30days_CM, count(*) from #tmp_c group by loc_post_30days_CM order by loc_post_30days_CM
select loc_post_30days_CMINST, count(*) from #tmp_c group by loc_post_30days_CMINST order by loc_post_30days_CMINST
select loc_post_30days_CMSTR, count(*) from #tmp_c group by loc_post_30days_CMSTR order by loc_post_30days_CMSTR
select loc_post_30days_CMTRAN, count(*) from #tmp_c group by loc_post_30days_CMTRAN order by loc_post_30days_CMTRAN
select loc_post_30days_WRAP, count(*) from #tmp_c group by loc_post_30days_WRAP order by loc_post_30days_WRAP
select loc_post_30days_FFS, count(*) from #tmp_c group by loc_post_30days_FFS order by loc_post_30days_FFS
select loc_post_30days_OP, count(*) from #tmp_c group by loc_post_30days_OP order by loc_post_30days_OP
select loc_post_30days_OPLIHP, count(*) from #tmp_c group by loc_post_30days_OPLIHP order by loc_post_30days_OPLIHP
select loc_post_30days_OPR, count(*) from #tmp_c group by loc_post_30days_OPR order by loc_post_30days_OPR
select loc_post_30days_PREV, count(*) from #tmp_c group by loc_post_30days_PREV order by loc_post_30days_PREV
select loc_post_30days_CO, count(*) from #tmp_c group by loc_post_30days_CO order by loc_post_30days_CO
select loc_post_30days_CR, count(*) from #tmp_c group by loc_post_30days_CR order by loc_post_30days_CR
select loc_post_30days_CS, count(*) from #tmp_c group by loc_post_30days_CS order by loc_post_30days_CS
select loc_post_30days_ESU, count(*) from #tmp_c group by loc_post_30days_ESU order by loc_post_30days_ESU
select loc_post_30days_PERT, count(*) from #tmp_c group by loc_post_30days_PERT order by loc_post_30days_PERT
select loc_post_30days_UO, count(*) from #tmp_c group by loc_post_30days_UO order by loc_post_30days_UO
select loc_post_30days_IP, count(*) from #tmp_c group by loc_post_30days_IP order by loc_post_30days_IP
select loc_post_30days_IPCAPS, count(*) from #tmp_c group by loc_post_30days_IPCAPS order by loc_post_30days_IPCAPS
select loc_post_30days_IPCNTY, count(*) from #tmp_c group by loc_post_30days_IPCNTY order by loc_post_30days_IPCNTY
select loc_post_30days_IPFFS, count(*) from #tmp_c group by loc_post_30days_IPFFS order by loc_post_30days_IPFFS
select loc_post_30days_IPLIHP, count(*) from #tmp_c group by loc_post_30days_IPLIHP order by loc_post_30days_IPLIHP
select loc_post_30days_IPST, count(*) from #tmp_c group by loc_post_30days_IPST order by loc_post_30days_IPST
select loc_post_30days_JAIL, count(*) from #tmp_c group by loc_post_30days_JAIL order by loc_post_30days_JAIL
select loc_post_30days_JFS, count(*) from #tmp_c group by loc_post_30days_JFS order by loc_post_30days_JFS
select loc_post_30days_EDG, count(*) from #tmp_c group by loc_post_30days_EDG order by loc_post_30days_EDG
select loc_post_30days_LTC, count(*) from #tmp_c group by loc_post_30days_LTC order by loc_post_30days_LTC
select loc_post_30days_LTCINST, count(*) from #tmp_c group by loc_post_30days_LTCINST order by loc_post_30days_LTCINST
select loc_post_30days_LTCRES, count(*) from #tmp_c group by loc_post_30days_LTCRES order by loc_post_30days_LTCRES
select loc_post_30days_RES, count(*) from #tmp_c group by loc_post_30days_RES order by loc_post_30days_RES
select loc_post_30days_BHC, count(*) from #tmp_c group by loc_post_30days_BHC order by loc_post_30days_BHC
select loc_post_30days_DTC, count(*) from #tmp_c group by loc_post_30days_DTC order by loc_post_30days_DTC
select loc_post_30days_DTCTF, count(*) from #tmp_c group by loc_post_30days_DTCTF order by loc_post_30days_DTCTF
select loc_post_30days_DTR, count(*) from #tmp_c group by loc_post_30days_DTR order by loc_post_30days_DTR
select loc_post_30days_STRTP, count(*) from #tmp_c group by loc_post_30days_STRTP order by loc_post_30days_STRTP

select loc_post_60days_ACT, count(*) from #tmp_c group by loc_post_60days_ACT order by loc_post_60days_ACT
select loc_post_60days_CM, count(*) from #tmp_c group by loc_post_60days_CM order by loc_post_60days_CM
select loc_post_60days_CMINST, count(*) from #tmp_c group by loc_post_60days_CMINST order by loc_post_60days_CMINST
select loc_post_60days_CMSTR, count(*) from #tmp_c group by loc_post_60days_CMSTR order by loc_post_60days_CMSTR
select loc_post_60days_CMTRAN, count(*) from #tmp_c group by loc_post_60days_CMTRAN order by loc_post_60days_CMTRAN
select loc_post_60days_WRAP, count(*) from #tmp_c group by loc_post_60days_WRAP order by loc_post_60days_WRAP
select loc_post_60days_FFS, count(*) from #tmp_c group by loc_post_60days_FFS order by loc_post_60days_FFS
select loc_post_60days_OP, count(*) from #tmp_c group by loc_post_60days_OP order by loc_post_60days_OP
select loc_post_60days_OPLIHP, count(*) from #tmp_c group by loc_post_60days_OPLIHP order by loc_post_60days_OPLIHP
select loc_post_60days_OPR, count(*) from #tmp_c group by loc_post_60days_OPR order by loc_post_60days_OPR
select loc_post_60days_PREV, count(*) from #tmp_c group by loc_post_60days_PREV order by loc_post_60days_PREV
select loc_post_60days_CO, count(*) from #tmp_c group by loc_post_60days_CO order by loc_post_60days_CO
select loc_post_60days_CR, count(*) from #tmp_c group by loc_post_60days_CR order by loc_post_60days_CR
select loc_post_60days_CS, count(*) from #tmp_c group by loc_post_60days_CS order by loc_post_60days_CS
select loc_post_60days_ESU, count(*) from #tmp_c group by loc_post_60days_ESU order by loc_post_60days_ESU
select loc_post_60days_PERT, count(*) from #tmp_c group by loc_post_60days_PERT order by loc_post_60days_PERT
select loc_post_60days_UO, count(*) from #tmp_c group by loc_post_60days_UO order by loc_post_60days_UO
select loc_post_60days_IP, count(*) from #tmp_c group by loc_post_60days_IP order by loc_post_60days_IP
select loc_post_60days_IPCAPS, count(*) from #tmp_c group by loc_post_60days_IPCAPS order by loc_post_60days_IPCAPS
select loc_post_60days_IPCNTY, count(*) from #tmp_c group by loc_post_60days_IPCNTY order by loc_post_60days_IPCNTY
select loc_post_60days_IPFFS, count(*) from #tmp_c group by loc_post_60days_IPFFS order by loc_post_60days_IPFFS
select loc_post_60days_IPLIHP, count(*) from #tmp_c group by loc_post_60days_IPLIHP order by loc_post_60days_IPLIHP
select loc_post_60days_IPST, count(*) from #tmp_c group by loc_post_60days_IPST order by loc_post_60days_IPST
select loc_post_60days_JAIL, count(*) from #tmp_c group by loc_post_60days_JAIL order by loc_post_60days_JAIL
select loc_post_60days_JFS, count(*) from #tmp_c group by loc_post_60days_JFS order by loc_post_60days_JFS
select loc_post_60days_EDG, count(*) from #tmp_c group by loc_post_60days_EDG order by loc_post_60days_EDG
select loc_post_60days_LTC, count(*) from #tmp_c group by loc_post_60days_LTC order by loc_post_60days_LTC
select loc_post_60days_LTCINST, count(*) from #tmp_c group by loc_post_60days_LTCINST order by loc_post_60days_LTCINST
select loc_post_60days_LTCRES, count(*) from #tmp_c group by loc_post_60days_LTCRES order by loc_post_60days_LTCRES
select loc_post_60days_RES, count(*) from #tmp_c group by loc_post_60days_RES order by loc_post_60days_RES
select loc_post_60days_BHC, count(*) from #tmp_c group by loc_post_60days_BHC order by loc_post_60days_BHC
select loc_post_60days_DTC, count(*) from #tmp_c group by loc_post_60days_DTC order by loc_post_60days_DTC
select loc_post_60days_DTCTF, count(*) from #tmp_c group by loc_post_60days_DTCTF order by loc_post_60days_DTCTF
select loc_post_60days_DTR, count(*) from #tmp_c group by loc_post_60days_DTR order by loc_post_60days_DTR
select loc_post_60days_STRTP, count(*) from #tmp_c group by loc_post_60days_STRTP order by loc_post_60days_STRTP

select loc_post_90days_ACT, count(*) from #tmp_c group by loc_post_90days_ACT order by loc_post_90days_ACT
select loc_post_90days_CM, count(*) from #tmp_c group by loc_post_90days_CM order by loc_post_90days_CM
select loc_post_90days_CMINST, count(*) from #tmp_c group by loc_post_90days_CMINST order by loc_post_90days_CMINST
select loc_post_90days_CMSTR, count(*) from #tmp_c group by loc_post_90days_CMSTR order by loc_post_90days_CMSTR
select loc_post_90days_CMTRAN, count(*) from #tmp_c group by loc_post_90days_CMTRAN order by loc_post_90days_CMTRAN
select loc_post_90days_WRAP, count(*) from #tmp_c group by loc_post_90days_WRAP order by loc_post_90days_WRAP
select loc_post_90days_FFS, count(*) from #tmp_c group by loc_post_90days_FFS order by loc_post_90days_FFS
select loc_post_90days_OP, count(*) from #tmp_c group by loc_post_90days_OP order by loc_post_90days_OP
select loc_post_90days_OPLIHP, count(*) from #tmp_c group by loc_post_90days_OPLIHP order by loc_post_90days_OPLIHP
select loc_post_90days_OPR, count(*) from #tmp_c group by loc_post_90days_OPR order by loc_post_90days_OPR
select loc_post_90days_PREV, count(*) from #tmp_c group by loc_post_90days_PREV order by loc_post_90days_PREV
select loc_post_90days_CO, count(*) from #tmp_c group by loc_post_90days_CO order by loc_post_90days_CO
select loc_post_90days_CR, count(*) from #tmp_c group by loc_post_90days_CR order by loc_post_90days_CR
select loc_post_90days_CS, count(*) from #tmp_c group by loc_post_90days_CS order by loc_post_90days_CS
select loc_post_90days_ESU, count(*) from #tmp_c group by loc_post_90days_ESU order by loc_post_90days_ESU
select loc_post_90days_PERT, count(*) from #tmp_c group by loc_post_90days_PERT order by loc_post_90days_PERT
select loc_post_90days_UO, count(*) from #tmp_c group by loc_post_90days_UO order by loc_post_90days_UO
select loc_post_90days_IP, count(*) from #tmp_c group by loc_post_90days_IP order by loc_post_90days_IP
select loc_post_90days_IPCAPS, count(*) from #tmp_c group by loc_post_90days_IPCAPS order by loc_post_90days_IPCAPS
select loc_post_90days_IPCNTY, count(*) from #tmp_c group by loc_post_90days_IPCNTY order by loc_post_90days_IPCNTY
select loc_post_90days_IPFFS, count(*) from #tmp_c group by loc_post_90days_IPFFS order by loc_post_90days_IPFFS
select loc_post_90days_IPLIHP, count(*) from #tmp_c group by loc_post_90days_IPLIHP order by loc_post_90days_IPLIHP
select loc_post_90days_IPST, count(*) from #tmp_c group by loc_post_90days_IPST order by loc_post_90days_IPST
select loc_post_90days_JAIL, count(*) from #tmp_c group by loc_post_90days_JAIL order by loc_post_90days_JAIL
select loc_post_90days_JFS, count(*) from #tmp_c group by loc_post_90days_JFS order by loc_post_90days_JFS
select loc_post_90days_EDG, count(*) from #tmp_c group by loc_post_90days_EDG order by loc_post_90days_EDG
select loc_post_90days_LTC, count(*) from #tmp_c group by loc_post_90days_LTC order by loc_post_90days_LTC
select loc_post_90days_LTCINST, count(*) from #tmp_c group by loc_post_90days_LTCINST order by loc_post_90days_LTCINST
select loc_post_90days_LTCRES, count(*) from #tmp_c group by loc_post_90days_LTCRES order by loc_post_90days_LTCRES
select loc_post_90days_RES, count(*) from #tmp_c group by loc_post_90days_RES order by loc_post_90days_RES
select loc_post_90days_BHC, count(*) from #tmp_c group by loc_post_90days_BHC order by loc_post_90days_BHC
select loc_post_90days_DTC, count(*) from #tmp_c group by loc_post_90days_DTC order by loc_post_90days_DTC
select loc_post_90days_DTCTF, count(*) from #tmp_c group by loc_post_90days_DTCTF order by loc_post_90days_DTCTF
select loc_post_90days_DTR, count(*) from #tmp_c group by loc_post_90days_DTR order by loc_post_90days_DTR
select loc_post_90days_STRTP, count(*) from #tmp_c group by loc_post_90days_STRTP order by loc_post_90days_STRTP


*/


