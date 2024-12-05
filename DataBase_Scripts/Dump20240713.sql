-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 10.23.91.13    Database: iffco
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `inward_master`
--

DROP TABLE IF EXISTS inward_master;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE inward_master (
  INWARD_SYS_ID int NOT NULL AUTO_INCREMENT,
  INWARD_TYPE varchar(20) NOT NULL,
  IS_POSTED tinyint(1) NOT NULL,
  PRIMARY KEY (INWARD_SYS_ID)
) ENGINE=MyISAM AUTO_INCREMENT=128 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'iffco'
--
/*!50003 DROP PROCEDURE IF EXISTS CD_access_rights_insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE CD_access_rights_insert(IN `_Id` INT(11), IN `_Role_Id` INT(11), IN `_Url_Id` INT(11), IN `_Plant_Id` INT(11), IN `_Status` TINYINT(1))
BEGIN
INSERT INTO access_rights
(
Id,
Role_Id,
Url_Id,
Plant_Id,
Status
)
VALUES
(
_Id,
_Role_Id,
_Url_Id,
_Plant_Id,
_Status
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS CD_all_urls_insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE CD_all_urls_insert(IN `_Id` INT(11), IN `_url` VARCHAR(200), IN `_url_name` VARCHAR(200), IN `_menu_name` VARCHAR(200))
BEGIN
INSERT INTO all_urls
(
Id,
url,
url_name,
menu_name
)
VALUES
(
_Id,
_url,
_url_name,
_menu_name
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS CD_belt_master_insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE CD_belt_master_insert(in `_BeltNum` varchar(10), in `_HardwareUID` varchar(45), 
in `_BeltStatus` tinyint(1),in `_PLANT_ID` int)
BEGIN
INSERT INTO belt_master
(BeltNum,HardwareUID,BeltStatus,PLANT_ID)
VALUES
(_BeltNum,_HardwareUID,_BeltStatus,_PLANT_ID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS CD_CONVEYOR_PRODUCT_MAPPING_INSERT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE CD_CONVEYOR_PRODUCT_MAPPING_INSERT(
IN _PROD_SYS_ID INT(11),
IN _BELT_SYS_ID INT(11),
IN _PLANT_ID INT(11),
IN _CREATED_BY INT(11),
IN _CREATED_DATETIME DATETIME
)
BEGIN
INSERT INTO conveyor_product_mapping
(
PROD_SYS_ID,
BELT_SYS_ID,
PLANT_ID,
CREATED_BY,
CREATED_DATETIME
)
VALUES
(
_PROD_SYS_ID,
_BELT_SYS_ID,
_PLANT_ID,
_CREATED_BY,
_CREATED_DATETIME
);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS CD_countrymaster_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE CD_countrymaster_Insert(IN `_COUNTRY_ID` INT(11), IN `_COUNTRY_NAME` VARCHAR(45), IN `_PLANT_ID` INT(11), IN `_CREATED_BY` INT(11), IN `_CREATED_DATETIME` DATETIME)
BEGIN
INSERT INTO countrymaster
(
COUNTRY_ID,
COUNTRY_NAME,
PLANT_ID,
CREATED_BY,
CREATED_DATETIME
)
VALUES
(
_COUNTRY_ID,
_COUNTRY_NAME,
_PLANT_ID,
_CREATED_BY,
_CREATED_DATETIME
);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS CD_districtmaster_insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE CD_districtmaster_insert(IN `_DISTRICT_ID` INT(11), IN `_DISTRICT_NAME` VARCHAR(45), IN `_STATE_ID` INT(11), IN `_COUNTRY_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_CREATED_BY` INT(11), IN `_CREATED_DATETIME` DATETIME)
BEGIN
INSERT INTO districtmaster
(
DISTRICT_ID,
DISTRICT_NAME,
STATE_ID,
COUNTRY_ID,
PLANT_ID,
CREATED_BY,
CREATED_DATETIME
)
VALUES
(
_DISTRICT_ID,
_DISTRICT_NAME,
_STATE_ID,
_COUNTRY_ID,
_PLANT_ID,
_CREATED_BY,
_CREATED_DATETIME
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS CD_plant_master_insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE CD_plant_master_insert(IN `_PlantID` INT(11), IN `_PlantCode` VARCHAR(45), IN `_PlantAddress` VARCHAR(150), IN `_Plant_Name` VARCHAR(150))
BEGIN
INSERT INTO plant_master
(
PlantID,
PlantCode,
PlantAddress,
Plant_Name
)
VALUES
(
_PlantID,
_PlantCode,
_PlantAddress,
_Plant_Name
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS CD_product_master_insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE CD_product_master_insert(IN `_PROD_SYS_ID` INT(11), IN `_SKU_CODE` VARCHAR(5), IN `_SKU_NAME` VARCHAR(200), IN `_PRD_CD` VARCHAR(5), IN `_PRD_DESC` VARCHAR(200), IN `_PLANT_ID` INT(11), IN `_Created_DateTime` DATETIME, IN `_IS_POSTED` TINYINT(1), IN `_PRD_WT_FILL` DOUBLE, IN `_SHIP_WT_FILL` DOUBLE, IN `_PROD_PER_SHIPPER` INT(11), IN `_TOLERANCE_PER` DOUBLE, IN `_PAL_WT_FILL` DOUBLE, IN `_SHIP_PER_PALLET` INT(11), IN `_NOTE` VARCHAR(250), IN `_ISACTIVE` TINYINT(1), IN `_prd_desc_h` VARCHAR(45), IN `_plant_cd` VARCHAR(5), IN `_print_order` INT(11), IN `_prd_desc_short` VARCHAR(45), IN `_extra1` VARCHAR(45), IN `_extra2` VARCHAR(45), IN `_extra3` VARCHAR(45), IN `_prd_type` VARCHAR(5), IN `_sub_plant_cd` VARCHAR(5), IN `_prd_category` VARCHAR(45), IN `_active` VARCHAR(1), IN `_hsn_code` INT(11), IN `_prd_cd_group_app` VARCHAR(5), IN `_uom` VARCHAR(5), IN `_conv_factor` DOUBLE, IN `_uom_evikas` VARCHAR(5), IN _GTIN varchar(150), IN _BPEX varchar(45))
BEGIN
INSERT INTO product_master
(
PROD_SYS_ID,
SKU_CODE,
SKU_NAME,
PRD_CD,
PRD_DESC,
PLANT_ID,
Created_DateTime,
IS_POSTED,
PRD_WT_FILL,
SHIP_WT_FILL,
PROD_PER_SHIPPER,
TOLERANCE_PER,
PAL_WT_FILL,
SHIP_PER_PALLET,
NOTE,
ISACTIVE,
prd_desc_h,
plant_cd,
print_order,
prd_desc_short,
extra1,
extra2,
extra3,
prd_type,
sub_plant_cd,
prd_category,
active,
hsn_code,
prd_cd_group_app,
uom,
conv_factor,
uom_evikas,
GTIN,
BPEX
)
VALUES
(
_PROD_SYS_ID,
_SKU_CODE,
_SKU_NAME,
_PRD_CD,
_PRD_DESC,
_PLANT_ID,
_Created_DateTime,
_IS_POSTED,
_PRD_WT_FILL,
_SHIP_WT_FILL,
_PROD_PER_SHIPPER,
_TOLERANCE_PER,
_PAL_WT_FILL,
_SHIP_PER_PALLET,
_NOTE,
_ISACTIVE,
_prd_desc_h,
_plant_cd,
_print_order,
_prd_desc_short,
_extra1,
_extra2,
_extra3,
_prd_type,
_sub_plant_cd,
_prd_category,
_active,
_hsn_code,
_prd_cd_group_app,
_uom,
_conv_factor,
_uom_evikas,
_GTIN,
_BPEX
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS CD_roleto_user_insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE CD_roleto_user_insert(IN `_Id` INT(11), IN `_User_Id` INT(11), IN `_Role_Id` INT(11), IN `_Plant_Id` INT(11))
BEGIN
INSERT INTO roleto_user
(
Id,
User_Id,
Role_Id,
Plant_Id
)
VALUES
(
_Id,
_User_Id,
_Role_Id,
_Plant_Id
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS CD_role_master_insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE CD_role_master_insert(IN `_ROLE_ID` INT(11), IN `_ROLE_NAME` VARCHAR(45), IN `_PLANT_ID` INT(11), IN `_CREATED_BY` INT(11), IN `_CREATED_DATETIME` DATETIME)
BEGIN

INSERT INTO role_master
(ROLE_ID,ROLE_NAME,PLANT_ID,CREATED_BY,CREATED_DATETIME)
VALUES
(_ROLE_ID,_ROLE_NAME,_PLANT_ID,_CREATED_BY,_CREATED_DATETIME);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS CD_statemaster_insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE CD_statemaster_insert(IN `_STATE_ID` INT(11), IN `_STATE_NAME` VARCHAR(45), IN `_COUNTRY_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_CREATED_BY` INT(11), IN `_CREATED_DATETIME` DATETIME)
BEGIN
INSERT INTO statemaster
(
STATE_ID,
STATE_NAME,
COUNTRY_ID,
PLANT_ID,
CREATED_BY,
CREATED_DATETIME
)
VALUES
(
_STATE_ID,
_STATE_NAME,
_COUNTRY_ID,
_PLANT_ID,
_CREATED_BY,
_CREATED_DATETIME
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS CD_system_users_insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE CD_system_users_insert(IN `_USER_ID` INT(11), IN `_FIRST_NAME` VARCHAR(45), IN `_MIDDLE_NAME` VARCHAR(45), IN `_LAST_NAME` VARCHAR(45), IN `_MOBILE_NO` VARCHAR(10), IN `_ALT_MOBILE_NO` VARCHAR(10), IN `_EMAIL_ID` VARCHAR(30), IN `_ALT_EMAIL_ID` VARCHAR(30), IN `_FULL_ADDRESS` VARCHAR(200), IN `_COUNTRY_ID` INT(11), IN `_STATE_ID` INT(11), IN `_DISTRICT_ID` INT(11), IN `_CITY` VARCHAR(30), IN `_POSTAL_CODE` VARCHAR(8), IN `_EMP_CODE` VARCHAR(10), IN `_EMP_DESIGNATION_ID` INT(11), IN `_EMP_WORK_SHIFT_ID` INT(11), IN `_EMP_WORK_STATION_ID` INT(11), IN `_USER_PASSWORD` VARCHAR(1200), IN `_ROLE_ID` INT(11), IN `_IS_ACTIVE` TINYINT(1), IN `_IS_LOCK` TINYINT(1), IN `_NOTE_FEEDBACK` VARCHAR(100), IN `_PLANT_ID` INT(11), IN `_CREATED_BY` INT(11), IN `_CREATED_DATETIME` DATETIME)
BEGIN

INSERT INTO system_users
(
USER_ID,
FIRST_NAME,
MIDDLE_NAME,
LAST_NAME,
MOBILE_NO,
ALT_MOBILE_NO,
EMAIL_ID,
ALT_EMAIL_ID,
FULL_ADDRESS,
COUNTRY_ID,
STATE_ID,
DISTRICT_ID,
CITY,
POSTAL_CODE,
EMP_CODE,
EMP_DESIGNATION_ID,
EMP_WORK_SHIFT_ID,
EMP_WORK_STATION_ID,
USER_PASSWORD,
ROLE_ID,
IS_ACTIVE,
IS_LOCK,
NOTE_FEEDBACK,
PLANT_ID,
CREATED_BY,
CREATED_DATETIME
)
VALUES
(
_USER_ID,
_FIRST_NAME,
_MIDDLE_NAME,
_LAST_NAME,
_MOBILE_NO,
_ALT_MOBILE_NO,
_EMAIL_ID,
_ALT_EMAIL_ID,
_FULL_ADDRESS,
_COUNTRY_ID,
_STATE_ID,
_DISTRICT_ID,
_CITY,
_POSTAL_CODE,
_EMP_CODE,
_EMP_DESIGNATION_ID,
_EMP_WORK_SHIFT_ID,
_EMP_WORK_STATION_ID,
_USER_PASSWORD,
_ROLE_ID,
_IS_ACTIVE,
_IS_LOCK,
_NOTE_FEEDBACK,
_PLANT_ID,
_CREATED_BY,
_CREATED_DATETIME
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS MDADispatchDetails */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE MDADispatchDetails(IN `_MDA_NO` VARCHAR(50), IN `_MDA_DT` DATE)
BEGIN
select mh.MDA_NO as VAR_MDA_NO, fg.GATE_OUT_DT as DT_DISPTACH_DATE, mld.SHIPPER_QR_CODE as VAR_SHIPPER_QR_CODE, shq.bottle_qrcode as VAR_IML_QR_CODE,
prdm.SKU_CODE as VAR_SKU_CODE, shqapi.batch_no as VAR_BATCH_NO, shqapi.mfg_date as DT_MFG_DATE, shqapi.expiry_date as DT_EXPIRE_DATE, 
mh.MDA_DT as VAR_MDA_DATE, fg.TRUCK_NO as VAR_TRUCK_NO, pm.PlantCode as VAR_PLANT_CODE, pm.Plant_Name as VAR_PLANT_NAME, mh.WH_CD as VAR_WH_CODE, 
mh.PARTY_NAME as VAR_WH_NAME, '' as VAR_DESTINATION, '' as DESP_MODE from fg_gate_in_out as fg 
inner join plant_master as pm on fg.PLANT_ID = pm.PlantID
inner join mda_loading as mld on fg.GATE_SYS_ID = mld.GATE_SYS_ID and fg.PLANT_ID = mld.PLANT_ID
inner join mda_header as mh on mld.MDA_SYS_ID = mh.MDA_SYS_ID and mld.PLANT_ID = mh.PLANT_ID
inner join mda_detail as mdtl on mdtl.MDA_SYS_ID = mh.MDA_SYS_ID and mdtl.PLANT_ID = mh.PLANT_ID
inner join shipper_qrcode as shq on mld.SHIPPER_QR_CODE = shq.shipper_qrcode and mld.PLANT_ID = shq.plant_id
inner join shipper_qrcode_api as shqapi on shq.shipper_qrcode_api_sysId = shqapi.shipper_qrcode_api_sysId and shq.plant_id = shqapi.plant_id
inner join bottle_qrcode as bqr on shq.shipper_qrcode_sysId = bqr.shipper_qrcode_sysId and shq.plant_id = bqr.plant_id
inner join product_master as prdm on mld.PROD_SYS_ID = prdm.PROD_SYS_ID
where mh.MDA_NO=_MDA_NO and mh.MDA_DT=_MDA_DT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS new_procedure */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE new_procedure(IN `_RFIDSRNO` VARCHAR(30))
BEGIN
SELECT 
gt.GATE_SYS_ID,
gt.GATE_IN_DT,
gt.GATE_OUT_DT,
gt.INWARD_SYS_ID,
gt.SO_SYS_ID,
gt.TRANS_SYS_ID,
gt.TRANSPORTER_NAME,
gt.TRUCK_NO,
gt.DRIVER_ID_TYPE,
gt.DRIVER_ID_NUMBER,
gt.DRIVER_NAME,
gt.DRIVER_CONTACT,
gt.DRIVER_CHANGED,
gt.DRIVER_NAME_NEW,
gt.DRIVER_CONTACT_NEW,
gt.TRUCK_VALIDATION,
gt.RFSYSID,
gt.VERIFIED_DOCUMENTS,
gt.RFID_RECEIVE,
gt.VERIFIED_OFFICER_ID,
gt.CANCEL_GATE_IN,
gt.CANCEL_GATE_REASON,
gt.GATE_SYS_ID_OLD,
gt.IS_GOODS_TRANSFER,
gt.STATION_ID,
gt.PLANT_ID,
gt.Created_BY_ID,
gt.Created_DateTime,
gt.IS_POSTED,
sh.SO_NO,
sh.SO_DATE,
sh.CUST_NAME
FROM sp_gate_in_out gt 
inner join rfid_master rfid on gt.RFSYSID = rfid.RFSYSID
inner join so_header sh on gt.SO_SYS_ID = sh.SO_SYS_ID
WHERE (rfid.RFIDSRNO=_RFIDSRNO or rfid.RFIDCODE=_RFIDSRNO) and rfid.STATUS='Assigned'; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_CHANGEPASSWORD */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_CHANGEPASSWORD(
    IN P_OLD_PASSWORD VARCHAR(255),
    IN P_CONFIRM_PASSWORD VARCHAR(255),
    IN P_NEW_PASSWORD VARCHAR(255), 
    IN P_PLANT_ID INT, 
    IN P_USER_ID INT, 
    IN P_ROLE_ID INT, 
    IN P_MENU_ID INT, 
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_NUM INT;

    -- Check if new password matches the confirm password
    IF P_NEW_PASSWORD = P_CONFIRM_PASSWORD THEN
        -- Check if the old password is correct
        SELECT COUNT(*)
        INTO TEMP_NUM
        FROM user_master_new
        WHERE ID = P_USER_ID
        AND USER_PASSWORD = P_OLD_PASSWORD
        AND IS_ACTIVE = 'Y'
        LIMIT 1;

        IF TEMP_NUM > 0 THEN
            -- Update the password
            UPDATE user_master_new
            SET USER_PASSWORD = P_NEW_PASSWORD
            WHERE ID = P_USER_ID
            AND IS_ACTIVE = 'Y';

            SET P_RESULT = 'S|Password updated successfully|';
        ELSE
            SET P_RESULT = 'E|Old Password is wrong|';
        END IF;
    ELSE
        SET P_RESULT = 'E|New Password and Confirm Password do not match|';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_DISPATCH_COUNT_SUMMARY_REPORT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_DISPATCH_COUNT_SUMMARY_REPORT(
    IN P_MDA_NO VARCHAR(255),
    IN P_SEARCH_TERM VARCHAR(255),
    IN P_FROM_DATE VARCHAR(255),
    IN P_TO_DATE VARCHAR(255),
    IN P_DISPLAY_LENGTH INT,
    IN P_DISPLAY_START INT,
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #,OUT P_RESULT CURSOR
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Exception handling
        SELECT 'E|Oops!... Something went wrong. Please contact the system administrator|0' AS Result;
    END;

    #OPEN P_RESULT FOR
    WITH TBL_MAIN AS (
        SELECT 
            ROW_NUMBER() OVER () AS RNUM, 
            (SELECT COUNT(*) FROM (your_main_query)) AS COUNT_ROW, 
            ZZ.*
        FROM (
            SELECT 
                DISTINCT MHDR.MDA_NO, 
                MHDR.MDA_DT AS MDA_DATE, 
                FGIN.TRUCK_NO, 
                MLOD.LOADED_SHIPPER AS MDA_SHIPPER_QTY, 
                (MLOD.LOADED_SHIPPER * 24) AS MDA_BOTTLE_QTY, 
                PM.SKU_CODE AS PRODUCT_SKU_CODE, 
                PM.PRD_DESC AS PRODUCT_SKU_DESC, 
                '' AS DESTINATION
            FROM 
                fg_gate_in_out FGIN 
            INNER JOIN 
                MDA_HEADER MHDR ON FGIN.MDA_SYS_ID = MHDR.MDA_SYS_ID
            INNER JOIN 
                MDA_LOADING MLOD ON MHDR.MDA_SYS_ID = MLOD.MDA_SYS_ID
            INNER JOIN 
                PRODUCT_MASTER PM ON MLOD.PROD_SYS_ID = PM.PROD_SYS_ID
            WHERE 
                FGIN.PLANT_ID = P_PLANT_ID
                AND MHDR.MDA_NO = COALESCE(P_MDA_NO, MHDR.MDA_NO)
                AND 1 = (CASE WHEN P_FROM_DATE IS NULL OR P_FROM_DATE = '' THEN 1 ELSE (CASE WHEN (DATE(MHDR.MDA_DT) - STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y')) > -1 THEN 1 ELSE 0 END) END)
                AND 1 = (CASE WHEN P_TO_DATE IS NULL OR P_TO_DATE = '' THEN 1 ELSE (CASE WHEN (STR_TO_DATE(P_TO_DATE, '%d/%m/%Y') - DATE(MHDR.MDA_DT)) > -1 THEN 1 ELSE 0 END) END)
                AND 1 = (CASE WHEN LENGTH(P_SEARCH_TERM) > 0 AND (UPPER(MHDR.MDA_NO) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%')) THEN 1 ELSE 0 END)
        ) AS ZZ
    )
    SELECT * FROM TBL_MAIN 
    WHERE 
        1 = (CASE WHEN P_DISPLAY_LENGTH > 0 AND RNUM <= (P_DISPLAY_LENGTH + P_DISPLAY_START) AND RNUM > P_DISPLAY_START THEN 1 WHEN P_DISPLAY_LENGTH = 0 THEN 1 ELSE 0 END);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_DISPATCH_SUMMARY_REPORT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_DISPATCH_SUMMARY_REPORT(
    IN P_MDA_NO VARCHAR(255),
    IN P_SEARCH_TERM VARCHAR(255),
    IN P_FROM_DATE VARCHAR(255),
    IN P_TO_DATE VARCHAR(255),
    IN P_TRUCK_NO VARCHAR(255),
    IN P_PARTY_NAME VARCHAR(255),
    IN P_DESTINATION VARCHAR(255),
    IN P_DISPLAY_LENGTH INT,
    IN P_DISPLAY_START INT,
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #,    OUT P_RESULT CURSOR
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Exception handling
        SELECT 'E|Oops!... Something went wrong. Please contact the system administrator|0' AS Result;
    END;

    #OPEN P_RESULT FOR
    WITH TBL_MAIN AS (
        SELECT 
            ROW_NUMBER() OVER () AS RNUM, 
            (SELECT COUNT(*) FROM (your_main_query)) AS COUNT_ROW, 
            ZZ.*
        FROM (
            SELECT 
                MH.MDA_NO, 
                'Dispatch' AS TRANSACTIONTYPE, 
                PM.SKU_CODE AS ARTICLECODE, 
                PM.SKU_NAME AS ARTICLENAME, 
                FG.GATE_OUT_DT AS DISP_DATE_TIME, 
                'Plant' AS DISPATCHFROMTYPE,
                CONCAT(PL.PLANTCODE, ' ', PL.PLANT_NAME) AS DISPATCHFROMCODENAME,
                'Warehouse/FSC' AS DISPATCHTOTYPE, 
                '' AS DISPATCHTOCODENAME, 
                (MR.LOADED_ITEM * 24) / 2 AS DISPATCHEDQTYKL, 
                MR.LOADED_ITEM AS DISPATCHEDQTYSHIPPER, 
                MR.LOADED_ITEM * 24 AS DISPATCHEDQTYUNITS
            FROM 
                FG_GATE_IN_OUT FG 
            INNER JOIN 
                MDA_REQUISITION_DATA MR ON FG.PLANT_ID = MR.PLANT_ID AND FG.GATE_SYS_ID = MR.GATE_SYS_ID
            INNER JOIN 
                MDA_HEADER MH ON MR.PLANT_ID = MH.PLANT_ID AND MR.MDA_NO = MH.MDA_NO
            INNER JOIN 
                MDA_DETAIL MD ON MH.MDA_SYS_ID = MD.MDA_SYS_ID AND MH.PLANT_ID = MD.PLANT_ID AND MD.PROD_SYS_ID = MR.PROD_SYS_ID
            INNER JOIN 
                MDA_SEQUENCE MS ON FG.PLANT_ID = MS.PLANT_ID AND FG.MDA_SYS_ID = MS.MDA_SYS_ID AND FG.GATE_SYS_ID = MS.GATE_SYS_ID
            INNER JOIN 
                SYSTEM_USERS SYSUR ON MS.CREATED_BY_ID = SYSUR.USER_ID
            INNER JOIN 
                PRODUCT_MASTER PM ON MR.PROD_SYS_ID = PM.PROD_SYS_ID AND MR.PLANT_ID = PM.PLANT_ID
            INNER JOIN 
                PLANT_MASTER PL ON MH.PLANT_ID = PL.PLANTID
            WHERE 
                FG.PLANT_ID = P_PLANT_ID
                AND MH.MDA_NO = COALESCE(P_MDA_NO, MH.MDA_NO)
                AND MH.VEHICLE_NO = COALESCE(P_TRUCK_NO, MH.VEHICLE_NO)
                AND MH.PARTY_NAME = COALESCE(P_PARTY_NAME, MH.PARTY_NAME)
                AND 1 = (CASE WHEN P_FROM_DATE IS NULL OR P_FROM_DATE = '' THEN 1 ELSE (CASE WHEN (DATE(MH.MDA_DT) - STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y')) > -1 THEN 1 ELSE 0 END) END)
                AND 1 = (CASE WHEN P_TO_DATE IS NULL OR P_TO_DATE = '' THEN 1 ELSE (CASE WHEN (STR_TO_DATE(P_TO_DATE, '%d/%m/%Y') - DATE(MH.MDA_DT)) > -1 THEN 1 ELSE 0 END) END)
                AND 1 = (CASE WHEN LENGTH(P_SEARCH_TERM) > 0 AND (UPPER(MH.MDA_NO) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%')
                                                           OR UPPER(MH.VEHICLE_NO) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%')
                                                           OR UPPER(MH.PARTY_NAME) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%')) THEN 1 ELSE 0 END)
        ) AS ZZ
    )
    SELECT * FROM TBL_MAIN 
    WHERE 
        1 = (CASE WHEN P_DISPLAY_LENGTH > 0 AND RNUM <= (P_DISPLAY_LENGTH + P_DISPLAY_START) AND RNUM > P_DISPLAY_START THEN 1 WHEN P_DISPLAY_LENGTH = 0 THEN 1 ELSE 0 END);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_GATE_IN_CANCEL_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_GATE_IN_CANCEL_GET(
    IN P_ID INT,
    IN P_RFID_NO VARCHAR(255),
    IN P_VEHICLE_NO VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
    SELECT 
        GATE_SYS_ID AS ID, 
        DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, 
        DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT,
        INWARD_SYS_ID, 
        (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE, 
        COMMON_NO, 
        COMMON_SYS_ID,
        X.WT_SYS_ID, 
        X.TARE_WT, 
        DATE_FORMAT(X.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, 
        X.TARE_WT_MANUALLY, 
        X.TARE_WT_NOTE, 
        X.GROSS_WT, 
        DATE_FORMAT(X.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, 
        X.GROSS_WT_MANUALLY, 
        X.GROSS_WT_NOTE, 
        X.NET_WT,
        TRANS_SYS_ID, 
        (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) AS TRANSPORTER_NAME,
        TRUCK_NO, 
        DRIVER_ID_TYPE, 
        (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT,
        DRIVER_ID_NUMBER, 
        DRIVER_NAME, 
        DRIVER_CONTACT, 
        DRIVER_CHANGED, 
        DRIVER_NAME_NEW, 
        DRIVER_CONTACT_NEW, 
        TRUCK_VALIDATION, 
        IS_GOODS_TRANSFER, 
        IS_UNLOAD_TRUCK,
        X.RFSYSID, 
        XZ.RFIDSRNO, 
        XZ.RFIDCODE,
        VERIFIED_DOCUMENTS, 
        RFID_RECEIVE, 
        VERIFIED_OFFICER_ID, 
        NULL AS VERIFIED_OFFICER_NAME, 
        GATE_SYS_ID_OLD, 
        CANCEL_GATE_IN, 
        CANCEL_GATE_REASON,
        X.VENDOR_SYS_ID, 
        VM.VENDOR_CODE, 
        VM.ORGANIZATION_NAME AS VENDOR_NAME,
        X.CUST_CD, 
        X.CUST_NAME, 
        X.CUST_SITE_CD, 
        X.SITE_NAME, 
        X.STATION_ID, 
        X.PLANT_ID, 
        PM.PLANT_NAME, 
        PM.PLANTCODE AS PLANT_CODE, 
        X.IS_POSTED
    FROM (
        SELECT 
            X.GATE_SYS_ID, 
            GATE_IN_DT, 
            GATE_OUT_DT, 
            INWARD_SYS_ID, 
            X.MDA_SYS_ID AS COMMON_SYS_ID, 
            XZ.MDA_NO AS COMMON_NO,
            ZZ.WT_SYS_ID, 
            ZZ.TARE_WT, 
            ZZ.TARE_WT_DT, 
            ZZ.TARE_WT_MANUALLY, 
            ZZ.TARE_WT_NOTE, 
            ZZ.GROSS_WT, 
            ZZ.GROSS_WT_DT, 
            ZZ.GROSS_WT_MANUALLY, 
            ZZ.GROSS_WT_NOTE, 
            ZZ.NET_WT,
            XZ.TRANS_SYS_ID, 
            TRUCK_NO, 
            DRIVER_ID_TYPE, 
            DRIVER_ID_NUMBER, 
            DRIVER_NAME, 
            DRIVER_CONTACT, 
            DRIVER_CHANGED, 
            DRIVER_NAME_NEW, 
            DRIVER_CONTACT_NEW, 
            TRUCK_VALIDATION, 
            IS_GOODS_TRANSFER, 
            NULL AS IS_UNLOAD_TRUCK,
            RFSYSID, 
            VERIFIED_DOCUMENTS, 
            RFID_RECEIVE, 
            VERIFIED_OFFICER_ID, 
            GATE_SYS_ID_OLD, 
            CANCEL_GATE_IN, 
            CANCEL_GATE_REASON,
            NULL AS VENDOR_SYS_ID, 
            XZ.WH_CD AS CUST_CD, 
            XZ.PARTY_NAME AS CUST_NAME, 
            NULL AS CUST_SITE_CD, 
            NULL AS SITE_NAME, 
            X.STATION_ID, 
            X.PLANT_ID, 
            X.IS_POSTED
        FROM FG_GATE_IN_OUT X
        LEFT JOIN MDA_HEADER XZ ON X.MDA_SYS_ID = XZ.MDA_SYS_ID
        LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
        WHERE X.PLANT_ID = P_PLANT_ID AND XZ.OUT_TIME IS NULL AND COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL
            /*AND (
                (1 = (CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN (CASE WHEN X.MDA_SYS_ID IN (SELECT MDA_SYS_ID FROM MDA_HEADER WHERE MDA_NO = P_VEHICLE_NO OR VEHICLE_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 1 END))
                OR 
                (1 = (CASE WHEN LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 1 END))
            )*/
            AND (
			1 = (CASE WHEN CHAR_LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN 
                        (CASE WHEN X.MDA_SYS_ID IN (SELECT Z.MDA_SYS_ID FROM MDA_HEADER Z WHERE Z.MDA_NO = P_VEHICLE_NO OR Z.VEHICLE_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END)                        
                ELSE 1 END)
			OR
			1 = (CASE WHEN CHAR_LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN 
                        (CASE WHEN RFSYSID IN (SELECT Z.RFSYSID FROM RFID_MASTER Z WHERE Z.RFIDSRNO = P_RFID_NO OR Z.RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END)
                ELSE 1 END)
        ) 
        UNION ALL
        SELECT 
            X.GATE_SYS_ID, 
            GATE_IN_DT, 
            GATE_OUT_DT, 
            INWARD_SYS_ID, 
            X.PO_SYS_ID AS COMMON_SYS_ID, 
            XZ.PO_NO AS COMMON_NO,
            ZZ.WT_SYS_ID, 
            ZZ.TARE_WT, 
            ZZ.TARE_WT_DT, 
            ZZ.TARE_WT_MANUALLY, 
            ZZ.TARE_WT_NOTE, 
            ZZ.GROSS_WT, 
            ZZ.GROSS_WT_DT, 
            ZZ.GROSS_WT_MANUALLY, 
            ZZ.GROSS_WT_NOTE, 
            ZZ.NET_WT,
            XZ.TRANS_SYS_ID, 
            X.TRUCK_NO, 
            DRIVER_ID_TYPE, 
            DRIVER_ID_NUMBER, 
            DRIVER_NAME, 
            DRIVER_CONTACT, 
            DRIVER_CHANGED, 
            DRIVER_NAME_NEW, 
            DRIVER_CONTACT_NEW, 
            TRUCK_VALIDATION, 
            NULL AS IS_GOODS_TRANSFER, 
            IS_UNLOAD_TRUCK,
            RFSYSID, 
            VERIFIED_DOCUMENTS, 
            RFID_RECEIVE, 
            VERIFIED_OFFICER_ID, 
            NULL AS GATE_SYS_ID_OLD, 
            CANCEL_GATE_IN, 
            CANCEL_GATE_REASON,
            XZ.VENDOR_SYS_ID, 
            NULL AS CUST_CD, 
            NULL AS CUST_NAME, 
            NULL AS CUST_SITE_CD, 
            NULL AS SITE_NAME, 
            X.STATION_ID, 
            X.PLANT_ID, 
            X.IS_POSTED
        FROM RM_GATE_IN_OUT X
        LEFT JOIN PO_HEADER XZ ON X.PO_SYS_ID = XZ.PO_SYS_ID
        LEFT JOIN RM_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
        WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL
            AND (
                (1 = (CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN (CASE WHEN X.PO_SYS_ID IN (SELECT PO_SYS_ID FROM PO_HEADER WHERE PO_NO = P_VEHICLE_NO OR TRUCK_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 1 END))
                OR 
                (1 = (CASE WHEN LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 1 END))
            )
        UNION ALL
        SELECT 
            X.GATE_SYS_ID, 
            GATE_IN_DT, 
            GATE_OUT_DT, 
            INWARD_SYS_ID, 
            X.SO_SYS_ID AS COMMON_SYS_ID, 
            XZ.SO_NO AS COMMON_NO,
            ZZ.WT_SYS_ID, 
            ZZ.TARE_WT, 
            ZZ.TARE_WT_DT, 
            ZZ.TARE_WT_MANUALLY, 
            ZZ.TARE_WT_NOTE, 
            ZZ.GROSS_WT, 
            ZZ.GROSS_WT_DT, 
            ZZ.GROSS_WT_MANUALLY, 
            ZZ.GROSS_WT_NOTE, 
            ZZ.NET_WT,
            X.TRANS_SYS_ID, 
            X.TRUCK_NO, 
            DRIVER_ID_TYPE, 
            DRIVER_ID_NUMBER, 
            DRIVER_NAME, 
            DRIVER_CONTACT, 
            DRIVER_CHANGED, 
            DRIVER_NAME_NEW, 
            DRIVER_CONTACT_NEW, 
            TRUCK_VALIDATION, 
            IS_GOODS_TRANSFER, 
            NULL AS IS_UNLOAD_TRUCK,
            RFSYSID, 
            VERIFIED_DOCUMENTS, 
            RFID_RECEIVE, 
            VERIFIED_OFFICER_ID, 
            GATE_SYS_ID_OLD, 
            CANCEL_GATE_IN, 
            CANCEL_GATE_REASON,
            XZ.VENSOR_SYS_ID AS VENDOR_SYS_ID, 
            XZ.CUST_CD AS CUST_CD, 
            XZ.CUST_NAME, 
            XZ.CUST_SITE_CD, 
            XZ.SITE_NAME, 
            X.STATION_ID, 
            X.PLANT_ID, 
            X.IS_POSTED
        FROM SP_GATE_IN_OUT X
        LEFT JOIN SO_HEADER XZ ON X.SO_SYS_ID = XZ.SO_SYS_ID
        LEFT JOIN SP_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
        WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL
            AND (
                (1 = (CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN (CASE WHEN X.SO_SYS_ID IN (SELECT SO_SYS_ID FROM SO_HEADER WHERE SO_NO = P_VEHICLE_NO OR TENDER_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 1 END))
                OR 
                (1 = (CASE WHEN LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 1 END))
            )
    ) X
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
    LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_GATE_IN_CANCEL_REPORT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_GATE_IN_CANCEL_REPORT(
    IN P_SEARCH_TERM VARCHAR(255),
    IN P_VEHICLE_NO VARCHAR(255),
    IN P_GATE_FROM_DATE VARCHAR(255),
    IN P_GATE_TO_DATE VARCHAR(255),
    IN P_DISPLAY_LENGTH INT,
    IN P_DISPLAY_START INT,
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #,    OUT P_RESULT CURSOR
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    #OPEN P_RESULT FOR
        WITH TBL_MAIN AS (
            SELECT 
                ROW_NUMBER() OVER () AS RNUM,
                (SELECT COUNT(*) FROM FG_GATE_IN_OUT WHERE NVL(CANCEL_GATE_IN, 0) = 1 AND GATE_IN_DT IS NOT NULL) AS COUNT_ROW,
                X.TRUCK_NO, 
                X.COMMON_NO, 
                (SELECT TPTR_NAME FROM TRANSPORTER_MASTER WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) AS TRANSPORTER,
                X.DRIVER_NAME, 
                X.DRIVER_CONTACT, 
                (SELECT RFIDSRNO FROM RFID_MASTER_TEMP WHERE RFSYSID = X.RFSYSID) AS RFID, 
                X.GATE_IN_DT, 
                X.GROSS_WT_DT WEIGHT_OUT_DT, 
                X.GATE_OUT_DT, 
                X.CANCEL_GATE_REASON 
            FROM (
                SELECT 
                    X.GATE_SYS_ID, 
        DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, 
        DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT,
                    INWARD_SYS_ID, 
                    X.MDA_SYS_ID COMMON_SYS_ID, 
                    TO_CHAR(XZ.MDA_NO) COMMON_NO,
                    ZZ.WT_SYS_ID, 
                    ZZ.TARE_WT, 
        DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, 
                    ZZ.TARE_WT_MANUALLY, 
                    ZZ.TARE_WT_NOTE, 
                    ZZ.GROSS_WT, 
        DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, 
                    ZZ.GROSS_WT_MANUALLY, 
                    ZZ.GROSS_WT_NOTE, 
                    ZZ.NET_WT,
                    NULL TRANS_SYS_ID, 
                    TRUCK_NO, 
                    DRIVER_ID_TYPE, 
                    DRIVER_ID_NUMBER, 
                    DRIVER_NAME, 
                    DRIVER_CONTACT, 
                    DRIVER_CHANGED, 
                    DRIVER_NAME_NEW, 
                    DRIVER_CONTACT_NEW, 
                    TRUCK_VALIDATION, 
                    IS_GOODS_TRANSFER, 
                    NULL IS_UNLOAD_TRUCK,
                    RFSYSID, 
                    VERIFIED_DOCUMENTS, 
                    RFID_RECEIVE, 
                    VERIFIED_OFFICER_ID, 
                    GATE_SYS_ID_OLD, 
                    CANCEL_GATE_IN, 
                    CANCEL_GATE_REASON,
                    NULL VENDOR_SYS_ID, 
                    XZ.WH_CD CUST_CD, 
                    XZ.PARTY_NAME CUST_NAME, 
                    NULL CUST_SITE_CD, 
                    NULL SITE_NAME, 
                    X.STATION_ID, 
                    X.PLANT_ID, 
                    X.IS_POSTED
                FROM FG_GATE_IN_OUT Z
                LEFT JOIN MDA_HEADER XZ ON X.MDA_SYS_ID = XZ.MDA_SYS_ID
                LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
                WHERE NVL(CANCEL_GATE_IN, 0) = 1 
                    AND GATE_IN_DT IS NOT NULL
                    AND (
                        (P_GATE_FROM_DATE IS NULL OR P_GATE_FROM_DATE = '' OR TRUNC(Z.GATE_IN_DT) >= TRUNC(TO_DATE(P_GATE_FROM_DATE, 'DD/MM/YYYY')))
                        AND (P_GATE_TO_DATE IS NULL OR P_GATE_TO_DATE = '' OR TRUNC(Z.GATE_IN_DT) <= TRUNC(TO_DATE(P_GATE_TO_DATE, 'DD/MM/YYYY')))
                    )
                    AND (LENGTH(NVL(P_VEHICLE_NO, '')) = 0 OR (P_VEHICLE_NO IS NOT NULL AND P_VEHICLE_NO != '' AND (MDA_SYS_ID IN (SELECT MDA_SYS_ID FROM MDA_HEADER WHERE MDA_NO = P_VEHICLE_NO OR VEHICLE_NO = P_VEHICLE_NO))))
            ) X
            UNION ALL
           SELECT 
                X.GATE_SYS_ID, 
        DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, 
        DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT,
                INWARD_SYS_ID, 
                X.PO_SYS_ID COMMON_SYS_ID, 
                TO_CHAR(XZ.PO_NO) COMMON_NO,
                ZZ.WT_SYS_ID, 
                ZZ.TARE_WT, 
        DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, 
                ZZ.TARE_WT_MANUALLY, 
                ZZ.TARE_WT_NOTE, 
                ZZ.GROSS_WT, 
        DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, 
                ZZ.GROSS_WT_MANUALLY, 
                ZZ.GROSS_WT_NOTE, 
                ZZ.NET_WT,
                X.TRANS_SYS_ID, 
                X.TRUCK_NO, 
                DRIVER_ID_TYPE, 
                DRIVER_ID_NUMBER, 
                DRIVER_NAME, 
                DRIVER_CONTACT, 
                DRIVER_CHANGED, 
                DRIVER_NAME_NEW, 
                DRIVER_CONTACT_NEW, 
                TRUCK_VALIDATION, 
                NULL IS_GOODS_TRANSFER, 
                IS_UNLOAD_TRUCK,
                RFSYSID, 
                VERIFIED_DOCUMENTS, 
                RFID_RECEIVE, 
                VERIFIED_OFFICER_ID, 
                NULL GATE_SYS_ID_OLD, 
                CANCEL_GATE_IN, 
                CANCEL_GATE_REASON,
                XZ.VENDOR_SYS_ID,
                NULL CUST_CD, 
                NULL CUST_NAME, 
                NULL CUST_SITE_CD, 
                NULL SITE_NAME, 
                X.STATION_ID, 
                X.PLANT_ID, 
                X.IS_POSTED
            FROM RM_GATE_IN_OUT Z
            LEFT JOIN PO_HEADER XZ ON X.PO_SYS_ID = XZ.PO_SYS_ID
            LEFT JOIN RM_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
            WHERE NVL(CANCEL_GATE_IN, 0) = 1 
                AND GATE_IN_DT IS NOT NULL
                AND (
                    (P_GATE_FROM_DATE IS NULL OR P_GATE_FROM_DATE = '' OR TRUNC(Z.GATE_IN_DT) >= TRUNC(TO_DATE(P_GATE_FROM_DATE, 'DD/MM/YYYY')))
                    AND (P_GATE_TO_DATE IS NULL OR P_GATE_TO_DATE = '' OR TRUNC(Z.GATE_IN_DT) <= TRUNC(TO_DATE(P_GATE_TO_DATE, 'DD/MM/YYYY')))
                )
                AND (LENGTH(NVL(P_VEHICLE_NO, '')) = 0 OR (P_VEHICLE_NO IS NOT NULL AND P_VEHICLE_NO != '' AND (PO_SYS_ID IN (SELECT PO_SYS_ID FROM PO_HEADER WHERE PO_NO = P_VEHICLE_NO OR TRUCK_NO = P_VEHICLE_NO))))
            UNION ALL
           SELECT 
                X.GATE_SYS_ID,
        DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, 
        DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT,
                INWARD_SYS_ID, 
                X.SO_SYS_ID COMMON_SYS_ID, 
                TO_CHAR(XZ.SO_NO) COMMON_NO,
                ZZ.WT_SYS_ID, 
                ZZ.TARE_WT, 
        DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, 
                ZZ.TARE_WT_MANUALLY, 
                ZZ.TARE_WT_NOTE, 
                ZZ.GROSS_WT, 
        DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, 
                ZZ.GROSS_WT_MANUALLY, 
                ZZ.GROSS_WT_NOTE, 
                ZZ.NET_WT,
                X.TRANS_SYS_ID, 
                X.TRUCK_NO, 
                DRIVER_ID_TYPE, 
                DRIVER_ID_NUMBER, 
                DRIVER_NAME, 
                DRIVER_CONTACT, 
                DRIVER_CHANGED, 
                DRIVER_NAME_NEW, 
                DRIVER_CONTACT_NEW, 
                TRUCK_VALIDATION, 
                IS_GOODS_TRANSFER, 
                NULL IS_UNLOAD_TRUCK,
                RFSYSID, 
                VERIFIED_DOCUMENTS, 
                RFID_RECEIVE, 
                VERIFIED_OFFICER_ID, 
                GATE_SYS_ID_OLD, 
                CANCEL_GATE_IN, 
                CANCEL_GATE_REASON,
                XZ.VENSOR_SYS_ID AS VENDOR_SYS_ID, 
                TO_CHAR(XZ.CUST_CD) AS CUST_CD, 
                XZ.CUST_NAME, 
                XZ.CUST_SITE_CD, 
                XZ.SITE_NAME, 
                X.STATION_ID, 
                X.PLANT_ID, 
                X.IS_POSTED
            FROM SP_GATE_IN_OUT Z
            LEFT JOIN SO_HEADER XZ ON X.SO_SYS_ID = XZ.SO_SYS_ID
            LEFT JOIN SP_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
            WHERE NVL(CANCEL_GATE_IN, 0) = 1 
                AND GATE_IN_DT IS NOT NULL
                AND (
                    (P_GATE_FROM_DATE IS NULL OR P_GATE_FROM_DATE = '' OR TRUNC(Z.GATE_IN_DT) >= TRUNC(TO_DATE(P_GATE_FROM_DATE, 'DD/MM/YYYY')))
                    AND (P_GATE_TO_DATE IS NULL OR P_GATE_TO_DATE = '' OR TRUNC(Z.GATE_IN_DT) <= TRUNC(TO_DATE(P_GATE_TO_DATE, 'DD/MM/YYYY')))
                )
                AND (LENGTH(NVL(P_VEHICLE_NO, '')) = 0 OR (P_VEHICLE_NO IS NOT NULL AND P_VEHICLE_NO != '' AND (SO_SYS_ID IN (SELECT SO_SYS_ID FROM SO_HEADER WHERE SO_NO = P_VEHICLE_NO OR TENDER_NO = P_VEHICLE_NO))))
        )
        SELECT * FROM TBL_MAIN WHERE RNUM BETWEEN P_DISPLAY_START + 1 AND P_DISPLAY_START + P_DISPLAY_LENGTH;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_GATE_IN_CANCEL_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_GATE_IN_CANCEL_SAVE(
    IN P_ID INT,
    IN P_INWARD_SYS_ID INT,
    IN P_CANCEL_GATE_REASON VARCHAR(255),
    IN P_STATION_ID INT,
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_NUM INT;
    DECLARE TEMP_RFSYSID INT;
    
    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact the system administrator|0';

    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT := 'E|You are not authorized to perform this operation.|0';    
    #ELSE
    IF P_ID > 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 1 THEN
        SELECT COUNT(*) INTO TEMP_NUM FROM FG_GATE_IN_OUT X WHERE X.GATE_SYS_ID = COALESCE(P_ID, 0);

        IF COALESCE(TEMP_NUM, 0) > 0 THEN
            SELECT RFSYSID INTO TEMP_RFSYSID FROM FG_GATE_IN_OUT X WHERE X.GATE_SYS_ID = COALESCE(P_ID, 0);
        
            SELECT COUNT(*) INTO TEMP_NUM FROM RFID_MASTER WHERE RFSYSID = TEMP_RFSYSID;
        
            IF COALESCE(TEMP_NUM, 0) > 0 THEN
                SELECT RFSYSID INTO TEMP_RFSYSID FROM RFID_MASTER WHERE RFSYSID = TEMP_RFSYSID;
            ELSE
                SET TEMP_RFSYSID := 0;
            END IF;
        ELSE
            SET TEMP_RFSYSID := 0;
        END IF;

        UPDATE FG_GATE_IN_OUT 
        SET CANCEL_GATE_IN = 1, CANCEL_GATE_REASON = P_CANCEL_GATE_REASON
        WHERE GATE_SYS_ID = P_ID AND RFSYSID = TEMP_RFSYSID AND COALESCE(CANCEL_GATE_IN, 0) = 0;
  
        UPDATE RFID_MASTER SET STATUS = 'Active' WHERE RFSYSID = TEMP_RFSYSID;

        SET P_RESULT := 'S|Record saved successfully|';
    END IF;

    -- Exception handling
    -- Note: MySQL doesn't support detailed exception handling like Oracle
    -- You can handle exceptions in your application logic
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_GATE_IN_MDA_LIST */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE PC_GATE_IN_MDA_LIST(IN `P_SearchTerm` VARCHAR(255),IN P_PLANT_ID INT)
BEGIN

SELECT MDA_SYS_ID ID, MDA_NO, DI_NO, PLANT_CD, DATE_FORMAT(MDA_DT, '%d/%m/%Y') AS MDA_DT, X.TRANS_SYS_ID, TPTR_CD, TPTR_NAME, WH_CD, PARTY_NAME, DRIVER,
VEHICLE_NO, MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, OUT_TIME, X.PLANT_ID, X.CREATED_DATETIME, X.IS_POSTED, desp_place,
@MDA_ORDER := @MDA_ORDER + 1 AS MDA_ORDER,
COALESCE((SELECT Y.GATE_SYS_ID FROM FG_GATE_IN_OUT Y WHERE COALESCE(Y.CANCEL_GATE_IN, 0) = 0 AND Y.GATE_OUT_DT IS NULL AND Y.MDA_SYS_ID = X.MDA_SYS_ID ORDER BY GATE_IN_DT DESC LIMIT 1), 0) AS GATE_SYS_ID
FROM MDA_HEADER X
LEFT JOIN TRANSPORTER_MASTER TR ON X.TRANS_SYS_ID = TR.TRANS_SYS_ID ,
(SELECT @MDA_ORDER := 0) AS MO
WHERE X.PLANT_ID = P_PLANT_ID AND OUT_TIME IS NULL AND MDA_SYS_ID not in (select MDA_SYS_ID FROM FG_GATE_IN_OUT)
AND 1 = CASE WHEN LENGTH(COALESCE(P_SearchTerm, '')) > 0 THEN CASE WHEN UPPER(VEHICLE_NO) LIKE CONCAT('%', UPPER(P_SearchTerm), '%')  OR  UPPER(MDA_NO) LIKE CONCAT('%', UPPER(P_SearchTerm), '%')  THEN 1 ELSE 0 END ELSE 1 END
ORDER BY CREATED_DATETIME DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_GATE_IN_OUT_REPORT_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_GATE_IN_OUT_REPORT_GET(
IN P_SEARCHTERM VARCHAR(20),
IN P_TYPE VARCHAR(20),
IN P_PLANT_ID BIGINT
)
BEGIN




WITH TBL_MAIN AS (SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, MDA_DT, TRANS_SYS_ID, INWARD_SYS_ID
					, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION
					, RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD, IS_GOODS_TRANSFER
					, DI_NO, PLANT_CD, WH_CD, PARTY_NAME, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, OUT_TIME, desp_place
						FROM (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
						, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
						, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
						, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
								FROM fg_gate_in_out X, 
								(SELECT Z.* FROM mda_header Z
									WHERE Z.PLANT_ID = P_PLANT_ID AND Z.MDA_NO = P_SEARCHTERM -- (
                                    -- Z.VEHICLE_NO = P_SEARCHTERM
									-- OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM OR XZ.MDA_SYS_ID = 0) 
									#OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.GATE_SYS_ID = 0 OR XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = 'RJ31GB0918'))
								-- )
                                ) Y WHERE X.TRUCK_NO = Y.VEHICLE_NO AND X.PLANT_ID = P_PLANT_ID 
                                AND X.MDA_SYS_ID = Y.MDA_SYS_ID  -- Added by ashish 
							) M_G
					)
SELECT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID ID, X.MDA_SYS_ID, X.MDA_NO, X.VEHICLE_NO
, DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(X.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
, X.TRANS_SYS_ID, X.INWARD_SYS_ID
, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD
, X.IS_GOODS_TRANSFER, NULL AS IS_UNLOAD_TRUCK, NULL AS VENDOR_SYS_ID, NULL AS CUST_SITE_CD, NULL AS SITE_NAME
, X.DI_NO, X.PLANT_CD, X.WH_CD, X.PARTY_NAME, X.DIST
, Y.PROD_SYS_ID, PRD_CD, PRD_DESC, X.BAG_NOS, (X.BAG_NOS / 24) AS Required_SHIPPER
, (SELECT COUNT(*) FROM mda_loading Z WHERE Z.MDA_SYS_ID  = X.MDA_SYS_ID)LOADED_SHIPPER
, X.NETT_QTY, X.GROSS_QTY, X.ECHIT_NO, X.GST_NO, X.OUT_TIME, X.desp_place
FROM TBL_MAIN X
LEFT JOIN MDA_DETAIL Y ON Y.MDA_SYS_ID = X.MDA_SYS_ID
LEFT JOIN PRODUCT_MASTER Z ON Z.PROD_SYS_ID = Y.PROD_SYS_ID;

IF IFNULL(P_TYPE, '') = '' THEN
	WITH TBL_MAIN AS (SELECT (ROW_NUMBER() OVER ()) AS RNUM, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO
						##########################
						, ML.SHIPPER_QR_CODE, SQA.BATCH_NO, SUM(COUNT(ML.SHIPPER_QR_CODE)) OVER () AS COUNT_ROW#LOADED_SHIPPER 
						FROM (SELECT DISTINCT X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO 
						FROM fg_gate_in_out X, 
							(SELECT Z.* FROM mda_header Z
									WHERE Z.PLANT_ID = P_PLANT_ID AND Z.MDA_NO = P_SEARCHTERM /*AND (Z.VEHICLE_NO = P_SEARCHTERM
									OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM OR XZ.MDA_SYS_ID = 0) 
									#OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.GATE_SYS_ID = 0 OR XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = 'RJ31GB0918'))
								)*/) Y WHERE X.TRUCK_NO = Y.VEHICLE_NO AND X.PLANT_ID = P_PLANT_ID and Y.MDA_SYS_ID = X.MDA_SYS_ID ) M_G
						########################## and Y.MDA_SYS_ID = X.MDA_SYS_ID -- added by ashish 
						INNER JOIN MDA_LOADING ML ON ML.MDA_SYS_ID = M_G.MDA_SYS_ID
						LEFT JOIN SHIPPER_QRCODE SQ ON SQ.SHIPPER_QRCODE = ML.SHIPPER_QR_CODE
						LEFT JOIN SHIPPER_QRCODE_API SQA ON SQA.SHIPPER_QRCODE_API_SYSID = SQ.SHIPPER_QRCODE_API_SYSID
						GROUP BY M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO, ML.SHIPPER_QR_CODE, SQA.BATCH_NO
		)
		SELECT RNUM SR_NO, COUNT_ROW, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, VEHICLE_NO, SHIPPER_QR_CODE, BATCH_NO FROM TBL_MAIN ;
ELSEIF IFNULL(P_TYPE, '') = 'R' THEN
		SELECT (ROW_NUMBER() OVER ()) AS SR_NO, NULL COUNT_ROW, NULL GATE_SYS_ID, NULL MDA_SYS_ID, NULL MDA_NO, NULL VEHICLE_NO
        , QRCODE as SHIPPER_QR_CODE, REJECT_REASON 
        FROM qr_code_rejectlist where MDA_NO = P_SEARCHTERM;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_GATE_IN_PO_LIST */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_GATE_IN_PO_LIST(IN `P_SearchTerm` VARCHAR(255),IN P_PLANT_ID INT)
BEGIN

SELECT PO_SYS_ID, PO_NO, PO_DATE, VENDOR_SYS_ID, COST_CENTER, PO_DESCCRIPTION, PO.TRANS_SYS_ID, TR.TPTR_CD, TR.TPTR_NAME, TRUCK_NO, IS_PO_MANUAL
, PO.STATION_ID, PO.PLANT_ID, (SELECT PLANTCODE FROM PLANT_MASTER PM WHERE PO.PLANT_ID = PM.PLANTID) PLANT_CD, PO.CREATED_BY_ID, PO.CREATED_DATETIME
, PO.IS_POSTED FROM PO_HEADER PO
LEFT JOIN TRANSPORTER_MASTER TR ON PO.TRANS_SYS_ID = TR.TRANS_SYS_ID
WHERE PO.PLANT_ID = P_PLANT_ID 
AND PO_SYS_ID NOT IN (SELECT PO_SYS_ID FROM RM_GATE_IN_OUT)
AND 1 = CASE WHEN LENGTH(COALESCE(P_SEARCHTERM, '')) > 0 THEN CASE WHEN UPPER(TRUCK_NO) LIKE CONCAT('%', UPPER(P_SEARCHTERM), '%')  OR  UPPER(PO_NO) LIKE CONCAT('%', UPPER(P_SEARCHTERM), '%')  THEN 1 ELSE 0 END ELSE 1 END
ORDER BY CREATED_DATETIME DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_GATE_IN_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_GATE_IN_SAVE(
IN `P_ID` INT,
IN `P_INWARD_SYS_ID` INT,
IN `P_COMMON_SYS_ID` INT,
IN `P_COMMON_NO` VARCHAR(255),
IN `P_TRUCK_NO` VARCHAR(255),
IN `P_DRIVER_ID_TYPE` VARCHAR(255),
IN `P_DRIVER_ID_NUMBER` VARCHAR(255),
IN `P_DRIVER_NAME` VARCHAR(255),
IN `P_DRIVER_CONTACT` VARCHAR(255),
IN `P_DRIVER_CHANGED` INT,
IN `P_DRIVER_NAME_NEW` VARCHAR(255),
IN `P_DRIVER_CONTACT_NEW` VARCHAR(255),
IN `P_TRUCK_VALIDATION` INT,
IN `P_RFSYSID` VARCHAR(255),
IN `P_RFID_CODE` VARCHAR(255),
IN `P_RFID_SRNO` VARCHAR(255),
IN `P_RFID_RECEIVE` INT,
IN `P_STATION_ID` INT,
IN `P_ISACTIVE` VARCHAR(255),
IN `P_PLANT_ID` INT,
IN `P_USER_ID` INT,
IN `P_ROLE_ID` INT,
IN `P_MENU_ID` INT,
OUT `P_RESULT` VARCHAR(255)
)
BEGIN

DECLARE TEMP_STATION_ID INT DEFAULT 7;
DECLARE TEMP_NUM INT DEFAULT 0;
DECLARE TEMP_COMMON_SYS_ID INT DEFAULT 0;
DECLARE TEMP_RFSYSID INT DEFAULT 0;
      
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

IF IFNULL(P_COMMON_SYS_ID, 0) = 0 AND IFNULL(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 1 THEN
	SELECT COUNT(*) INTO TEMP_NUM FROM MDA_HEADER WHERE MDA_NO = P_COMMON_NO;
		IF IFNULL(TEMP_NUM, 0) > 0 THEN
			SELECT MDA_SYS_ID INTO TEMP_COMMON_SYS_ID FROM MDA_HEADER WHERE MDA_NO = P_COMMON_NO LIMIT 1;
		ELSE
			SET TEMP_COMMON_SYS_ID = 0;       
		END IF;
ELSE
	SET TEMP_COMMON_SYS_ID = P_COMMON_SYS_ID;
END IF;

IF IFNULL(P_RFSYSID, 0) = 0 AND IFNULL(P_RFID_SRNO, '') != '' THEN
	
    SELECT COUNT(*) INTO TEMP_NUM FROM RFID_MASTER X WHERE X.STATUS IN ('Active', 'A') AND TRIM(X.RFIDSRNO) = TRIM(P_RFID_SRNO);
	
    IF IFNULL(TEMP_NUM, 0) > 0 THEN
		SELECT RFSYSID INTO TEMP_RFSYSID FROM RFID_MASTER X WHERE X.STATUS IN ('Active', 'A') AND TRIM(X.RFIDSRNO) = TRIM(P_RFID_SRNO)  LIMIT 1;
	ELSE
		SET TEMP_RFSYSID = 0;        
	END IF;
ELSE
	SET TEMP_RFSYSID = P_RFSYSID;
END IF;

SELECT COUNT(*) INTO TEMP_NUM FROM FG_GATE_IN_OUT WHERE /*DATE(GATE_IN_DT) = DATE(CURRENT_DATE) AND*/ INWARD_SYS_ID = IFNULL(P_INWARD_SYS_ID, 0) 
		AND MDA_SYS_ID = IFNULL(TEMP_COMMON_SYS_ID, 0) AND GATE_SYS_ID != IFNULL(P_ID, 0);

IF IFNULL(TEMP_NUM, 0) > 0 THEN
	SET P_RESULT = 'E|Entered Gate In details already exist.|0';
ELSEIF IFNULL(TEMP_RFSYSID, 0) = 0 THEN
	SET P_RESULT = 'E|RFID does not exist or already assigned.|0';
ELSEIF IFNULL(TEMP_COMMON_SYS_ID, 0) = 0 AND IFNULL(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 1 THEN
	SET P_RESULT = 'E|MDA No. does not exist.|0';
ELSEIF P_ID > 0 AND IFNULL(TEMP_COMMON_SYS_ID, 0) > 0 THEN
	SET P_RESULT = 'S|Record updated successfully|';

ELSEIF IFNULL(TEMP_COMMON_SYS_ID, 0) > 0 THEN
	IF IFNULL(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 1 THEN
		SELECT IFNULL(MAX(GATE_SYS_ID), 0) + 1 INTO TEMP_NUM FROM FG_GATE_IN_OUT;

		INSERT INTO FG_GATE_IN_OUT (
		GATE_SYS_ID, GATE_IN_DT, INWARD_SYS_ID, MDA_SYS_ID, TRUCK_NO, 
		DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, 
		DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION,
		RFSYSID, RFID_RECEIVE, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME
		)
		VALUES (
		TEMP_NUM, NOW(), P_INWARD_SYS_ID, TEMP_COMMON_SYS_ID, P_TRUCK_NO, 
		P_DRIVER_ID_TYPE, P_DRIVER_ID_NUMBER, P_DRIVER_NAME, P_DRIVER_CONTACT, 
		IFNULL(P_DRIVER_CHANGED, 0), P_DRIVER_NAME_NEW, P_DRIVER_CONTACT_NEW, IFNULL(P_TRUCK_VALIDATION, 0),
		IFNULL(TEMP_RFSYSID, 0), IFNULL(P_RFID_RECEIVE, 0), TEMP_STATION_ID, P_PLANT_ID, P_USER_ID, NOW()
		);

		UPDATE RFID_MASTER SET STATUS = 'Assigned' WHERE RFSYSID = TEMP_RFSYSID;

		SET P_RESULT = 'S|Record saved successfully|';
	END IF;
    
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_GATE_IN_SO_LIST */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_GATE_IN_SO_LIST(IN `P_SearchTerm` VARCHAR(255),IN P_PLANT_ID INT)
BEGIN

SELECT SO_SYS_ID, UNIT_CODE, SO_NO, SO_DATE, SO_RELEASE_DATE, SO_VALID_DATE, SEQUENCE_NO, TENDER_NO, TENDER_DATE, SO.VENSOR_SYS_ID, CUST_CD
 , CUST_NAME, CUST_SITE_CD, SITE_NAME, ADD1, ADD2, ADD3, CITY, PIN, STATE, STATE_CD, GSTN_NO, PAN_NO, CUST_NON_GST, TEL_NO
 , SO_REMARKS, STATUS, STATUS_DATE, STATUS_REMARKS, TERMS_PYMT_TERM, TERMS_LIFTING_PERIOD_DAYS, TENDER_TYPE, AMEND_NO
 , AMEND_RELEASE_DATE, CREATED_DATETIME, IS_POSTED, PLANT_ID, RIVISION FROM SO_HEADER SO
    WHERE SO.PLANT_ID = P_PLANT_ID 
    AND SO_SYS_ID NOT IN (SELECT SO_SYS_ID FROM SP_GATE_IN_OUT)
    AND 1 = CASE WHEN LENGTH(COALESCE(P_SEARCHTERM, '')) > 0 THEN CASE WHEN UPPER(SO_NO) LIKE CONCAT('%', UPPER(P_SEARCHTERM), '%')  THEN 1 ELSE 0 END ELSE 1 END
    ORDER BY CREATED_DATETIME DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_GATE_OUT_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_GATE_OUT_GET(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
	DECLARE TEMP_STATION_ID INT DEFAULT 7;
    
    
WITH TBL_MAIN AS 
(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
		, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
				FROM fg_gate_in_out X, 
				(SELECT Z.* FROM mda_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID AND 1 = (CASE WHEN IFNULL(P_SEARCHTERM,'') = '' THEN (CASE WHEN OUT_TIME IS NULL THEN 1 ELSE 0 END ) ELSE 1 END ) 
					AND ((Z.VEHICLE_NO = P_SEARCHTERM 
							OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM OR XZ.MDA_SYS_ID = P_ID) 
							OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID IN (125, 1))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND P_ID = 0, 1, 0)
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.VEHICLE_NO AND 1 = (CASE WHEN IFNULL(P_SEARCHTERM,'') = '' THEN (CASE WHEN COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL THEN 1 ELSE 0 END ) ELSE 1 END ) 
				AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0)
	)
SELECT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID ID, X.MDA_SYS_ID COMMON_SYS_ID, X.MDA_NO COMMON_NO, X.VEHICLE_NO TRUCK_NO
, DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(X.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
, X.TRANS_SYS_ID, (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) AS TRANSPORTER_NAME
, X.INWARD_SYS_ID, (SELECT Z.INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = IF(X.INWARD_SYS_ID = 1, 125, X.INWARD_SYS_ID) LIMIT 1) AS INWARD_TYPE
, X.DRIVER_ID_TYPE, (SELECT Z.LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD
, X.IS_GOODS_TRANSFER, NULL AS IS_UNLOAD_TRUCK, NULL AS VENDOR_SYS_ID, NULL AS CUST_SITE_CD, NULL AS SITE_NAME
, X.DI_NO, X.PLANT_CD PLANT_CODE, X.WH_CD, X.PARTY_NAME, X.DIST, X.BAG_NOS, X.NETT_QTY, X.GROSS_QTY, X.ECHIT_NO, X.GST_NO, X.OUT_TIME, X.desp_place
, ZZ.WT_SYS_ID, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.TARE_WT_MANUALLY, ZZ.TARE_WT_NOTE
, ZZ.GROSS_WT, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, ZZ.GROSS_WT_MANUALLY, ZZ.GROSS_WT_NOTE, ZZ.NET_WT
FROM TBL_MAIN X 
LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID AND ZZ.PLANT_ID = X.PLANT_ID
-- WHERE COALESCE(X.CANCEL_GATE_IN, 0) = 0 -- AND X.GATE_OUT_DT IS NULL -- AND X.OUT_TIME IS NULL
AND ZZ.TARE_WT IS NOT NULL AND COALESCE(ZZ.TARE_WT,0) > 0 AND ZZ.GROSS_WT_DT IS NOT NULL AND COALESCE(ZZ.GROSS_WT,0) > 0;

    /*SELECT 
        GATE_SYS_ID AS ID, 
        DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, 
        DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT,
        INWARD_SYS_ID, 
        (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE, 
        COMMON_NO, 
        COMMON_SYS_ID,
        X.WT_SYS_ID, 
        X.TARE_WT, 
        DATE_FORMAT(X.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, 
        X.TARE_WT_MANUALLY, 
        X.TARE_WT_NOTE, 
        X.GROSS_WT, 
        DATE_FORMAT(X.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, 
        X.GROSS_WT_MANUALLY, 
        X.GROSS_WT_NOTE, 
        X.NET_WT,
        TRANS_SYS_ID,
        #(SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Plant_ID = P_PLANT_ID LIMIT 1) AS TRANSPORTER_NAME,
        (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) AS TRANSPORTER_NAME,
        TRUCK_NO, 
        DRIVER_ID_TYPE, 
        (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT,
        DRIVER_ID_NUMBER, 
        DRIVER_NAME, 
        DRIVER_CONTACT, 
        DRIVER_CHANGED, 
        DRIVER_NAME_NEW, 
        DRIVER_CONTACT_NEW, 
        TRUCK_VALIDATION, 
        IS_GOODS_TRANSFER, 
        IS_UNLOAD_TRUCK,
        X.RFSYSID, 
        XZ.RFIDSRNO, 
        XZ.RFIDCODE,
        VERIFIED_DOCUMENTS, 
        RFID_RECEIVE, 
        VERIFIED_OFFICER_ID, 
        NULL AS VERIFIED_OFFICER_NAME, 
        GATE_SYS_ID_OLD, 
        CANCEL_GATE_IN, 
        CANCEL_GATE_REASON,
        X.VENDOR_SYS_ID, 
        VM.VENDOR_CODE, 
        VM.ORGANIZATION_NAME AS VENDOR_NAME,
        X.CUST_CD, 
        X.CUST_NAME, 
        X.CUST_SITE_CD, 
        X.SITE_NAME, 
        X.STATION_ID, 
        X.PLANT_ID, 
        PM.PLANT_NAME, 
        PM.PLANTCODE AS PLANT_CODE, 
        X.IS_POSTED
    FROM (
        SELECT 
            X.GATE_SYS_ID, 
            GATE_IN_DT, 
            GATE_OUT_DT, 
            INWARD_SYS_ID, 
            X.MDA_SYS_ID AS COMMON_SYS_ID, 
            XZ.MDA_NO AS COMMON_NO,
            ZZ.WT_SYS_ID, 
            ZZ.TARE_WT, 
            ZZ.TARE_WT_DT, 
            ZZ.TARE_WT_MANUALLY, 
            ZZ.TARE_WT_NOTE, 
            ZZ.GROSS_WT, 
            ZZ.GROSS_WT_DT, 
            ZZ.GROSS_WT_MANUALLY, 
            ZZ.GROSS_WT_NOTE, 
            ZZ.NET_WT,
            XZ.TRANS_SYS_ID,
            -- (SELECT TRANS_SYS_ID FROM TRANSPORTER_MASTER Z WHERE Z.tptr_cd = X.tptr_code and Plant_ID = P_PLANT_ID LIMIT 1) AS TRANS_SYS_ID, 
            TRUCK_NO, 
            DRIVER_ID_TYPE, 
            DRIVER_ID_NUMBER, 
            DRIVER_NAME, 
            DRIVER_CONTACT, 
            DRIVER_CHANGED, 
            DRIVER_NAME_NEW, 
            DRIVER_CONTACT_NEW, 
            TRUCK_VALIDATION, 
            IS_GOODS_TRANSFER, 
            NULL AS IS_UNLOAD_TRUCK,
            RFSYSID, 
            VERIFIED_DOCUMENTS, 
            RFID_RECEIVE, 
            VERIFIED_OFFICER_ID, 
            GATE_SYS_ID_OLD, 
            CANCEL_GATE_IN, 
            CANCEL_GATE_REASON,
            NULL AS VENDOR_SYS_ID, 
            XZ.WH_CD AS CUST_CD, 
            XZ.PARTY_NAME AS CUST_NAME, 
            NULL AS CUST_SITE_CD, 
            NULL AS SITE_NAME, 
            X.STATION_ID, 
            X.PLANT_ID, 
            X.IS_POSTED
        FROM FG_GATE_IN_OUT X
        LEFT JOIN MDA_HEADER XZ ON X.MDA_SYS_ID = XZ.MDA_SYS_ID
        LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
        WHERE X.PLANT_ID = P_PLANT_ID AND COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL AND STATION_ID = TEMP_STATION_ID
            AND (
			1 = (CASE WHEN CHAR_LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN 
                        (CASE WHEN X.MDA_SYS_ID IN (SELECT Z.MDA_SYS_ID FROM MDA_HEADER Z WHERE Z.MDA_NO = P_VEHICLE_NO OR Z.VEHICLE_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END)                        
                ELSE 1 END)
			OR
			1 = (CASE WHEN CHAR_LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN 
                        (CASE WHEN RFSYSID IN (SELECT Z.RFSYSID FROM RFID_MASTER Z WHERE Z.RFIDSRNO = P_RFID_NO) THEN 1 ELSE 0 END)
                ELSE 1 END)
			) 
            AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL FG WHERE X.GATE_SYS_ID = FG.GATE_SYS_ID AND TARE_WT IS NOT NULL AND COALESCE(FG.TARE_WT,0) > 0 AND GROSS_WT_DT IS NOT NULL AND COALESCE(FG.GROSS_WT,0) > 0)
        UNION ALL
        SELECT 
            X.GATE_SYS_ID, 
            GATE_IN_DT, 
            GATE_OUT_DT, 
            INWARD_SYS_ID, 
            X.PO_SYS_ID AS COMMON_SYS_ID, 
            XZ.PO_NO AS COMMON_NO,
            ZZ.WT_SYS_ID, 
            ZZ.TARE_WT, 
            ZZ.TARE_WT_DT, 
            ZZ.TARE_WT_MANUALLY, 
            ZZ.TARE_WT_NOTE, 
            ZZ.GROSS_WT, 
            ZZ.GROSS_WT_DT, 
            ZZ.GROSS_WT_MANUALLY, 
            ZZ.GROSS_WT_NOTE, 
            ZZ.NET_WT,
            NULL AS TRANS_SYS_ID, 
            X.TRUCK_NO, 
            DRIVER_ID_TYPE, 
            DRIVER_ID_NUMBER, 
            DRIVER_NAME, 
            DRIVER_CONTACT, 
            DRIVER_CHANGED, 
            DRIVER_NAME_NEW, 
            DRIVER_CONTACT_NEW, 
            TRUCK_VALIDATION, 
            NULL AS IS_GOODS_TRANSFER, 
            IS_UNLOAD_TRUCK,
            RFSYSID, 
            VERIFIED_DOCUMENTS, 
            RFID_RECEIVE, 
            VERIFIED_OFFICER_ID, 
            NULL AS GATE_SYS_ID_OLD, 
            CANCEL_GATE_IN, 
            CANCEL_GATE_REASON,
            XZ.VENDOR_SYS_ID, 
            NULL AS CUST_CD, 
            NULL AS CUST_NAME, 
            NULL AS CUST_SITE_CD, 
            NULL AS SITE_NAME, 
            X.STATION_ID, 
            X.PLANT_ID, 
            X.IS_POSTED
        FROM RM_GATE_IN_OUT X
        LEFT JOIN PO_HEADER XZ ON X.PO_SYS_ID = XZ.PO_SYS_ID
        LEFT JOIN RM_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
        WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL
            AND (
                (1 = (CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN (CASE WHEN X.PO_SYS_ID IN (SELECT PO_SYS_ID FROM PO_HEADER WHERE PO_NO = P_VEHICLE_NO OR TRUCK_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 1 END))
                OR 
                (1 = (CASE WHEN LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 1 END))
            ) AND 0 < (SELECT COUNT(*) FROM RM_WEIGHMENT_DETAIL RM WHERE X.GATE_SYS_ID = RM.GATE_SYS_ID AND TARE_WT IS NOT NULL AND COALESCE(RM.TARE_WT,0) > 0 AND GROSS_WT_DT IS NOT NULL AND COALESCE(RM.GROSS_WT,0) > 0)
        UNION ALL
        SELECT 
            X.GATE_SYS_ID, 
            GATE_IN_DT, 
            GATE_OUT_DT, 
            INWARD_SYS_ID, 
            X.SO_SYS_ID AS COMMON_SYS_ID, 
            XZ.SO_NO AS COMMON_NO,
            ZZ.WT_SYS_ID, 
            ZZ.TARE_WT, 
            ZZ.TARE_WT_DT, 
            ZZ.TARE_WT_MANUALLY, 
            ZZ.TARE_WT_NOTE, 
            ZZ.GROSS_WT, 
            ZZ.GROSS_WT_DT, 
            ZZ.GROSS_WT_MANUALLY, 
            ZZ.GROSS_WT_NOTE, 
            ZZ.NET_WT,
            X.TRANS_SYS_ID, 
            X.TRUCK_NO, 
            DRIVER_ID_TYPE, 
            DRIVER_ID_NUMBER, 
            DRIVER_NAME, 
            DRIVER_CONTACT, 
            DRIVER_CHANGED, 
            DRIVER_NAME_NEW, 
            DRIVER_CONTACT_NEW, 
            TRUCK_VALIDATION, 
            IS_GOODS_TRANSFER, 
            NULL AS IS_UNLOAD_TRUCK,
            RFSYSID, 
            VERIFIED_DOCUMENTS, 
            RFID_RECEIVE, 
            VERIFIED_OFFICER_ID, 
            GATE_SYS_ID_OLD, 
            CANCEL_GATE_IN, 
            CANCEL_GATE_REASON,
            XZ.VENSOR_SYS_ID AS VENDOR_SYS_ID, 
            XZ.CUST_CD AS CUST_CD, 
            XZ.CUST_NAME, 
            XZ.CUST_SITE_CD, 
            XZ.SITE_NAME, 
            X.STATION_ID, 
            X.PLANT_ID, 
            X.IS_POSTED
        FROM SP_GATE_IN_OUT X
        LEFT JOIN SO_HEADER XZ ON X.SO_SYS_ID = XZ.SO_SYS_ID
        LEFT JOIN SP_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
        WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL
            AND (
                (1 = (CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN (CASE WHEN X.SO_SYS_ID IN (SELECT SO_SYS_ID FROM SO_HEADER WHERE SO_NO = P_VEHICLE_NO OR TENDER_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 1 END))
                OR 
                (1 = (CASE WHEN LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 1 END))
            ) AND 0 < (SELECT COUNT(*) FROM SP_WEIGHMENT_DETAIL SP WHERE X.GATE_SYS_ID = SP.GATE_SYS_ID AND TARE_WT IS NOT NULL AND COALESCE(SP.TARE_WT,0) > 0 AND GROSS_WT_DT IS NOT NULL AND COALESCE(SP.GROSS_WT,0) > 0)
    ) X
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
    LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID;
    */
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_GATE_OUT_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_GATE_OUT_SAVE(
    IN P_ID INT,
    IN P_MDA_SYS_ID INT,
    IN P_GATE_OUT_NOTE VARCHAR(255),
    IN P_INVOICE_QR_CODE VARCHAR(255),
    IN P_BASE64_INVOICE_QR_CODE LONGTEXT,
    IN P_STATION_ID INT,
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN

	DECLARE TEMP_STATION_ID INT DEFAULT 7;
	DECLARE TEMP_NUM INT DEFAULT 0;
    DECLARE TEMP_INWARD_SYS_ID INT DEFAULT 1;
    DECLARE TEMP_RFID INT DEFAULT 0;
    DECLARE TEMP_MDA_NO VARCHAR(255);
    DECLARE TEMP_GATE_OUT_DT VARCHAR(255) DEFAULT NULL;
    DECLARE TEMP_INVOICE_QR_CODE VARCHAR(255) DEFAULT NULL;
      
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SELECT X.RFSYSID, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_RFID, TEMP_GATE_OUT_DT FROM fg_gate_in_out X WHERE X.GATE_SYS_ID = P_ID AND X.MDA_SYS_ID = P_MDA_SYS_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NULL THEN
			
            SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
            
        ELSE
			
            SELECT X.INVOICEQrCODE INTO TEMP_INVOICE_QR_CODE FROM mda_invoice_qr X WHERE X.GATE_SYS_ID = P_ID AND X.MDA_SYS_ID = P_MDA_SYS_ID AND PLANT_ID = P_PLANT_ID LIMIT 1;
        			
            IF IFNULL(TEMP_INVOICE_QR_CODE, '') != '' THEN
				SET P_RESULT = CONCAT('E|Gate Out Details is already saved. Gate Out Date Time : ', IFNULL(TEMP_GATE_OUT_DT,''), ' and Invoice QR Code : ', TEMP_INVOICE_QR_CODE, '|0');
			ELSE        
				SET P_RESULT = CONCAT('E|Gate Out Details is already saved. Gate Out Date Time : ', IFNULL(TEMP_GATE_OUT_DT,''), '|0');
            END IF;
            
        END IF;
        
    END;

	SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
		
    #IF NVL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT := 'E|You are not authorized to perform this operation.|0';    
    #ELSE
    IF P_ID > 0 THEN
		
		/*		
		-- Creating a temporary table for TBL_MAIN
		DROP TEMPORARY TABLE IF EXISTS TBL_MAIN_GATE_OUT;

		CREATE TEMPORARY TABLE TBL_MAIN_GATE_OUT AS
		SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
				, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
				, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
				, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
						FROM fg_gate_in_out X, 
						(SELECT Z.* FROM mda_header Z
							WHERE Z.PLANT_ID = P_PLANT_ID AND OUT_TIME IS NULL
							AND (Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM OR XZ.MDA_SYS_ID = P_ID))
						) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.VEHICLE_NO AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
						AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ 
											WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID 
											AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0);
                        
			*/

        
        
        SELECT X.RFSYSID, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_RFID, TEMP_GATE_OUT_DT FROM fg_gate_in_out X WHERE X.GATE_SYS_ID = P_ID AND X.MDA_SYS_ID = P_MDA_SYS_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        -- SELECT INWARD_SYS_ID INTO TEMP_INWARD_SYS_ID FROM FG_GATE_IN_OUT WHERE GATE_SYS_ID = P_ID AND COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND STATION_ID = TEMP_STATION_ID;

        IF TEMP_GATE_OUT_DT IS NULL THEN
        
            UPDATE FG_GATE_IN_OUT 
            SET GATE_OUT_DT = CURRENT_TIMESTAMP(), IS_GOODS_TRANSFER = 1
            WHERE GATE_SYS_ID = P_ID AND COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND STATION_ID = TEMP_STATION_ID AND PLANT_ID = P_PLANT_ID;
			
            UPDATE mda_header SET OUT_TIME = NOW() WHERE MDA_SYS_ID = P_MDA_SYS_ID AND PLANT_ID = P_PLANT_ID;

			SELECT MDA_NO INTO TEMP_MDA_NO FROM mda_header Z WHERE MDA_SYS_ID = P_MDA_SYS_ID AND PLANT_ID = P_PLANT_ID LIMIT 1;
            
			SELECT COALESCE(MAX(MDAInvQr_SYS_ID), 0) + 1 INTO TEMP_NUM FROM mda_invoice_qr;
            
			INSERT INTO mda_invoice_qr (MDAInvQr_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, INVOICEQrCODE, BASE64InvQrCode, Created_BY_ID, Created_DateTime, PLANT_ID, IS_POSTED, IS_DISPATCHED)
			VALUES(TEMP_NUM, P_ID, P_MDA_SYS_ID,TEMP_MDA_NO,P_INVOICE_QR_CODE,P_BASE64_INVOICE_QR_CODE, P_USER_ID, NOW(), P_PLANT_ID, 0,1);
            
            COMMIT;
            
            #UPDATE RFID_MASTER SET STATUS = 'Active' WHERE RFSYSID = TEMP_RFID AND PLANT_ID = P_PLANT_ID;
            
            UPDATE RFID_MASTER SET STATUS = 'Active' 
            WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM iffco.fg_gate_in_out X
								INNER JOIN mda_header Y ON Y.PLANT_ID = X.PLANT_ID AND Y.MDA_SYS_ID = X.MDA_SYS_ID
								WHERE GATE_OUT_DT IS NULL AND OUT_TIME IS NULL AND DATE_FORMAT(X.GATE_IN_DT, '%Y') = '2024'
								ORDER BY 1 DESC) 
			AND PLANT_ID = P_PLANT_ID;
            
            COMMIT;
            
            SET P_RESULT := 'S|Record saved successfully|0';
        ELSE
			
            SELECT X.INVOICEQrCODE INTO TEMP_INVOICE_QR_CODE FROM mda_invoice_qr X WHERE X.GATE_SYS_ID = P_ID AND X.MDA_SYS_ID = P_MDA_SYS_ID AND PLANT_ID = P_PLANT_ID LIMIT 1;
        			
            IF IFNULL(TEMP_INVOICE_QR_CODE, '') != '' THEN
				SET P_RESULT = CONCAT('E|Gate Out Details is already saved. Gate Out Date Time : ', IFNULL(TEMP_GATE_OUT_DT,''), ' and Invoice QR Code : ', TEMP_INVOICE_QR_CODE, '|0');
			ELSE        
				SET P_RESULT = CONCAT('E|Gate Out Details is already saved. Gate Out Date Time : ', IFNULL(TEMP_GATE_OUT_DT,''), '|0');
            END IF;
            
        END IF;
        
    END IF;

    -- Exception handling
    IF TEMP_INWARD_SYS_ID = 0 THEN
        SET P_RESULT := 'E|No inward record found for the provided ID|0';
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_INWARD_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_INWARD_GET(
IN P_ID INT,
IN P_ISACTIVE VARCHAR(255),
IN P_PLANT_ID INT,
IN P_USER_ID INT,
IN P_ROLE_ID INT,
IN P_MENU_ID INT
)
BEGIN

IF P_ID > 0 THEN
SELECT INWARD_SYS_ID AS ID, INWARD_TYPE
FROM INWARD_MASTER
WHERE INWARD_SYS_ID = P_ID;
ELSE
SELECT INWARD_SYS_ID AS ID, INWARD_TYPE
FROM INWARD_MASTER
ORDER BY INWARD_SYS_ID;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_LOAD_MDA_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_LOAD_MDA_GET(IN P_SEARCHTERM VARCHAR(255), IN P_PLANT_ID INT)
BEGIN
	WITH TBL_MAIN AS 
		(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
			, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
			, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER
			, Y.DI_NO, Y.PLANT_CD, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
					FROM fg_gate_in_out X, 
					(SELECT Z.* FROM mda_header Z
						WHERE Z.PLANT_ID = 4 AND OUT_TIME IS NULL
						AND ((Z.VEHICLE_NO = P_SEARCHTERM
								OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM) 
								OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = '') AND XZ.INWARD_SYS_ID IN (125, 1))
							 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '', 1, 0)
							)
					) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.VEHICLE_NO AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
					AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 
													AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0)
		)
		SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, ZZ.WT_SYS_ID, X.MDA_NO, X.VEHICLE_NO, X.PLANT_CD
		, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
		, (X.BAG_NOS / 24) Required_Shipper, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT
		, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
		, X.TRANS_SYS_ID, TM.tptr_cd, TM.TPTR_NAME
		, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
		, X.WH_CD, X.PARTY_NAME, X.DIST
        , NULL MDA_ORDER
		FROM TBL_MAIN X 
		INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
		INNER JOIN TRANSPORTER_MASTER TM ON TM.TRANS_SYS_ID = X.TRANS_SYS_ID and TM.Plant_ID = X.PLANT_ID
		WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL
		ORDER BY 3 DESC, 4 DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_LOAD_MDA_GET_NEW */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_LOAD_MDA_GET_NEW(IN P_GATE_SYS_ID INT, IN P_MDA_SYS_ID INT, IN P_SEARCHTERM VARCHAR(255), IN P_PLANT_ID INT)
BEGIN

SET @rownum := 0;

WITH TBL_MAIN AS (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, MH.MDA_SYS_ID, MH.MDA_NO, X.TRUCK_NO VEHICLE_NO, MH.PLANT_CD
		, GATE_IN_DT, GATE_OUT_DT, MH.MDA_DT
		, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
		, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DIST,MH.desp_place, X.RFSYSID
		FROM fg_gate_in_out X
		INNER JOIN mda_header MH ON MH.PLANT_ID = X.PLANT_ID AND (CASE WHEN IFNULL(P_GATE_SYS_ID,0) > 0 OR IFNULL(P_SEARCHTERM,'') != '' 
																		THEN TRUCK_NO = VEHICLE_NO
																		WHEN IFNULL(P_GATE_SYS_ID,0) = 0 THEN  MH.MDA_SYS_ID = X.MDA_SYS_ID 
                                                                        ELSE FALSE END)
									AND MH.OUT_TIME IS NULL #(CASE WHEN IFNULL(0,0) = 1 THEN MH.OUT_TIME IS NULL ELSE TRUE END)
		WHERE X.PLANT_ID = 4 AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_IN_DT IS NOT NULL AND X.GATE_OUT_DT IS NULL 
        AND ((MH.VEHICLE_NO, MH.MDA_DT) IN (SELECT VEHICLE_NO, MDA_DT FROM mda_header MHZ WHERE MHZ.MDA_NO = P_SEARCHTERM)
        OR (CASE WHEN IFNULL(P_SEARCHTERM,'') != '' THEN X.TRUCK_NO = P_SEARCHTERM
				  WHEN IFNULL(P_GATE_SYS_ID,0) > 0 THEN X.GATE_SYS_ID = P_GATE_SYS_ID
				  ELSE TRUE END)) 
		AND 1 = IF(IFNULL(P_MDA_SYS_ID, 0) = 0, 1, IF(P_MDA_SYS_ID = MH.MDA_SYS_ID, 1, 0))
        ORDER BY 3 DESC, 4 DESC
)
SELECT (@rownum := @rownum + 1) SR_NO, X.*, CASE WHEN (X.Required_Shipper <= X.Loaded_Shipper) THEN 1 ELSE 0 END AS Is_End_Loading FROM (
	SELECT M_G.PLANT_ID, M_G.STATION_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, MD.MDA_DTL_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO, M_G.PLANT_CD
	, DATE_FORMAT(M_G.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(M_G.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
	, MD.BAG_NOS, MD.NETT_QTY, MD.GROSS_QTY, (MD.BAG_NOS / 24) Required_Shipper, (SELECT COUNT(*) FROM MDA_LOADING Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND Z.GATE_SYS_ID = M_G.GATE_SYS_ID AND Z.MDA_SYS_ID = M_G.MDA_SYS_ID) Loaded_Shipper
	, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT
	, MD.PROD_SYS_ID, MD.PROD_SNO, PM.SKU_CODE, PM.SKU_NAME, PM.PRD_CD, PM.PRD_DESC, PM.SHIP_PER_PALLET
	, M_G.DRIVER_ID_NUMBER, IFNULL(M_G.DRIVER_NAME, M_G.DRIVER_NAME_NEW)DRIVER_NAME, IFNULL(M_G.DRIVER_CONTACT, M_G.DRIVER_CONTACT_NEW)DRIVER_CONTACT, DRIVER_CHANGED, TRUCK_VALIDATION
	, M_G.TRANS_SYS_ID, TM.tptr_cd, TM.TPTR_NAME, M_G.WH_CD, M_G.PARTY_NAME, M_G.DIST, M_G.desp_place, M_G.RFSYSID, RM.RFIDSRNO, NULL MDA_ORDER
	FROM TBL_MAIN M_G
	INNER JOIN mda_detail MD ON MD.PLANT_ID = M_G.PLANT_ID AND MD.MDA_SYS_ID = M_G.MDA_SYS_ID
	INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = M_G.GATE_SYS_ID AND ZZ.STATION_ID = M_G.STATION_ID AND ZZ.PLANT_ID = M_G.PLANT_ID
	INNER JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = M_G.PLANT_ID AND TM.TRANS_SYS_ID = M_G.TRANS_SYS_ID
	LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = M_G.PLANT_ID AND PM.PROD_SYS_ID = MD.PROD_SYS_ID
	LEFT JOIN rfid_master RM ON RM.PLANT_ID = M_G.PLANT_ID AND RM.RFSYSID = M_G.RFSYSID 
	WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL 
	ORDER BY M_G.GATE_IN_DT  DESC, M_G.GATE_OUT_DT  DESC, M_G.MDA_DT  DESC, M_G.DIST
) X;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_LOGIN_AUTH */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_LOGIN_AUTH(
	IN P_PLANT_ID BIGINT,
    IN P_USER_ID BIGINT,
    IN P_ROLE_ID BIGINT,
    IN P_USERNAME VARCHAR(255),
    IN P_PASSWORD VARCHAR(255)
)
BEGIN
    DECLARE P_RESULT VARCHAR(2000);
    DECLARE TEMP_USER_PASSWORD VARCHAR(2000);
    DECLARE TEMP_IS_ACTIVE INT DEFAULT 1;
	DECLARE DEFAULT_PLANT BIGINT DEFAULT 0;
    DECLARE TEMP_NUM BIGINT DEFAULT 0;
    
    SET P_RESULT := '';
    
    IF LENGTH(TRIM(IFNULL(P_USERNAME, ''))) > 0 THEN
            SELECT X.USER_PASSWORD, IF(X.IS_ACTIVE = 'Y', 1, 0) INTO TEMP_USER_PASSWORD, TEMP_IS_ACTIVE
            FROM USER_MASTER_NEW X 
            WHERE 1 = (CASE WHEN LENGTH(TRIM(IFNULL(P_USERNAME, ''))) > 0 AND TRIM(IFNULL(X.USER_NAME, '')) = TRIM(IFNULL(P_USERNAME, '')) THEN 1 ELSE 0 END)
			ORDER BY ID DESC LIMIT 1;
    END IF;    
    
    IF LENGTH(TRIM(IFNULL(P_USERNAME, ''))) > 0 && LENGTH(TRIM(IFNULL(P_PASSWORD, ''))) > 0 && TRIM(IFNULL(P_PASSWORD, '')) != TRIM(IFNULL(TEMP_USER_PASSWORD, '')) THEN
        SET P_RESULT := 'Wrong Password';
    ELSEIF LENGTH(TRIM(IFNULL(P_USERNAME, ''))) > 0 && LENGTH(TRIM(IFNULL(P_PASSWORD, ''))) > 0 && TRIM(IFNULL(P_PASSWORD, '')) = TRIM(IFNULL(TEMP_USER_PASSWORD, '')) && TEMP_IS_ACTIVE = 0 THEN
        SET P_RESULT := 'Opps!... Your account was De-Active. Please contact the system administrator';
    END IF;

    SELECT COUNT(*) INTO TEMP_NUM FROM USER_ROLE_NEW Z WHERE USER_ID IN (SELECT X.ID FROM USER_MASTER_NEW X 
                                                            WHERE 1 = (CASE WHEN COALESCE(P_USER_ID, 0) = 0 AND TRIM(IFNULL(X.USER_NAME, '')) = TRIM(IFNULL(P_USERNAME, '')) /*AND X.USER_PASSWORD = P_PASSWORD*/ THEN 1 WHEN COALESCE(P_USER_ID, 0) > 0 AND X.ID = COALESCE(P_USER_ID, 0) THEN 1 ELSE 0 END)) 
                                AND Z.IS_DEFAULT = 'Y';

    IF COALESCE(TEMP_NUM, 0) > 0 AND COALESCE(P_PLANT_ID, 0) <= 0 THEN
            SELECT PLANT_ID INTO DEFAULT_PLANT FROM USER_ROLE_NEW Z WHERE USER_ID IN (SELECT X.ID FROM USER_MASTER_NEW X 
                                                    WHERE 1 = (CASE WHEN COALESCE(P_USER_ID, 0) = 0 AND TRIM(IFNULL(X.USER_NAME, '')) = TRIM(IFNULL(P_USERNAME, '')) /*AND X.USER_PASSWORD = P_PASSWORD*/ THEN 1 WHEN COALESCE(P_USER_ID, 0) > 0 AND X.ID = COALESCE(P_USER_ID, 0) THEN 1 ELSE 0 END)) 
                        AND Z.IS_DEFAULT = 'Y';
    ELSE
        SET DEFAULT_PLANT = P_PLANT_ID;
    END IF;    
    
    IF COALESCE(DEFAULT_PLANT, 0) <= 0 THEN
            SELECT MIN(Z.PLANT_ID) INTO DEFAULT_PLANT FROM USER_ROLE_NEW Z WHERE USER_ID IN (SELECT X.ID FROM USER_MASTER_NEW X 
                                                    WHERE 1 = (CASE WHEN COALESCE(P_USER_ID, 0) = 0 AND TRIM(IFNULL(X.USER_NAME, '')) = TRIM(IFNULL(P_USERNAME, '')) /*AND X.USER_PASSWORD = P_PASSWORD*/ THEN 1 WHEN COALESCE(P_USER_ID, 0) > 0 AND X.ID = COALESCE(P_USER_ID, 0) THEN 1 ELSE 0 END)) ;
    END IF;    
    
    
    
    SELECT ID, USER_NAME, FIRST_NAME, LAST_NAME, MOBILE_NO, ISADMIN, ISACTIVE, ROLE_ID, ROLE_NAME, PLANT_ID, PLANT_NAME, UNIT_CODE, P_RESULT
	FROM (
	SELECT X.ID, X.USER_NAME, X.FIRST_NAME, X.LAST_NAME, X.MOBILE_NO,
	IF(Z.IS_ADMIN = 'Y', 1, 0) AS ISADMIN,
	IF(X.IS_ACTIVE = 'Y', 1, 0) AS ISACTIVE,
	Y.ROLE_ID, Z.Role_Name, Y.PLANT_ID, ZZ.Plant_Name, ZZ.PlantCode UNIT_CODE
	FROM USER_MASTER_NEW X
	LEFT JOIN USER_ROLE_NEW Y ON X.ID = Y.USER_ID
	LEFT JOIN ROLE_MASTER_NEW Z ON Y.ROLE_ID = Z.ROLE_ID
	LEFT JOIN PLANT_MASTER ZZ ON Y.PLANT_ID = ZZ.PLANTID 
	WHERE 1 = CASE
	WHEN COALESCE(P_USER_ID, 0) = 0 AND TRIM(IFNULL(X.USER_NAME, '')) = TRIM(IFNULL(P_USERNAME, '')) /*AND X.USER_PASSWORD = P_PASSWORD*/ THEN 1 
	WHEN COALESCE(P_USER_ID, 0) > 0 AND X.ID = COALESCE(P_USER_ID, 0) THEN 1 
	ELSE 0 
	END
	AND X.IS_ACTIVE = 'Y' AND Z.IS_ACTIVE = 'Y' #AND ZZ.IS_ACTIVE = 'Y'
	AND Y.PLANT_ID = CASE
	WHEN COALESCE(P_ROLE_ID, 0) = 1 THEN Y.PLANT_ID 
	ELSE DEFAULT_PLANT 
	END 
	AND Y.USER_ID = CASE
	WHEN COALESCE(P_USER_ID, 0) > 0 THEN COALESCE(P_USER_ID, 0) 
	ELSE Y.USER_ID 
	END
	AND Y.ROLE_ID = CASE
	WHEN (SELECT COUNT(*) FROM USER_ROLE_NEW ZQ WHERE ZQ.USER_ID = X.ID AND ZQ.PLANT_ID = Y.PLANT_ID) > 0 
	THEN (SELECT MIN(ZQ.ROLE_ID) FROM USER_ROLE_NEW ZQ WHERE ZQ.USER_ID = X.ID AND ZQ.PLANT_ID = Y.PLANT_ID)
	WHEN COALESCE(P_ROLE_ID, 0) > 0 THEN COALESCE(P_ROLE_ID, 0) 
	ELSE Y.ROLE_ID 
	END
	) XZ 
	WHERE 
	LENGTH(TRIM(IFNULL(XZ.ROLE_NAME, ''))) > 0 
	AND LENGTH(TRIM(IFNULL(XZ.PLANT_NAME, ''))) > 0
	GROUP BY ID, USER_NAME, ROLE_ID, PLANT_ID, FIRST_NAME, LAST_NAME, MOBILE_NO, ISADMIN, ISACTIVE, ROLE_NAME, PLANT_NAME, UNIT_CODE;
    
    SELECT PLANT_ID, USER_ID, ROLE_ID, MENU_ID, PARENT_ID, AREA, CONTROLLER, DISPLAY_NAME, URL, DISPLAYORDER, ISADMIN, ISACTIVE 
	FROM (
		SELECT Y.PLANT_ID, Y.USER_ID, Y.ROLE_ID, ZY.ID MENU_ID, ZY.PARENT_ID, ZY.AREA, ZY.CONTROLLER, ZY.DISPLAY_NAME, ZY.URL, ZY.DISPLAYORDER,
		IF(ZY.ISADMIN = 'Y', 1, 0) AS ISADMIN,
		IF(ZY.IS_ACTIVE = 'Y', 1, 0) AS ISACTIVE 
		FROM USER_MASTER_NEW X
		LEFT JOIN USER_ROLE_NEW Y ON X.ID = Y.USER_ID
		LEFT JOIN ROLE_MASTER_NEW Z ON Y.ROLE_ID = Z.ROLE_ID
		LEFT JOIN PLANT_MASTER ZZ ON Y.PLANT_ID = ZZ.PLANTID
		LEFT JOIN ROLE_MENU_NEW ZA ON Y.ROLE_ID = ZA.ROLE_ID
		LEFT JOIN MENU_MASTER_NEW ZY ON  (1 = CASE WHEN Y.ROLE_ID = 1 THEN 1 WHEN ZA.MENU_ID = ZY.ID THEN 1 ELSE 0 END) 
		WHERE 1 = CASE
					WHEN COALESCE(P_USER_ID, 0) = 0 AND TRIM(IFNULL(X.USER_NAME, '')) = TRIM(IFNULL(P_USERNAME, '')) /*AND X.USER_PASSWORD = P_PASSWORD*/ THEN 1 
					WHEN COALESCE(P_USER_ID, 0) > 0 AND X.ID = COALESCE(P_USER_ID, 0) THEN 1 
					ELSE 0 
				  END
		AND X.IS_ACTIVE = 'Y' AND Z.IS_ACTIVE = 'Y' AND ZY.IS_ACTIVE = 'Y' #AND ZZ.IS_ACTIVE = 'Y'
		AND Y.PLANT_ID = CASE
							WHEN COALESCE(P_ROLE_ID, 0) = 1 THEN Y.PLANT_ID 
							ELSE DEFAULT_PLANT 
							END 
							AND Y.USER_ID = CASE
							WHEN COALESCE(P_USER_ID, 0) > 0 THEN COALESCE(P_USER_ID, 0) 
							ELSE Y.USER_ID 
						  END
		AND Y.ROLE_ID = CASE
							WHEN (SELECT COUNT(*) FROM USER_ROLE_NEW ZQ WHERE ZQ.USER_ID = X.ID AND ZQ.PLANT_ID = Y.PLANT_ID) > 0 
							THEN (SELECT MIN(ZQ.ROLE_ID) FROM USER_ROLE_NEW ZQ WHERE ZQ.USER_ID = X.ID AND ZQ.PLANT_ID = Y.PLANT_ID)
							WHEN COALESCE(P_ROLE_ID, 0) > 0 THEN COALESCE(P_ROLE_ID, 0) 
							ELSE Y.ROLE_ID 
						 END
	) XZ
	GROUP BY PLANT_ID, USER_ID, ROLE_ID, MENU_ID, PARENT_ID, AREA, CONTROLLER, DISPLAY_NAME, URL, DISPLAYORDER, ISADMIN, ISACTIVE
	ORDER BY PARENT_ID, DISPLAYORDER, MENU_ID;

    
	
	SELECT Y.PLANT_ID, ZZ.ROLE_ID, ZX.Plant_Name 
	FROM USER_MASTER_NEW X
	LEFT JOIN USER_ROLE_NEW Y ON X.ID = Y.USER_ID
	LEFT JOIN ROLE_MASTER_NEW ZZ ON Y.ROLE_ID = ZZ.ROLE_ID
    LEFT JOIN PLANT_MASTER ZX ON (1 = CASE WHEN Y.ROLE_ID = 1 THEN 1 WHEN Y.PLANT_ID = ZX.PLANTID THEN 1 ELSE 0 END)
	WHERE 1 = CASE
				WHEN COALESCE(P_USER_ID, 0) = 0 AND TRIM(IFNULL(X.USER_NAME, '')) = TRIM(IFNULL(P_USERNAME, '')) /*AND X.USER_PASSWORD = P_PASSWORD*/ THEN 1 
				WHEN COALESCE(P_USER_ID, 0) > 0 AND X.ID = COALESCE(P_USER_ID, 0) THEN 1 
				ELSE 0 
			  END
	AND X.IS_ACTIVE = 'Y' AND ZZ.IS_ACTIVE = 'Y';

    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_LOV_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_LOV_GET(
IN P_LOV_COLUMN VARCHAR(255),
IN P_ISACTIVE VARCHAR(1),
IN P_PLANT_ID INT,
IN P_USER_ID INT,
IN P_ROLE_ID INT,
IN P_MENU_ID INT
)
BEGIN
IF TRIM(P_LOV_COLUMN) <> '' THEN
SELECT LOV_COLUMN, LOV_CODE, LOV_DESC, DISPLAY_SEQ_NO, IF(X.ISACTIVE = 'Y', 1, 0) AS ISACTIVE FROM LOV_MASTER X WHERE LOV_COLUMN = P_LOV_COLUMN AND X.ISACTIVE = IFNULL(P_ISACTIVE, X.ISACTIVE);
ELSE
SELECT LOV_COLUMN, LOV_CODE, LOV_DESC, DISPLAY_SEQ_NO, IF(X.ISACTIVE = 'Y', 1, 0) AS ISACTIVE FROM LOV_MASTER X WHERE X.ISACTIVE = IFNULL(P_ISACTIVE, X.ISACTIVE);
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MDAWISEREJECTREPORT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MDAWISEREJECTREPORT(
IN P_SEARCHTERM VARCHAR(20),
IN P_PLANT_ID BIGINT
)
BEGIN




WITH TBL_MAIN AS (SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, MDA_DT, TRANS_SYS_ID, INWARD_SYS_ID
					, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION
					, RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD, IS_GOODS_TRANSFER
					, DI_NO, PLANT_CD, WH_CD, PARTY_NAME, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, OUT_TIME, desp_place
						FROM (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
						, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
						, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
						, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
								FROM fg_gate_in_out X, 
								(SELECT Z.* FROM mda_header Z
									WHERE Z.PLANT_ID = P_PLANT_ID AND (Z.VEHICLE_NO = P_SEARCHTERM
									OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM OR XZ.MDA_SYS_ID = 0) 
									#OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.GATE_SYS_ID = 0 OR XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = 'RJ31GB0918'))
								)) Y WHERE X.TRUCK_NO = Y.VEHICLE_NO AND X.PLANT_ID = P_PLANT_ID 
							) M_G
					)
SELECT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID ID, X.MDA_SYS_ID, X.MDA_NO, X.VEHICLE_NO, X.GATE_IN_DT, X.GATE_OUT_DT, X.MDA_DT, X.TRANS_SYS_ID, X.INWARD_SYS_ID
, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD
, X.IS_GOODS_TRANSFER, NULL AS IS_UNLOAD_TRUCK, NULL AS VENDOR_SYS_ID, NULL AS CUST_SITE_CD, NULL AS SITE_NAME
, X.DI_NO, X.PLANT_CD, X.WH_CD, X.PARTY_NAME, X.DIST
, Y.PROD_SYS_ID, PRD_CD, PRD_DESC, X.BAG_NOS, (X.BAG_NOS / 24) AS Required_SHIPPER
, (SELECT COUNT(*) FROM mda_loading Z WHERE Z.MDA_SYS_ID  = X.MDA_SYS_ID)LOADED_SHIPPER
, X.NETT_QTY, X.GROSS_QTY, X.ECHIT_NO, X.GST_NO, X.OUT_TIME, X.desp_place
FROM TBL_MAIN X
LEFT JOIN MDA_DETAIL Y ON Y.MDA_SYS_ID = X.MDA_SYS_ID
LEFT JOIN PRODUCT_MASTER Z ON Z.PROD_SYS_ID = Y.PROD_SYS_ID;

WITH TBL_MAIN AS (SELECT (ROW_NUMBER() OVER ()) AS RNUM, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO
						##########################
						, ML.SHIPPER_QR_CODE, SQA.BATCH_NO, SUM(COUNT(ML.SHIPPER_QR_CODE)) OVER () AS COUNT_ROW#LOADED_SHIPPER 
						FROM (SELECT DISTINCT X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO 
						FROM fg_gate_in_out X, 
							(SELECT Z.* FROM mda_header Z
									WHERE Z.PLANT_ID = P_PLANT_ID AND (Z.VEHICLE_NO = P_SEARCHTERM
									OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM OR XZ.MDA_SYS_ID = 0) 
									#OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.GATE_SYS_ID = 0 OR XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = 'RJ31GB0918'))
								)) Y WHERE X.TRUCK_NO = Y.VEHICLE_NO AND X.PLANT_ID = P_PLANT_ID ) M_G
						##########################
						INNER JOIN MDA_LOADING ML ON ML.MDA_SYS_ID = M_G.MDA_SYS_ID
						LEFT JOIN SHIPPER_QRCODE SQ ON SQ.SHIPPER_QRCODE = ML.SHIPPER_QR_CODE
						LEFT JOIN SHIPPER_QRCODE_API SQA ON SQA.SHIPPER_QRCODE_API_SYSID = SQ.SHIPPER_QRCODE_API_SYSID
						GROUP BY M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO, ML.SHIPPER_QR_CODE, SQA.BATCH_NO
    )
    
    #SELECT (ROW_NUMBER() OVER ()) AS RNUM,  from qr_code_rejectlist
    
    #select (ROW_NUMBER() OVER ()) AS RNUM, QRCODE,REJECT_REASON FROM qr_code_rejectlist_log where MDA_NO = 'KL23000957'
    
    #select * from qr_code_rejectlist
    
    SELECT (ROW_NUMBER() OVER ()) AS SR_NO, NULL COUNT_ROW, NULL GATE_SYS_ID, NULL MDA_SYS_ID, NULL MDA_NO, NULL VEHICLE_NO, 
    QRCODE as SHIPPER_QR_CODE, REJECT_REASON BATCH_NO FROM qr_code_rejectlist_log where MDA_NO = P_SEARCHTERM;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MDA_ADD_QTY_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MDA_ADD_QTY_SAVE(
IN `P_GATE_SYS_ID` INT,
IN `P_MDA_SYS_ID` INT,
IN `P_MDA_DTL_SYS_ID` INT,
IN `P_PROD_SYS_ID` INT,
IN `P_ADDITIONAL_QTY` INT,
IN `P_REASON` VARCHAR(255),
IN `P_STATION_ID` INT,
IN `P_PLANT_ID` INT,
IN `P_USER_ID` INT,
IN `P_ROLE_ID` INT,
IN `P_MENU_ID` INT,
OUT `P_RESULT` VARCHAR(255)
)
BEGIN
DECLARE TEMP_NUM INT DEFAULT 0;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

IF COALESCE(P_GATE_SYS_ID, 0) > 0 AND COALESCE(P_MDA_SYS_ID, 0) > 0 THEN

SELECT COALESCE(MAX(MDA_ADD_SYS_ID), 0) + 1 INTO TEMP_NUM FROM mda_add_qty_request;

INSERT INTO mda_add_qty_request (MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER_QTY, REASON, Created_BY_ID, Created_DateTime, PLANT_ID, IS_POSTED)
VALUES(TEMP_NUM, P_GATE_SYS_ID, P_MDA_SYS_ID, P_PROD_SYS_ID, P_ADDITIONAL_QTY, P_REASON, P_USER_ID, NOW(), P_PLANT_ID, 0);

SET P_RESULT = 'S|Record saved successfully|0';
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MDA_BATCH_NO_LIST_REPORT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MDA_BATCH_NO_LIST_REPORT(
    IN P_MDA_NO VARCHAR(255), 
    IN P_SEARCH_TERM VARCHAR(255), 
    IN P_DISPLAY_LENGTH INT, 
    IN P_DISPLAY_START INT,
    IN P_PLANT_ID INT
)
BEGIN
    -- Declare variables for row numbers and total count
    DECLARE RNUM INT DEFAULT 0;
    DECLARE COUNT_ROW INT DEFAULT 0;
    
     DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        -- SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
        SELECT @errmsg;
    END;
    
    WITH TBL_MAIN AS (SELECT (ROW_NUMBER() OVER ()) AS RNUM, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO
						##########################
						, ML.SHIPPER_QR_CODE, SQA.BATCH_NO, SUM(COUNT(ML.SHIPPER_QR_CODE)) OVER () AS COUNT_ROW#LOADED_SHIPPER 
						FROM (SELECT DISTINCT X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO 
						FROM fg_gate_in_out X, 
							(SELECT Z.* FROM mda_header Z
								WHERE Z.PLANT_ID = P_PLANT_ID AND (Z.VEHICLE_NO = P_VEHICLE_NO 
								OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_VEHICLE_NO) 
								OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_SYS_ID = P_ID) 
								OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_VEHICLE_NO) AND XZ.INWARD_SYS_ID = 1))
							) Y WHERE X.TRUCK_NO = Y.VEHICLE_NO AND X.PLANT_ID = P_PLANT_ID) M_G -- Y WHERE X.TRUCK_NO = Y.VEHICLE_NO) M_G
						##########################
						INNER JOIN MDA_LOADING ML ON ML.MDA_SYS_ID = M_G.MDA_SYS_ID
						LEFT JOIN SHIPPER_QRCODE SQ ON SQ.SHIPPER_QRCODE = ML.SHIPPER_QR_CODE
						LEFT JOIN SHIPPER_QRCODE_API SQA ON SQA.SHIPPER_QRCODE_API_SYSID = SQ.SHIPPER_QRCODE_API_SYSID
						GROUP BY M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO, ML.SHIPPER_QR_CODE, SQA.BATCH_NO
    )
    SELECT RNUM, COUNT_ROW, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, VEHICLE_NO, SHIPPER_QR_CODE, BATCH_NO FROM TBL_MAIN;
    -- WHERE RNUM > P_DISPLAY_START AND RNUM <= (P_DISPLAY_LENGTH + P_DISPLAY_START);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MDA_CHECK */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MDA_CHECK(
IN P_JSON_LIST longtext,
IN P_PLANT_ID INT,
OUT P_RESULT VARCHAR(16300)
)
BEGIN

DECLARE TEMP_NUM INT;
DECLARE TEMP_NUM_DTLS INT;
DECLARE TEMP_SRNUM_DTLS INT;
DECLARE TEMP_PLANT_ID INT;
DECLARE TEMP_TRANS_ID INT;
DECLARE TEMP_PROD_ID INT;


DECLARE v_counter BIGINT DEFAULT 1;
DECLARE v_line LongText;
DECLARE v_not_found LongText DEFAULT '';


    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';

		IF LENGTH(IFNULL(P_JSON_LIST, '')) > 0 THEN
			            
				SET v_counter = 1;
				SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^|]+', 1, v_counter);
                 
				
				WHILE v_line IS NOT NULL DO
				
					SELECT COUNT(*) INTO TEMP_NUM FROM mda_header MH
					INNER JOIN mda_detail MD ON MD.MDA_SYS_ID = MH.MDA_SYS_ID
					WHERE MH.MDA_NO = v_line;
                
					IF IFNULL(TEMP_NUM, 0) = 0 THEN
						SET v_not_found = CONCAT(v_line, '<#>', v_not_found);					
                    END IF;
                    
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^|]+', 1, v_counter);
				END WHILE;
				
            
		END IF;


		SET P_RESULT = CONCAT('S|',v_not_found,'|0');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MDA_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MDA_GET(
IN `P_ID` INT,
IN `P_SearchTerm` VARCHAR(255),
IN `P_VEHICLE_NO` VARCHAR(255)
)
BEGIN


-- DATE_FORMAT(MDA_DT, '%d/%m/%Y %k:%m:%s')

SELECT MDA_SYS_ID ID, MDA_NO, DI_NO, PLANT_CD, DATE_FORMAT(MDA_DT, '%d/%m/%Y') AS MDA_DT, X.TRANS_SYS_ID, TPTR_CD, TPTR_NAME, WH_CD, PARTY_NAME, DRIVER,
VEHICLE_NO, MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, OUT_TIME, X.PLANT_ID, X.CREATED_DATETIME, X.IS_POSTED, desp_place,
@MDA_ORDER := @MDA_ORDER + 1 AS MDA_ORDER,
COALESCE((SELECT Y.GATE_SYS_ID FROM FG_GATE_IN_OUT Y WHERE COALESCE(Y.CANCEL_GATE_IN, 0) = 0 AND Y.GATE_OUT_DT IS NULL AND Y.MDA_SYS_ID = X.MDA_SYS_ID ORDER BY GATE_IN_DT DESC LIMIT 1), 0) AS GATE_SYS_ID
FROM MDA_HEADER X
LEFT JOIN TRANSPORTER_MASTER TR ON X.TRANS_SYS_ID = TR.TRANS_SYS_ID,
(SELECT @MDA_ORDER := 0) AS MO
WHERE 1 = CASE WHEN P_ID > 0 THEN CASE WHEN MDA_SYS_ID = P_ID THEN 1 ELSE 0 END ELSE 1 END
AND 1 = CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN CASE WHEN UPPER(VEHICLE_NO) = UPPER(P_VEHICLE_NO) THEN 1 ELSE 0 END ELSE 1 END
AND 1 = CASE WHEN LENGTH(COALESCE(P_SearchTerm, '')) > 0 THEN CASE WHEN UPPER(VEHICLE_NO) LIKE CONCAT('%', UPPER(P_SearchTerm), '%') THEN 1 ELSE 0 END ELSE 1 END
ORDER BY CREATED_DATETIME DESC;


-- Creating a temporary table for TBL_MAIN
DROP TEMPORARY TABLE IF EXISTS TBL_MAIN;

CREATE TEMPORARY TABLE TBL_MAIN AS
SELECT DISTINCT Y.MDA_DTL_SYS_ID ID, Y.MDA_SYS_ID Mda_Id, Y.MDA_NO, Y.PROD_SNO, Y.MDA_DT, Y.PROD_SYS_ID, Y.SHIPMENT_NO, X.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, X.TRANS_SYS_ID, WH_CD, PARTY_NAME, desp_place, DRIVER
FROM MDA_HEADER X
LEFT JOIN MDA_DETAIL Y ON Y.MDA_SYS_ID = X.MDA_SYS_ID
WHERE 1 = CASE WHEN P_ID > 0 THEN CASE WHEN X.MDA_SYS_ID = P_ID THEN 1 ELSE 0 END ELSE 1 END
AND 1 = CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN CASE WHEN UPPER(VEHICLE_NO) = UPPER(P_VEHICLE_NO) THEN 1 ELSE 0 END ELSE 1 END;

-- Creating a temporary table for TBL_Load
DROP TEMPORARY TABLE IF EXISTS TBL_Load;

CREATE TEMPORARY TABLE TBL_Load AS
SELECT Mda_Id, SUM(Loaded_Shipper) AS Loaded_Shipper
FROM (
SELECT X.Mda_Id, X.MDA_NO, (SELECT COUNT(*) FROM MDA_LOADING Z WHERE Z.MDA_SYS_ID = X.Mda_Id) Loaded_Shipper
FROM TBL_MAIN X
-- LEFT JOIN MDA_LOADING Z ON Z.MDA_SYS_ID = X.Mda_Id
) AS XZ
GROUP BY Mda_Id, MDA_NO, Loaded_Shipper;

-- Final SELECT query
SELECT ID, X.MDA_ID, X.MDA_NO, PROD_SNO, MDA_DT, X.TRANS_SYS_ID, TPTR_CD, TPTR_NAME, WH_CD, PARTY_NAME, desp_place, DRIVER, X.PROD_SYS_ID, SKU_CODE, SKU_NAME, PRD_CD, PRD_DESC,
SHIPMENT_NO, DIST, (BAG_NOS / 24)BAG_NOS, NETT_QTY, GROSS_QTY, (BAG_NOS / 24) Required_Shipper, Z.Loaded_Shipper
, (SELECT COUNT(*) FROM QR_CODE_REJECTLIST XZ WHERE XZ.MDA_SYS_ID = X.MDA_ID AND XZ.PRODUCT_SYS_ID = X.PROD_SYS_ID) REJECT_SHIPPER
, CASE WHEN ((BAG_NOS / 24) <= Z.Loaded_Shipper) THEN 1 ELSE 0 END AS Is_End_Loading, Y.SHIP_PER_PALLET
, ROW_NUMBER() OVER (ORDER BY X.DIST DESC) AS MDA_ORDER
FROM TBL_MAIN X
LEFT JOIN TBL_Load Z ON Z.Mda_Id = X.Mda_Id
LEFT JOIN TRANSPORTER_MASTER TR ON X.TRANS_SYS_ID = TR.TRANS_SYS_ID
LEFT JOIN PRODUCT_MASTER Y ON X.PROD_SYS_ID = Y.PROD_SYS_ID;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MDA_REQUISITION_DATA_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MDA_REQUISITION_DATA_SAVE(
    IN P_GATE_SYS_ID INT,
    IN P_MDA_SYS_ID INT,
    IN P_MDA_DTL_SYS_ID INT,
    IN P_PROD_SYS_ID INT,
    IN P_REASON  VARCHAR(2550),
    IN P_LOADING_PROGRESS  VARCHAR(2550),
    IN P_PLANT_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN       
	DECLARE TEMP_CNT INT DEFAULT 0;
	-- DECLARE TEMP_BOTTLE_QTY INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Error handling
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
        -- ROLLBACK if needed, but not necessary for a single insert
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please contact the system administrator. ', @errmsg, '|0');
    END;

    START TRANSACTION;

    
    IF IFNULL(P_GATE_SYS_ID,0) = 0  THEN
			SET P_RESULT = 'E|Invalid Gate in details.|0';
	ELSEIF IFNULL(P_MDA_SYS_ID,0) = 0 THEN
			SET P_RESULT = 'E|Invalid MDA details.|0';
	ELSE
		SELECT COUNT(*) INTO TEMP_CNT
		FROM MDA_HEADER X
		LEFT JOIN MDA_DETAIL Y ON Y.MDA_SYS_ID = X.MDA_SYS_ID
		LEFT JOIN FG_GATE_IN_OUT Z ON Z.MDA_SYS_ID = X.MDA_SYS_ID
		LEFT JOIN PRODUCT_MASTER P ON P.PROD_SYS_ID = Y.PROD_SYS_ID
		WHERE X.MDA_SYS_ID = P_MDA_SYS_ID AND Y.MDA_DTL_SYS_ID = P_MDA_DTL_SYS_ID AND  Z.GATE_SYS_ID = P_GATE_SYS_ID AND Y.PROD_SYS_ID = P_PROD_SYS_ID
		AND X.PLANT_ID = P_PLANT_ID AND COALESCE(Z.CANCEL_GATE_IN, 0) = 0 AND Z.GATE_OUT_DT IS NULL;
		
		IF IFNULL(TEMP_CNT,0) > 0 THEN
			
            SELECT COUNT(*) INTO TEMP_CNT
			FROM mda_requisition_data Q
			LEFT JOIN MDA_HEADER X ON X.MDA_SYS_ID = Q.MDA_SYS_ID
			LEFT JOIN MDA_DETAIL Y ON Y.MDA_SYS_ID = X.MDA_SYS_ID
			LEFT JOIN FG_GATE_IN_OUT Z ON Z.MDA_SYS_ID = X.MDA_SYS_ID
			LEFT JOIN PRODUCT_MASTER P ON P.PROD_SYS_ID = Y.PROD_SYS_ID
			WHERE X.MDA_SYS_ID = P_MDA_SYS_ID AND Y.MDA_DTL_SYS_ID = P_MDA_DTL_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND Y.PROD_SYS_ID = P_PROD_SYS_ID
			AND X.PLANT_ID = P_PLANT_ID;

			IF IFNULL(TEMP_CNT,0) = 0 THEN
			
    IF LENGTH(IFNULL(P_LOADING_PROGRESS,'')) = 0  THEN
			SET P_LOADING_PROGRESS = 'In Progress';
	END IF;
    
				INSERT INTO mda_requisition_data (GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, PLANT_ID, LOADING_STATUS, LOADING_PROGRESS, LOAD_IN_TIME, REASON
							, TRUCK_NO, MDA_NO, MDA_DATE, SKU_CODE, SKU_NAME, BOTTLE_QTY, CARTON_QTY, LOADED_QTY)
				SELECT GATE_SYS_ID, X.MDA_SYS_ID, Y.PROD_SYS_ID, X.PLANT_ID, 'New Dispatch', P_LOADING_PROGRESS, NOW(), P_REASON
							, X.VEHICLE_NO, X.MDA_NO, X.MDA_DT, P.SKU_CODE, P.SKU_NAME, Y.BAG_NOS, (Y.BAG_NOS / 24), 0
				FROM MDA_HEADER X
				LEFT JOIN MDA_DETAIL Y ON Y.MDA_SYS_ID = X.MDA_SYS_ID
				LEFT JOIN FG_GATE_IN_OUT Z ON Z.MDA_SYS_ID = X.MDA_SYS_ID
				LEFT JOIN PRODUCT_MASTER P ON P.PROD_SYS_ID = Y.PROD_SYS_ID
				WHERE X.MDA_SYS_ID = P_MDA_SYS_ID AND Y.MDA_DTL_SYS_ID = P_MDA_DTL_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND Y.PROD_SYS_ID = P_PROD_SYS_ID
				AND X.PLANT_ID = P_PLANT_ID AND COALESCE(Z.CANCEL_GATE_IN, 0) = 0 AND Z.GATE_OUT_DT IS NULL LIMIT 1;

				SET P_RESULT = 'S|Record saved successfully|';
			ELSE
						
				IF LENGTH(IFNULL(P_LOADING_PROGRESS,'')) > 0 THEN
                
						UPDATE mda_requisition_data SET LOADING_PROGRESS = P_LOADING_PROGRESS, LOAD_OUT_TIME = NOW()
                        WHERE MDA_SYS_ID = P_MDA_SYS_ID AND MDA_DTL_SYS_ID = P_MDA_DTL_SYS_ID AND GATE_SYS_ID = P_GATE_SYS_ID 
                        AND PROD_SYS_ID = P_PROD_SYS_ID AND PLANT_ID = P_PLANT_ID;
                        
				SET P_RESULT = 'S|Record saved successfully|';
				ELSE
					SET P_RESULT = 'S|Requisition data already inserted.|0';
				END IF;
		
				
			END IF;
		ELSE
			SET P_RESULT = 'E|Opps!... Something went wrong|0';
		END IF;
	END IF;

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MDA_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MDA_SAVE(
IN P_ID INT,
IN P_JSON_LIST LONGTEXT,
IN P_PLANT_ID INT,
IN P_USER_ID INT,
IN P_ROLE_ID INT,
IN P_MENU_ID INT,
OUT P_RESULT VARCHAR(16300)
)
BEGIN

            DECLARE v_CNT BIGINT DEFAULT 1;
            DECLARE v_counter BIGINT DEFAULT 1;
            DECLARE v_line LONGTEXT;
    
            DECLARE v_counter_MDA BIGINT DEFAULT 1;
            DECLARE v_line_MDA LONGTEXT;
    
DECLARE TEMP_NUM INT DEFAULT 0;
DECLARE TEMP_NUM_DTLS INT DEFAULT 0;
DECLARE TEMP_SRNUM_DTLS INT DEFAULT 0;
DECLARE TEMP_MDA_HEADER_ID INT DEFAULT 0;
DECLARE TEMP_PLANT_ID INT DEFAULT 0;
DECLARE TEMP_TRANS_ID INT DEFAULT 0;
DECLARE TEMP_PROD_ID INT DEFAULT 0;
DECLARE STR_MDA VARCHAR(16300) DEFAULT '';
DECLARE STR_MDA_DTLS VARCHAR(16300) DEFAULT '';
DECLARE TEMP_STR VARCHAR(16300) DEFAULT '';
      
DECLARE v_MDA_NO varchar(15);
DECLARE v_DI_NO varchar(15);
DECLARE v_PLANT_CD varchar(5);
DECLARE v_GR_NO varchar(25);
DECLARE v_GR_DT_STR varchar(25);
DECLARE v_GR_DT DATETIME;
DECLARE v_MDA_DT_STR varchar(25);
DECLARE v_MDA_DT DATETIME;
DECLARE v_TPTR_CD varchar(50);
DECLARE v_TPTR_NAME varchar(50);
DECLARE v_WH_CD varchar(15);
DECLARE v_PARTY_NAME varchar(50);
DECLARE v_DRIVER varchar(50);
DECLARE v_VEHICLE_NO varchar(10);
DECLARE v_MOBILE_NO varchar(10);
DECLARE v_DIST varchar(25);
DECLARE v_BAG_NOS varchar(25);
DECLARE v_NETT_QTY varchar(25);
DECLARE v_GROSS_QTY varchar(25);
DECLARE v_ECHIT_NO varchar(50);
DECLARE v_GST_NO varchar(20);
DECLARE v_OUT_TIME_STR varchar(25);
DECLARE v_OUT_TIME DATETIME;
DECLARE v_DESP_PLACE varchar(150);

DECLARE v_PROD_SNO varchar(150);
DECLARE v_SKU_CODE varchar(150);
DECLARE v_PRD_CD varchar(150);
DECLARE v_SHIPMENT_NO varchar(150);

DECLARE v_TRANS_SYS_ID int;
DECLARE v_PLANT_ID int;
DECLARE v_PROD_SYS_ID int;
      
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    IF LENGTH(IFNULL(P_JSON_LIST, '')) > 0 THEN
       
				SET v_counter = 1;
				SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^##]+', 1, v_counter);
            
				WHILE v_line IS NOT NULL DO
                
					SET STR_MDA = REGEXP_SUBSTR(v_line, '[^$$]+', 1, 1);
					SET STR_MDA_DTLS = REGEXP_SUBSTR(v_line, '[^$$]+', 1, 2);
                    
                    SET v_CNT = 1;
					SET v_MDA_NO = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
                    
						SET v_CNT = v_CNT + 1;
						SET v_DI_NO = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_PLANT_CD = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
                        
						SELECT COUNT(*) INTO TEMP_NUM FROM plant_master x WHERE x.PlantCode = v_PLANT_CD;
						
						IF IFNULL(TEMP_NUM, 0) > 0 THEN						
							SELECT PlantID INTO v_PLANT_ID FROM plant_master x WHERE x.PlantCode = v_PLANT_CD LIMIT 1;
						END IF;
                        
					SELECT COUNT(*) INTO TEMP_NUM FROM mda_header WHERE MDA_NO = v_MDA_NO AND DI_NO = v_DI_NO AND PLANT_ID = v_PLANT_ID;
					
					SELECT MDA_SYS_ID, MDA_NO, MDA_DT INTO TEMP_MDA_HEADER_ID, v_MDA_NO, v_MDA_DT FROM mda_header WHERE MDA_NO = v_MDA_NO AND DI_NO = v_DI_NO AND PLANT_ID = v_PLANT_ID;
					
                    IF IFNULL(TEMP_NUM, 0) = 0 OR IFNULL(P_ID, 0) > 0 THEN
                    
						SET v_CNT = v_CNT + 1;
						SET v_GR_NO = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
                        
						SET v_CNT = v_CNT + 1;
						SET v_GR_DT_STR = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_GR_DT = IF(IFNULL(v_GR_DT_STR, '') = '' OR v_GR_DT_STR = '=', NULL, STR_TO_DATE(REPLACE(v_GR_DT_STR, '-', '/'), '%d/%m/%Y %H:%i'));
                        
						SET v_CNT = v_CNT + 1;
						SET v_MDA_DT_STR = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
                        SET v_MDA_DT = IF(IFNULL(v_MDA_DT_STR, '') = '' OR v_MDA_DT_STR = '=', NULL, STR_TO_DATE(REPLACE(v_MDA_DT_STR, '-', '/'), '%d/%m/%Y %H:%i'));
                        
						SET v_CNT = v_CNT + 1;
						SET v_TPTR_CD = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_TPTR_NAME = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
                        
						SELECT COUNT(*) INTO TEMP_NUM FROM transporter_master x WHERE x.tptr_cd = v_TPTR_CD;
						
						IF IFNULL(TEMP_NUM, 0) > 0 THEN						
							SELECT TRANS_SYS_ID INTO v_TRANS_SYS_ID FROM transporter_master x WHERE x.tptr_cd = v_TPTR_CD AND x.PLANT_ID = v_PLANT_ID LIMIT 1;
						ELSE
                        
							SELECT IFNULL(MAX(TRANS_SYS_ID), 0) + 1 INTO TEMP_NUM FROM transporter_master;
							
                            INSERT INTO transporter_master (TRANS_SYS_ID, tptr_cd, tptr_name, IS_ENTRY_MANUAL, PLANT_ID, Created_DateTime, IS_POSTED)
                            VALUES(TEMP_NUM, v_TPTR_CD, v_TPTR_NAME, 0, v_PLANT_ID, NOW(), 1);
                        
							SET v_TRANS_SYS_ID = TEMP_NUM;
						END IF;
                        
                        
						SET v_CNT = v_CNT + 1;
						SET v_WH_CD = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_PARTY_NAME = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_DRIVER = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_VEHICLE_NO = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_MOBILE_NO = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_DIST = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_BAG_NOS = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_NETT_QTY = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_GROSS_QTY = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_ECHIT_NO = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_GST_NO = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_CNT = v_CNT + 1;
						SET v_OUT_TIME_STR = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);
						SET v_OUT_TIME = IF(IFNULL(v_OUT_TIME_STR, '') = '' OR v_OUT_TIME_STR = '=', NULL, STR_TO_DATE(REPLACE(v_OUT_TIME_STR, '-', '/'), '%d/%m/%Y %H:%i'));
                        
						SET v_CNT = v_CNT + 1;
						SET v_DESP_PLACE = REGEXP_SUBSTR(STR_MDA, '[^|]+', 1, v_CNT);

						IF IFNULL(P_ID, 0) > 0 THEN						
							
                            UPDATE mda_header SET BAG_NOS = CAST(v_BAG_NOS AS UNSIGNED), NETT_QTY = CAST(v_NETT_QTY AS UNSIGNED), GROSS_QTY = CAST(v_GROSS_QTY AS UNSIGNED), DIST = CAST(v_DIST AS UNSIGNED), desp_place = v_DESP_PLACE
                            WHERE MDA_SYS_ID = P_ID;								
                            	   
							SET TEMP_MDA_HEADER_ID = P_ID;
                            
						ELSE
							
							SELECT IFNULL(MAX(MDA_SYS_ID), 0) + 1 INTO TEMP_NUM FROM mda_header;

							INSERT INTO mda_header (MDA_SYS_ID, MDA_NO, DI_NO, PLANT_CD, MDA_DT
									, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO, MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, PLANT_ID
									, desp_place, Created_DateTime, IS_POSTED)
							VALUES(TEMP_NUM, v_MDA_NO, v_DI_NO, v_PLANT_CD, v_MDA_DT
									, v_TRANS_SYS_ID, v_WH_CD, v_PARTY_NAME, v_DRIVER, v_VEHICLE_NO, v_MOBILE_NO, CAST(v_DIST AS UNSIGNED), CAST(v_BAG_NOS AS UNSIGNED), CAST(v_NETT_QTY AS UNSIGNED), CAST(v_GROSS_QTY AS UNSIGNED), v_ECHIT_NO, v_GST_NO, v_PLANT_ID
									, v_DESP_PLACE, NOW(), 0);
								   
							SET TEMP_MDA_HEADER_ID = TEMP_NUM;
                            
						END IF;
                         
					END IF;
                        
                        
							SET v_counter_MDA = 1;
							SET v_line_MDA = REGEXP_SUBSTR(STR_MDA_DTLS, '[^@@]+', 1, v_counter_MDA);
						
							WHILE v_line_MDA IS NOT NULL DO
							
								SET v_CNT = 1;
								SET v_PROD_SNO = REGEXP_SUBSTR(v_line_MDA, '[^|]+', 1, v_CNT);
								SET v_CNT = v_CNT + 1;
								SET v_SKU_CODE = REGEXP_SUBSTR(v_line_MDA, '[^|]+', 1, v_CNT);
								SET v_CNT = v_CNT + 1;
								SET v_PRD_CD = REGEXP_SUBSTR(v_line_MDA, '[^|]+', 1, v_CNT);
										
								SELECT COUNT(*) INTO TEMP_NUM FROM product_master x WHERE x.PRD_CD = v_PRD_CD AND x.SKU_CODE = v_SKU_CODE;
								
								IF IFNULL(TEMP_NUM, 0) > 0 THEN						
									SELECT PROD_SYS_ID INTO v_PROD_SYS_ID FROM product_master x WHERE x.PRD_CD = v_PRD_CD AND x.SKU_CODE = v_SKU_CODE AND PLANT_ID = 4 LIMIT 1;
								END IF;
								
								SET v_CNT = v_CNT + 1;
								SET v_SHIPMENT_NO = REGEXP_SUBSTR(v_line_MDA, '[^|]+', 1, v_CNT);
								SET v_CNT = v_CNT + 1;
								SET v_BAG_NOS = REGEXP_SUBSTR(v_line_MDA, '[^|]+', 1, v_CNT);
								SET v_CNT = v_CNT + 1;
								SET v_NETT_QTY = REGEXP_SUBSTR(v_line_MDA, '[^|]+', 1, v_CNT);
								SET v_CNT = v_CNT + 1;
								SET v_GROSS_QTY = REGEXP_SUBSTR(v_line_MDA, '[^|]+', 1, v_CNT);

								
								-- SET TEMP_STR = CONCAT('|', IFNULL(v_GROSS_QTY, ''));

										
								SELECT COUNT(*) INTO TEMP_NUM FROM mda_detail x WHERE x.MDA_SYS_ID = IFNULL(TEMP_MDA_HEADER_ID, 0) AND x.PROD_SYS_ID = v_PROD_SYS_ID; -- AND x.SHIPMENT_NO = IF(v_SHIPMENT_NO = '' OR v_SHIPMENT_NO = '=', NULL, v_SHIPMENT_NO);
								
								IF IFNULL(TEMP_NUM, 0) > 0 THEN		
                                
									UPDATE mda_detail SET BAG_NOS = CAST(v_BAG_NOS AS UNSIGNED), NETT_QTY = CAST(v_NETT_QTY AS UNSIGNED), GROSS_QTY = CAST(v_GROSS_QTY AS UNSIGNED)
									WHERE MDA_SYS_ID = IFNULL(TEMP_MDA_HEADER_ID, 0) AND PROD_SYS_ID = v_PROD_SYS_ID; --  AND SHIPMENT_NO = IF(v_SHIPMENT_NO = '' OR v_SHIPMENT_NO = '=', NULL, v_SHIPMENT_NO);						
									
								ELSE
										
									SELECT IFNULL(MAX(MDA_DTL_SYS_ID), 0) + 1 INTO TEMP_NUM_DTLS FROM mda_detail;

									INSERT INTO mda_detail (MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, MDA_DT, PROD_SNO, PROD_SYS_ID, SHIPMENT_NO, BAG_NOS, NETT_QTY, GROSS_QTY, PLANT_ID, Created_DateTime, IS_POSTED)
									VALUES(TEMP_NUM_DTLS, TEMP_MDA_HEADER_ID, v_MDA_NO, v_MDA_DT
											, IF(v_PROD_SNO = '' OR v_PROD_SNO = '=', NULL, CAST(v_PROD_SNO AS UNSIGNED))
											, v_PROD_SYS_ID
											, IF(v_SHIPMENT_NO = '' OR v_SHIPMENT_NO = '=', NULL, v_SHIPMENT_NO)
											, IF(v_BAG_NOS = '' OR v_BAG_NOS = '=', NULL, CAST(v_BAG_NOS AS UNSIGNED))
											, IF(v_NETT_QTY = '' OR v_NETT_QTY = '=', NULL, CAST(v_NETT_QTY AS UNSIGNED))
											, IF(v_GROSS_QTY = '' OR v_GROSS_QTY = '=', NULL, CAST(v_GROSS_QTY AS UNSIGNED))
											, v_PLANT_ID, NOW(), 0);
									
								END IF;
								 
                                
								SET v_counter_MDA = v_counter_MDA + 1;
								SET v_line_MDA = REGEXP_SUBSTR(STR_MDA_DTLS, '[^@@]+', 1, v_counter_MDA); 
								
							END WHILE;
                               
                        
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^##]+', 1, v_counter); 
                    
				END WHILE;
				
           
            
                COMMIT;
				SET P_RESULT = 'S|Record saved successfully|0';
            /*
			WITH RECURSIVE number_sequence AS (
			SELECT 1 AS line_no, 0 AS prev_no
			UNION ALL
			SELECT line_no + 1, line_no
			FROM number_sequence
			WHERE line_no < (SELECT CAST(((LENGTH(your_column) - LENGTH(REPLACE(your_column, '<#>', ''))) / length('<#>')) AS SIGNED) AS OccurrenceOfB
						FROM (SELECT 'D01|NANO ZINC 250 ML|uSuks ftad 250 ,e,y|KL0|99|NANOZ250ML|NANO|NANO|NANO|D|KL1|INDIGENOUS|N|2853|LT|0.25|NO|=<#>D02|NANO COPPER 250 ML|=|KL0|99|NANOC250ML|NANO|NANO|NANO|D|KL1|INDIGENOUS|N|2853|LT|0.25|NO|DU0<#>D03|NANO UREA LIQUID 500 ML KALOL|uSuks ;wfj;k fyDoM 500 ,e,y|KL0|99|NANOU500ML|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D04|NANO DAP LIQUID 500 ML KALOL|uSuks Mh,ih rjy 500 fe-yh- dyksy|KL0|99|NANOD500ML|NANO|NANO|NANO DAP|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DD0<#>D05|NANO DAP LIQUID 500 ML KALOL NV|uSuks Mh,ih rjy 500 fe-yh- dyksy ,uoh|KL0|99|NANOD500NV|NANO|NANO|NANO DAP|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DD0<#>D06|SNU 500 ML KALOL NV|=|KL0|99|SNU500MLNV|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D07|NANO UREA LIQUID 500 ML KALOL (2YR)|uSuks ;wfj;k fyDoM 500 ,e,y|KL0|99|NANOU5KL2Y|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D08|NANO UREA LIQUID 500 ML KALOL NV|=|KL0|99|NANOU500NV|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D09|NANO UREA PLUS 500 ML KALOL|=|KL0|99|NUP500MLKL|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D31|NANO UREA SUPER 500 ML KALOL|=|KL0|99|NUS500ML|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0'  AS your_column) X LIMIT 1)
			)
			SELECT line_no, SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 1), '|', -1) AS column1
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 2), '|', -1), '|', 1) AS column2 
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 3), '|', -1), '|', 1) AS column3  
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 4), '|', -1), '|', 1) AS column4 
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 5), '|', -1), '|', 1) AS column5 
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 6), '|', -1), '|', 1) AS column6  
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 7), '|', -1), '|', 1) AS column7  
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 8), '|', -1), '|', 1) AS column8   
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 9), '|', -1), '|', 1) AS column9  
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 10), '|', -1), '|', 1) AS column10 
			FROM (SELECT line_no, prev_no, REGEXP_SUBSTR(your_column, '[^<#>]+', 1, line_no) line FROM number_sequence
			JOIN 
			(SELECT 'D01|NANO ZINC 250 ML|uSuks ftad 250 ,e,y|KL0|99|NANOZ250ML|NANO|NANO|NANO|D|KL1|INDIGENOUS|N|2853|LT|0.25|NO|=<#>D02|NANO COPPER 250 ML|=|KL0|99|NANOC250ML|NANO|NANO|NANO|D|KL1|INDIGENOUS|N|2853|LT|0.25|NO|DU0<#>D03|NANO UREA LIQUID 500 ML KALOL|uSuks ;wfj;k fyDoM 500 ,e,y|KL0|99|NANOU500ML|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D04|NANO DAP LIQUID 500 ML KALOL|uSuks Mh,ih rjy 500 fe-yh- dyksy|KL0|99|NANOD500ML|NANO|NANO|NANO DAP|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DD0<#>D05|NANO DAP LIQUID 500 ML KALOL NV|uSuks Mh,ih rjy 500 fe-yh- dyksy ,uoh|KL0|99|NANOD500NV|NANO|NANO|NANO DAP|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DD0<#>D06|SNU 500 ML KALOL NV|=|KL0|99|SNU500MLNV|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D07|NANO UREA LIQUID 500 ML KALOL (2YR)|uSuks ;wfj;k fyDoM 500 ,e,y|KL0|99|NANOU5KL2Y|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D08|NANO UREA LIQUID 500 ML KALOL NV|=|KL0|99|NANOU500NV|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D09|NANO UREA PLUS 500 ML KALOL|=|KL0|99|NUP500MLKL|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D31|NANO UREA SUPER 500 ML KALOL|=|KL0|99|NUS500ML|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0' AS your_column) AS subquery
			ON true) Z; 
            */
    END IF;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MDA_STATUS_REPORT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MDA_STATUS_REPORT(
    IN P_MDA_NO VARCHAR(255),
    IN P_SEARCH_TERM VARCHAR(255),
    IN P_TRUCK_NO VARCHAR(255),
    IN P_INVOICE_QR_CODE VARCHAR(255),
    IN P_FROM_DATE VARCHAR(255),
    IN P_TO_DATE VARCHAR(255),
    IN P_DISPLAY_LENGTH INT,
    IN P_DISPLAY_START INT,
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #,    OUT P_RESULT CURSOR
)
BEGIN
    DECLARE done INT DEFAULT FALSE;

    -- Cursor for P_RESULT
    #DECLARE cur_result CURSOR FOR
    WITH TBL_MAIN AS (
        SELECT 
            ROW_NUMBER() OVER() AS RNUM,  
            (SELECT COUNT(*) FROM FG_GATE_IN_OUT FG 
                INNER JOIN MDA_REQUISITION_DATA MR ON FG.PLANT_ID = MR.PLANT_ID AND FG.GATE_SYS_ID = MR.GATE_SYS_ID
                INNER JOIN MDA_HEADER MH ON MR.PLANT_ID = MH.PLANT_ID AND MR.MDA_NO = MH.MDA_NO
                INNER JOIN MDA_DETAIL MD ON MH.MDA_SYS_ID = MD.MDA_SYS_ID AND MH.PLANT_ID = MD.PLANT_ID AND MD.PROD_SYS_ID = MR.PROD_SYS_ID
                INNER JOIN MDA_SEQUENCE MS ON FG.PLANT_ID = MS.PLANT_ID AND FG.MDA_SYS_ID = MS.MDA_SYS_ID AND FG.GATE_SYS_ID = MS.GATE_SYS_ID
                INNER JOIN MDA_INVOICE_QR INVQR ON MR.PLANT_ID = INVQR.PLANT_ID AND MR.MDA_NO = INVQR.MDA_NO  
                INNER JOIN SYSTEM_USERS SYSUR ON MS.CREATED_BY_ID = SYSUR.USER_ID
                WHERE FG.PLANT_ID = P_PLANT_ID 
                    AND MH.MDA_NO = COALESCE(P_MDA_NO, MH.MDA_NO)
                    AND MH.VEHICLE_NO = COALESCE(P_TRUCK_NO, MH.VEHICLE_NO)
                    AND INVQR.INVOICEQRCODE = COALESCE(P_INVOICE_QR_CODE, INVQR.INVOICEQRCODE)
                    AND (P_FROM_DATE IS NULL OR TRUNC(MH.MDA_DT) >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y'))
                    AND (P_TO_DATE IS NULL OR TRUNC(MH.MDA_DT) <= STR_TO_DATE(P_TO_DATE, '%d/%m/%Y'))
                    AND (P_SEARCH_TERM IS NULL OR P_SEARCH_TERM = '' 
                        OR UPPER(MH.MDA_NO) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%')
                        OR UPPER(MH.VEHICLE_NO) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%')
                        OR UPPER(INVQR.INVOICEQRCODE) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%'))
            ) AS COUNT_ROW,
            MH.MDA_NO,
            MH.CREATED_DATETIME AS MDA_REC_DATE,
            MH.VEHICLE_NO AS TRUCK_NO,
            MH.DRIVER AS DRIVER_NAME,
            MH.PARTY_NAME AS CUST_NAME,
            MH.WH_CD AS WH_CD,
            '' AS DESTINATION,
            MS.CREATED_DATETIME AS LOADING_IN_DATETIME,
            MS.MDA_STATUS_DATETIME AS LOADING_OUT_DATETIME, 
            MS.MDA_SEQUENCE_NO AS LIFO_LOADING_SEQUENCE,
            MR.LOADING_BAY,
            CONCAT(SYSUR.FIRST_NAME, ' ', SYSUR.LAST_NAME) AS LOADING_BAY_OPERATOR,
            '' AS LI_LO_SKIP,
            MR.SKU_CODE,
            MR.SKU_NAME,
            (MD.BAG_NOS / 24) AS MDA_QTY_SHIPPER,
            (MD.BAG_NOS / 24) AS MDA_UPDATED_QTY_SHIPPER,
            MR.LOADED_ITEM AS LOADED_QTY_SHIPPER,
            MS.MDA_STATUS AS MDA_STATUS,
            FG.GATE_OUT_DT AS DISP_DATE_TIME,
            '' AS INVOICE_QR_CODE
        FROM FG_GATE_IN_OUT FG 
        INNER JOIN MDA_REQUISITION_DATA MR ON FG.PLANT_ID = MR.PLANT_ID AND FG.GATE_SYS_ID = MR.GATE_SYS_ID
        INNER JOIN MDA_HEADER MH ON MR.PLANT_ID = MH.PLANT_ID AND MR.MDA_NO = MH.MDA_NO
        INNER JOIN MDA_DETAIL MD ON MH.MDA_SYS_ID = MD.MDA_SYS_ID AND MH.PLANT_ID = MD.PLANT_ID AND MD.PROD_SYS_ID = MR.PROD_SYS_ID
        INNER JOIN MDA_SEQUENCE MS ON FG.PLANT_ID = MS.PLANT_ID AND FG.MDA_SYS_ID = MS.MDA_SYS_ID AND FG.GATE_SYS_ID = MS.GATE_SYS_ID
        INNER JOIN MDA_INVOICE_QR INVQR ON MR.PLANT_ID = INVQR.PLANT_ID AND MR.MDA_NO = INVQR.MDA_NO  
        INNER JOIN SYSTEM_USERS SYSUR ON MS.CREATED_BY_ID = SYSUR.USER_ID
        WHERE FG.PLANT_ID = P_PLANT_ID 
            AND MH.MDA_NO = COALESCE(P_MDA_NO, MH.MDA_NO)
            AND MH.VEHICLE_NO = COALESCE(P_TRUCK_NO, MH.VEHICLE_NO)
            AND INVQR.INVOICEQRCODE = COALESCE(P_INVOICE_QR_CODE, INVQR.INVOICEQRCODE)
            AND (P_FROM_DATE IS NULL OR TRUNC(MH.MDA_DT) >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y'))
            AND (P_TO_DATE IS NULL OR TRUNC(MH.MDA_DT) <= STR_TO_DATE(P_TO_DATE, '%d/%m/%Y'))
            AND (P_SEARCH_TERM IS NULL OR P_SEARCH_TERM = '' 
                OR UPPER(MH.MDA_NO) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%')
                OR UPPER(MH.VEHICLE_NO) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%')
                OR UPPER(INVQR.INVOICEQRCODE) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%'))
    )
    SELECT * FROM TBL_MAIN WHERE  1 = (CASE WHEN COALESCE(P_DISPLAY_LENGTH, 0) > 0 AND RNUM <= (P_DISPLAY_LENGTH + P_DISPLAY_START)  AND RNUM > P_DISPLAY_START THEN 1 WHEN COALESCE(P_DISPLAY_LENGTH, 0) = 0 THEN 1 ELSE 0 END);

    -- Open the cursor
    #OPEN P_RESULT;
    #FETCH cur_result INTO P_RESULT;
    #CLOSE cur_result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MDA_WISE_DISPATCH_SUMMARY_REPORT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MDA_WISE_DISPATCH_SUMMARY_REPORT(
    IN P_MDA_NO VARCHAR(255),
    IN P_FROM_DATE VARCHAR(255),
    IN P_TO_DATE VARCHAR(255),
    IN P_DISPLAY_LENGTH INT,
    IN P_DISPLAY_START INT,
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #,    OUT P_RESULT CURSOR
)
BEGIN
    DECLARE done INT DEFAULT FALSE;

    -- Cursor for P_RESULT
    #DECLARE cur_result CURSOR FOR
    
    #IF P_MDA_NO IS NOT NULL THEN
    WITH TBL_MAIN AS (
        SELECT ROW_NUMBER() OVER() AS RNUM, (COUNT(*) OVER()) COUNT_ROW, 
            mdahdr.MDA_SYS_ID, mdahdr.MDA_NO, DATE_Format(mdahdr.MDA_DT,'%d/%m/%Y')MDA_DT, mdahdr.VEHICLE_NO, 
            (select GROUP_CONCAT(batch_no ORDER BY batch_no SEPARATOR ',') batchno 
			FROM SHIPPER_QRCODE_API  where Plant_id = 4  and SHIPPER_QRCODE_API_SYSID in (
			select SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE where shipper_qrcode in 
		(select shipper_qr_code FROM MDA_LOADING where MDA_SYS_ID IN (select MDA_SYS_ID FROM MDA_HEADER where MDA_NO = mdahdr.MDA_NO )))) BATCH_NO, 
        (select GROUP_CONCAT(DATE_Format(MFG_DATE,'%d/%m/%Y'),'' ORDER BY DATE_Format(MFG_DATE,'%d/%m/%Y') SEPARATOR ',') MFGDT 
FROM SHIPPER_QRCODE_API  where Plant_id = 4  and SHIPPER_QRCODE_API_SYSID in (
select SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE where shipper_qrcode in 
(select shipper_qr_code FROM MDA_LOADING where MDA_SYS_ID IN (select MDA_SYS_ID FROM MDA_HEADER where MDA_NO = mdahdr.MDA_NO )))
) MFG_DT, 
			(select COUNT(MDA_SYS_ID) FROM mda_loading where MDA_SYS_ID  = mdahdr.MDA_SYS_ID)Shipper_Qty,
			(select COUNT(MDA_SYS_ID) * 24 FROM mda_loading where MDA_SYS_ID  = mdahdr.MDA_SYS_ID)Bottle_Qty,
			(select IFNULL(LOADING_BAY,'DLA02') FROM mda_requisition_data where MDA_SYS_ID = mdahdr.MDA_SYS_ID)LoadingBay,
			pdm.SKU_NAME,mdahdr.party_name,desp_place Destination,NULL address
			FROM MDA_HEADER  mdahdr
			inner join mda_detail mdadtl on mdahdr.MDA_SYS_ID = mdadtl.MDA_SYS_ID
			inner join product_master pdm on mdadtl.PROD_SYS_ID = pdm.PROD_SYS_ID
			where mdahdr.PLANT_ID = P_PLANT_ID and mdahdr.MDA_NO = P_MDA_NO
            OR (DATE(mdahdr.MDA_DT) >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y')
			AND DATE(mdahdr.MDA_DT) <= IFNULL(STR_TO_DATE(P_TO_DATE, '%d/%m/%Y'), NOW()))
    )
    SELECT TBL_MAIN.*, (COUNT(*) OVER()) COUNT_ROW FROM TBL_MAIN WHERE  1 = (CASE WHEN COALESCE(P_DISPLAY_LENGTH, 0) > 0 AND RNUM <= (P_DISPLAY_LENGTH + P_DISPLAY_START)  AND RNUM > P_DISPLAY_START THEN 1 WHEN COALESCE(P_DISPLAY_LENGTH, 0) = 0 THEN 1 ELSE 0 END);
	#END IF;
    
    /*IF P_FROM_DATE IS NOT NULL THEN
    WITH TBL_MAIN AS (
				SELECT 
					ROW_NUMBER() OVER() AS RNUM, 
					(COUNT(*) OVER()) AS COUNT_ROW, 
					mdahdr.MDA_SYS_ID, 
					mdahdr.MDA_NO, 
					mdahdr.MDA_DT, 
					mdahdr.VEHICLE_NO, NULL BATCH_NO, NULL MFG_DT,
					(SELECT COUNT(MDA_SYS_ID) FROM mda_loading WHERE MDA_SYS_ID = mdahdr.MDA_SYS_ID) AS Shipper_Qty,
					(SELECT COUNT(MDA_SYS_ID) * 24 FROM mda_loading WHERE MDA_SYS_ID = mdahdr.MDA_SYS_ID) AS Bottle_Qty,
					(SELECT IFNULL(LOADING_BAY, 'DLA02') FROM mda_requisition_data WHERE MDA_SYS_ID = mdahdr.MDA_SYS_ID) AS LoadingBay,
					pdm.SKU_NAME,
					mdahdr.party_name,
					desp_place AS Destination,
					NULL AS address
				FROM 
					MDA_HEADER mdahdr
					INNER JOIN mda_detail mdadtl ON mdahdr.MDA_SYS_ID = mdadtl.MDA_SYS_ID
					INNER JOIN product_master pdm ON mdadtl.PROD_SYS_ID = pdm.PROD_SYS_ID
				WHERE 
					mdahdr.PLANT_ID = P_PLANT_ID
					AND DATE(mdahdr.MDA_DT) >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y')
					AND DATE(mdahdr.MDA_DT) <= IFNULL(STR_TO_DATE(P_TO_DATE, '%d/%m/%Y'), NOW())
    )
    SELECT * FROM TBL_MAIN WHERE  1 = (CASE WHEN COALESCE(P_DISPLAY_LENGTH, 0) > 0 AND RNUM <= (P_DISPLAY_LENGTH + P_DISPLAY_START)  AND RNUM > P_DISPLAY_START THEN 1 WHEN COALESCE(P_DISPLAY_LENGTH, 0) = 0 THEN 1 ELSE 0 END);
	
    END IF;*/
  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MENU_COMBOFORROLE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MENU_COMBOFORROLE(
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #OUT P_RESULT CURSOR
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Error handling
        -- You might want to handle exceptions based on specific error codes
        -- Here, we're just ignoring the error and returning NULL
    END;

    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) > 0 THEN
        #OPEN P_RESULT FOR
        SELECT ID, DISPLAY_NAME AS NAME
        FROM MENU_MASTER_NEW
        WHERE IS_ACTIVE = 'Y' AND Parent_ID != 0;
    #END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MENU_COMBOFORROLE_NEW */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MENU_COMBOFORROLE_NEW(
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #OUT P_RESULT CURSOR
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Error handling
        -- You might want to handle exceptions based on specific error codes
        -- Here, we're just ignoring the error and returning NULL
    END;

    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) > 0 THEN
        #OPEN P_RESULT FOR
        SELECT ID, DISPLAY_NAME AS NAME
        FROM MENU_MASTER
        WHERE IS_ACTIVE = 'Y' AND Parent_ID != 0;
    #END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MENU_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MENU_GET(
    IN P_ID INT,
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #OUT P_RESULT CURSOR
)
BEGIN
             
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        -- SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) > 0 THEN
        IF P_ID > 0 THEN
            #OPEN P_RESULT FOR
            SELECT ID, PARENT_ID,
                (SELECT Z.DISPLAY_NAME FROM MENU_MASTER_NEW Z WHERE Z.ID = X.PARENT_ID LIMIT 1) AS PARENT_MENU_NAME,
                AREA, CONTROLLER, DISPLAY_NAME AS NAME, URL, DISPLAYORDER,
                CASE WHEN X.ISADMIN = 'Y' THEN 1 ELSE 0 END AS ISADMIN,
                CASE WHEN X.IS_ACTIVE = 'Y' THEN 1 ELSE 0 END AS ISACTIVE
            FROM MENU_MASTER_NEW X
            WHERE X.ID = P_ID AND X.IS_ACTIVE = COALESCE(P_ISACTIVE, X.IS_ACTIVE) AND UPPER(COALESCE(CONTROLLER, 'Z')) != 'MENU';
        ELSE
            #OPEN P_RESULT FOR
            SELECT ROW_NUMBER() OVER (ORDER BY PARENT_ID, ID, DISPLAYORDER) AS SR_NO, ID, PARENT_ID,
                (SELECT Z.DISPLAY_NAME FROM MENU_MASTER_NEW Z WHERE Z.ID = X.PARENT_ID LIMIT 1) AS PARENT_MENU_NAME,
                AREA, CONTROLLER, DISPLAY_NAME AS NAME, URL, DISPLAYORDER,
                CASE WHEN X.ISADMIN = 'Y' THEN 1 ELSE 0 END AS ISADMIN,
                CASE WHEN X.IS_ACTIVE = 'Y' THEN 1 ELSE 0 END AS ISACTIVE
            FROM MENU_MASTER_NEW X
            WHERE X.IS_ACTIVE = COALESCE(P_ISACTIVE, X.IS_ACTIVE) AND UPPER(COALESCE(CONTROLLER, 'Z')) != 'MENU';
        END IF;
    #END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MENU_GET_NEW */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MENU_GET_NEW(
    IN P_ID INT,
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #OUT P_RESULT CURSOR
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Error handling
        -- You might want to handle exceptions based on specific error codes
        -- Here, we're just ignoring the error and returning NULL
    END;

    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) > 0 THEN
        IF P_ID > 0 THEN
            #OPEN P_RESULT FOR
            SELECT ID, PARENT_ID,
                (SELECT Z.DISPLAY_NAME FROM MENU_MASTER Z WHERE Z.ID = X.PARENT_ID LIMIT 1) AS PARENT_MENU_NAME,
                AREA, CONTROLLER, DISPLAY_NAME AS NAME, URL, DISPLAYORDER,
                CASE WHEN X.ISADMIN = 'Y' THEN 1 ELSE 0 END AS ISADMIN,
                CASE WHEN X.IS_ACTIVE = 'Y' THEN 1 ELSE 0 END AS ISACTIVE
            FROM MENU_MASTER X
            WHERE X.ID = P_ID AND X.IS_ACTIVE = COALESCE(P_ISACTIVE, X.IS_ACTIVE) AND UPPER(COALESCE(CONTROLLER, 'Z')) != 'MENU';
        ELSE
            #OPEN P_RESULT FOR
            SELECT ROW_NUMBER() OVER (ORDER BY PARENT_ID, ID, DISPLAYORDER) AS SR_NO, ID, PARENT_ID,
                (SELECT Z.DISPLAY_NAME FROM MENU_MASTER Z WHERE Z.ID = X.PARENT_ID LIMIT 1) AS PARENT_MENU_NAME,
                AREA, CONTROLLER, DISPLAY_NAME AS NAME, URL, DISPLAYORDER,
                CASE WHEN X.ISADMIN = 'Y' THEN 1 ELSE 0 END AS ISADMIN,
                CASE WHEN X.IS_ACTIVE = 'Y' THEN 1 ELSE 0 END AS ISACTIVE
            FROM MENU_MASTER X
            WHERE X.IS_ACTIVE = COALESCE(P_ISACTIVE, X.IS_ACTIVE) AND UPPER(COALESCE(CONTROLLER, 'Z')) != 'MENU';
        END IF;
    #END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MENU_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MENU_SAVE(
    IN P_ID INT,
    IN P_PARENT_ID INT,
    IN P_AREA VARCHAR(255),
    IN P_CONTROLLER VARCHAR(255),
    IN P_NAME VARCHAR(255),
    IN P_URL VARCHAR(255),
    IN P_DISPLAYORDER INT,
    IN P_ISADMIN VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_NUM INT;
    DECLARE TEMP_DISPLAYORDER INT;
    
    SET P_RESULT := 'E|Oops!... Something went wrong. Please contact the system administrator|0';

    SELECT COUNT(*) INTO TEMP_NUM FROM MENU_MASTER_NEW X WHERE (AREA = P_AREA AND CONTROLLER = P_CONTROLLER AND DISPLAY_NAME = P_NAME) AND X.ID != P_ID;
    SELECT COALESCE(MAX(DISPLAYORDER), 0) + 1 INTO TEMP_DISPLAYORDER FROM MENU_MASTER_NEW WHERE PARENT_ID = P_PARENT_ID;

    IF P_DISPLAYORDER > 0 THEN
        SET TEMP_DISPLAYORDER := P_DISPLAYORDER;
    END IF;
            
    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT := 'E|You are not authorized to perform this operation.|0';    
    #ELSE
    IF COALESCE(TEMP_NUM, 0) > 0 THEN
        SET P_RESULT := 'E|Plant name or code is already exist.|0';    
    ELSEIF P_ID > 0 THEN
        UPDATE MENU_MASTER_NEW SET PARENT_ID = P_PARENT_ID, AREA = P_AREA, CONTROLLER = P_CONTROLLER, DISPLAY_NAME = P_NAME, URL = P_URL, DISPLAYORDER = TEMP_DISPLAYORDER, ISADMIN = P_ISADMIN, IS_ACTIVE = P_ISACTIVE
        WHERE ID = P_ID;
        
        SET P_RESULT := 'S|Record updated successfully|';
    ELSE
        SELECT COALESCE(MAX(ID), 0) + 1 INTO TEMP_NUM FROM MENU_MASTER_NEW;
        SELECT COALESCE(MAX(DISPLAYORDER), 0) + 1 INTO TEMP_DISPLAYORDER FROM MENU_MASTER_NEW WHERE PARENT_ID = P_PARENT_ID;
    
        INSERT INTO MENU_MASTER_NEW (ID, PARENT_ID, AREA, CONTROLLER, DISPLAY_NAME, URL, DISPLAYORDER, ISADMIN, IS_ACTIVE, CREATED_BY, CREATED_DATETIME)
        VALUES(TEMP_NUM, P_PARENT_ID, P_AREA, P_CONTROLLER, P_NAME, P_URL, TEMP_DISPLAYORDER, P_ISADMIN, P_ISACTIVE, P_USER_ID, NOW(), P_USER_ID, NOW());
        
        INSERT INTO ROLE_MENU (ROLE_ID, MENU_ID)
        VALUES(P_ROLE_ID, TEMP_NUM);
    
        SET P_RESULT := 'S|Record saved successfully|';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_MENU_SAVE_NEW */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_MENU_SAVE_NEW(
    IN P_ID INT,
    IN P_PARENT_ID INT,
    IN P_AREA VARCHAR(255),
    IN P_CONTROLLER VARCHAR(255),
    IN P_NAME VARCHAR(255),
    IN P_URL VARCHAR(255),
    IN P_DISPLAYORDER INT,
    IN P_ISADMIN VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_NUM INT;
    DECLARE TEMP_DISPLAYORDER INT;
    
    SET P_RESULT := 'E|Oops!... Something went wrong. Please contact the system administrator|0';

    SELECT COUNT(*) INTO TEMP_NUM FROM MENU_MASTER X WHERE (AREA = P_AREA AND CONTROLLER = P_CONTROLLER AND DISPLAY_NAME = P_NAME) AND X.ID != P_ID;
    SELECT COALESCE(MAX(DISPLAYORDER), 0) + 1 INTO TEMP_DISPLAYORDER FROM MENU_MASTER WHERE PARENT_ID = P_PARENT_ID;

    IF P_DISPLAYORDER > 0 THEN
        SET TEMP_DISPLAYORDER := P_DISPLAYORDER;
    END IF;
            
    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT := 'E|You are not authorized to perform this operation.|0';    
    #ELSE
    IF COALESCE(TEMP_NUM, 0) > 0 THEN
        SET P_RESULT := 'E|Plant name or code is already exist.|0';    
    ELSEIF P_ID > 0 THEN
        UPDATE MENU_MASTER SET PARENT_ID = P_PARENT_ID, AREA = P_AREA, CONTROLLER = P_CONTROLLER, DISPLAY_NAME = P_NAME, URL = P_URL, DISPLAYORDER = TEMP_DISPLAYORDER, ISADMIN = P_ISADMIN, IS_ACTIVE = P_ISACTIVE
        WHERE ID = P_ID;
        
        SET P_RESULT := 'S|Record updated successfully|';
    ELSE
        SELECT COALESCE(MAX(ID), 0) + 1 INTO TEMP_NUM FROM MENU_MASTER;
        SELECT COALESCE(MAX(DISPLAYORDER), 0) + 1 INTO TEMP_DISPLAYORDER FROM MENU_MASTER WHERE PARENT_ID = P_PARENT_ID;
    
        INSERT INTO MENU_MASTER (ID, PARENT_ID, AREA, CONTROLLER, DISPLAY_NAME, URL, DISPLAYORDER, ISADMIN, IS_ACTIVE, CREATED_BY, CREATED_DATETIME)
        VALUES(TEMP_NUM, P_PARENT_ID, P_AREA, P_CONTROLLER, P_NAME, P_URL, TEMP_DISPLAYORDER, P_ISADMIN, P_ISACTIVE, P_USER_ID, NOW(), P_USER_ID, NOW());
        
        INSERT INTO ROLE_MENU (ROLE_ID, MENU_ID)
        VALUES(P_ROLE_ID, TEMP_NUM);
    
        SET P_RESULT := 'S|Record saved successfully|';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_NEW_TRUCK_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_NEW_TRUCK_SAVE(
    IN P_ID INT,
    IN P_REF_SYS_ID INT,
    IN P_INWARD_SYS_ID INT,
    IN P_STATION_ID INT,
    IN P_TRUCK_NO VARCHAR(255),
    IN P_TRANSPORTER_NAME VARCHAR(255),
    IN P_DRIVER_NAME VARCHAR(255),
    IN P_DRIVER_CONTACT VARCHAR(255),
    IN P_DRIVER_ID_TYPE VARCHAR(255),
    IN P_DRIVER_ID_NUMBER VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_NUM INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|';
    END;
    
    SET P_RESULT := 'E|Oops!... Something went wrong. Please contact the system administrator|1';

    IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        SET P_RESULT := 'E|You are not authorized to perform this operation.|0';  
    ELSEIF COALESCE(P_ID, 0) > 0 THEN
        UPDATE RFID_MASTER_TEMP SET STATUS = 'A' WHERE RFSYSID = P_REF_SYS_ID;

        IF COALESCE(P_ID, 0) > 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 1 THEN
            UPDATE FG_GATE_IN_OUT SET 
                TRUCK_NO = P_TRUCK_NO,
                RFSYSID = P_REF_SYS_ID,
                DRIVER_NAME = P_DRIVER_NAME,
                DRIVER_CONTACT = P_DRIVER_CONTACT,
                DRIVER_ID_TYPE = P_DRIVER_ID_TYPE,
                DRIVER_ID_NUMBER = P_DRIVER_ID_NUMBER,
                IS_GOODS_TRANSFER = 1,
                GATE_SYS_ID_OLD = 1
            WHERE GATE_SYS_ID = P_ID;
        ELSEIF COALESCE(P_ID, 0) > 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 126 THEN
            UPDATE RM_GATE_IN_OUT SET 
                TRUCK_NO = P_TRUCK_NO,
                RFSYSID = P_REF_SYS_ID,
                TRANSPORTER_NAME = P_TRANSPORTER_NAME,
                DRIVER_NAME = P_DRIVER_NAME,
                DRIVER_CONTACT = P_DRIVER_CONTACT,
                DRIVER_ID_TYPE = P_DRIVER_ID_TYPE,
                DRIVER_ID_NUMBER = P_DRIVER_ID_NUMBER,
                IS_UNLOAD_TRUCK = 1,
                CANCEL_GATE_IN = 1
            WHERE GATE_SYS_ID = P_ID;
        ELSEIF COALESCE(P_ID, 0) > 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 127 THEN
            UPDATE SP_GATE_IN_OUT SET 
                TRUCK_NO = P_TRUCK_NO,
                RFSYSID = P_REF_SYS_ID,
                TRANSPORTER_NAME = P_TRANSPORTER_NAME,
                DRIVER_NAME = P_DRIVER_NAME,
                DRIVER_CONTACT = P_DRIVER_CONTACT,
                DRIVER_ID_TYPE = P_DRIVER_ID_TYPE,
                DRIVER_ID_NUMBER = P_DRIVER_ID_NUMBER,
                IS_GOODS_TRANSFER = 1,
                GATE_SYS_ID_OLD = 1
            WHERE GATE_SYS_ID = P_ID;
        END IF;

        SET P_RESULT := 'S|Record saved successfully|';
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_OLD_TRUCK_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_OLD_TRUCK_SAVE(
    IN P_ID INT,
    IN P_INWARD_SYS_ID INT,
    IN P_REF_SYS_ID_OLD INT,
    IN P_STATION_ID INT,
    IN P_REASON VARCHAR(255),
    IN P_ISACTIVE VARCHAR(1),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_NUM INT;
	
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|';
    END;
    
    SET P_RESULT := 'E|Oops!... Something went wrong. Please contact the system administrator|1';

    IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        SET P_RESULT := 'E|You are not authorized to perform this operation.|0';  
    ELSEIF COALESCE(P_ID, 0) > 0 THEN
        UPDATE RFID_MASTER_TEMP SET STATUS = 'Act' WHERE RFSYSID = P_REF_SYS_ID_OLD;

        IF COALESCE(P_ID, 0) > 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 1 THEN
            UPDATE FG_GATE_IN_OUT SET CANCEL_GATE_REASON = P_REASON WHERE GATE_SYS_ID = P_ID;
        ELSEIF COALESCE(P_ID, 0) > 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 126 THEN
            UPDATE RM_GATE_IN_OUT SET CANCEL_GATE_REASON = P_REASON WHERE GATE_SYS_ID = P_ID;
        ELSEIF COALESCE(P_ID, 0) > 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 127 THEN
            UPDATE SP_GATE_IN_OUT SET CANCEL_GATE_REASON = P_REASON WHERE GATE_SYS_ID = P_ID;
        END IF;

        SET P_RESULT := 'S|Record saved successfully|';
    END IF;  

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_PLANT_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_PLANT_GET(
IN `P_ID` INT,
IN `P_ISACTIVE` VARCHAR(255),
IN `P_PLANT_ID` INT,
IN `P_USER_ID` INT,
IN `P_ROLE_ID` INT,
IN `P_MENU_ID` INT
)
BEGIN
IF `P_ID` > 0 THEN
SELECT `PLANTID` AS `ID`,
`PLANTCODE` AS `CODE`,
`PLANTADDRESS` AS `ADDRESS`,
`PLANT_NAME` AS `NAME`#,
/*`UNIT_CODE`,
CASE `X`.`IS_ACTIVE`
WHEN 'Y' THEN 1
ELSE 0
END AS `IS_ACTIVE`*/
FROM `PLANT_MASTER` `X`
WHERE `X`.`PLANTID` = `P_ID`;
#AND `X`.`IS_ACTIVE` = IFNULL(`P_ISACTIVE`, `X`.`IS_ACTIVE`);
ELSE
SELECT `PLANTID` AS `ID`,
`PLANTCODE` AS `CODE`,
`PLANTADDRESS` AS `ADDRESS`,
`PLANT_NAME` AS `NAME`#,
/*`UNIT_CODE`,
CASE `X`.`IS_ACTIVE`
WHEN 'Y' THEN 1
ELSE 0
END AS `IS_ACTIVE`*/
FROM `PLANT_MASTER` `X`;
#WHERE `X`.`IS_ACTIVE` = IFNULL(`P_ISACTIVE`, `X`.`IS_ACTIVE`);
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_PO_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_PO_SAVE(
    IN P_ID BIGINT, 
    IN P_VENDOR_ID BIGINT, 
    IN P_SITE_ID BIGINT, 
    IN P_PO_NO VARCHAR(255), 
    IN P_PO_DATE VARCHAR(255), 
    IN P_PO_DESC VARCHAR(255), 
    IN P_TRUCK_NO VARCHAR(255), 
    IN P_TRANS_SYS_ID BIGINT, 
    IN P_PO_DTLS VARCHAR(255), 
    IN P_ISACTIVE VARCHAR(255), 
    IN P_PLANT_ID BIGINT, 
    IN P_USER_ID BIGINT,  
    IN P_ROLE_ID BIGINT, 
    IN P_MENU_ID BIGINT, 
    OUT P_RESULT VARCHAR(255))
BEGIN
    DECLARE TEMP_PO_ID INT DEFAULT 0; 
    DECLARE TEMP_PO_DTLS_ID INT DEFAULT 0; 
    DECLARE TEMP_PO_DTLS_LINE_NO INT DEFAULT 0; 
    DECLARE TEMP_CNT INT DEFAULT 0; 
    DECLARE TEMP_STATION_ID INT DEFAULT 7;
	DECLARE v_PO_DATE DATETIME;

    DECLARE v_counter BIGINT DEFAULT 1;
	DECLARE v_line VARCHAR(16300);
    
					DECLARE v_line_id VARCHAR(255);
					DECLARE v_line_no VARCHAR(255);
					DECLARE v_line_desc VARCHAR(16300);
					DECLARE v_line_uom VARCHAR(255);
					DECLARE v_line_qty VARCHAR(255);
                
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;


    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact system administrator|0';

    IF LENGTH(IFNULL(P_PO_NO, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter Vendor PO No.|0';
    ELSEIF IFNULL(P_VENDOR_ID, 0) = 0 THEN
		SET P_RESULT := 'E|Please select Vendor.|0';
    ELSEIF IFNULL(P_SITE_ID, 0) = 0 THEN
		SET P_RESULT := 'E|Please select Vendor Site.|0';
    ELSEIF LENGTH(IFNULL(P_PO_DATE, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter Vendor PO Date.|0';
    ELSEIF LENGTH(IFNULL(P_PO_DESC, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter Vendor PO description|0';
    ELSEIF LENGTH(IFNULL(P_TRUCK_NO, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter Vehicle No.|0';
    ELSEIF IFNULL(P_ID, 0) = 0 AND LENGTH(IFNULL(P_PO_DTLS, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter Vendor PO details|0';
    ELSE 
		
		SELECT COUNT(*) INTO TEMP_CNT FROM po_header WHERE PLANT_ID = P_PLANT_ID AND PO_NO = P_PO_NO AND PO_SYS_ID != IFNULL(P_ID, 0);

		IF IFNULL(TEMP_CNT, 0) = 0 THEN
							
			SET v_PO_DATE = IF(IFNULL(P_PO_DATE, '') = '' OR P_PO_DATE = '=', NULL, STR_TO_DATE(REPLACE(P_PO_DATE, '-', '/'), '%d/%m/%Y %H:%i'));
                            
			IF IFNULL(P_ID, 0) > 0 THEN
			
            
            
            
				SET TEMP_PO_ID = IFNULL(P_ID, 0);
                
				SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_PO_ID);
			ELSE
				
				SELECT IFNULL(MAX(PO_SYS_ID), 0) + 1 INTO TEMP_PO_ID FROM po_header;
					
				INSERT INTO po_header (PO_SYS_ID, PO_NO, PO_DATE, VENDOR_SYS_ID, PO_DESCCRIPTION, TRANS_SYS_ID, TRUCK_NO, IS_PO_MANUAL, STATION_ID, PLANT_ID, Created_BY_ID, Created_DateTime, IS_POSTED)
				VALUES (TEMP_PO_ID, P_PO_NO, v_PO_DATE, P_VENDOR_ID, P_PO_DESC, P_TRANS_SYS_ID, P_TRUCK_NO, 1, TEMP_STATION_ID, P_PLANT_ID, P_USER_ID, NOW(), 0);
					
				SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_PO_ID);
	 
			END IF;
                        
				SET v_counter = 1;
				SET v_line = REGEXP_SUBSTR(IFNULL(P_PO_DTLS, ''), '[^##]+', 1, v_counter);
                
				WHILE v_line IS NOT NULL DO
                
					SET v_line_id = REGEXP_SUBSTR(v_line, '[^|]+', 1, 1);
					SET v_line_no = REGEXP_SUBSTR(v_line, '[^|]+', 1, 2);
					SET v_line_desc = REGEXP_SUBSTR(v_line, '[^|]+', 1, 3);
					SET v_line_uom = REGEXP_SUBSTR(v_line, '[^|]+', 1, 4);
					SET v_line_qty = REGEXP_SUBSTR(v_line, '[^|]+', 1, 5);
                
					SELECT IFNULL(MAX(PO_DTL_SYS_ID), 0) + 1 INTO TEMP_PO_DTLS_ID FROM po_detail;
					
                    IF CAST(IFNULL(v_line_no, '0') AS UNSIGNED) > 0 THEN SET TEMP_PO_DTLS_LINE_NO = CAST(IFNULL(v_line_no, '0') AS UNSIGNED);
                    ELSE SELECT IFNULL(MAX(PO_LINE_NO), 0) + 1 INTO TEMP_PO_DTLS_LINE_NO FROM po_detail WHERE PLANT_ID = P_PLANT_ID AND PO_SYS_ID = TEMP_PO_ID; END IF;
                    
					INSERT INTO po_detail (PO_DTL_SYS_ID, PO_SYS_ID, PO_LINE_NO, LINE_DESC, UMO, LINE_QTY, IS_POSTED, PLANT_ID, Created_DateTime)
                    VALUES (TEMP_PO_DTLS_ID, TEMP_PO_ID, TEMP_PO_DTLS_LINE_NO, v_line_desc, v_line_uom, CAST(IFNULL(v_line_qty, '0') AS UNSIGNED), 0, P_PLANT_ID, NOW());
                
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_PO_DTLS, '[^##]+', 1, v_counter);
                    
				END WHILE;
				
		ELSE
			SET P_RESULT := 'E|Vendor PO No. is already available.|0';
		END IF;
        
    END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_QR_CODE_CHECK */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_QR_CODE_CHECK(
    IN P_GATE_IN_ID INT,
    IN P_MDA_ID INT,
    IN P_PRODUCT_ID INT, 
    IN P_QR_CODE VARCHAR(255), 
	IN IS_MANUAL_SCAN INT, 
    IN P_PLANT_ID INT, 
    IN P_USER_ID INT, 
    IN P_ROLE_ID INT, 
	IN P_MENU_ID INT, 
    OUT P_RESULT VARCHAR(255)
)
BEGIN
DECLARE TEMP_NUM INT DEFAULT 0;
DECLARE TEMP_ID INT DEFAULT 0;
DECLARE IsAvailable_QRCode INT DEFAULT 0;
DECLARE IsAvailable_ShipperQRCode INT DEFAULT 0;
DECLARE IsAvailable_SuccessList INT DEFAULT 0;
DECLARE TEMP_MDA_Loading INT DEFAULT 0;
DECLARE Bottles_PER_SHIPPER INT DEFAULT 0;
DECLARE Total_REQUIRED_SHIPPER INT DEFAULT 0;
DECLARE Total_LOADED_SHIPPER INT DEFAULT 0;
DECLARE BottlesQuantity INT DEFAULT 0;
DECLARE Nett_Qty INT DEFAULT 0;
DECLARE BAG_NOS INT DEFAULT 0;
DECLARE MDA_Loaded_Qty INT DEFAULT 0;

DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
SET P_RESULT = 'E|Oops!... Something went wrong. Please Contact system administrator|0';
END;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

IF P_GATE_IN_ID > 0 AND CHAR_LENGTH(IFNULL(P_QR_CODE,'')) > 0 THEN

	-- Check the number of bottles per shipper
	SELECT PROD_PER_SHIPPER INTO Bottles_PER_SHIPPER FROM PRODUCT_MASTER X WHERE X.PROD_SYS_ID = P_PRODUCT_ID LIMIT 1;

	-- Check if the QR code is available in SHIPPER_QRCODE
	SELECT COUNT(*) INTO TEMP_NUM FROM SHIPPER_QRCODE X WHERE X.SHIPPER_QRCODE LIKE CONCAT('%', P_QR_Code) AND PLANT_ID = P_PLANT_ID;
	SET IsAvailable_ShipperQRCode = IF(IFNULL(TEMP_NUM,0) > 0, 1, 0);

	-- Check if the QR code is already scanned
	SELECT COUNT(*) INTO TEMP_NUM FROM QR_Code_SuccessList WHERE QRCODE LIKE CONCAT('%', P_QR_Code) AND PLANT_ID = P_PLANT_ID;
	SET IsAvailable_SuccessList = IF(IFNULL(TEMP_NUM,0) > 0, 1, 0);

	-- Calculate the total required shippers
	SELECT IF(IFNULL(BAG_NOS, 0) > 0, FLOOR(BAG_NOS / Bottles_PER_SHIPPER), 0) INTO Total_REQUIRED_SHIPPER FROM MDA_Detail X WHERE MDA_SYS_ID = P_MDA_ID AND PROD_SYS_ID = P_PRODUCT_ID AND PLANT_ID = P_PLANT_ID LIMIT 1;

	-- Count the total loaded shippers
	SELECT COUNT(*) INTO Total_LOADED_SHIPPER FROM MDA_Loading Z WHERE GATE_SYS_ID = P_GATE_IN_ID AND MDA_SYS_ID = P_MDA_ID AND PROD_SYS_ID = P_PRODUCT_ID AND PLANT_ID = P_PLANT_ID;

		-- Check various conditions to determine if the entry should be rejected or accepted
		IF Total_LOADED_SHIPPER >= Total_REQUIRED_SHIPPER OR IFNULL(IsAvailable_ShipperQRCode,0) <= 0 OR IFNULL(IsAvailable_SuccessList,0) > 0 THEN

			-- Reject Entry
			SET IsAvailable_QRCode = 1;
			SET P_RESULT = CASE
			WHEN IFNULL(IsAvailable_ShipperQRCode,0) <= 0 THEN 'QR code is not found in database'
			WHEN IFNULL(IsAvailable_SuccessList,0) > 0 THEN 'QR code already Scanned.'
			ELSE 'All Bottles are Loaded.'
			END;

			-- Insert into reject list log
			INSERT INTO QR_Code_RejectList_Log (PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_SYS_ID) 
			VALUES (P_PLANT_ID,2,P_QR_Code,P_PRODUCT_ID,P_MDA_ID);

			-- Insert into reject list
			INSERT INTO QR_Code_RejectList (PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_SYS_ID, Reason) 
			VALUES (P_PLANT_ID,2,P_QR_Code,P_PRODUCT_ID,P_MDA_ID,P_RESULT);

					SET TEMP_ID = LAST_INSERT_ID();
                     
			-- SET P_RESULT = CONCAT('E|', P_RESULT, '|0');
			SET P_RESULT = CONCAT('E|', P_RESULT, '|', TEMP_ID);
                    
		ELSEIF IFNULL(Bottles_PER_SHIPPER,0) > 0 AND IFNULL(IsAvailable_ShipperQRCode,0) > 0 AND IFNULL(IsAvailable_ShipperQRCode,0) <= 0 THEN
				
			-- Success Entry
			SET IsAvailable_QRCode = 0;

			-- Get the next MDA loading system ID
			SELECT IFNULL(MAX(MDA_LOD_SYS_ID), 0) + 1 INTO TEMP_NUM FROM MDA_Loading;

			-- Insert into MDA loading
			INSERT INTO MDA_Loading (PLANT_ID, MDA_LOD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER, SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, CREATED_DATETIME, IS_POSTED)                 
			VALUES (P_PLANT_ID, TEMP_NUM, P_GATE_IN_ID, P_MDA_ID, P_PRODUCT_ID , Total_REQUIRED_SHIPPER, Total_LOADED_SHIPPER , P_QR_Code, IS_MANUAL_SCAN, P_USER_ID, NOW(), 0);

			-- Insert into success list log
			INSERT INTO QR_Code_SuccessList_Log (PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_SYS_ID) 
			VALUES (P_PLANT_ID,NULL,P_QR_Code,P_PRODUCT_ID,P_MDA_ID);

			-- Insert into success list
			INSERT INTO QR_Code_SuccessList (PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_SYS_ID) 
			VALUES (P_PLANT_ID,NULL,P_QR_Code,P_PRODUCT_ID,P_MDA_ID);

					SET TEMP_ID = LAST_INSERT_ID();
                     
			-- SET P_RESULT = 'S|Valid QR Code|0';	
			SET P_RESULT = CONCAT('S|Valid QR Code|', TEMP_ID);
		END IF;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_QR_CODE_DELETE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_QR_CODE_DELETE(
    IN P_GATE_SYS_ID INT,
    IN P_MDA_SYS_ID INT,
    IN P_MDA_DTL_SYS_ID INT,
    IN P_PROD_SYS_ID INT,
    IN P_QR_CODE_IDS_S  VARCHAR(16000),
    IN P_QR_CODE_IDS_R  VARCHAR(16000),
    IN P_PLANT_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
                  
            DECLARE v_counter BIGINT DEFAULT 1;
            DECLARE v_id VARCHAR(255);
            DECLARE Concatenated_Result VARCHAR(255);
            
            DECLARE Total_Count BIGINT DEFAULT 0;
            DECLARE Success_Count BIGINT DEFAULT 0;
            DECLARE Reject_Count BIGINT DEFAULT 0;
            
            
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			-- Error handling
			GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
			#SELECT @sqlstate AS State, @errmsg AS Message;
			ROLLBACK;
		
			SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
		END;

		DROP TEMPORARY TABLE IF EXISTS TBL_MAIN;

		CREATE TEMPORARY TABLE TBL_MAIN AS
		SELECT * FROM (SELECT SID ID, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, 'S' LOG_Type, ENTRY_TIME FROM QR_CODE_SUCCESSLIST X 
						WHERE X.MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID AND PLANT_ID = P_PLANT_ID
						UNION ALL
						SELECT RID ID, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, 'R' LOG_Type, ENTRY_TIME FROM QR_CODE_REJECTLIST X 
						WHERE X.MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID AND PLANT_ID = P_PLANT_ID
        ) Z
		ORDER BY Z.ENTRY_TIME;

		SELECT COUNT(*) INTO Total_Count FROM TBL_MAIN;
		SELECT COUNT(*) INTO Success_Count FROM TBL_MAIN WHERE LOG_Type = 'S';
		SELECT COUNT(*) INTO Reject_Count FROM TBL_MAIN WHERE LOG_Type = 'R';

		SET Concatenated_Result = CONCAT(Total_Count, '#', Success_Count, '#', Reject_Count);

		SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator.#', Concatenated_Result, '|0');
        
        IF LENGTH(IFNULL(P_QR_CODE_IDS_S, '')) > 0 THEN
        
				SET v_counter = 1;
				SET v_id = REGEXP_SUBSTR(P_QR_CODE_IDS_S, '[^|]+', 1, v_counter);
                
				WHILE v_id IS NOT NULL DO
                
					IF IFNULL(v_id, '') != '' AND CAST(v_id AS UNSIGNED) > 0 THEN
						DELETE FROM qr_code_successlist WHERE SID = CAST(v_id AS UNSIGNED) AND MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID AND PLANT_ID = P_PLANT_ID;
					END IF;
				
					SET v_counter = v_counter + 1;
					SET v_id = REGEXP_SUBSTR(P_QR_CODE_IDS_S, '[^|]+', 1, v_counter);
                    
				END WHILE;
				
        END IF;
        
        IF LENGTH(IFNULL(P_QR_CODE_IDS_R, '')) > 0 THEN
        
				SET v_counter = 1;
				SET v_id = REGEXP_SUBSTR(P_QR_CODE_IDS_R, '[^|]+', 1, v_counter);
                
				WHILE v_id IS NOT NULL DO
                
					IF IFNULL(v_id, '') != '' AND CAST(v_id AS UNSIGNED) > 0 THEN
						DELETE FROM qr_code_rejectlist WHERE RID = CAST(v_id AS UNSIGNED) AND MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID AND PLANT_ID = P_PLANT_ID;
					END IF;
				
					SET v_counter = v_counter + 1;
					SET v_id = REGEXP_SUBSTR(P_QR_CODE_IDS_R, '[^|]+', 1, v_counter);
                    
				END WHILE;
				
        END IF;
        
		
        
        
		SET P_RESULT = CONCAT('S|Record delete successfully.#', Concatenated_Result, '|0');
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_QR_CODE_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_QR_CODE_GET(
    IN P_ID INT,
    IN P_REQUEST_NO VARCHAR(255),
    IN P_PO_NO VARCHAR(255),
    IN P_VENDOR_CODE VARCHAR(255),
    IN P_PROD_ID INT,
    IN P_FROM_DATE VARCHAR(255),
    IN P_TO_DATE VARCHAR(255),
    IN P_CONSIGNMENT_NO VARCHAR(255),
    IN P_TYPE VARCHAR(255),
    IN P_WITH_DTLS VARCHAR(255),
    IN P_SEARCH_TERM VARCHAR(255),
    IN P_DISPLAY_LENGTH INT,
    IN P_DISPLAY_START INT,
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #,OUT P_RESULT CURSOR,
    #OUT P_DTLS CURSOR
)
BEGIN
        
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        #SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|';
    END;

    IF P_ID > 0 THEN
        #OPEN P_RESULT FOR
        SELECT 
            X.QR_CODE_SYS_ID AS ID, 
            X.PLANT_ID, 
            X.VENDER_ID AS VENDOR_ID, 
            VM.VENDOR_CODE, 
            VM.ORGANIZATION_NAME AS VENDOR_NAME, 
            VS.SITE_ID, 
            VS.SITE_NAME AS VENDOR_SITE, 
            VS.PRIMARY_EMAIL AS VENDOR_EMAIL,
            X.VPO_SYS_ID, 
            PO.PO_NO, 
            PO.PO_DATE, 
            DATE_FORMAT(PO.PO_DATE, '%d/%m/%Y') AS PO_DATE_TEXT,
            REQUEST_NO, 
            REQUEST_DATE, 
            DATE_FORMAT(REQUEST_DATE, '%d/%m/%Y') AS REQUEST_DATE_TEXT, 
            REQUEST_STATUS, 
            (SELECT Z.LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'QR_GEN' AND Z.LOV_CODE = X.REQUEST_STATUS LIMIT 1) AS REQUEST_STATUS_TEXT,
            EXPECTED_DATE, 
            DATE_FORMAT(EXPECTED_DATE, '%d/%m/%Y') AS EXPECTED_DATE_TEXT,
            CONSIGNMENT_NO, 
            CONSIGNMENT_DATE, 
            DATE_FORMAT(CONSIGNMENT_DATE, '%d/%m/%Y') AS CONSIGNMENT_DATE_TEXT, 
            MODE_OF_DISPATCH, 
            ESTIMATE_DATE, 
            DATE_FORMAT(ESTIMATE_DATE, '%d/%m/%Y') AS ESTIMATE_DATE_TEXT, 
            SHIPMENT_DETAILS, 
            PRINT_NOTES,
            LINE_ITEM_NO, 
            LINE_ITEM_DESC, 
            PROD_SYS_ID, 
            SKU_DESC, 
            TOTAL_QTY, 
            REQUEST_QTY, 
            REMAIN_QTY, 
            QR_CODE_QTY_PER_FILE, 
            NO_OF_FILES, 
            UMO,
            CASE IS_FILE_EMAIL WHEN 1 THEN 'Send' ELSE 'Pending' END AS FILE_EMAIL_SEND, 
            IS_FILE_EMAIL, 
            IS_LOCK, 
            IS_PRINT_FINISHED
        FROM 
            QR_CODE_GENERATION X
        INNER JOIN 
            VENDOR_MASTER VM ON X.VENDER_ID = VM.VENDOR_SYS_ID
        INNER JOIN 
            VENDOR_PO_HDR PO ON X.VPO_SYS_ID = PO.VPO_SYS_ID
        INNER JOIN 
            SITE_MASTER VS ON X.VENDER_ID = VS.VENDER_ID AND PO.SITE_ID = VS.SITE_ID                                        
        WHERE 
            X.QR_CODE_SYS_ID = P_ID;

        #OPEN P_DTLS FOR
        SELECT 
            QRCD_SYS_ID AS ID, 
            QR_CODE_SYS_ID AS QR_CODE_GEN_ID, 
            PLANT_ID, 
            VENDER_ID, 
            VPO_SYS_ID, 
            QRCD_SERIAL_NO AS QTY, 
            QRCD_FILE_NAME AS FILE_NAME, 
            IS_DOWNLOADED, 
            CASE IS_DOWNLOADED WHEN 1 THEN 'Download' ELSE 'Pending' END AS STATUS_DOWNLOAD,
            IS_LOCK, 
            QRCD_SERIAL_FROM, 
            QRCD_SERIAL_TO
        FROM 
            QR_CODE_SERIAL_NO 
        WHERE 
            QR_CODE_SYS_ID = P_ID 
        ORDER BY 
            CREATED_DATETIME;
    ELSE
        #OPEN P_RESULT FOR
        SELECT 
            X.*, 
            (SELECT Z.LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'QR_GEN' AND Z.LOV_CODE = X.REQUEST_STATUS LIMIT 1) AS REQUEST_STATUS_TEXT,
            PM.PLANT_NAME, 
            PM.PLANTCODE AS PLANT_CODE
        FROM 
            (SELECT 
                ROWNUM RNUM, 
                ZZ.*
            FROM 
                (SELECT 
                    COUNT(*) OVER() AS COUNT_ROW, 
                    X.QR_CODE_SYS_ID AS ID, 
                    X.PLANT_ID, 
                    X.VENDER_ID AS VENDOR_ID, 
                    VM.VENDOR_CODE, 
                    VM.ORGANIZATION_NAME AS VENDOR_NAME, 
                    VS.SITE_ID, 
                    VS.SITE_NAME AS VENDOR_SITE, 
                    X.VPO_SYS_ID, 
                    PO.PO_NO, 
                    PO.PO_DATE, 
                    DATE_FORMAT(PO.PO_DATE, '%d/%m/%Y') AS PO_DATE_TEXT,
                    REQUEST_NO, 
                    REQUEST_DATE, 
                    DATE_FORMAT(REQUEST_DATE, '%d/%m/%Y') AS REQUEST_DATE_TEXT, 
                    REQUEST_STATUS, 
                    EXPECTED_DATE, 
                    DATE_FORMAT(EXPECTED_DATE, '%d/%m/%Y') AS EXPECTED_DATE_TEXT, 
                    CONSIGNMENT_NO, 
                    CONSIGNMENT_DATE, 
                    DATE_FORMAT(CONSIGNMENT_DATE, '%d/%m/%Y') AS CONSIGNMENT_DATE_TEXT, 
                    MODE_OF_DISPATCH, 
                    ESTIMATE_DATE, 
                    DATE_FORMAT(ESTIMATE_DATE, '%d/%m/%Y') AS ESTIMATE_DATE_TEXT, 
                    SHIPMENT_DETAILS, 
                    PRINT_NOTES,
                    LINE_ITEM_NO, 
                    LINE_ITEM_DESC, 
                    PROD_SYS_ID, 
                    SKU_DESC, 
                    TOTAL_QTY, 
                    REQUEST_QTY, 
                    REMAIN_QTY, 
                    QR_CODE_QTY_PER_FILE, 
                    NO_OF_FILES, 
                    UMO,
                    CASE IS_FILE_EMAIL WHEN 1 THEN 'Send' ELSE 'Pending' END AS FILE_EMAIL_SEND, 
                    IS_FILE_EMAIL, 
                    IS_LOCK, 
                    IS_PRINT_FINISHED
                FROM 
                    QR_CODE_GENERATION X
                INNER JOIN 
                    VENDOR_MASTER VM ON X.VENDER_ID = VM.VENDOR_SYS_ID
                INNER JOIN 
                    VENDOR_PO_HDR PO ON X.VPO_SYS_ID = PO.VPO_SYS_ID
                INNER JOIN 
                    SITE_MASTER VS ON X.VENDER_ID = VS.VENDER_ID AND PO.SITE_ID = VS.SITE_ID
                WHERE 
                    X.PLANT_ID = IFNULL(P_PLANT_ID, X.PLANT_ID) 
                    AND X.REQUEST_NO = IFNULL(P_REQUEST_NO, X.REQUEST_NO)
                    AND PO.PO_NO = IFNULL(P_PO_NO, PO.PO_NO)
                    AND VM.VENDOR_CODE = IFNULL(P_VENDOR_CODE, VM.VENDOR_CODE)
                    AND X.PROD_SYS_ID = IFNULL(P_PROD_ID, X.PROD_SYS_ID)
                    AND IFNULL(P_FROM_DATE, '') = '' OR (X.REQUEST_DATE >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y'))
                    AND IFNULL(P_TO_DATE, '') = '' OR (X.REQUEST_DATE <= STR_TO_DATE(P_TO_DATE, '%d/%m/%Y'))
                    AND IFNULL(P_TYPE, '') = '' OR (P_TYPE = 'RECEIPT' AND REQUEST_STATUS = 'DISP') 
                                                    OR (P_TYPE = 'DISPATCH' AND REQUEST_STATUS = 'PRNT') 
                                                    OR (P_TYPE = 'SEARCH') 
                                                    OR (P_TYPE = 'PRINT' AND REQUEST_STATUS = 'EMAL')
                    AND IFNULL(P_SEARCH_TERM, '') = '' OR (UPPER(X.REQUEST_NO) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%') 
                                                           OR UPPER(PO.PO_NO) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%') 
                                                           OR UPPER(VM.VENDOR_CODE) LIKE CONCAT('%', UPPER(P_SEARCH_TERM), '%'))
                ORDER BY 
                    X.REQUEST_DATE DESC
            ) ZZ
        ) X
        LEFT JOIN 
            PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
        WHERE 
            IFNULL(P_DISPLAY_LENGTH, 0) = 0 OR (RNUM <= (P_DISPLAY_LENGTH + P_DISPLAY_START) AND RNUM > P_DISPLAY_START);
    END IF;

   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_REPORT_DISPATCH_SUMMARY_NEW */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_REPORT_DISPATCH_SUMMARY_NEW(
    IN P_REPORT_TYPE VARCHAR(255),
    IN P_MDA_NO VARCHAR(255),
    IN P_TRUCK_NO VARCHAR(255),
    IN P_PARTY_NAME VARCHAR(255),
    IN P_DESTINATION VARCHAR(255),
    IN P_FROM_DATE VARCHAR(255),
    IN P_TO_DATE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN

-- Assuming TEMP_PAGE_TITLE and the parameters are declared somewhere in the procedure
DECLARE TEMP_PAGE_TITLE VARCHAR(1000);

SET TEMP_PAGE_TITLE = '';

IF IFNULL(P_MDA_NO, '') != '' THEN 
    SET TEMP_PAGE_TITLE = CONCAT(TEMP_PAGE_TITLE, 'MDA No. : ', P_MDA_NO); 
END IF;

IF IFNULL(P_TRUCK_NO, '') != '' THEN 
    SET TEMP_PAGE_TITLE = CONCAT(TEMP_PAGE_TITLE, 
                                 CASE WHEN LENGTH(TEMP_PAGE_TITLE) = 0 THEN '' ELSE ' ' END, 
                                 'Vehicle No. : ', P_TRUCK_NO); 
END IF;

IF IFNULL(P_PARTY_NAME, '') != '' THEN 
    SET TEMP_PAGE_TITLE = CONCAT(TEMP_PAGE_TITLE, 
                                 CASE WHEN LENGTH(TEMP_PAGE_TITLE) = 0 THEN '' ELSE ' ' END, 
                                 'Party Name : ', P_PARTY_NAME); 
END IF;

IF IFNULL(P_DESTINATION, '') != '' THEN 
    SET TEMP_PAGE_TITLE = CONCAT(TEMP_PAGE_TITLE, 
                                 CASE WHEN LENGTH(TEMP_PAGE_TITLE) = 0 THEN '' ELSE ' ' END, 
                                 'Destination : ', P_DESTINATION); 
END IF;

IF IFNULL(P_FROM_DATE, '') != '' AND IFNULL(P_TO_DATE, '') != '' THEN 
    SET TEMP_PAGE_TITLE = CONCAT(TEMP_PAGE_TITLE, 
                                 CASE WHEN LENGTH(TEMP_PAGE_TITLE) = 0 THEN '' ELSE ' ' END, 
                                 'Date : ', P_FROM_DATE); 
END IF;

IF IFNULL(P_FROM_DATE, '') != '' AND IFNULL(P_TO_DATE, '') != '' THEN 
    SET TEMP_PAGE_TITLE = CONCAT(TEMP_PAGE_TITLE, 
                                 CASE WHEN LENGTH(TEMP_PAGE_TITLE) = 0 THEN '' ELSE ' ' END, 
                                 ' To ', P_TO_DATE); 
END IF;

IF IFNULL(P_FROM_DATE, '') != '' AND IFNULL(P_TO_DATE, '') = '' THEN 
    SET TEMP_PAGE_TITLE = CONCAT(TEMP_PAGE_TITLE, 
                                 CASE WHEN LENGTH(TEMP_PAGE_TITLE) = 0 THEN '' ELSE ' ' END, 
                                 'After Date ', P_FROM_DATE); 
END IF;

IF IFNULL(P_FROM_DATE, '') = '' AND IFNULL(P_TO_DATE, '') != '' THEN 
    SET TEMP_PAGE_TITLE = CONCAT(TEMP_PAGE_TITLE, 
                                 CASE WHEN LENGTH(TEMP_PAGE_TITLE) = 0 THEN '' ELSE ' ' END, 
                                 'Before Date : ', P_TO_DATE); 
END IF;

SELECT TEMP_PAGE_TITLE AS MAIN_HEADER;


WITH TBL_MAIN AS (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
                    , X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
                    , X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
                    , Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
            FROM fg_gate_in_out X, 
            (SELECT Z.* FROM mda_header Z
                WHERE Z.PLANT_ID =  4
                -- AND 1 = (CASE WHEN LENGTH(IFNULL( P_SEARCH_TERM,'')) > 0 THEN (CASE WHEN UPPER(Z.MDA_NO) = UPPER(IFNULL( P_SEARCH_TERM,'')) OR UPPER(Z.VEHICLE_NO) = UPPER(IFNULL( P_SEARCH_TERM,'')) OR UPPER(Z.PARTY_NAME) = UPPER(IFNULL( P_SEARCH_TERM,''))  OR UPPER(Z.desp_place) = UPPER(IFNULL( P_SEARCH_TERM,'')) THEN 1 ELSE 0 END) ELSE 1 END)
                AND 1 = (CASE WHEN LENGTH(IFNULL( P_TRUCK_NO,'')) > 0 THEN (CASE WHEN UPPER(Z.VEHICLE_NO) = UPPER(IFNULL( P_TRUCK_NO,'')) THEN 1 ELSE 0 END) ELSE 1 END)
                               AND 1 = (CASE WHEN LENGTH(IFNULL( P_PARTY_NAME,'')) > 0 THEN (CASE WHEN UPPER(Z.PARTY_NAME) = UPPER(IFNULL( P_PARTY_NAME,'')) THEN 1 ELSE 0 END) ELSE 1 END)
                               AND 1 = (CASE WHEN LENGTH(IFNULL( P_DESTINATION,'')) > 0 THEN (CASE WHEN UPPER(Z.desp_place) = UPPER(IFNULL( P_DESTINATION,'')) THEN 1 ELSE 0 END) ELSE 1 END)
                               AND 1 = (CASE WHEN LENGTH(IFNULL( P_MDA_NO,'')) > 0 THEN (CASE WHEN UPPER(Z.MDA_NO) = UPPER(IFNULL( P_MDA_NO,'')) THEN 1 ELSE 0 END) ELSE 1 END)
            AND 1 = (CASE WHEN LENGTH(IFNULL( P_FROM_DATE,'')) > 0 THEN (CASE WHEN (DATEDIFF(DATE(Z.MDA_DT), STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y'))) >= 0  THEN 1 ELSE 0 END) ELSE 1/*(CASE WHEN (DATEDIFF(DATE(Z.MDA_DT), DATE_SUB(CURDATE(), INTERVAL 30 DAY))) >= 0  THEN 1 ELSE 0 END)*/ END)
            AND 1 = (CASE WHEN LENGTH(IFNULL( P_TO_DATE,'')) > 0 THEN (CASE WHEN (DATEDIFF(DATE(Z.MDA_DT), STR_TO_DATE(P_TO_DATE, '%d/%m/%Y'))) <= 0  THEN 1 ELSE 0 END) ELSE 1/*(CASE WHEN (DATEDIFF(DATE(Z.MDA_DT), CURDATE())) <= 0  THEN 1 ELSE 0 END)*/ END)
            ) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.VEHICLE_NO AND X.MDA_SYS_ID=Y.MDA_SYS_ID)
, TBL_MB AS (SELECT XZ.MDA_SYS_ID, GROUP_CONCAT(XZ.batch_no ORDER BY XZ.batch_no SEPARATOR ', ') AS BATCH_NO
					, GROUP_CONCAT(DATE_Format(MFG_DATE,'%d/%m/%Y') ORDER BY XZ.batch_no SEPARATOR ', ') AS MFG_DATE
                    , COUNT(*) AS Shipper_Qty, COUNT(*) * 24 AS Bottle_Qty
				FROM (SELECT ML.MDA_SYS_ID, SQA.batch_no, SQA.MFG_DATE
				FROM MDA_LOADING ML
				LEFT JOIN SHIPPER_QRCODE SQ ON SQ.shipper_qrcode = ML.shipper_qr_code
				LEFT JOIN SHIPPER_QRCODE_API SQA ON SQA.SHIPPER_QRCODE_API_SYSID = SQ.SHIPPER_QRCODE_API_SYSID
				WHERE (ML.PLANT_ID, ML.MDA_SYS_ID) IN (SELECT DISTINCT PLANT_ID, MDA_SYS_ID FROM TBL_MAIN)
				GROUP BY ML.MDA_SYS_ID, SQA.batch_no, SQA.MFG_DATE 
				ORDER BY ML.MDA_SYS_ID, SQA.batch_no, SQA.MFG_DATE ) XZ
				GROUP BY XZ.MDA_SYS_ID
			)
#######################################################################################################################################
SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, X.MDA_NO, X.VEHICLE_NO, MB.BATCH_NO, MB.MFG_DATE, MB.Shipper_Qty, MB.Bottle_Qty
, DATE_FORMAT(X.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT, 'Dispatch' AS TRANSACTIONTYPE
, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i')  AS DISP_DATE_TIME, 'Plant' AS DISPATCHFROMTYPE
, Z.SKU_CODE AS ARTICLECODE, Z.SKU_NAME AS ARTICLENAME, PL.PLANTCODE ||' '||PL.PLANT_NAME AS DISPATCHFROMCODENAME,'Warehouse/FSC' AS DISPATCHTOTYPE, '' AS  DISPATCHTOCODENAME
, (MR.LOADED_ITEM*24)/2 AS DISPATCHEDQTYKL, MR.LOADED_ITEM AS DISPATCHEDQTYSHIPPER, (MR.LOADED_ITEM*24) AS DISPATCHEDQTYUNITS
, IFNULL(MR.LOADING_BAY,'DLA02')LOADING_BAY
, X.PARTY_NAME,X.desp_place Destination,NULL address
FROM TBL_MAIN X
LEFT JOIN TBL_MB MB ON MB.MDA_SYS_ID = X.MDA_SYS_ID
LEFT JOIN MDA_REQUISITION_DATA MR ON X.PLANT_ID=MR.PLANT_ID AND X.GATE_SYS_ID=MR.GATE_SYS_ID -- AND X.MDA_SYS_ID=MR.MDA_SYS_ID
LEFT JOIN MDA_DETAIL Y ON Y.PLANT_ID=X.PLANT_ID AND Y.MDA_SYS_ID = X.MDA_SYS_ID
LEFT JOIN PRODUCT_MASTER Z ON Z.PLANT_ID=X.PLANT_ID AND Z.PROD_SYS_ID = Y.PROD_SYS_ID
LEFT JOIN PLANT_MASTER  PL ON X.PLANT_ID = PL.PLANTID
ORDER BY X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, X.MDA_NO, X.VEHICLE_NO;
            
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_REPORT_GATE_IN_OUT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_REPORT_GATE_IN_OUT(
IN P_SEARCHTERM VARCHAR(20),
IN P_TYPE VARCHAR(20),
IN P_PLANT_ID BIGINT
)
BEGIN




WITH TBL_MAIN AS (SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, MDA_DT, TRANS_SYS_ID, INWARD_SYS_ID
					, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION
					, RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD, IS_GOODS_TRANSFER
					, DI_NO, PLANT_CD, WH_CD, PARTY_NAME, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, OUT_TIME, desp_place
						FROM (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
						, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
						, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
						, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
								FROM fg_gate_in_out X, 
								(SELECT Z.* FROM mda_header Z
									WHERE Z.PLANT_ID = P_PLANT_ID AND Z.MDA_NO = P_SEARCHTERM -- (
                                    -- Z.VEHICLE_NO = P_SEARCHTERM
									-- OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM OR XZ.MDA_SYS_ID = 0) 
									#OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.GATE_SYS_ID = 0 OR XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = 'RJ31GB0918'))
								-- )
                                ) Y WHERE X.TRUCK_NO = Y.VEHICLE_NO AND X.PLANT_ID = P_PLANT_ID 
                                AND X.MDA_SYS_ID = Y.MDA_SYS_ID  -- Added by ashish 
							) M_G
					)
SELECT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID ID, X.MDA_SYS_ID, X.MDA_NO, X.VEHICLE_NO
, DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(X.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
, X.TRANS_SYS_ID, X.INWARD_SYS_ID
, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD
, X.IS_GOODS_TRANSFER, NULL AS IS_UNLOAD_TRUCK, NULL AS VENDOR_SYS_ID, NULL AS CUST_SITE_CD, NULL AS SITE_NAME
, X.DI_NO, X.PLANT_CD, X.WH_CD, X.PARTY_NAME, X.DIST
, Y.PROD_SYS_ID, PRD_CD, PRD_DESC, X.BAG_NOS, (X.BAG_NOS / 24) AS Required_SHIPPER
, (SELECT COUNT(*) FROM mda_loading Z WHERE Z.MDA_SYS_ID  = X.MDA_SYS_ID)LOADED_SHIPPER
, X.NETT_QTY, X.GROSS_QTY, X.ECHIT_NO, X.GST_NO, X.OUT_TIME, X.desp_place
FROM TBL_MAIN X
LEFT JOIN MDA_DETAIL Y ON Y.MDA_SYS_ID = X.MDA_SYS_ID
LEFT JOIN PRODUCT_MASTER Z ON Z.PROD_SYS_ID = Y.PROD_SYS_ID;

IF IFNULL(P_TYPE, '') = '' THEN
	WITH TBL_MAIN AS (SELECT (ROW_NUMBER() OVER ()) AS RNUM, M_G.PLANT_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO
						##########################
						, ML.SHIPPER_QR_CODE, SQA.BATCH_NO, DATE_FORMAT(SQA.mfg_date, '%d/%m/%Y %H:%i') AS mfg_date, DATE_FORMAT(SQA.expiry_date, '%d/%m/%Y %H:%i') AS expiry_date
                        , SUM(COUNT(ML.SHIPPER_QR_CODE)) OVER () AS COUNT_ROW#LOADED_SHIPPER 
						FROM (SELECT DISTINCT X.PLANT_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO 
						FROM fg_gate_in_out X, 
							(SELECT Z.* FROM mda_header Z
									WHERE Z.PLANT_ID = P_PLANT_ID AND Z.MDA_NO = P_SEARCHTERM /*AND (Z.VEHICLE_NO = P_SEARCHTERM
									OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM OR XZ.MDA_SYS_ID = 0) 
									#OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.GATE_SYS_ID = 0 OR XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = 'RJ31GB0918'))
								)*/) Y WHERE X.TRUCK_NO = Y.VEHICLE_NO AND X.PLANT_ID = Y.PLANT_ID and Y.MDA_SYS_ID = X.MDA_SYS_ID ) M_G
						########################## and Y.MDA_SYS_ID = X.MDA_SYS_ID -- added by ashish 
						INNER JOIN MDA_LOADING ML ON ML.MDA_SYS_ID = M_G.MDA_SYS_ID
						LEFT JOIN SHIPPER_QRCODE SQ ON SQ.PLANT_ID = M_G.PLANT_ID AND SQ.SHIPPER_QRCODE = ML.SHIPPER_QR_CODE
						LEFT JOIN SHIPPER_QRCODE_API SQA ON SQA.PLANT_ID = M_G.PLANT_ID AND SQA.SHIPPER_QRCODE_API_SYSID = SQ.SHIPPER_QRCODE_API_SYSID
						GROUP BY M_G.PLANT_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO, ML.SHIPPER_QR_CODE, SQA.BATCH_NO, SQA.expiry_date, SQA.mfg_date
		)
		SELECT RNUM SR_NO, COUNT_ROW, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, VEHICLE_NO, SHIPPER_QR_CODE, BATCH_NO, mfg_date, expiry_date FROM TBL_MAIN ;
ELSEIF IFNULL(P_TYPE, '') = 'R' THEN
		SELECT (ROW_NUMBER() OVER ()) AS SR_NO, NULL COUNT_ROW, NULL GATE_SYS_ID, NULL MDA_SYS_ID, NULL MDA_NO, NULL VEHICLE_NO
        , QRCODE as SHIPPER_QR_CODE, REJECT_REASON 
        FROM qr_code_rejectlist where MDA_NO = P_SEARCHTERM;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_REPORT_WEIGHT_IN_OUT_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_REPORT_WEIGHT_IN_OUT_GET(
IN P_GATE_SYS_ID INT
, IN P_SEARCHTERM VARCHAR(255)
, IN P_FROMDATE VARCHAR(255)
, IN P_TODATE VARCHAR(255)
, IN P_IS_OUT_TIME_NULL INT
, IN P_PLANT_ID INT)
BEGIN

SET @rownum := 0;

WITH TBL_MAIN AS (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, MH.MDA_SYS_ID, MH.MDA_NO, X.TRUCK_NO VEHICLE_NO, MH.PLANT_CD
		, GATE_IN_DT, GATE_OUT_DT, MH.MDA_DT
		, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
		, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DIST,MH.desp_place, X.RFSYSID
		FROM fg_gate_in_out X
		INNER JOIN mda_header MH ON MH.PLANT_ID = X.PLANT_ID AND (CASE WHEN IFNULL(P_GATE_SYS_ID,0) > 0 OR IFNULL(P_SEARCHTERM,'') != '' THEN TRUCK_NO = VEHICLE_NO
																		WHEN IFNULL(P_GATE_SYS_ID,0) = 0 THEN  MH.MDA_SYS_ID = X.MDA_SYS_ID 
                                                                        ELSE FALSE END)
									AND (CASE WHEN IFNULL(P_IS_OUT_TIME_NULL,0) = 1 THEN MH.OUT_TIME IS NULL ELSE TRUE END)
		WHERE X.PLANT_ID = 4 AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_IN_DT IS NOT NULL 
        AND ((MH.VEHICLE_NO, MH.MDA_DT) IN (SELECT VEHICLE_NO, MDA_DT FROM mda_header MHZ WHERE MHZ.MDA_NO = P_SEARCHTERM)
        OR (CASE WHEN IFNULL(P_SEARCHTERM,'') != '' THEN X.TRUCK_NO = P_SEARCHTERM
				  WHEN IFNULL(P_GATE_SYS_ID,0) > 0 THEN X.GATE_SYS_ID = P_GATE_SYS_ID
				  WHEN IFNULL(P_GATE_SYS_ID,0) = 0 AND IFNULL(P_IS_OUT_TIME_NULL,0) = 0 THEN (GATE_IN_DT >= STR_TO_DATE(P_FROMDATE, '%d/%m/%Y') AND GATE_IN_DT < STR_TO_DATE(P_TODATE, '%d/%m/%Y') + INTERVAL 1 DAY
					  OR GATE_OUT_DT >= STR_TO_DATE(P_FROMDATE, '%d/%m/%Y') AND GATE_OUT_DT < STR_TO_DATE(P_TODATE, '%d/%m/%Y') + INTERVAL 1 DAY)
				  ELSE FALSE END))
        ORDER BY 3 DESC, 4 DESC
)
SELECT (@rownum := @rownum + 1) SR_NO, X.* FROM (
SELECT M_G.PLANT_ID, M_G.STATION_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO TRUCK_NO
, DATE_FORMAT(M_G.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(M_G.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
, MD.BAG_NOS, (MD.BAG_NOS / 24) Required_Shipper, (SELECT COUNT(*) FROM MDA_LOADING Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND Z.GATE_SYS_ID = M_G.GATE_SYS_ID AND Z.MDA_SYS_ID = M_G.MDA_SYS_ID) Loaded_Shipper
, ZZ.TARE_WT, ZZ.GROSS_WT, ZZ.NET_WT, ZZ.TOLERANCE_WT, ZZ.TARE_WT_NOTE, ZZ.GROSS_WT_NOTE
, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT
, MD.PROD_SYS_ID, SKU_CODE, SKU_NAME, PRD_CD, PRD_DESC
, M_G.DRIVER_ID_NUMBER, IFNULL(M_G.DRIVER_NAME, M_G.DRIVER_NAME_NEW)DRIVER_NAME, IFNULL(M_G.DRIVER_CONTACT, M_G.DRIVER_CONTACT_NEW)DRIVER_CONTACT, DRIVER_CHANGED, TRUCK_VALIDATION
, M_G.TRANS_SYS_ID, TM.tptr_cd, TM.TPTR_NAME, M_G.WH_CD, M_G.PARTY_NAME, M_G.DIST, M_G.desp_place, M_G.RFSYSID, RM.RFIDSRNO, NULL STATUS, NULL Skip_LILO_Remarks
FROM TBL_MAIN M_G
INNER JOIN mda_detail MD ON MD.PLANT_ID = M_G.PLANT_ID AND MD.MDA_SYS_ID = M_G.MDA_SYS_ID
INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = M_G.GATE_SYS_ID AND ZZ.STATION_ID = M_G.STATION_ID AND ZZ.PLANT_ID = M_G.PLANT_ID
INNER JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = M_G.PLANT_ID AND TM.TRANS_SYS_ID = M_G.TRANS_SYS_ID
LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = M_G.PLANT_ID AND PM.PROD_SYS_ID = MD.PROD_SYS_ID
LEFT JOIN rfid_master RM ON RM.PLANT_ID = M_G.PLANT_ID AND RM.RFSYSID = M_G.RFSYSID 
WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL 
ORDER BY M_G.GATE_IN_DT  DESC, M_G.GATE_OUT_DT  DESC, M_G.MDA_DT  DESC
) X;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_RFID_DELETE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_RFID_DELETE(
    IN P_ID INT,
    IN P_ISACTIVE VARCHAR(1),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_NUM INT;
    
     DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|';
    END;

    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact system administrator|0';

    IF NVL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        SET P_RESULT := 'E|You are not authorized to perform this operation.|0';
    ELSE
        IF P_ID > 0 THEN
            UPDATE RFID_MASTER_TEMP SET IS_ACTIVE = 'N' WHERE RFSYSID = P_ID;

            SET P_RESULT := 'S|Record deleted successfully|';
        END IF;
    END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_RFID_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_RFID_GET(
    IN P_ID INT,
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
IF P_ID < 0 THEN
SELECT CONCAT('KL', LPAD((COALESCE(MAX(RFSYSID),0) + 1), 5, '0')) AS SRNO 
FROM RFID_MASTER 
WHERE PLANT_ID = P_PLANT_ID;
ELSEIF P_ID > 0 THEN
SELECT RFSYSID ID, RFIDSRNO SRNO, RFIDCODE CODE, STATUS, REASONFOREDIT, STATION_ID, PLANT_ID#, IF(X.IS_ACTIVE='Y', 1, 0) ISACTIVE  
FROM RFID_MASTER X 
WHERE X.RFSYSID = P_ID 
#AND X.IS_ACTIVE = IF(COALESCE(P_ISACTIVE, '')='', X.IS_ACTIVE, P_ISACTIVE) 
AND PLANT_ID = P_PLANT_ID;
ELSE
SELECT RFSYSID ID, RFIDSRNO SRNO, RFIDCODE CODE, STATUS, REASONFOREDIT, STATION_ID, PLANT_ID#, IF(X.IS_ACTIVE='Y', 1, 0) ISACTIVE  
FROM RFID_MASTER X 
#WHERE X.IS_ACTIVE = IF(COALESCE(P_ISACTIVE, '')='', X.IS_ACTIVE, P_ISACTIVE) 
WHERE PLANT_ID = P_PLANT_ID;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_RFID_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_RFID_SAVE(
IN P_ID INT, 
IN P_STATION_ID INT, 
IN P_RFIDCODE VARCHAR(255),
IN P_RFIDSRNO VARCHAR(255), 
IN P_STATUS VARCHAR(255), 
IN P_REASONFOREDIT VARCHAR(255),  
IN P_ISACTIVE VARCHAR(255), 
IN P_PLANT_ID INT, 
IN P_USER_ID INT, 
IN P_ROLE_ID INT, 
IN P_MENU_ID INT, 
OUT P_RESULT VARCHAR(255)
)
BEGIN
DECLARE TEMP_NUM INT DEFAULT 0;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';
END;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

SELECT COUNT(*) INTO TEMP_NUM FROM RFID_MASTER_TEMP X WHERE X.RFIDCODE = P_RFIDCODE AND X.RFSYSID != P_ID;

IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
SET P_RESULT = 'E|You are not authorize to perform this operation.|0';    
ELSEIF COALESCE(TEMP_NUM, 0) > 0 THEN
SET P_RESULT = 'E|RFID is already exist.|0';    
ELSEIF P_ID > 0 THEN

UPDATE RFID_MASTER_TEMP SET RFIDCODE = P_RFIDCODE, RFIDSRNO = P_RFIDSRNO, STATUS = P_STATUS, REASONFOREDIT = P_REASONFOREDIT, STATION_ID = P_STATION_ID, IS_ACTIVE = P_ISACTIVE
WHERE RFSYSID = P_ID;

SET P_RESULT = 'S|Record updated successfully|';

ELSE

SELECT COALESCE(MAX(RFSYSID), 0) + 1 INTO TEMP_NUM FROM RFID_MASTER_TEMP;

INSERT INTO RFID_MASTER_TEMP (RFSYSID, RFIDSRNO, RFIDCODE, STATUS, REASONFOREDIT, STATION_ID, PLANT_ID, IS_ACTIVE, CREATED_BY, CREATED_DATETIME)
VALUES(TEMP_NUM, P_RFIDSRNO, P_RFIDCODE, P_STATUS, P_REASONFOREDIT, P_STATION_ID, P_PLANT_ID, P_ISACTIVE, P_USER_ID, NOW());

SET P_RESULT = 'S|Record saved successfully|';
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_RM_GATE_IN_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_RM_GATE_IN_SAVE(
IN `P_ID` INT,
IN `P_INWARD_SYS_ID` INT,
IN `P_COMMON_SYS_ID` INT,
IN `P_COMMON_NO` VARCHAR(255),
IN `P_TRANSPORTER_NAME` VARCHAR(255),
IN `P_TRUCK_NO` VARCHAR(255),
IN `P_DRIVER_ID_TYPE` VARCHAR(255),
IN `P_DRIVER_ID_NUMBER` VARCHAR(255),
IN `P_DRIVER_NAME` VARCHAR(255),
IN `P_DRIVER_CONTACT` VARCHAR(255),
IN `P_DRIVER_CHANGED` INT,
IN `P_DRIVER_NAME_NEW` VARCHAR(255),
IN `P_DRIVER_CONTACT_NEW` VARCHAR(255),
IN `P_TRUCK_VALIDATION` INT,
IN `P_RFSYSID` VARCHAR(255),
IN `P_RFID_CODE` VARCHAR(255),
IN `P_RFID_SRNO` VARCHAR(255),
IN `P_RFID_RECEIVE` INT,
IN `P_STATION_ID` INT,
IN `P_ISACTIVE` VARCHAR(255),
IN `P_PLANT_ID` INT,
IN `P_USER_ID` INT,
IN `P_ROLE_ID` INT,
IN `P_MENU_ID` INT,
OUT `P_RESULT` VARCHAR(255)
)
BEGIN
DECLARE TEMP_NUM INT DEFAULT 0;
DECLARE TEMP_COMMON_SYS_ID INT DEFAULT 0;
DECLARE TEMP_RFSYSID INT DEFAULT 0;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

IF COALESCE(P_COMMON_SYS_ID, 0) = 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 THEN
SELECT COUNT(*) INTO TEMP_NUM FROM po_header WHERE PO_NO = P_COMMON_NO;
IF COALESCE(TEMP_NUM, 0) > 0 THEN
SELECT PO_SYS_ID INTO TEMP_COMMON_SYS_ID FROM po_header WHERE PO_NO = P_COMMON_NO LIMIT 1;
END IF;
SET TEMP_NUM = 0;
ELSE
SET TEMP_COMMON_SYS_ID = P_COMMON_SYS_ID;
END IF;

IF COALESCE(P_RFSYSID, 0) <= 0 AND (LENGTH(COALESCE(P_RFID_CODE, '')) > 0 OR LENGTH(COALESCE(P_RFID_SRNO, '')) > 0) THEN
	#SELECT COUNT(*) INTO TEMP_NUM FROM RFID_MASTER WHERE STATUS IN ('Active', 'A') AND (RFIDCODE = COALESCE(P_RFID_CODE, RFIDCODE) OR RFIDSRNO = COALESCE(P_RFID_SRNO, RFIDCODE));
    SELECT COUNT(*) INTO TEMP_NUM FROM RFID_MASTER WHERE STATUS IN ('Active', 'A') AND RFIDSRNO = P_RFID_SRNO;
	IF COALESCE(TEMP_NUM, 0) > 0 THEN
		SELECT RFSYSID INTO TEMP_RFSYSID FROM RFID_MASTER WHERE STATUS IN ('Active', 'A') AND RFIDSRNO = P_RFID_SRNO  LIMIT 1;
	END IF;
		SET TEMP_NUM = 0;
ELSE
	SET TEMP_RFSYSID = P_RFSYSID;
END IF;

SELECT COUNT(*) INTO TEMP_NUM FROM rm_gate_in_out WHERE DATE(GATE_IN_DT) = DATE(CURRENT_DATE) AND INWARD_SYS_ID = COALESCE(P_INWARD_SYS_ID, 0) 
		AND PO_SYS_ID = COALESCE(TEMP_COMMON_SYS_ID, 0) AND GATE_SYS_ID != COALESCE(P_ID, 0);

IF COALESCE(TEMP_NUM, 0) > 0 THEN
SET P_RESULT = 'E|Entered Gate In details already exist.|0';
ELSEIF COALESCE(TEMP_RFSYSID, 0) = 0 THEN
SET P_RESULT = 'E|RFID does not exist or already assigned.|0';
ELSEIF COALESCE(TEMP_COMMON_SYS_ID, 0) = 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 THEN
SET P_RESULT = 'E|MDA No. does not exist.|0';
ELSEIF P_ID > 0 AND COALESCE(TEMP_COMMON_SYS_ID, 0) > 0 THEN
SET P_RESULT = 'S|Record updated successfully|';

ELSEIF COALESCE(TEMP_COMMON_SYS_ID, 0) > 0 THEN
IF COALESCE(P_INWARD_SYS_ID, 0) > 0 THEN
SELECT COALESCE(MAX(GATE_SYS_ID), 0) + 1 INTO TEMP_NUM FROM rm_gate_in_out;

INSERT INTO rm_gate_in_out (
GATE_SYS_ID, GATE_IN_DT, INWARD_SYS_ID, PO_SYS_ID, TRANSPORTER_NAME, TRUCK_NO, 
DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, 
DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION,
RFSYSID, RFID_RECEIVE, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME
)
VALUES (
TEMP_NUM, NOW(), P_INWARD_SYS_ID, TEMP_COMMON_SYS_ID, P_TRANSPORTER_NAME, P_TRUCK_NO, 
P_DRIVER_ID_TYPE, P_DRIVER_ID_NUMBER, P_DRIVER_NAME, P_DRIVER_CONTACT, 
IFNULL(P_DRIVER_CHANGED, 0), P_DRIVER_NAME_NEW, P_DRIVER_CONTACT_NEW, IFNULL(P_TRUCK_VALIDATION, 0),
IFNULL(TEMP_RFSYSID, 0), IFNULL(P_RFID_RECEIVE, 0), P_STATION_ID, P_PLANT_ID, P_USER_ID, NOW()
);

UPDATE RFID_MASTER SET STATUS = 'Assigned' WHERE RFSYSID = TEMP_RFSYSID;

SET P_RESULT = 'S|Record saved successfully|';
END IF;


END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_ROLE_DELETE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_ROLE_DELETE(
	IN P_ID BIGINT,
    IN P_ISACTIVE VARCHAR(1),
	IN P_PLANT_ID BIGINT,
    IN P_USER_ID BIGINT,
    IN P_ROLE_ID BIGINT,
    IN P_MENU_ID BIGINT,
    OUT P_RESULT VARCHAR(16300)
)
BEGIN
             
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;


	START TRANSACTION;
		SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
		
        IF P_ID > 0 THEN
			
            DELETE FROM ROLE_MASTER_NEW
			WHERE ROLE_ID = P_ID
			AND IS_ACTIVE = IF(COALESCE(P_ISACTIVE, '') = '', IS_ACTIVE, P_ISACTIVE);
            
            SET P_RESULT = 'S|Record deleted successfully|';
		END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_ROLE_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_ROLE_GET(
	IN P_ID BIGINT,
    IN P_ISACTIVE VARCHAR(2),
	IN P_PLANT_ID BIGINT,
    IN P_USER_ID BIGINT,
    IN P_ROLE_ID BIGINT,
    IN P_MENU_ID BIGINT
)
BEGIN

DECLARE STRMENUS VARCHAR(2000);
DECLARE STRMENUS_NAME VARCHAR(2000);

IF P_ID > 0 THEN

	SELECT GROUP_CONCAT(DISTINCT MENU_ID ORDER BY MENU_ID SEPARATOR ',') INTO STRMENUS
	FROM ROLE_MENU_NEW
	WHERE ROLE_ID = P_ID;

	SET @STRMENUS_NAME = (
	SELECT GROUP_CONCAT(
	IF(Z.PARENT_ID = 0, Z.NAME, CONCAT(PARENT_MENU_NAME, ' - ', Z.NAME))
	ORDER BY Z.NAME SEPARATOR '||'
	)
	FROM (
	SELECT X.MENU_ID,
	Z.DISPLAY_NAME AS NAME,
	Z.PARENT_ID,
	(SELECT ZX.DISPLAY_NAME
	FROM MENU_MASTER_NEW ZX
	WHERE ZX.ID = Z.PARENT_ID
	LIMIT 1) AS PARENT_MENU_NAME
	FROM ROLE_MENU_NEW X
	LEFT JOIN MENU_MASTER_NEW Z ON X.MENU_ID = Z.ID
	WHERE X.ROLE_ID = P_ID AND Z.IS_ACTIVE = 'Y'
	) Z
	);
    
    SELECT X.ROLE_ID AS ID,
	PLANT_ID,
	ZZ.Plant_Name,
	X.ROLE_NAME AS NAME,
	IF(X.IS_ADMIN = 'Y', 1, 0) AS ISADMIN,
	IF(X.IS_ACTIVE = 'Y', 1, 0) AS ISACTIVE
    , STRMENUS MENUS, @STRMENUS_NAME MENUS_NAME
	FROM ROLE_MASTER_NEW X
	LEFT JOIN PLANT_MASTER ZZ ON X.PLANT_ID = ZZ.PLANTID
	WHERE X.ROLE_ID > 1
	AND (X.PLANT_ID = P_PLANT_ID OR X.PLANT_ID = 0)
	AND X.ROLE_ID = P_ID
	AND X.IS_ACTIVE = IF(COALESCE(P_ISACTIVE, '') = '', X.IS_ACTIVE, P_ISACTIVE);
    
ELSE

	SELECT X.ROLE_ID AS ID,
	PLANT_ID,
	ZZ.Plant_Name,
	X.ROLE_NAME AS NAME,
	IF(X.IS_ADMIN = 'Y', 1, 0) AS ISADMIN,
	IF(X.IS_ACTIVE = 'Y', 1, 0) AS ISACTIVE
	FROM ROLE_MASTER_NEW X
	LEFT JOIN PLANT_MASTER ZZ ON X.PLANT_ID = ZZ.PLANTID
	WHERE X.ROLE_ID > 1
	AND (X.PLANT_ID = P_PLANT_ID OR X.PLANT_ID = 0)
	AND X.IS_ACTIVE = IF(COALESCE(P_ISACTIVE, '') = '', X.IS_ACTIVE, P_ISACTIVE);

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_ROLE_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE PC_ROLE_SAVE(
	IN P_ID BIGINT,
	IN P_ROLE_PLANT_ID BIGINT,
	IN P_NAME VARCHAR(255),
	IN P_ISADMIN VARCHAR(2),
    IN P_ISACTIVE VARCHAR(1),
	IN P_MENUS VARCHAR(16300),
	IN P_PLANT_ID BIGINT,
    IN P_USER_ID BIGINT,
    IN P_ROLE_ID BIGINT,
    IN P_MENU_ID BIGINT,
    OUT P_RESULT VARCHAR(16300)
)
BEGIN
	DECLARE TEMP_NUM BIGINT;
    DECLARE v_counter BIGINT DEFAULT 1;
	DECLARE v_menu_id VARCHAR(255);
             
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;


	START TRANSACTION;
		SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
		
        SELECT COUNT(*) INTO TEMP_NUM FROM ROLE_MASTER_NEW X WHERE X.ROLE_NAME = P_NAME AND X.PLANT_ID = P_ROLE_PLANT_ID AND X.ROLE_ID != P_ID;
        
        IF TEMP_NUM > 0 THEN
			SET P_RESULT = 'E|Role name already exists.|0';    
		ELSEIF P_ID > 0 THEN

			UPDATE ROLE_MASTER_NEW SET PLANT_ID = P_ROLE_PLANT_ID, ROLE_NAME = P_NAME, IS_ADMIN = P_ISADMIN, IS_ACTIVE = P_ISACTIVE, MODIFIED_BY = P_USER_ID, MODIFIED_DATETIME = NOW()
			WHERE ROLE_ID = P_ID;

			DELETE FROM ROLE_MENU_NEW WHERE ROLE_ID = P_ID;
            
			IF LENGTH(IFNULL(P_MENUS, '')) > 0 THEN
				SET v_counter = 1;
				SET v_menu_id  = '';

				SET v_menu_id = REGEXP_SUBSTR(P_MENUS, '[^,]+', 1, v_counter);

				WHILE v_menu_id IS NOT NULL DO
					                                
					INSERT INTO ROLE_MENU_NEW (ROLE_ID, MENU_ID) 
                    SELECT P_ID, PARENT_ID FROM MENU_MASTER_NEW WHERE ID = (CAST(v_menu_id AS DECIMAL(10, 0)));
                    
					INSERT INTO ROLE_MENU_NEW (ROLE_ID, MENU_ID) VALUES (P_ID, (CAST(v_menu_id AS DECIMAL(10, 0))));

					SET v_counter = v_counter + 1;
					SET v_menu_id = REGEXP_SUBSTR(P_MENUS, '[^,]+', 1, v_counter);
				END WHILE;
			END IF;
            

			SET P_RESULT = 'S|Record updated successfully|';

		ELSE

			SELECT IFNULL(MAX(ROLE_ID), 0) + 1 INTO TEMP_NUM FROM ROLE_MASTER_NEW;

			INSERT INTO ROLE_MASTER_NEW (ROLE_ID, PLANT_ID, ROLE_NAME, IS_ADMIN, IS_ACTIVE, CREATED_BY, CREATED_DATETIME, MODIFIED_BY, MODIFIED_DATETIME)
			VALUES(TEMP_NUM, P_ROLE_PLANT_ID, P_NAME, P_ISADMIN, P_ISACTIVE, P_USER_ID, NOW(), P_USER_ID, NOW());

			
			DELETE FROM ROLE_MENU_NEW WHERE ROLE_ID = TEMP_NUM;
            
			IF LENGTH(IFNULL(P_MENUS, '')) > 0 THEN
				SET v_counter = 1;
				SET v_menu_id  = '';

				SET v_menu_id = REGEXP_SUBSTR(P_MENUS, '[^,]+', 1, v_counter);

				WHILE v_menu_id IS NOT NULL DO
					                                
					INSERT INTO ROLE_MENU_NEW (ROLE_ID, MENU_ID) 
                    SELECT TEMP_NUM, PARENT_ID FROM MENU_MASTER_NEW WHERE ID = (CAST(v_menu_id AS DECIMAL(10, 0)));
                    
					INSERT INTO ROLE_MENU_NEW (ROLE_ID, MENU_ID) VALUES (TEMP_NUM, (CAST(v_menu_id AS DECIMAL(10, 0))));

					SET v_counter = v_counter + 1;
					SET v_menu_id = REGEXP_SUBSTR(P_MENUS, '[^,]+', 1, v_counter);
				END WHILE;
			END IF;
            

			SET P_RESULT = 'S|Record saved successfully|';
		END IF;
        
	COMMIT;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SCAN_CODE_HISTORY_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SCAN_CODE_HISTORY_GET(
IN P_ID INT
)
BEGIN


DROP TEMPORARY TABLE IF EXISTS TBL_MAIN;

CREATE TEMPORARY TABLE TBL_MAIN AS
SELECT * FROM (SELECT SID ID, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, 'S' LOG_Type, ENTRY_TIME FROM QR_CODE_SUCCESSLIST X WHERE X.MDA_SYS_ID = P_ID
UNION ALL
SELECT RID ID, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, 'R' LOG_Type, ENTRY_TIME FROM QR_CODE_REJECTLIST X WHERE X.MDA_SYS_ID = P_ID) Z
ORDER BY Z.ENTRY_TIME;

SET @srno := 0;
SELECT (@srno := @srno + 1) AS SRNO, ID, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, LOG_Type, ENTRY_TIME FROM TBL_MAIN;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SHIPPER_QRCODE_DELETE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SHIPPER_QRCODE_DELETE(
    IN P_GATE_SYS_ID INT,
    IN P_MDA_SYS_ID INT,
    IN P_MDA_DTL_SYS_ID INT,
    IN P_PROD_SYS_ID INT,
    IN P_QR_CODE_IDS_S  VARCHAR(16000),
    IN P_QR_CODE_IDS_R  VARCHAR(16000),
    IN P_PLANT_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
                  
    DECLARE v_counter BIGINT DEFAULT 1;
    DECLARE v_id VARCHAR(255);
            
	DECLARE TEMP_REQUIRED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_LOADED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_REJECT_SHIPPER INT DEFAULT 0;
                                                 
            
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			-- Error handling
			GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
			#SELECT @sqlstate AS State, @errmsg AS Message;
			ROLLBACK;
										 
			SELECT (Z.BAG_NOS / 24) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
				
			SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;

			SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM QR_CODE_REJECTLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

			SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|-1');

		END;
						 
			SELECT (Z.BAG_NOS / 24) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
				
			SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;

			SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM QR_CODE_REJECTLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

			SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|0');

        IF LENGTH(IFNULL(P_QR_CODE_IDS_S, '')) > 0 THEN
        
				SET v_counter = 1;
				SET v_id = REGEXP_SUBSTR(P_QR_CODE_IDS_S, '[^|]+', 1, v_counter);
                
				WHILE v_id IS NOT NULL DO
                
					IF IFNULL(v_id, '') != '' AND CAST(v_id AS UNSIGNED) > 0 THEN
                    
						DELETE FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID
							AND SHIPPER_QR_CODE IN (SELECT QRCODE FROM qr_code_successlist WHERE SID = CAST(v_id AS UNSIGNED) AND MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID AND PLANT_ID = P_PLANT_ID);
                                        
						DELETE FROM qr_code_successlist WHERE SID = CAST(v_id AS UNSIGNED) AND MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID AND PLANT_ID = P_PLANT_ID;
					END IF;
				
					SET v_counter = v_counter + 1;
					SET v_id = REGEXP_SUBSTR(P_QR_CODE_IDS_S, '[^|]+', 1, v_counter);
                    
				END WHILE;
				
        END IF;
        
        IF LENGTH(IFNULL(P_QR_CODE_IDS_R, '')) > 0 THEN
        
				SET v_counter = 1;
				SET v_id = REGEXP_SUBSTR(P_QR_CODE_IDS_R, '[^|]+', 1, v_counter);
                
				WHILE v_id IS NOT NULL DO
                
					IF IFNULL(v_id, '') != '' AND CAST(v_id AS UNSIGNED) > 0 THEN
						DELETE FROM qr_code_rejectlist WHERE RID = CAST(v_id AS UNSIGNED) AND MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID AND PLANT_ID = P_PLANT_ID;
					END IF;
				
					SET v_counter = v_counter + 1;
					SET v_id = REGEXP_SUBSTR(P_QR_CODE_IDS_R, '[^|]+', 1, v_counter);
                    
				END WHILE;
				
        END IF;
        
		
        			 
			SELECT (Z.BAG_NOS / 24) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
				
			SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;

			SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM QR_CODE_REJECTLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

        
		SET P_RESULT = CONCAT('S|Record delete successfully.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|0');
		#SET P_RESULT = CONCAT('S|Record delete successfully.#', Concatenated_Result, '|0');
      
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SHIPPER_QRCODE_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SHIPPER_QRCODE_GET(
IN P_QRCODE NVARCHAR(255),
IN `P_GATE_SYS_ID` INT,
IN `P_MDA_SYS_ID` INT,
IN `P_MDA_DTL_SYS_ID` INT,
IN `P_PROD_SYS_ID` INT,
OUT P_RESULT VARCHAR(16300))
BEGIN

	DECLARE TEMP_NUM INT DEFAULT 0;
	DECLARE TEMP_REQUIRED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_LOADED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_MDA_NO VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = 'E|NOK|0';
    END;

		SET P_RESULT = 'E|NOK|0';


		IF LENGTH(COALESCE(P_QRCODE, '')) > 0 THEN
			            
			SELECT MDA_NO INTO TEMP_MDA_NO FROM mda_header Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID LIMIT 1;
            
            SELECT COUNT(*) INTO TEMP_NUM FROM SHIPPER_QRCODE X WHERE X.SHIPPER_QRCODE = P_QRCODE;

			IF IFNULL(TEMP_NUM, 0) > 0 THEN						
					
				SELECT COUNT(*) INTO TEMP_NUM FROM mda_loading Z WHERE Z.SHIPPER_QR_CODE = P_QRCODE;

				IF IFNULL(TEMP_NUM, 0) = 0 THEN	
					
					INSERT INTO QR_CODE_SUCCESSLIST ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID) 
					VALUES ( 4,2, P_QRCODE, P_PROD_SYS_ID, TEMP_MDA_NO, P_MDA_SYS_ID);
	 				 
					INSERT INTO QR_CODE_SUCCESSLIST_LOG ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO) 
					VALUES (4,2, P_QRCODE, P_PROD_SYS_ID, TEMP_MDA_NO);
                                
                                
					SELECT (Z.BAG_NOS / 24) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
            
					SELECT COUNT(*) + 1 INTO TEMP_LOADED_SHIPPER FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;
            
					SELECT MAX(MDA_LOD_SYS_ID) + 1 INTO TEMP_NUM FROM mda_loading Z ;

					INSERT INTO MDA_LOADING ( MDA_LOD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER, SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, CREATED_DATETIME, PLANT_ID, IS_POSTED, ENTRY_TIME) 
					VALUES (TEMP_NUM, P_GATE_SYS_ID, P_MDA_SYS_ID, P_PROD_SYS_ID, TEMP_REQUIRED_SHIPPER, TEMP_LOADED_SHIPPER, P_QRCODE, 0, 1, NOW(), 4, 0, NOW() );
                
					SET P_RESULT = 'S|OK|0';
                    
				ELSE
						
					INSERT INTO QR_CODE_REJECTLIST ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, REJECT_REASON, ENTRY_TIME) 
					VALUES (4,2, P_QRCODE, P_PROD_SYS_ID, TEMP_MDA_NO, P_MDA_SYS_ID, 'Duplicate QR Code found.', NOW());
					 
					 
					INSERT INTO QR_CODE_REJECTLIST_LOG ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, REJECT_REASON, IS_POSTED) 
					VALUES (4,2, P_QRCODE, P_PROD_SYS_ID, TEMP_MDA_NO, 'Duplicate QR Code found.', 0);
								
				END IF;
			ELSE
            
					INSERT INTO QR_CODE_REJECTLIST ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, REJECT_REASON, ENTRY_TIME) 
					VALUES (4,2, P_QRCODE, P_PROD_SYS_ID, TEMP_MDA_NO, P_MDA_SYS_ID, 'QR Code not found.', NOW());
					 
					 
					INSERT INTO QR_CODE_REJECTLIST_LOG ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, REJECT_REASON, IS_POSTED) 
					VALUES (4,2, P_QRCODE, P_PROD_SYS_ID, TEMP_MDA_NO, 'QR Code not found.', 0);
								
            
			END IF;
                        
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SHIPPER_QRCODE_GET_NEW */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SHIPPER_QRCODE_GET_NEW(IN P_QRCODE NVARCHAR(255),
IN `P_GATE_SYS_ID` INT,
IN `P_MDA_SYS_ID` INT,
IN `P_MDA_DTL_SYS_ID` INT,
IN `P_PROD_SYS_ID` INT,
OUT P_RESULT VARCHAR(16300))
BEGIN

    DECLARE last_id BIGINT DEFAULT 0;
	DECLARE TEMP_NUM INT DEFAULT 0;
	DECLARE TEMP_REQUIRED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_LOADED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_REJECT_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_MDA_NO VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
                                               
		SELECT (Z.BAG_NOS / 24) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
            
		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;

		SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM QR_CODE_REJECTLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

        SET P_RESULT = CONCAT('E|NOK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|-1');

    END;

		SELECT (Z.BAG_NOS / 24) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
            
		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;

		SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM QR_CODE_REJECTLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

        SET P_RESULT = CONCAT('E|NOK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|0');

		IF LENGTH(COALESCE(P_QRCODE, '')) > 0 THEN
			
			SELECT MDA_NO INTO TEMP_MDA_NO FROM mda_header Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID LIMIT 1;
            
            SELECT COUNT(*) INTO TEMP_NUM FROM SHIPPER_QRCODE X WHERE X.SHIPPER_QRCODE = P_QRCODE;

			IF IFNULL(TEMP_NUM, 0) > 0 THEN						
					
				SELECT COUNT(*) INTO TEMP_NUM FROM mda_loading Z WHERE Z.SHIPPER_QR_CODE = P_QRCODE;

				IF IFNULL(TEMP_NUM, 0) = 0 THEN	
					                     
					IF TEMP_REQUIRED_SHIPPER >= (TEMP_LOADED_SHIPPER + 1) THEN	
							
						INSERT INTO QR_CODE_SUCCESSLIST ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID) 
						VALUES ( 4,2, P_QRCODE, P_PROD_SYS_ID, TEMP_MDA_NO, P_MDA_SYS_ID);
						 
						 SET last_id = LAST_INSERT_ID();
						 
						INSERT INTO QR_CODE_SUCCESSLIST_LOG ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO) 
						VALUES (4,2, P_QRCODE, P_PROD_SYS_ID, TEMP_MDA_NO);
						 
						SET TEMP_LOADED_SHIPPER = TEMP_LOADED_SHIPPER + 1;
            
                        SELECT MAX(MDA_LOD_SYS_ID) + 1 INTO TEMP_NUM FROM mda_loading Z ;

						INSERT INTO MDA_LOADING ( MDA_LOD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER, SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, CREATED_DATETIME, PLANT_ID, IS_POSTED, ENTRY_TIME) 
						VALUES (TEMP_NUM, P_GATE_SYS_ID, P_MDA_SYS_ID, P_PROD_SYS_ID, TEMP_REQUIRED_SHIPPER, TEMP_LOADED_SHIPPER, P_QRCODE, 0, 1, NOW(), 4, 0, NOW() );
					
						IF TEMP_REQUIRED_SHIPPER = TEMP_LOADED_SHIPPER THEN                        
							SET P_RESULT = CONCAT('E|OK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);
                        ELSEIF TEMP_REQUIRED_SHIPPER > TEMP_LOADED_SHIPPER THEN                        
							SET P_RESULT = CONCAT('S|OK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);
                        ELSE
							SET P_RESULT = CONCAT('E|NOK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);
                        END IF;
                    ELSE  
							SET P_RESULT = CONCAT('E|NOK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);                
                    END IF;
				ELSE
						
					SET TEMP_REJECT_SHIPPER = TEMP_REJECT_SHIPPER + 1;
            
					INSERT INTO QR_CODE_REJECTLIST ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, REJECT_REASON, ENTRY_TIME) 
					VALUES (4,2, P_QRCODE, P_PROD_SYS_ID, TEMP_MDA_NO, P_MDA_SYS_ID, 'Duplicate QR Code found.', NOW());
					 
	 				 SET last_id = LAST_INSERT_ID();
                     
					INSERT INTO QR_CODE_REJECTLIST_LOG ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, REJECT_REASON, IS_POSTED) 
					VALUES (4,2, P_QRCODE, P_PROD_SYS_ID, TEMP_MDA_NO, 'Duplicate QR Code found.', 0);
							
					SET P_RESULT = CONCAT('E|NOK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);   
				END IF;
			ELSE
            
					SET TEMP_REJECT_SHIPPER = TEMP_REJECT_SHIPPER + 1;
            
					INSERT INTO QR_CODE_REJECTLIST ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, REJECT_REASON, ENTRY_TIME) 
					VALUES (4,2, P_QRCODE, P_PROD_SYS_ID, TEMP_MDA_NO, P_MDA_SYS_ID, 'QR Code not found.', NOW());
					 
	 				 SET last_id = LAST_INSERT_ID();
                     
					INSERT INTO QR_CODE_REJECTLIST_LOG ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, REJECT_REASON, IS_POSTED) 
					VALUES (4,2, P_QRCODE, P_PROD_SYS_ID, TEMP_MDA_NO, 'QR Code not found.', 0);
						
					SET P_RESULT = CONCAT('E|NOK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);   
			END IF;
                        
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SHIPPER_QRCODE_HISTORY_GET_NEW */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SHIPPER_QRCODE_HISTORY_GET_NEW(
IN `P_GATE_SYS_ID` INT,
IN `P_MDA_SYS_ID` INT,
IN `P_MDA_DTL_SYS_ID` INT,
IN `P_PROD_SYS_ID` INT
)
BEGIN

	DECLARE TEMP_REQUIRED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_LOADED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_REJECT_SHIPPER INT DEFAULT 0;
                                                   
		SELECT (Z.BAG_NOS / 24) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
            
		-- SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND Z.PROD_SYS_ID = P_PROD_SYS_ID;

		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM QR_CODE_SUCCESSLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

		SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM QR_CODE_REJECTLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

DROP TEMPORARY TABLE IF EXISTS TBL_MAIN;

CREATE TEMPORARY TABLE TBL_MAIN AS
SELECT * FROM (SELECT SID ID, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, 'S' LOG_Type, ENTRY_TIME, NULL REJECT_REASON FROM QR_CODE_SUCCESSLIST X WHERE X.MDA_SYS_ID = P_MDA_SYS_ID AND X.PRODUCT_SYS_ID = P_PROD_SYS_ID
UNION ALL
SELECT RID ID, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, 'R' LOG_Type, ENTRY_TIME, REJECT_REASON FROM QR_CODE_REJECTLIST X WHERE X.MDA_SYS_ID = P_MDA_SYS_ID AND X.PRODUCT_SYS_ID = P_PROD_SYS_ID) Z
ORDER BY Z.ENTRY_TIME;

SET @srno := 0;
SELECT (@srno := @srno + 1) AS SRNO, ID, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, LOG_Type, ENTRY_TIME, REJECT_REASON, TEMP_REQUIRED_SHIPPER REQUIRED_SHIPPER, TEMP_LOADED_SHIPPER LOADED_SHIPPER, TEMP_REJECT_SHIPPER REJECT_SHIPPER FROM TBL_MAIN
UNION 
SELECT 0 SRNO, 0 ID, 0 PLANT_ID, 0 BELT_NO, '' QRCODE, 0 PRODUCT_SYS_ID, '' MDA_NO, 0 MDA_SYS_ID, '' LOG_Type, NULL ENTRY_TIME, NULL REJECT_REASON, TEMP_REQUIRED_SHIPPER REQUIRED_SHIPPER, TEMP_LOADED_SHIPPER LOADED_SHIPPER, TEMP_REJECT_SHIPPER REJECT_SHIPPER;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SO_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SO_SAVE(
    IN P_ID INT,
    IN P_VENDOR_ID INT,
    IN P_SITE_ID VARCHAR(255),
    IN P_SO_NO INT,
    IN P_SO_DATE VARCHAR(255),
    IN P_RIVISION VARCHAR(255),
    IN P_TENDER_TYPE VARCHAR(255),
    IN P_SO_RELEASE_DATE VARCHAR(255),
    IN P_SO_VALID_DATE VARCHAR(255),
    IN P_EMD_AMT DECIMAL(10,2),
    IN P_MSR_NO INT,
    IN P_CUST_NAME VARCHAR(255),
    IN P_ADDRESS VARCHAR(255),
    IN P_CITY VARCHAR(255),
    IN P_STATE VARCHAR(255),
    IN P_PANNO VARCHAR(255),
    IN P_GSTNNO VARCHAR(255),
    IN P_TERMS_PRICE DECIMAL(10,2),
    IN P_TERMS_PYMT_TERM VARCHAR(255),
    IN P_TERMS_LIFTING_PERIOD_DAYS INT,
    IN P_SO_REMARKS VARCHAR(255),
    IN P_STATUS_REMARKS VARCHAR(255),
    IN P_SO_DTLS VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_SO_SYS_ID INT DEFAULT 0;
    DECLARE TEMP_SO_DTL_SYS_ID INT DEFAULT 0;
    DECLARE TEMP_CNT INT DEFAULT 0;
    DECLARE TEMP_LINE_NO INT DEFAULT 0;
    DECLARE TEMP_1 VARCHAR(1000);
    
    DECLARE v_counter BIGINT DEFAULT 1;
	DECLARE v_line VARCHAR(16300);
    
	DECLARE v_line_id VARCHAR(255);
	DECLARE v_line_no VARCHAR(255);
	DECLARE v_line_desc VARCHAR(16300);
	DECLARE v_line_uom VARCHAR(255);
	DECLARE v_line_qty VARCHAR(255);

	
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    SELECT COUNT(*) INTO TEMP_SO_SYS_ID FROM SO_HEADER WHERE SO_NO = P_SO_NO AND SO_SYS_ID != P_ID;

    /*IF FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID) <= 0 THEN
        SET P_RESULT = 'E|You are not authorized to perform this operation.|0';
    ELSE
    IF IFNULL(P_VENDOR_ID, 0) <= 0 THEN
        SET P_RESULT = 'E|Please select Vendor.|0';
    ELSEIF P_SITE_ID IS NULL OR P_SITE_ID = '' THEN
        SET P_RESULT = 'E|Please select Vendor Site.|0';
    ELSE*/
    IF IFNULL(TEMP_SO_SYS_ID, 0) > 0 THEN
        SET P_RESULT = CONCAT('E|SO is already exist.|', P_ID);
    ELSE
        SET TEMP_CNT = CHAR_LENGTH(IFNULL(P_SO_DTLS, ''));

        IF IFNULL(TEMP_CNT, 0) > 0 AND P_ID > 0 THEN
            UPDATE SO_HEADER SET 
                VENSOR_SYS_ID = P_VENDOR_ID,
                SO_NO = P_SO_NO,
                SO_DATE = STR_TO_DATE(REPLACE(P_SO_DATE, '-', '/'), '%d/%m/%Y'),
                RIVISION = P_RIVISION,
                TENDER_TYPE = P_TENDER_TYPE,
                SO_RELEASE_DATE = STR_TO_DATE(REPLACE(P_SO_RELEASE_DATE, '-', '/'), '%d/%m/%Y'),
                SO_VALID_DATE = STR_TO_DATE(REPLACE(P_SO_VALID_DATE, '-', '/'), '%d/%m/%Y'),
                EMD_AMT = P_EMD_AMT,
                AMEND_NO = P_MSR_NO,
                CUST_NAME = P_CUST_NAME,
                SITE_NAME = P_SITE_ID,
                ADD1 = P_ADDRESS,
                CITY = P_CITY,
                STATE = P_SITE_ID,
                PAN_NO = P_PANNO,
                GSTN_NO = P_GSTNNO,
                TERMS_PRICE = P_TERMS_PRICE,
                TERMS_PYMT_TERM = P_TERMS_PYMT_TERM,
                TERMS_LIFTING_PERIOD_DAYS = P_TERMS_LIFTING_PERIOD_DAYS,
                SO_REMARKS = P_SO_REMARKS,
                STATUS_REMARKS = P_STATUS_REMARKS
            WHERE PLANT_ID = P_PLANT_ID AND SO_SYS_ID = P_ID;
            
				SET v_counter = 1;            
				SET v_line = REGEXP_SUBSTR(IFNULL(P_SO_DTLS, ''), '[^##]+', 1, v_counter);
                
				WHILE v_line IS NOT NULL DO
                
					SET v_line_id = REGEXP_SUBSTR(v_line, '[^|]+', 1, 1);
					SET v_line_no = REGEXP_SUBSTR(v_line, '[^|]+', 1, 2);
					SET v_line_desc = REGEXP_SUBSTR(v_line, '[^|]+', 1, 3);
					SET v_line_uom = REGEXP_SUBSTR(v_line, '[^|]+', 1, 4);
					SET v_line_qty = REGEXP_SUBSTR(v_line, '[^|]+', 1, 5);
                    
                    SELECT COUNT(*) INTO TEMP_CNT FROM SO_DETAIL WHERE SO_DTL_SYS_ID = v_line_id AND SO_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;
                    
                    IF IFNULL(TEMP_CNT, 0) > 0 THEN
                        IF IFNULL(v_line_no, 0) <= 0 THEN
                            SELECT IFNULL(MAX(SLNO), 0) + 1 INTO TEMP_LINE_NO FROM SO_DETAIL WHERE SO_DTL_SYS_ID = v_line_id AND SO_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;
                        ELSE
                            SET TEMP_LINE_NO = IFNULL(v_line_no, 0);
                        END IF;
                        
                        UPDATE SO_DETAIL SET 
                            SLNO = TEMP_LINE_NO, 
                            SCRAP_DESC = v_line_desc,
                            UOM = v_line_uom,
                            SO_QTY = v_line_qty
                        WHERE SO_DTL_SYS_ID = v_line_id AND SO_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;
			ELSE   
                    SELECT IFNULL(MAX(SO_DTL_SYS_ID), 0) + 1 INTO TEMP_SO_DTL_SYS_ID FROM SO_DETAIL;
					
                    IF CAST(IFNULL(v_line_no, '0') AS UNSIGNED) > 0 THEN SET TEMP_LINE_NO = CAST(IFNULL(v_line_no, '0') AS UNSIGNED);
                    ELSE SELECT IFNULL(MAX(SLNO), 0) + 1 INTO TEMP_LINE_NO FROM SO_DETAIL WHERE PLANT_ID = P_PLANT_ID AND SO_SYS_ID = TEMP_SO_SYS_ID; END IF;
                    
					INSERT INTO SO_DETAIL (SO_DTL_SYS_ID, SO_SYS_ID, SLNO, SCRAP_DESC, UOM, SO_QTY, IS_POSTED, PLANT_ID)
                    VALUES (TEMP_SO_DTL_SYS_ID, TEMP_SO_SYS_ID, TEMP_LINE_NO, v_line_desc, v_line_uom, CAST(IFNULL(v_line_qty, '0') AS UNSIGNED), 0, P_PLANT_ID);
                
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_SO_DTLS, '[^##]+', 1, v_counter);
                   END IF;  
				END WHILE;           

            SET P_RESULT = CONCAT('S|Record updated successfully|', P_ID);

        ELSEIF IFNULL(TEMP_CNT, 0) > 0 THEN
            SELECT IFNULL(MAX(SO_SYS_ID), 0) + 1 INTO TEMP_SO_SYS_ID FROM SO_HEADER;

            INSERT INTO SO_HEADER (
                SO_SYS_ID, PLANT_ID, VENSOR_SYS_ID, SO_NO, SO_DATE, RIVISION, TENDER_TYPE, 
                SO_RELEASE_DATE, SO_VALID_DATE, EMD_AMT, AMEND_NO, CUST_NAME, SITE_NAME, 
                ADD1, CITY, STATE, PAN_NO, GSTN_NO, TERMS_PRICE, TERMS_PYMT_TERM, 
                TERMS_LIFTING_PERIOD_DAYS, SO_REMARKS, STATUS_REMARKS, CREATED_DATETIME
            ) VALUES (
                TEMP_SO_SYS_ID, P_PLANT_ID, P_VENDOR_ID, P_SO_NO, STR_TO_DATE(REPLACE(P_SO_DATE, '-', '/'), '%d/%m/%Y'), 
                P_RIVISION, P_TENDER_TYPE, STR_TO_DATE(REPLACE(P_SO_RELEASE_DATE, '-', '/'), '%d/%m/%Y'), 
                STR_TO_DATE(REPLACE(P_SO_VALID_DATE, '-', '/'), '%d/%m/%Y'), P_EMD_AMT, P_MSR_NO, P_CUST_NAME, 
                P_SITE_ID, P_ADDRESS, P_CITY, P_STATE, P_PANNO, P_GSTNNO, P_TERMS_PRICE, P_TERMS_PYMT_TERM, 
                P_TERMS_LIFTING_PERIOD_DAYS, P_SO_REMARKS, P_STATUS_REMARKS, NOW()
            );
            
				SET v_counter = 1;            
				SET v_line = REGEXP_SUBSTR(IFNULL(P_SO_DTLS, ''), '[^##]+', 1, v_counter);
                
				WHILE v_line IS NOT NULL DO
                
					SET v_line_id = REGEXP_SUBSTR(v_line, '[^|]+', 1, 1);
					SET v_line_no = REGEXP_SUBSTR(v_line, '[^|]+', 1, 2);
					SET v_line_desc = REGEXP_SUBSTR(v_line, '[^|]+', 1, 3);
					SET v_line_uom = REGEXP_SUBSTR(v_line, '[^|]+', 1, 4);
					SET v_line_qty = REGEXP_SUBSTR(v_line, '[^|]+', 1, 5);
                    
                    SELECT COUNT(*) INTO TEMP_CNT FROM SO_DETAIL WHERE SO_DTL_SYS_ID = v_line_id AND SO_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;
                    
                    IF IFNULL(TEMP_CNT, 0) > 0 THEN
                        IF IFNULL(v_line_no, 0) <= 0 THEN
                            SELECT IFNULL(MAX(SLNO), 0) + 1 INTO TEMP_LINE_NO FROM SO_DETAIL WHERE SO_DTL_SYS_ID = v_line_id AND SO_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;
                        ELSE
                            SET TEMP_LINE_NO = IFNULL(v_line_no, 0);
                        END IF;
                        
                        UPDATE SO_DETAIL SET 
                            SLNO = TEMP_LINE_NO, 
                            SCRAP_DESC = v_line_desc, 
                            UOM = v_line_uom,
                            SO_QTY = v_line_qty
                        WHERE SO_DTL_SYS_ID = v_line_id AND SO_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;
					
                    ELSE   
                    
                    SELECT IFNULL(MAX(SO_DTL_SYS_ID), 0) + 1 INTO TEMP_SO_DTL_SYS_ID FROM SO_DETAIL;
					
                    IF CAST(IFNULL(v_line_no, '0') AS UNSIGNED) > 0 THEN SET TEMP_LINE_NO = CAST(IFNULL(v_line_no, '0') AS UNSIGNED);
                    ELSE SELECT IFNULL(MAX(SLNO), 0) + 1 INTO TEMP_LINE_NO FROM SO_DETAIL WHERE PLANT_ID = P_PLANT_ID AND SO_SYS_ID = TEMP_SO_SYS_ID; END IF;
                    
					INSERT INTO SO_DETAIL (SO_DTL_SYS_ID, SO_SYS_ID, SLNO, SCRAP_DESC, UOM, SO_QTY, IS_POSTED, PLANT_ID)
                    VALUES (TEMP_SO_DTL_SYS_ID, TEMP_SO_SYS_ID, TEMP_LINE_NO, v_line_desc, v_line_uom, CAST(IFNULL(v_line_qty, '0') AS UNSIGNED), 0, P_PLANT_ID);
                
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_SO_DTLS, '[^##]+', 1, v_counter);
                   END IF;  
				END WHILE; 

            SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_SO_SYS_ID);

        ELSE
            SET P_RESULT = CONCAT('E|Please add SO details.|', P_ID);
        END IF;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SO_SAVE_NEW */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SO_SAVE_NEW(
    IN P_ID BIGINT, 
    IN P_VENDOR_ID BIGINT, 
    IN P_SITE_ID BIGINT, 
    IN P_SO_NO BIGINT, 
    IN P_SO_DATE VARCHAR(255), 
    IN P_RIVISION VARCHAR(255), 
    IN P_TENDER_TYPE VARCHAR(255),
    IN P_SO_RELEASE_DATE VARCHAR(255),
    IN P_SO_VALID_DATE VARCHAR(255),
    IN P_EMD_AMT BIGINT,
    IN P_MSR_NO BIGINT,
    IN P_CUST_NAME VARCHAR(255),
    IN P_ADDRESS VARCHAR(255),
    IN P_CITY VARCHAR(255),
    IN P_STATE VARCHAR(255),
    IN P_PANNO VARCHAR(255),
    IN P_GSTNNO VARCHAR(255),
    IN P_TERMS_PRICE BIGINT,
    IN P_TERMS_PYMT_TERM VARCHAR(255),
    IN P_TERMS_LIFTING_PERIOD_DAYS BIGINT,
    IN P_SO_REMARKS VARCHAR(255),
    IN P_STATUS_REMARKS VARCHAR(255),
    IN P_SO_DTLS VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID BIGINT,
    IN P_USER_ID BIGINT,
    IN P_ROLE_ID BIGINT,
    IN P_MENU_ID BIGINT,
    OUT P_RESULT VARCHAR(255))
BEGIN
    DECLARE TEMP_SO_ID INT DEFAULT 0; 
    DECLARE TEMP_SO_DTLS_ID INT DEFAULT 0; 
    DECLARE TEMP_SO_DTLS_LINE_NO INT DEFAULT 0; 
    DECLARE TEMP_CNT INT DEFAULT 0; 
    DECLARE TEMP_STATION_ID INT DEFAULT 7;
	DECLARE v_SO_DATE DATETIME;

    DECLARE v_counter BIGINT DEFAULT 1;
	DECLARE v_line VARCHAR(16300);
    
					DECLARE v_line_id VARCHAR(255);
					DECLARE v_line_no VARCHAR(255);
					DECLARE v_line_desc VARCHAR(16300);
					DECLARE v_line_uom VARCHAR(255);
					DECLARE v_line_qty VARCHAR(255);
                
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;


    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact system administrator|0';

    IF LENGTH(IFNULL(P_SO_NO, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter SO No.|0';
    ELSEIF LENGTH(IFNULL(P_SO_DATE, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter SO Date.|0';
    ELSEIF IFNULL(P_ID, 0) = 0 AND LENGTH(IFNULL(P_SO_DTLS, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter SO details|0';
    ELSE 
		
		SELECT COUNT(*) INTO TEMP_CNT FROM SO_HEADER WHERE PLANT_ID = P_PLANT_ID AND SO_NO = P_SO_NO AND SO_SYS_ID != IFNULL(P_ID, 0);

		IF IFNULL(TEMP_CNT, 0) = 0 THEN
							
			SET v_SO_DATE = IF(IFNULL(P_SO_DATE, '') = '' OR P_SO_DATE = '=', NULL, STR_TO_DATE(REPLACE(P_SO_DATE, '-', '/'), '%d/%m/%Y %H:%i'));
                            
			IF IFNULL(P_ID, 0) > 0 THEN
			
				/*UPDATE SO_HEADER SET 
					VENSOR_SYS_ID = P_VENDOR_ID,
					SO_NO = P_SO_NO,
					SO_DATE = v_SO_DATE,
					RIVISION = P_RIVISION,
					TENDER_TYPE = P_TENDER_TYPE,
					SO_RELEASE_DATE = STR_TO_DATE(REPLACE(P_SO_RELEASE_DATE, '-', '/'), '%d/%m/%Y'),
					SO_VALID_DATE = STR_TO_DATE(REPLACE(P_SO_VALID_DATE, '-', '/'), '%d/%m/%Y'),
					EMD_AMT = P_EMD_AMT,
					AMEND_NO = P_MSR_NO,
					CUST_NAME = P_CUST_NAME,
					SITE_NAME = P_SITE_ID,
					ADD1 = P_ADDRESS,
					CITY = P_CITY,
					STATE = P_SITE_ID,
					PAN_NO = P_PANNO,
					GSTN_NO = P_GSTNNO,
					TERMS_PRICE = P_TERMS_PRICE,
					TERMS_PYMT_TERM = P_TERMS_PYMT_TERM,
					TERMS_LIFTING_PERIOD_DAYS = P_TERMS_LIFTING_PERIOD_DAYS,
					SO_REMARKS = P_SO_REMARKS,
					STATUS_REMARKS = P_STATUS_REMARKS
				WHERE PLANT_ID = P_PLANT_ID AND SO_SYS_ID = P_ID;*/
            
            
				SET TEMP_SO_ID = IFNULL(P_ID, 0);
                
               /* SET v_counter = 1;
				SET v_line = REGEXP_SUBSTR(IFNULL(P_SO_DTLS, ''), '[^##]+', 1, v_counter);
                
				WHILE v_line IS NOT NULL DO
                
					SET v_line_id = REGEXP_SUBSTR(v_line, '[^|]+', 1, 1);
					SET v_line_no = REGEXP_SUBSTR(v_line, '[^|]+', 1, 2);
					SET v_line_desc = REGEXP_SUBSTR(v_line, '[^|]+', 1, 3);
					SET v_line_uom = REGEXP_SUBSTR(v_line, '[^|]+', 1, 4);
					SET v_line_qty = REGEXP_SUBSTR(v_line, '[^|]+', 1, 5);
                
                SELECT COUNT(*) INTO TEMP_CNT FROM SO_DETAIL WHERE SO_DTL_SYS_ID = v_line_id AND SO_SYS_ID = TEMP_SO_ID AND PLANT_ID = P_PLANT_ID;
                
					IF IFNULL(TEMP_CNT, 0) > 0 THEN
                        IF IFNULL(v_line_no, 0) <= 0 THEN
                            SELECT IFNULL(MAX(SLNO), 0) + 1 INTO TEMP_SO_DTLS_LINE_NO FROM SO_DETAIL WHERE SO_DTL_SYS_ID = v_line_id AND SO_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;
                        ELSE
                            SET TEMP_SO_DTLS_LINE_NO = IFNULL(v_line_no, 0);
                        END IF;
                        
                        UPDATE SO_DETAIL SET 
                            SLNO = TEMP_SO_DTLS_LINE_NO, 
                            SCRAP_DESC = v_line_desc,
                            UOM = v_line_uom,
                            SO_QTY = v_line_qty
                        WHERE SO_DTL_SYS_ID = v_line_id AND SO_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;
					ELSE   
						SELECT IFNULL(MAX(SO_DTL_SYS_ID), 0) + 1 INTO TEMP_SO_DTLS_ID FROM SO_DETAIL;
						
						IF CAST(IFNULL(v_line_no, '0') AS UNSIGNED) > 0 THEN SET TEMP_SO_DTLS_LINE_NO = CAST(IFNULL(v_line_no, '0') AS UNSIGNED);
						ELSE SELECT IFNULL(MAX(SLNO), 0) + 1 INTO TEMP_SO_DTLS_LINE_NO FROM SO_DETAIL WHERE PLANT_ID = P_PLANT_ID AND SO_SYS_ID = TEMP_SO_ID; END IF;
						
						INSERT INTO SO_DETAIL (SO_DTL_SYS_ID, SO_SYS_ID, SO_NO, SLNO, SCRAP_DESC, UOM, SO_QTY, IS_POSTED, PLANT_ID)
						VALUES (TEMP_SO_DTLS_ID, TEMP_SO_ID, P_SO_NO, TEMP_SO_DTLS_LINE_NO, v_line_desc, v_line_uom, CAST(IFNULL(v_line_qty, '0') AS UNSIGNED), 0, P_PLANT_ID);
					
						SET v_counter = v_counter + 1;
						SET v_line = REGEXP_SUBSTR(P_SO_DTLS, '[^##]+', 1, v_counter);
                    END IF; 
				END WHILE; */
                
                
				SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_SO_ID);
			ELSE
				
				SELECT IFNULL(MAX(SO_SYS_ID), 0) + 1 INTO TEMP_SO_ID FROM SO_HEADER;
				
				INSERT INTO SO_HEADER (
					SO_SYS_ID, PLANT_ID, VENSOR_SYS_ID, SO_NO, SO_DATE, RIVISION, TENDER_TYPE, 
					SO_RELEASE_DATE, SO_VALID_DATE, EMD_AMT, AMEND_NO, CUST_NAME, SITE_NAME, 
					ADD1, CITY, STATE, PAN_NO, GSTN_NO, TERMS_PRICE, TERMS_PYMT_TERM, 
					TERMS_LIFTING_PERIOD_DAYS, SO_REMARKS, STATUS_REMARKS, CREATED_DATETIME
						) VALUES (
					TEMP_SO_ID, P_PLANT_ID, P_VENDOR_ID, P_SO_NO, STR_TO_DATE(REPLACE(P_SO_DATE, '-', '/'), '%d/%m/%Y'), 
					P_RIVISION, P_TENDER_TYPE, STR_TO_DATE(REPLACE(P_SO_RELEASE_DATE, '-', '/'), '%d/%m/%Y'), 
					STR_TO_DATE(REPLACE(P_SO_VALID_DATE, '-', '/'), '%d/%m/%Y'), P_EMD_AMT, P_MSR_NO, P_CUST_NAME, 
					P_SITE_ID, P_ADDRESS, P_CITY, P_STATE, P_PANNO, P_GSTNNO, P_TERMS_PRICE, P_TERMS_PYMT_TERM, 
					P_TERMS_LIFTING_PERIOD_DAYS, P_SO_REMARKS, P_STATUS_REMARKS, NOW()
					);
                
				SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_SO_ID);                
	 
			END IF; 
            
            SET v_counter = 1;
				SET v_line = REGEXP_SUBSTR(IFNULL(P_SO_DTLS, ''), '[^<#>]+', 1, v_counter);
                
				WHILE v_line IS NOT NULL DO
                
					SET v_line_id = REGEXP_SUBSTR(v_line, '[^|]+', 1, 1);
					SET v_line_no = REGEXP_SUBSTR(v_line, '[^|]+', 1, 2);
					SET v_line_desc = REGEXP_SUBSTR(v_line, '[^|]+', 1, 3);
					SET v_line_uom = REGEXP_SUBSTR(v_line, '[^|]+', 1, 4);
					SET v_line_qty = REGEXP_SUBSTR(v_line, '[^|]+', 1, 5);
                
					SELECT IFNULL(MAX(SO_DTL_SYS_ID), 0) + 1 INTO TEMP_SO_DTLS_ID FROM SO_DETAIL;
					
                    IF CAST(IFNULL(v_line_no, '0') AS UNSIGNED) > 0 THEN SET TEMP_SO_DTLS_LINE_NO = CAST(IFNULL(v_line_no, '0') AS UNSIGNED);
                    ELSE SELECT IFNULL(MAX(SLNO), 0) + 1 INTO TEMP_SO_DTLS_LINE_NO FROM SO_DETAIL WHERE PLANT_ID = P_PLANT_ID AND SO_SYS_ID = TEMP_SO_ID; END IF;
                    
					INSERT INTO SO_DETAIL (SO_DTL_SYS_ID, SO_SYS_ID, SO_NO, SLNO, SCRAP_DESC, UOM, SO_QTY, IS_POSTED, PLANT_ID)
                    VALUES (TEMP_SO_DTLS_ID, TEMP_SO_ID, P_SO_NO, TEMP_SO_DTLS_LINE_NO, v_line_desc, v_line_uom, CAST(IFNULL(v_line_qty, '0') AS UNSIGNED), 0, P_PLANT_ID);
                
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_SO_DTLS, '[^<#>]+', 1, v_counter);
                    
				END WHILE;
				
		ELSE
			SET P_RESULT := 'E|SO No. is already available.|0';
		END IF;
        
    END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SplitString */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SplitString(
IN input_string VARCHAR(255), 
IN separatorPrimary CHAR(1),
IN separatorSecondary CHAR(1)
)
BEGIN
DECLARE v_finished INTEGER DEFAULT 0;
DECLARE v_str VARCHAR(255) DEFAULT '';
DECLARE v_idx INT DEFAULT 1;
DECLARE v_max_count INT DEFAULT 0;
DECLARE v_current_count INT DEFAULT 0;
DECLARE v_sub_str VARCHAR(255) DEFAULT '';
DECLARE v_temp_str VARCHAR(255) DEFAULT '';
DECLARE v_counter INT DEFAULT 0;
DECLARE v_dynamic_col_names VARCHAR(1000) DEFAULT '';

-- Determine the maximum number of substrings separated by separatorSecondary
SET v_temp_str = input_string;
WHILE INSTR(v_temp_str, separatorPrimary) > 0 DO
SET v_str = SUBSTRING_INDEX(v_temp_str, separatorPrimary, 1);
SET v_temp_str = SUBSTRING(v_temp_str FROM LENGTH(v_str) + 2);
SET v_current_count = (LENGTH(v_str) - LENGTH(REPLACE(v_str, separatorSecondary, ''))) / LENGTH(separatorSecondary) + 1;
IF v_current_count > v_max_count THEN
SET v_max_count = v_current_count;
END IF;
END WHILE;

-- Construct dynamic column names for the temporary table
SET v_dynamic_col_names = CONCAT('col1 VARCHAR(255)');
SET v_counter = 2;
WHILE v_counter <= v_max_count DO
SET v_dynamic_col_names = CONCAT(v_dynamic_col_names, ', col', v_counter, ' VARCHAR(255)');
SET v_counter = v_counter + 1;
END WHILE;

-- Create a dynamic temporary table with the maximum number of columns
SET @create_table_sql = CONCAT('CREATE TEMPORARY TABLE IF NOT EXISTS temp_values (', v_dynamic_col_names, ')');
PREPARE stmt FROM @create_table_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Now split the input_string into rows and columns
SET v_temp_str = input_string;
WHILE INSTR(v_temp_str, separatorPrimary) > 0 DO
SET v_str = SUBSTRING_INDEX(v_temp_str, separatorPrimary, 1);
SET v_temp_str = SUBSTRING(v_temp_str FROM LENGTH(v_str) + 2);
SET v_counter = 1;
SET @insert_values = '';
WHILE INSTR(v_str, separatorSecondary) > 0 OR v_str <> '' DO
SET v_sub_str = SUBSTRING_INDEX(v_str, separatorSecondary, 1);
SET v_str = SUBSTRING(v_str FROM LENGTH(v_sub_str) + 2);
IF v_counter = 1 THEN
SET @insert_values = CONCAT('(', QUOTE(v_sub_str));
ELSE
SET @insert_values = CONCAT(@insert_values, ', ', QUOTE(v_sub_str));
END IF;
SET v_counter = v_counter + 1;
END WHILE;
SET @insert_values = CONCAT(@insert_values, ')');
SET @insert_sql = CONCAT('INSERT INTO temp_values VALUES ', @insert_values);
PREPARE stmt FROM @insert_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
END WHILE;

-- Select the values from the temporary table
SELECT * FROM temp_values;
-- Drop the temporary table
DROP TEMPORARY TABLE IF EXISTS temp_values;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SP_GATE_IN_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SP_GATE_IN_SAVE(
IN `P_ID` INT,
IN `P_INWARD_SYS_ID` INT,
IN `P_COMMON_SYS_ID` INT,
IN `P_COMMON_NO` VARCHAR(255),
IN `P_TRANS_SYS_ID` INT,
IN `P_TRANSPORTER_NAME` VARCHAR(255),
IN `P_TRUCK_NO` VARCHAR(255),
IN `P_DRIVER_ID_TYPE` VARCHAR(255),
IN `P_DRIVER_ID_NUMBER` VARCHAR(255),
IN `P_DRIVER_NAME` VARCHAR(255),
IN `P_DRIVER_CONTACT` VARCHAR(255),
IN `P_DRIVER_CHANGED` INT,
IN `P_DRIVER_NAME_NEW` VARCHAR(255),
IN `P_DRIVER_CONTACT_NEW` VARCHAR(255),
IN `P_TRUCK_VALIDATION` INT,
IN `P_RFSYSID` VARCHAR(255),
IN `P_RFID_CODE` VARCHAR(255),
IN `P_RFID_SRNO` VARCHAR(255),
IN `P_RFID_RECEIVE` INT,
IN `P_STATION_ID` INT,
IN `P_ISACTIVE` VARCHAR(255),
IN `P_PLANT_ID` INT,
IN `P_USER_ID` INT,
IN `P_ROLE_ID` INT,
IN `P_MENU_ID` INT,
OUT `P_RESULT` VARCHAR(255)
)
BEGIN
DECLARE TEMP_NUM INT DEFAULT 0;
DECLARE TEMP_COMMON_SYS_ID INT DEFAULT 0;
DECLARE TEMP_RFSYSID INT DEFAULT 0;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

IF COALESCE(P_COMMON_SYS_ID, 0) = 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 THEN
SELECT COUNT(*) INTO TEMP_NUM FROM so_header WHERE SO_NO = P_COMMON_NO;
IF COALESCE(TEMP_NUM, 0) > 0 THEN
SELECT SO_SYS_ID INTO TEMP_COMMON_SYS_ID FROM so_header WHERE SO_NO = P_COMMON_NO LIMIT 1;
END IF;
SET TEMP_NUM = 0;
ELSE
SET TEMP_COMMON_SYS_ID = P_COMMON_SYS_ID;
END IF;

IF COALESCE(P_RFSYSID, 0) <= 0 AND (LENGTH(COALESCE(P_RFID_CODE, '')) > 0 OR LENGTH(COALESCE(P_RFID_SRNO, '')) > 0) THEN
	#SELECT COUNT(*) INTO TEMP_NUM FROM RFID_MASTER WHERE STATUS IN ('Active', 'A') AND (RFIDCODE = COALESCE(P_RFID_CODE, RFIDCODE) OR RFIDSRNO = COALESCE(P_RFID_SRNO, RFIDCODE));
    SELECT COUNT(*) INTO TEMP_NUM FROM RFID_MASTER WHERE STATUS IN ('Active', 'A') AND RFIDSRNO = P_RFID_SRNO;
	IF COALESCE(TEMP_NUM, 0) > 0 THEN
		SELECT RFSYSID INTO TEMP_RFSYSID FROM RFID_MASTER WHERE STATUS IN ('Active', 'A') AND RFIDSRNO = P_RFID_SRNO  LIMIT 1;
	END IF;
		SET TEMP_NUM = 0;
ELSE
	SET TEMP_RFSYSID = P_RFSYSID;
END IF;

SELECT COUNT(*) INTO TEMP_NUM FROM sp_gate_in_out WHERE DATE(GATE_IN_DT) = DATE(CURRENT_DATE) AND INWARD_SYS_ID = COALESCE(P_INWARD_SYS_ID, 0) 
		AND SO_SYS_ID = COALESCE(TEMP_COMMON_SYS_ID, 0) AND GATE_SYS_ID != COALESCE(P_ID, 0);

IF COALESCE(TEMP_NUM, 0) > 0 THEN
SET P_RESULT = 'E|Entered Gate In details already exist.|0';
ELSEIF COALESCE(TEMP_RFSYSID, 0) = 0 THEN
SET P_RESULT = 'E|RFID does not exist or already assigned.|0';
ELSEIF COALESCE(TEMP_COMMON_SYS_ID, 0) = 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 THEN
SET P_RESULT = 'E|MDA No. does not exist.|0';
ELSEIF P_ID > 0 AND COALESCE(TEMP_COMMON_SYS_ID, 0) > 0 THEN
SET P_RESULT = 'S|Record updated successfully|';

ELSEIF COALESCE(TEMP_COMMON_SYS_ID, 0) > 0 THEN
IF COALESCE(P_INWARD_SYS_ID, 0) > 0 THEN
SELECT COALESCE(MAX(GATE_SYS_ID), 0) + 1 INTO TEMP_NUM FROM sp_gate_in_out;

INSERT INTO sp_gate_in_out (
GATE_SYS_ID, GATE_IN_DT, INWARD_SYS_ID, SO_SYS_ID, TRANS_SYS_ID, TRANSPORTER_NAME, TRUCK_NO, 
DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, 
DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION,
RFSYSID, RFID_RECEIVE, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME
)
VALUES (
TEMP_NUM, NOW(), P_INWARD_SYS_ID, TEMP_COMMON_SYS_ID, P_TRANS_SYS_ID, P_TRANSPORTER_NAME, P_TRUCK_NO, 
P_DRIVER_ID_TYPE, P_DRIVER_ID_NUMBER, P_DRIVER_NAME, P_DRIVER_CONTACT, 
IFNULL(P_DRIVER_CHANGED, 0), P_DRIVER_NAME_NEW, P_DRIVER_CONTACT_NEW, IFNULL(P_TRUCK_VALIDATION, 0),
IFNULL(TEMP_RFSYSID, 0), IFNULL(P_RFID_RECEIVE, 0), P_STATION_ID, P_PLANT_ID, P_USER_ID, NOW()
);

UPDATE RFID_MASTER SET STATUS = 'Assigned' WHERE RFSYSID = TEMP_RFSYSID;

SET P_RESULT = 'S|Record saved successfully|';
END IF;


END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SYNC_BATCH_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SYNC_BATCH_SAVE(
    IN P_ID BIGINT,
    IN P_ServiceID BIGINT,
    IN P_Token VARCHAR(255),
    IN P_PlantCd VARCHAR(255),
    IN P_Batch_no VARCHAR(255),
    IN P_Mfg_Date VARCHAR(255),
    IN P_Expiry_Date VARCHAR(255),
    IN P_TOTAL_SHIPPER_QTY BIGINT,
    IN P_ManufacturedBy VARCHAR(255),
    IN P_MarketedBy VARCHAR(255),
    IN P_ShipperQRCode_Data LONGTEXT,
    IN P_PLANT_ID BIGINT,
    IN P_USER_ID BIGINT,
    OUT P_RESULT VARCHAR(16300)
)
BEGIN
    DECLARE TEMP_SHIPPER_ID BIGINT DEFAULT 0;
    DECLARE TEMP_SHIPPER_QRCODE_ID BIGINT DEFAULT 0;
    DECLARE TEMP_BOTTLE_QRCODE_ID BIGINT DEFAULT 0;
    DECLARE TEMP_PLANT_ID BIGINT DEFAULT 0;
    DECLARE TEMP_PRODUCT_ID BIGINT DEFAULT 0;
    DECLARE TEMP_CNT BIGINT DEFAULT 0;

            DECLARE v_counter BIGINT DEFAULT 1;
            DECLARE v_line VARCHAR(16300);
            DECLARE v_shipper_qrcode VARCHAR(16300);
            DECLARE v_action VARCHAR(50);
            DECLARE v_bottle_qty BIGINT DEFAULT 0;
            DECLARE v_bottle_qrcode_list VARCHAR(16300);
            DECLARE v_old_qrcode VARCHAR(255);
            DECLARE v_old_qrcode_id BIGINT DEFAULT 0;
            
                    DECLARE v_bottle_counter BIGINT DEFAULT 1;
                    DECLARE v_bottle_qrcode VARCHAR(255);
                    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;


	START TRANSACTION;
		SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
        
		IF LENGTH(IFNULL(P_ShipperQRCode_Data, '')) > 0 THEN
			IF LENGTH(IFNULL(P_PlantCd, '')) > 0 THEN
				SELECT PLANTID INTO TEMP_PLANT_ID FROM PLANT_MASTER WHERE PLANTCODE = P_PlantCd LIMIT 1;
			END IF;

			IF IFNULL(TEMP_PLANT_ID, 0) <= 0 THEN
				SET TEMP_PLANT_ID = P_PLANT_ID;
			END IF;
                        
		SELECT COUNT(*) INTO TEMP_CNT FROM SHIPPER_QRCODE_API WHERE BATCH_NO = P_Batch_no AND PLANT_ID = TEMP_PLANT_ID AND SHIPPER_QRCODE_API_SYSID != IFNULL(P_ID, 0);

			IF IFNULL(P_ID, 0) <= 0 AND IFNULL(TEMP_CNT, 0) <= 0 THEN
				SELECT IFNULL(MAX(SHIPPER_QRCODE_API_SYSID), 0) + 1 INTO TEMP_SHIPPER_ID FROM SHIPPER_QRCODE_API;

				INSERT INTO SHIPPER_QRCODE_API (
					SHIPPER_QRCODE_API_SYSID, PLANT_ID, BATCH_NO, MFG_DATE, EXPIRY_DATE, 
					TOTAL_SHIPPER_QTY, MARKETEDBY, MANUFACTUREDBY, CREATED_BY, CREATED_DATETIME
				) VALUES (
					TEMP_SHIPPER_ID, TEMP_PLANT_ID, P_Batch_no, 
					STR_TO_DATE(REPLACE(P_Mfg_Date, '-', '/'), '%d/%m/%Y'), 
					STR_TO_DATE(REPLACE(P_Expiry_Date, '-', '/'), '%d/%m/%Y'), 
					P_TOTAL_SHIPPER_QTY, P_MarketedBy, P_ManufacturedBy, P_USER_ID, NOW()
				);
			ELSEIF IFNULL(TEMP_SHIPPER_ID, 0) <= 0 THEN
				SET TEMP_SHIPPER_ID = P_ID;
			END IF;
       
			IF IFNULL(TEMP_CNT, 0) > 0 THEN
				SET P_RESULT = CONCAT('E|Batch No. already exist|', IFNULL(TEMP_SHIPPER_ID, 0));
			ELSEIF IFNULL(TEMP_SHIPPER_ID, 0) > 0 THEN
			
				SET v_shipper_qrcode = '';
				SET v_action = '';
				SET v_bottle_qrcode_list = '';
				SET v_old_qrcode = '';
				SET v_old_qrcode_id = 0;
      
				SET v_counter = 1;
				SET v_line = REGEXP_SUBSTR(P_ShipperQRCode_Data, '[^<#>]+', 1, v_counter);
                
				#SET P_RESULT = CONCAT('E|Record saved successfully', v_line);
                
				WHILE v_line IS NOT NULL DO
                
					SET v_shipper_qrcode = REGEXP_SUBSTR(v_line, '[^|]+', 1, 2);
					SET v_action = REGEXP_SUBSTR(v_line, '[^|]+', 1, 3);
					SET v_bottle_qty = REGEXP_SUBSTR(v_line, '[^|]+', 1, 4);
					SET v_bottle_qrcode_list = REGEXP_SUBSTR(v_line, '[^|]+', 1, 5);
					SET v_old_qrcode = REGEXP_SUBSTR(v_line, '[^|]+', 1, 6);
					SET v_old_qrcode_id = 0;

					IF LENGTH(IFNULL(v_action, '')) > 0 AND LENGTH(IFNULL(v_shipper_qrcode, '')) > 0 THEN
					
						IF (TRIM(UPPER(v_action)) = 'DELETE') AND LENGTH(IFNULL(v_old_qrcode, '')) > 0 THEN
																
							SELECT COUNT(*) INTO TEMP_CNT FROM SHIPPER_QRCODE WHERE SHIPPER_QRCODE = v_old_qrcode AND PLANT_ID = TEMP_PLANT_ID;

							IF IFNULL(TEMP_CNT, 0) = 0 THEN
													
								SELECT SHIPPER_QRCODE_SYSID INTO TEMP_CNT FROM SHIPPER_QRCODE WHERE SHIPPER_QRCODE = v_old_qrcode AND PLANT_ID = TEMP_PLANT_ID  LIMIT 1;
										
									IF IFNULL(TEMP_CNT, 0) > 0 THEN
															
										DELETE FROM bottle_qrcode WHERE SHIPPER_QRCODE_SYSID = TEMP_CNT;
					
										DELETE FROM SHIPPER_QRCODE WHERE SHIPPER_QRCODE_SYSID = TEMP_CNT;
										
										COMMIT;
									END IF;
							END IF;							
						
						END IF;
                        
						SELECT COUNT(*) INTO TEMP_CNT FROM SHIPPER_QRCODE WHERE SHIPPER_QRCODE = v_shipper_qrcode AND ACTION = v_action AND PLANT_ID = TEMP_PLANT_ID;

						IF IFNULL(TEMP_CNT, 0) = 0 THEN
							SELECT IFNULL(MAX(SHIPPER_QRCODE_SYSID), 0) + 1 INTO TEMP_SHIPPER_QRCODE_ID FROM SHIPPER_QRCODE;

							SELECT COUNT(*) INTO TEMP_CNT FROM SHIPPER_QRCODE WHERE SHIPPER_QRCODE = v_old_qrcode AND PLANT_ID = TEMP_PLANT_ID;

							IF IFNULL(TEMP_CNT, 0) = 0 THEN
								SELECT SHIPPER_QRCODE_SYSID INTO v_old_qrcode_id FROM SHIPPER_QRCODE WHERE SHIPPER_QRCODE = v_old_qrcode AND PLANT_ID = TEMP_PLANT_ID LIMIT 1;
							END IF;

							INSERT INTO SHIPPER_QRCODE (
								SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE_API_SYSID, PALLET_QRCODE_API_SYSID, 
								PLANT_ID, EVENTTIME, SHIPPER_QRCODE, OLD_SHIPPER_QRCODE_SYSID, STATUS, 
								ACTION, TOTAL_BOTTLES_QTY, CREATED_BY, CREATED_DATETIME
							) VALUES (
								TEMP_SHIPPER_QRCODE_ID, TEMP_SHIPPER_ID, 0, TEMP_PLANT_ID, 
								NOW(), v_shipper_qrcode, 
								v_old_qrcode_id, 
								'a', v_action, v_bottle_qty, P_USER_ID, NOW()
							);
						                        
							#SET P_RESULT = CONCAT('E|Record saved successfully', TEMP_SHIPPER_QRCODE_ID);
                    
                        END IF;

						IF LENGTH(IFNULL(v_bottle_qrcode_list, '')) > 0 THEN
							SET v_bottle_counter = 1;
							SET v_bottle_qrcode  = '';

							SET v_bottle_qrcode = REGEXP_SUBSTR(v_bottle_qrcode_list, '[^,]+', 1, v_bottle_counter);

							WHILE v_bottle_qrcode IS NOT NULL DO
								SELECT COUNT(*) INTO TEMP_CNT FROM BOTTLE_QRCODE WHERE BOTTLE_QRCODE = v_bottle_qrcode AND PLANT_ID = TEMP_PLANT_ID;

								IF IFNULL(TEMP_CNT, 0) = 0 THEN
									SELECT IFNULL(MAX(BOTTLE_QRCODE_SYSID), 0) + 1 INTO TEMP_BOTTLE_QRCODE_ID FROM BOTTLE_QRCODE;

									SELECT COUNT(*) INTO TEMP_CNT FROM PRODUCT_MASTER WHERE GTIN IN (
										SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(v_bottle_qrcode, ')', -1), '(', 1)
									);

									IF IFNULL(TEMP_CNT, 0) > 0 THEN
										SELECT PROD_SYS_ID INTO TEMP_PRODUCT_ID FROM PRODUCT_MASTER WHERE GTIN IN (
											SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(v_bottle_qrcode, ')', -1), '(', 1)
										) LIMIT 1;
									END IF;

									INSERT INTO BOTTLE_QRCODE (
										BOTTLE_QRCODE_SYSID, SHIPPER_QRCODE_SYSID, PLANT_ID, 
										BOTTLE_QRCODE, PRODUCT_ID, STATUS, CREATED_BY, CREATED_DATETIME
									) VALUES (
										TEMP_BOTTLE_QRCODE_ID, TEMP_SHIPPER_QRCODE_ID, TEMP_PLANT_ID, 
										v_bottle_qrcode, IFNULL(TEMP_PRODUCT_ID, 0), 'a', P_USER_ID, NOW()
									);
								END IF;

								SET v_bottle_counter = v_bottle_counter + 1;
								SET v_bottle_qrcode = REGEXP_SUBSTR(v_bottle_qrcode_list, '[^,]+', 1, v_bottle_counter);
							END WHILE;
						END IF;

                    	
					END IF;
				
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_ShipperQRCode_Data, '[^<#>]+', 1, v_counter);
                    
				END WHILE;
				
                COMMIT;
				SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_SHIPPER_ID);
            
			END IF;
         
		END IF;
        						
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SYNC_PLANT_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SYNC_PLANT_SAVE(
    IN P_JSON_LIST TEXT, 
    IN P_PLANT_CODE VARCHAR(255), 
    IN P_PLANT_ID INT, 
    IN P_USER_ID INT, 
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_PLANT_ID INT DEFAULT 0; 
    -- DECLARE TEMP_PLANT_ID INT DEFAULT 0; 
    DECLARE TEMP_CNT INT DEFAULT 0; 
    
            DECLARE v_counter BIGINT DEFAULT 1;
            DECLARE v_line VARCHAR(16300);
    
    DECLARE done INT DEFAULT 0;

    DECLARE v_plant_cd VARCHAR(255);
    DECLARE v_plant_name VARCHAR(255);
    DECLARE v_plant_name_h VARCHAR(255);
    DECLARE v_state_cd VARCHAR(255);
    DECLARE v_extra1 VARCHAR(255);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact system administrator|0';

    IF LENGTH(IFNULL(P_JSON_LIST, '')) > 0 THEN

				SET v_counter = 1;
				SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^<#>]+', 1, v_counter);
                
				WHILE v_line IS NOT NULL DO
                
					SET v_plant_cd = REGEXP_SUBSTR(v_line, '[^|]+', 1, 1);
					SET v_plant_name = REGEXP_SUBSTR(v_line, '[^|]+', 1, 2);
					SET v_plant_name_h = REGEXP_SUBSTR(v_line, '[^|]+', 1, 3);
					SET v_state_cd = REGEXP_SUBSTR(v_line, '[^|]+', 1, 4);
					SET v_extra1 = REGEXP_SUBSTR(v_line, '[^|]+', 1, 5);

					IF LENGTH(IFNULL(v_plant_cd, '')) > 0 AND LENGTH(IFNULL(v_plant_name, '')) > 0 THEN
							
						SELECT COUNT(*) INTO TEMP_CNT FROM plant_master WHERE PlantCode = v_plant_cd;

						IF IFNULL(TEMP_CNT, 0) = 0 THEN
							
							SELECT IFNULL(MAX(PlantID), 0) + 1 INTO TEMP_PLANT_ID FROM plant_master;

							INSERT INTO plant_master(PlantID, PlantCode, PlantAddress, Plant_Name)
							VALUES (TEMP_PLANT_ID, v_plant_cd, v_state_cd, v_plant_name);

							COMMIT;
						END IF;
					END IF;
				
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^<#>]+', 1, v_counter);
                    
				END WHILE;
				
                COMMIT;
				SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_PLANT_ID);
            
            
			/* WITH RECURSIVE number_sequence AS (
			SELECT 1 AS line_no, 0 AS prev_no
			UNION ALL
			SELECT line_no + 1, line_no
			FROM number_sequence
			WHERE line_no < (SELECT CAST(((LENGTH(your_column) - LENGTH(REPLACE(your_column, '<#>', ''))) / length('<#>')) AS SIGNED) AS OccurrenceOfB
						FROM (SELECT 'D01|NANO ZINC 250 ML|uSuks ftad 250 ,e,y|KL0|99|NANOZ250ML|NANO|NANO|NANO|D|KL1|INDIGENOUS|N|2853|LT|0.25|NO|=<#>D02|NANO COPPER 250 ML|=|KL0|99|NANOC250ML|NANO|NANO|NANO|D|KL1|INDIGENOUS|N|2853|LT|0.25|NO|DU0<#>D03|NANO UREA LIQUID 500 ML KALOL|uSuks ;wfj;k fyDoM 500 ,e,y|KL0|99|NANOU500ML|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D04|NANO DAP LIQUID 500 ML KALOL|uSuks Mh,ih rjy 500 fe-yh- dyksy|KL0|99|NANOD500ML|NANO|NANO|NANO DAP|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DD0<#>D05|NANO DAP LIQUID 500 ML KALOL NV|uSuks Mh,ih rjy 500 fe-yh- dyksy ,uoh|KL0|99|NANOD500NV|NANO|NANO|NANO DAP|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DD0<#>D06|SNU 500 ML KALOL NV|=|KL0|99|SNU500MLNV|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D07|NANO UREA LIQUID 500 ML KALOL (2YR)|uSuks ;wfj;k fyDoM 500 ,e,y|KL0|99|NANOU5KL2Y|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D08|NANO UREA LIQUID 500 ML KALOL NV|=|KL0|99|NANOU500NV|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D09|NANO UREA PLUS 500 ML KALOL|=|KL0|99|NUP500MLKL|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D31|NANO UREA SUPER 500 ML KALOL|=|KL0|99|NUS500ML|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0'  AS your_column) X LIMIT 1)
			)
			SELECT line_no, SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 1), '|', -1) AS column1
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 2), '|', -1), '|', 1) AS column2 
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 3), '|', -1), '|', 1) AS column3  
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 4), '|', -1), '|', 1) AS column4 
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 5), '|', -1), '|', 1) AS column5 
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 6), '|', -1), '|', 1) AS column6  
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 7), '|', -1), '|', 1) AS column7  
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 8), '|', -1), '|', 1) AS column8   
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 9), '|', -1), '|', 1) AS column9  
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 10), '|', -1), '|', 1) AS column10 
			FROM (SELECT line_no, prev_no, REGEXP_SUBSTR(your_column, '[^<#>]+', 1, line_no) line FROM number_sequence
			JOIN 
			(SELECT 'D01|NANO ZINC 250 ML|uSuks ftad 250 ,e,y|KL0|99|NANOZ250ML|NANO|NANO|NANO|D|KL1|INDIGENOUS|N|2853|LT|0.25|NO|=<#>D02|NANO COPPER 250 ML|=|KL0|99|NANOC250ML|NANO|NANO|NANO|D|KL1|INDIGENOUS|N|2853|LT|0.25|NO|DU0<#>D03|NANO UREA LIQUID 500 ML KALOL|uSuks ;wfj;k fyDoM 500 ,e,y|KL0|99|NANOU500ML|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D04|NANO DAP LIQUID 500 ML KALOL|uSuks Mh,ih rjy 500 fe-yh- dyksy|KL0|99|NANOD500ML|NANO|NANO|NANO DAP|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DD0<#>D05|NANO DAP LIQUID 500 ML KALOL NV|uSuks Mh,ih rjy 500 fe-yh- dyksy ,uoh|KL0|99|NANOD500NV|NANO|NANO|NANO DAP|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DD0<#>D06|SNU 500 ML KALOL NV|=|KL0|99|SNU500MLNV|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D07|NANO UREA LIQUID 500 ML KALOL (2YR)|uSuks ;wfj;k fyDoM 500 ,e,y|KL0|99|NANOU5KL2Y|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D08|NANO UREA LIQUID 500 ML KALOL NV|=|KL0|99|NANOU500NV|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D09|NANO UREA PLUS 500 ML KALOL|=|KL0|99|NUP500MLKL|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D31|NANO UREA SUPER 500 ML KALOL|=|KL0|99|NUS500ML|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0' AS your_column) AS subquery
			ON true) Z; */
            
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SYNC_PRODUCT_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SYNC_PRODUCT_SAVE(
    IN P_JSON_LIST VARCHAR(16300),
    IN P_PLANT_CODE VARCHAR(255), 
    IN P_PLANT_ID INT, 
    IN P_USER_ID INT, 
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_PLANT_ID INT DEFAULT 0; 
    DECLARE TEMP_PRODUCT_ID INT DEFAULT 0; 
    DECLARE TEMP_CNT INT DEFAULT 0; 
    
            DECLARE v_counter BIGINT DEFAULT 1;
            DECLARE v_line VARCHAR(16300);
    
    DECLARE done INT DEFAULT 0;

    DECLARE v_prd_cd VARCHAR(255);
    DECLARE v_prd_desc VARCHAR(255);
    DECLARE v_prd_desc_h VARCHAR(255);
    DECLARE v_plant_cd VARCHAR(255);
    DECLARE v_print_order INT;
    DECLARE v_prd_desc_short VARCHAR(255);
    DECLARE v_extra1 VARCHAR(255);
    DECLARE v_extra2 VARCHAR(255);
    DECLARE v_extra3 VARCHAR(255);
    DECLARE v_prd_type VARCHAR(255);
    DECLARE v_sub_plant_cd VARCHAR(255);
    DECLARE v_prd_category VARCHAR(255);
    DECLARE v_active VARCHAR(1);
    DECLARE v_hsn_code VARCHAR(255);
    DECLARE v_uom VARCHAR(255);
    DECLARE v_conv_factor DECIMAL(10,2);
    DECLARE v_uom_evikas VARCHAR(255);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact system administrator|0';

    IF LENGTH(IFNULL(P_JSON_LIST, '')) > 0 THEN        

				SET v_counter = 1;
				SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^<#>]+', 1, v_counter); -- 1#2#3#4#5     1   2#3#4#5
                
				WHILE v_line IS NOT NULL DO
                
					SET v_prd_cd = REGEXP_SUBSTR(v_line, '[^|]+', 1, 1); -- 1#2#3#4#5    1   2#3#4#5
					SET v_prd_desc = REGEXP_SUBSTR(v_line, '[^|]+', 1, 2); -- 1#2#3#4#5    1   2  3#4#5
					SET v_prd_desc_h = REGEXP_SUBSTR(v_line, '[^|]+', 1, 3);
					SET v_plant_cd = REGEXP_SUBSTR(v_line, '[^|]+', 1, 4);
					SET v_print_order = REGEXP_SUBSTR(v_line, '[^|]+', 1, 5);
					SET v_prd_desc_short = REGEXP_SUBSTR(v_line, '[^|]+', 1, 6);
					SET v_extra1 = REGEXP_SUBSTR(v_line, '[^|]+', 1, 7);
					SET v_extra2 = REGEXP_SUBSTR(v_line, '[^|]+', 1, 8);
					SET v_extra3 = REGEXP_SUBSTR(v_line, '[^|]+', 1, 9);
					SET v_prd_type = REGEXP_SUBSTR(v_line, '[^|]+', 1, 10);
					SET v_sub_plant_cd = REGEXP_SUBSTR(v_line, '[^|]+', 1, 11);
					SET v_prd_category = REGEXP_SUBSTR(v_line, '[^|]+', 1, 12);
					SET v_active = REGEXP_SUBSTR(v_line, '[^|]+', 1, 13);
					SET v_hsn_code = REGEXP_SUBSTR(v_line, '[^|]+', 1, 14);
					SET v_uom = REGEXP_SUBSTR(v_line, '[^|]+', 1, 15);
					SET v_conv_factor = REGEXP_SUBSTR(v_line, '[^|]+', 1, 16);
					SET v_uom_evikas = REGEXP_SUBSTR(v_line, '[^|]+', 1, 17);

					IF LENGTH(IFNULL(v_prd_cd, '')) > 0 AND LENGTH(IFNULL(v_prd_desc, '')) > 0 THEN
							IF LENGTH(IFNULL(v_plant_cd, '')) > 0 THEN
								SELECT PLANTID INTO TEMP_PLANT_ID FROM PLANT_MASTER WHERE PLANTCODE = v_plant_cd LIMIT 1;
							END IF;

							IF IFNULL(TEMP_PLANT_ID, 0) <= 0 THEN
								SET TEMP_PLANT_ID = P_PLANT_ID;
							END IF;
                            
						SELECT COUNT(*) INTO TEMP_CNT FROM PRODUCT_MASTER WHERE PRD_CD = v_prd_cd;

						IF IFNULL(TEMP_CNT, 0) = 0 THEN
							
							SELECT IFNULL(MAX(PROD_SYS_ID), 0) + 1 INTO TEMP_PRODUCT_ID FROM PRODUCT_MASTER;

							INSERT INTO PRODUCT_MASTER(PROD_SYS_ID, SKU_CODE, SKU_NAME, PRD_CD, PRD_DESC, PRD_DESC_H, PRD_DESC_SHORT, IS_POSTED,
													   ISACTIVE, PLANT_ID, PLANT_CD, EXTRA1, EXTRA2, EXTRA3, PRD_TYPE, SUB_PLANT_CD, PRD_CATEGORY, ACTIVE,
													   HSN_CODE, UOM, CONV_FACTOR, PRINT_ORDER, UOM_EVIKAS, CREATED_DATETIME)
							VALUES (TEMP_PRODUCT_ID, v_prd_cd, v_prd_desc, v_prd_cd, v_prd_desc, v_prd_desc_h, v_prd_desc_short, 0,
									IF(IFNULL(v_active, '') = 'Y', 1, 0), TEMP_PLANT_ID, v_plant_cd,
									v_extra1, v_extra2, v_extra3, v_prd_type, v_sub_plant_cd, v_prd_category, v_active,
									CAST(v_hsn_code AS DECIMAL), v_uom, CAST(v_conv_factor AS DECIMAL), CAST(v_print_order AS DECIMAL),
									v_uom_evikas, NOW());

							COMMIT;
						END IF;
					END IF;
				
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^<#>]+', 1, v_counter); -- 1#2#3#4#5     1   2#3#4#5
																						-- 1#2#3#4#5     5
                                                                                        -- 6
                    
				END WHILE;
				
                COMMIT;
				SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_PRODUCT_ID);
            
            /*
			WITH RECURSIVE number_sequence AS (
			SELECT 1 AS line_no, 0 AS prev_no
			UNION ALL
			SELECT line_no + 1, line_no
			FROM number_sequence
			WHERE line_no < (SELECT CAST(((LENGTH(your_column) - LENGTH(REPLACE(your_column, '<#>', ''))) / length('<#>')) AS SIGNED) AS OccurrenceOfB
						FROM (SELECT 'D01|NANO ZINC 250 ML|uSuks ftad 250 ,e,y|KL0|99|NANOZ250ML|NANO|NANO|NANO|D|KL1|INDIGENOUS|N|2853|LT|0.25|NO|=<#>D02|NANO COPPER 250 ML|=|KL0|99|NANOC250ML|NANO|NANO|NANO|D|KL1|INDIGENOUS|N|2853|LT|0.25|NO|DU0<#>D03|NANO UREA LIQUID 500 ML KALOL|uSuks ;wfj;k fyDoM 500 ,e,y|KL0|99|NANOU500ML|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D04|NANO DAP LIQUID 500 ML KALOL|uSuks Mh,ih rjy 500 fe-yh- dyksy|KL0|99|NANOD500ML|NANO|NANO|NANO DAP|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DD0<#>D05|NANO DAP LIQUID 500 ML KALOL NV|uSuks Mh,ih rjy 500 fe-yh- dyksy ,uoh|KL0|99|NANOD500NV|NANO|NANO|NANO DAP|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DD0<#>D06|SNU 500 ML KALOL NV|=|KL0|99|SNU500MLNV|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D07|NANO UREA LIQUID 500 ML KALOL (2YR)|uSuks ;wfj;k fyDoM 500 ,e,y|KL0|99|NANOU5KL2Y|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D08|NANO UREA LIQUID 500 ML KALOL NV|=|KL0|99|NANOU500NV|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D09|NANO UREA PLUS 500 ML KALOL|=|KL0|99|NUP500MLKL|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D31|NANO UREA SUPER 500 ML KALOL|=|KL0|99|NUS500ML|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0'  AS your_column) X LIMIT 1)
			)
			SELECT line_no, SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 1), '|', -1) AS column1
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 2), '|', -1), '|', 1) AS column2 
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 3), '|', -1), '|', 1) AS column3  
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 4), '|', -1), '|', 1) AS column4 
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 5), '|', -1), '|', 1) AS column5 
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 6), '|', -1), '|', 1) AS column6  
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 7), '|', -1), '|', 1) AS column7  
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 8), '|', -1), '|', 1) AS column8   
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 9), '|', -1), '|', 1) AS column9  
				   ,SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(line, '|', 10), '|', -1), '|', 1) AS column10 
			FROM (SELECT line_no, prev_no, REGEXP_SUBSTR(your_column, '[^<#>]+', 1, line_no) line FROM number_sequence
			JOIN 
			(SELECT 'D01|NANO ZINC 250 ML|uSuks ftad 250 ,e,y|KL0|99|NANOZ250ML|NANO|NANO|NANO|D|KL1|INDIGENOUS|N|2853|LT|0.25|NO|=<#>D02|NANO COPPER 250 ML|=|KL0|99|NANOC250ML|NANO|NANO|NANO|D|KL1|INDIGENOUS|N|2853|LT|0.25|NO|DU0<#>D03|NANO UREA LIQUID 500 ML KALOL|uSuks ;wfj;k fyDoM 500 ,e,y|KL0|99|NANOU500ML|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D04|NANO DAP LIQUID 500 ML KALOL|uSuks Mh,ih rjy 500 fe-yh- dyksy|KL0|99|NANOD500ML|NANO|NANO|NANO DAP|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DD0<#>D05|NANO DAP LIQUID 500 ML KALOL NV|uSuks Mh,ih rjy 500 fe-yh- dyksy ,uoh|KL0|99|NANOD500NV|NANO|NANO|NANO DAP|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DD0<#>D06|SNU 500 ML KALOL NV|=|KL0|99|SNU500MLNV|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D07|NANO UREA LIQUID 500 ML KALOL (2YR)|uSuks ;wfj;k fyDoM 500 ,e,y|KL0|99|NANOU5KL2Y|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D08|NANO UREA LIQUID 500 ML KALOL NV|=|KL0|99|NANOU500NV|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D09|NANO UREA PLUS 500 ML KALOL|=|KL0|99|NUP500MLKL|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0<#>D31|NANO UREA SUPER 500 ML KALOL|=|KL0|99|NUS500ML|NANO|NANO|NANO UREA|D|KL1|INDIGENOUS|Y|31051000|LT|0.5|NO|DU0' AS your_column) AS subquery
			ON true) Z; 
            */
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SYNC_RETAILER_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SYNC_RETAILER_SAVE(
    IN P_JSON_LIST LONGTEXT,
    IN P_PLANT_CODE VARCHAR(255), 
    IN P_PLANT_ID INT, 
    IN P_USER_ID INT, 
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_PLANT_ID INT DEFAULT 0; 
    DECLARE TEMP_Retailer_ID INT DEFAULT 0; 
    DECLARE TEMP_CNT INT DEFAULT 0; 
    
	   DECLARE v_counter BIGINT DEFAULT 1;
	   DECLARE v_line LONGTEXT;
    
    DECLARE done INT DEFAULT 0;

		DECLARE v_party_cd VARCHAR(255);
		DECLARE v_party_name VARCHAR(255);
		DECLARE v_addr1 VARCHAR(255);
		DECLARE v_tehsil_cd VARCHAR(255);
		DECLARE v_party_name_h VARCHAR(255);
		DECLARE v_pin_cd VARCHAR(255);
		DECLARE v_tin_no VARCHAR(255);
		DECLARE v_credit_limit VARCHAR(255);
		DECLARE v_warehousing VARCHAR(255);
		DECLARE v_handling VARCHAR(255);
		DECLARE v_sales VARCHAR(255);
		DECLARE v_tptn VARCHAR(255);
		DECLARE v_inv VARCHAR(255);
		DECLARE v_agency_cd VARCHAR(255);
		DECLARE v_distt_cd VARCHAR(255);
		DECLARE v_state_cd VARCHAR(255);
		DECLARE v_wh_capacity VARCHAR(255);
		DECLARE v_reserved_by_iffco VARCHAR(255);
		DECLARE v_consignee VARCHAR(255);
		DECLARE v_addr2 VARCHAR(255);
		DECLARE v_fsc VARCHAR(255);
		DECLARE v_port_wh VARCHAR(255);
		DECLARE v_active VARCHAR(255);
		DECLARE v_retailer_license_no VARCHAR(255);
		DECLARE v_dealer_type VARCHAR(255);
		DECLARE v_dealer_nature VARCHAR(255);
		DECLARE v_pan_no VARCHAR(255);
		DECLARE v_mobile_no VARCHAR(255);
		DECLARE v_panchayat VARCHAR(255);
		DECLARE v_village_cd VARCHAR(255);
		DECLARE v_village_name VARCHAR(255);
		DECLARE v_nic_village_cd VARCHAR(255);
		DECLARE v_text VARCHAR(255);
		DECLARE v_mfms_id VARCHAR(255);
		DECLARE v_tin_no_effective_dt VARCHAR(255);
		DECLARE v_rkvy VARCHAR(255);
		DECLARE v_fertiliser_lecence_validity VARCHAR(255);
		DECLARE v_virtual_entity VARCHAR(255);
		DECLARE v_contact_person VARCHAR(255);
		DECLARE v_gstin VARCHAR(255);
		DECLARE v_gstin_effective_dt VARCHAR(255);
		DECLARE v_gstin_effective_to_dt VARCHAR(255);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact system administrator|0';

    IF LENGTH(IFNULL(P_JSON_LIST, '')) > 0 THEN
        IF LENGTH(IFNULL(P_PLANT_CODE, '')) > 0 THEN
            SELECT PLANTID INTO TEMP_PLANT_ID FROM PLANT_MASTER WHERE PLANTCODE = P_PLANT_CODE LIMIT 1;
        END IF;

        IF IFNULL(TEMP_PLANT_ID, 0) <= 0 THEN
            SET TEMP_PLANT_ID = P_PLANT_ID;
        END IF;

				SET v_counter = 1;
				SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^<#>]+', 1, v_counter); -- 1#2#3#4#5     1   2#3#4#5
                
				WHILE v_line IS NOT NULL DO  
                
					SET v_party_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 1) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 1));
					SET v_party_name = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 2) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 2));
					SET v_addr1 = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 3) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 3));
					SET v_tehsil_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 4) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 4));
					SET v_party_name_h = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 5) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 5));
					SET v_pin_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 6) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 6));
					SET v_tin_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 7) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 7));
					SET v_credit_limit = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 8) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 8));
					SET v_warehousing = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 9) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 9));
					SET v_handling = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 10) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 10));
					SET v_sales = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 11) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 11));
					SET v_tptn = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 12) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 12));
					SET v_inv = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 13) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 13));
					SET v_agency_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 14) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 14));
					SET v_distt_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 15) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 15));
					SET v_state_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 16) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 16));
					SET v_wh_capacity = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 17) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 17));
					SET v_reserved_by_iffco = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 18) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 18));
					SET v_consignee = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 19) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 19));
					SET v_addr2 = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 20) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 20));
					SET v_fsc = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 21) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 21));
					SET v_port_wh = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 22) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 22));
					SET v_active = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 23) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 23));
					SET v_retailer_license_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 24) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 24));
					SET v_dealer_type = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 25) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 25));
					SET v_dealer_nature = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 26) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 26));
					SET v_pan_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 27) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 27));
					SET v_mobile_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 28) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 28));
					SET v_panchayat = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 29) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 29));
					SET v_village_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 30) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 30));
					SET v_village_name = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 31) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 31));
					SET v_nic_village_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 32) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 32));
					SET v_text = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 33) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 33));
					SET v_mfms_id = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 34) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 34));
					SET v_tin_no_effective_dt = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 35) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 35));
					SET v_rkvy = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 36) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 36));
					SET v_fertiliser_lecence_validity = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 37) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 37));
					SET v_virtual_entity = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 38) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 38));
					SET v_contact_person = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 39) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 39));
					SET v_gstin = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 40) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 40));
					SET v_gstin_effective_dt = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 41) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 41));
					SET v_gstin_effective_to_dt = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 42) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 42));
                   

					IF LENGTH(IFNULL(v_party_cd, '')) > 0 AND LENGTH(IFNULL(v_party_name, '')) > 0 THEN
							
						SELECT COUNT(*) INTO TEMP_CNT FROM retailer_new WHERE PARTY_CD = v_party_cd AND PLANT_ID = TEMP_PLANT_ID;

						IF IFNULL(TEMP_CNT, 0) = 0 THEN
							
							SELECT IFNULL(MAX(ID), 0) + 1 INTO TEMP_Retailer_ID FROM retailer_new;
                            
                           INSERT INTO retailer_new (
							ID, PLANT_ID, party_cd, party_name, addr1, tehsil_cd, party_name_h, pin_cd, tin_no, credit_limit, 
							warehousing, handling, sales, tptn, inv, agency_cd, distt_cd, state_cd, wh_capacity, reserved_by_iffco, 
							consignee, addr2, fsc, port_wh, active, retailer_license_no, dealer_type, dealer_nature, pan_no, mobile_no, 
							panchayat, village_cd, village_name, nic_village_cd, text, mfms_id, tin_no_effective_dt, rkvy, 
							fertiliser_lecence_validity, virtual_entity, contact_person, gstin, gstin_effective_dt, gstin_effective_to_dt, 
							CREATED_DATETIME
						) VALUES (
							TEMP_Retailer_ID, TEMP_PLANT_ID, v_party_cd, v_party_name, v_addr1, v_tehsil_cd, v_party_name_h, v_pin_cd, 
							v_tin_no, v_credit_limit, v_warehousing, v_handling, v_sales, v_tptn, v_inv, v_agency_cd, v_distt_cd, 
							v_state_cd, v_wh_capacity, v_reserved_by_iffco, v_consignee, v_addr2, v_fsc, v_port_wh, 
							v_active, v_retailer_license_no, v_dealer_type, v_dealer_nature, v_pan_no, v_mobile_no, v_panchayat, 
							v_village_cd, v_village_name, v_nic_village_cd, v_text, v_mfms_id, 
							v_tin_no_effective_dt, v_rkvy, 
							v_fertiliser_lecence_validity, v_virtual_entity, v_contact_person, v_gstin, 
							v_gstin_effective_dt,v_gstin_effective_to_dt, 
							NOW()
						);                            
							COMMIT;
						END IF;
					END IF;
				
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^<#>]+', 1, v_counter);				
                    
				END WHILE;
				
                COMMIT;
				SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_Retailer_ID);            
          
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SYNC_WAREHOUSE_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SYNC_WAREHOUSE_SAVE(
    IN P_JSON_LIST LONGTEXT,
    IN P_PLANT_CODE VARCHAR(255), 
    IN P_PLANT_ID INT, 
    IN P_USER_ID INT, 
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_PLANT_ID INT DEFAULT 0; 
    DECLARE TEMP_WAREHOUSE_ID INT DEFAULT 0; 
    DECLARE TEMP_CNT INT DEFAULT 0; 
    
   DECLARE v_counter BIGINT DEFAULT 1;
   DECLARE v_line LONGTEXT;
    
    DECLARE done INT DEFAULT 0;

    DECLARE v_party_cd VARCHAR(255);
	DECLARE v_party_name VARCHAR(255);
	DECLARE v_addr1 VARCHAR(255);
	DECLARE v_tehsil_cd VARCHAR(255);
	DECLARE v_party_name_h VARCHAR(255);
	DECLARE v_pin_cd VARCHAR(255);
	DECLARE v_tin_no VARCHAR(255);
	DECLARE v_email VARCHAR(255);
	DECLARE v_warehousing VARCHAR(255);
	DECLARE v_handling VARCHAR(255);
	DECLARE v_sales VARCHAR(255);
	DECLARE v_tptn VARCHAR(255);
	DECLARE v_inv VARCHAR(255);
	DECLARE v_agency_cd VARCHAR(255);
	DECLARE v_distt_cd VARCHAR(255);
	DECLARE v_state_cd VARCHAR(255);
	DECLARE v_wh_capacity VARCHAR(255);
	DECLARE v_consignee VARCHAR(255);
	DECLARE v_party_fas_cd VARCHAR(255);
	DECLARE v_fsc VARCHAR(255);
	DECLARE v_port_wh VARCHAR(255);
	DECLARE v_active VARCHAR(255);
	DECLARE v_retailer_license_no VARCHAR(255);
	DECLARE v_dealer_type VARCHAR(255);
	DECLARE v_dealer_nature VARCHAR(255);
	DECLARE v_wholesales_license_no VARCHAR(255);
	DECLARE v_pan_no VARCHAR(255);
	DECLARE v_mobile_no VARCHAR(255);
	DECLARE v_panchayat VARCHAR(255);
	DECLARE v_urban_name VARCHAR(255);
	DECLARE v_ward_name VARCHAR(255);
	DECLARE v_village_name VARCHAR(255);
	DECLARE v_tin_no_effective_dt VARCHAR(255);
	DECLARE v_rkvy VARCHAR(255);
	DECLARE v_fertiliser_lecence_validity VARCHAR(255);
	DECLARE v_virtual_entity VARCHAR(255);
	DECLARE v_gstin VARCHAR(255);
	DECLARE v_gstin_effective_dt VARCHAR(255);
	DECLARE v_longitude VARCHAR(255);
	DECLARE v_latitude VARCHAR(255);
	DECLARE v_stocking_point_flag VARCHAR(255);
	DECLARE v_speciality_fertiliser_activist VARCHAR(255);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact system administrator|0';

    IF LENGTH(IFNULL(P_JSON_LIST, '')) > 0 THEN
        IF LENGTH(IFNULL(P_PLANT_CODE, '')) > 0 THEN
            SELECT PLANTID INTO TEMP_PLANT_ID FROM PLANT_MASTER WHERE PLANTCODE = P_PLANT_CODE LIMIT 1;
        END IF;

        IF IFNULL(TEMP_PLANT_ID, 0) <= 0 THEN
            SET TEMP_PLANT_ID = P_PLANT_ID;
        END IF;

				SET v_counter = 1;
				SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^<#>]+', 1, v_counter); -- 1#2#3#4#5     1   2#3#4#5
                
				WHILE v_line IS NOT NULL DO
                
                SET v_party_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 1) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 1));
				SET v_party_name = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 2) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 2));
				SET v_addr1 = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 3) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 3));
				SET v_tehsil_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 4) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 4));
				SET v_party_name_h = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 5) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 5));
				SET v_pin_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 6) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 6));
				SET v_tin_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 7) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 7));
				SET v_email = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 8) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 8));
				SET v_warehousing = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 9) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 9));
				SET v_handling = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 10) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 10));
				SET v_sales = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 11) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 11));
				SET v_tptn = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 12) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 12));
				SET v_inv = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 13) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 13));
				SET v_agency_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 14) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 14));
				SET v_distt_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 15) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 15));
				SET v_state_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 16) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 16));
				SET v_wh_capacity = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 17) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 17));
				SET v_consignee = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 18) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 18));
				SET v_party_fas_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 19) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 19));
				SET v_fsc = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 20) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 20));
				SET v_port_wh = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 21) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 21));
				SET v_active = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 22) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 22));
				SET v_retailer_license_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 23) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 23));
				SET v_dealer_type = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 24) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 24));
				SET v_dealer_nature = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 25) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 25));
				SET v_wholesales_license_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 26) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 26));
				SET v_pan_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 27) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 27));
				SET v_mobile_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 28) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 28));
				SET v_panchayat = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 29) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 29));
				SET v_urban_name = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 30) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 30));
				SET v_ward_name = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 31) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 31));
				SET v_village_name = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 32) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 32));
				SET v_tin_no_effective_dt = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 33) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 33));
				SET v_rkvy = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 34) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 34));
				SET v_fertiliser_lecence_validity = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 35) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 35));
				SET v_virtual_entity = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 36) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 36));
				SET v_gstin = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 37) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 37));
				SET v_gstin_effective_dt = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 38) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 38));
				SET v_longitude = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 39) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 39));
				SET v_latitude = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 40) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 40));
				SET v_stocking_point_flag = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 41) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 41));
				SET v_speciality_fertiliser_activist = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 42) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 42));

					IF LENGTH(IFNULL(v_party_cd, '')) > 0 AND LENGTH(IFNULL(v_party_name, '')) > 0 THEN
							
						SELECT COUNT(*) INTO TEMP_CNT FROM WAREHOUSE WHERE PARTY_CD = v_party_cd AND PLANT_ID = TEMP_PLANT_ID;

						IF IFNULL(TEMP_CNT, 0) = 0 THEN
							
							SELECT IFNULL(MAX(ID), 0) + 1 INTO TEMP_WAREHOUSE_ID FROM WAREHOUSE;
                                    
                            INSERT INTO WAREHOUSE (
								ID, PLANT_ID, PARTY_CD, PARTY_NAME, ADDR1, TEHSIL_CD, PARTY_NAME_H, PIN_CD, TIN_NO, EMAIL, 
								WAREHOUSING, HANDLING, SALES, TPTN, INV, AGENCY_CD, DISTT_CD, STATE_CD, 
								WH_CAPACITY, CONSIGNEE, PARTY_FAS_CD, FSC, PORT_WH, ACTIVE, 
								RETAILER_LICENSE_NO, DEALER_TYPE, DEALER_NATURE, WHOLESALES_LICENSE_NO, 
								PAN_NO, MOBILE_NO, PANCHAYAT, URBAN_NAME, WARD_NAME, VILLAGE_NAME, 
								TIN_NO_EFFECTIVE_DT, RKVY, FERTILISER_LECENCE_VALIDITY, VIRTUAL_ENTITY, 
								GSTIN, GSTIN_EFFECTIVE_DT, LONGITUDE, LATITUDE, STOCKING_POINT_FLAG, 
								SPECIALITY_FERTILISER_ACTIVIST, CREATED_DATETIME
							) VALUES (
								TEMP_WAREHOUSE_ID, TEMP_PLANT_ID, v_party_cd, v_party_name, v_addr1, v_tehsil_cd, v_party_name_h, v_pin_cd, v_tin_no, v_email, 
								v_warehousing, v_handling, v_sales, v_tptn, v_inv, v_agency_cd, v_distt_cd, v_state_cd, 
								v_wh_capacity, v_consignee, v_party_fas_cd, v_fsc, v_port_wh, v_active, -- IF(IFNULL(v_active, '') = 'Y', 1, 0), 
								v_retailer_license_no, v_dealer_type, v_dealer_nature, v_wholesales_license_no, 
								v_pan_no, v_mobile_no, v_panchayat, v_urban_name, v_ward_name, v_village_name, 
								v_tin_no_effective_dt, v_rkvy, v_fertiliser_lecence_validity, v_virtual_entity, 
								v_gstin, v_gstin_effective_dt, v_longitude, v_latitude, v_stocking_point_flag, 
								v_speciality_fertiliser_activist, NOW()
							); 
                            
							COMMIT;
						END IF;
					END IF;
				
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^<#>]+', 1, v_counter);				
                    
				END WHILE;
				
                COMMIT;
				SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_WAREHOUSE_ID);            
          
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_SYNC_WHOLESALER_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_SYNC_WHOLESALER_SAVE(
    IN P_JSON_LIST LONGTEXT,
    IN P_PLANT_CODE VARCHAR(255), 
    IN P_PLANT_ID INT, 
    IN P_USER_ID INT, 
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_PLANT_ID INT DEFAULT 0; 
    DECLARE TEMP_Wholesaler_ID INT DEFAULT 0; 
    DECLARE TEMP_CNT INT DEFAULT 0; 
    
   DECLARE v_counter BIGINT DEFAULT 1;
   DECLARE v_line LONGTEXT;
    
    DECLARE done INT DEFAULT 0;

    DECLARE v_party_cd VARCHAR(255);
	DECLARE v_party_name VARCHAR(255);
	DECLARE v_addr1 VARCHAR(255);
	DECLARE v_tehsil_cd VARCHAR(255);
	DECLARE v_pin_cd VARCHAR(255);
	DECLARE v_phone_no_1 VARCHAR(20);
	DECLARE v_tin_no VARCHAR(255);
	DECLARE v_email VARCHAR(255);
	DECLARE v_warehousing VARCHAR(255);
	DECLARE v_handling VARCHAR(255);
	DECLARE v_sales VARCHAR(255);
	DECLARE v_tptn VARCHAR(255);
	DECLARE v_inv VARCHAR(255);
	DECLARE v_agency_cd VARCHAR(255);
	DECLARE v_distt_cd VARCHAR(255);
	DECLARE v_state_cd VARCHAR(255);
	DECLARE v_wh_capacity VARCHAR(255);
	DECLARE v_consignee VARCHAR(255);
	DECLARE v_fsc VARCHAR(255);
	DECLARE v_port_wh VARCHAR(255);
	DECLARE v_active VARCHAR(255);
	DECLARE v_dealer_type VARCHAR(255);
	DECLARE v_dealer_nature VARCHAR(255);
	DECLARE v_wholesales_license_no VARCHAR(255);
	DECLARE v_pan_no VARCHAR(255);
	DECLARE v_mobile_no VARCHAR(255);
	DECLARE v_panchayat VARCHAR(255);
	DECLARE v_village_cd VARCHAR(255);
	DECLARE v_village_name VARCHAR(255);
	DECLARE v_nic_village_cd VARCHAR(255);
	DECLARE v_text VARCHAR(255);
	DECLARE v_mfms_id_wholesaler VARCHAR(255);
	DECLARE v_tin_no_effective_dt VARCHAR(255);
	DECLARE v_rkvy VARCHAR(255);
	DECLARE v_fertiliser_lecence_validity VARCHAR(255);
	DECLARE v_virtual_entity VARCHAR(255);
	DECLARE v_gstin VARCHAR(255);
	DECLARE v_gstin_effective_dt VARCHAR(255);
	DECLARE v_speciality_fertiliser_activist VARCHAR(255);

    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact system administrator|0';

    IF LENGTH(IFNULL(P_JSON_LIST, '')) > 0 THEN
        IF LENGTH(IFNULL(P_PLANT_CODE, '')) > 0 THEN
            SELECT PLANTID INTO TEMP_PLANT_ID FROM PLANT_MASTER WHERE PLANTCODE = P_PLANT_CODE LIMIT 1;
        END IF;

        IF IFNULL(TEMP_PLANT_ID, 0) <= 0 THEN
            SET TEMP_PLANT_ID = P_PLANT_ID;
        END IF;

				SET v_counter = 1;
				SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^<#>]+', 1, v_counter); -- 1#2#3#4#5     1   2#3#4#5
                
				WHILE v_line IS NOT NULL DO
                
                SET v_party_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 1) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 1));
				SET v_party_name = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 2) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 2));
				SET v_addr1 = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 3) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 3));
				SET v_tehsil_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 4) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 4));
				SET v_pin_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 5) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 5));
				SET v_phone_no_1 = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 6) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 6));
				SET v_tin_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 7) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 7));
				SET v_email = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 8) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 8));
				SET v_warehousing = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 9) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 9));
				SET v_handling = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 10) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 10));
				SET v_sales = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 11) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 11));
				SET v_tptn = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 12) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 12));
				SET v_inv = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 13) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 13));
				SET v_agency_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 14) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 14));
				SET v_distt_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 15) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 15));
				SET v_state_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 16) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 16));
				SET v_wh_capacity = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 17) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 17));
				SET v_consignee = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 18) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 18));
				SET v_fsc = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 19) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 19));
				SET v_port_wh = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 20) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 20));
				SET v_active = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 21) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 21));
				SET v_dealer_type = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 22) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 22));
				SET v_dealer_nature = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 23) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 23));
				SET v_wholesales_license_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 24) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 24));
				SET v_pan_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 25) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 25));
				SET v_mobile_no = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 26) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 26));
				SET v_panchayat = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 27) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 27));
				SET v_village_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 28) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 28));
				SET v_village_name = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 29) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 29));
				SET v_nic_village_cd = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 30) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 30));
				SET v_text = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 31) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 31));
				SET v_mfms_id_wholesaler = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 32) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 32));
				SET v_tin_no_effective_dt = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 33) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 33));
				SET v_rkvy = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 34) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 34));
				SET v_fertiliser_lecence_validity = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 35) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 35));
				SET v_virtual_entity = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 36) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 36));
				SET v_gstin = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 37) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 37));
				SET v_gstin_effective_dt = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 38) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 38));
				SET v_speciality_fertiliser_activist = IF(REGEXP_SUBSTR(v_line, '[^|]+', 1, 39) = '=', NULL, REGEXP_SUBSTR(v_line, '[^|]+', 1, 39));

					IF LENGTH(IFNULL(v_party_cd, '')) > 0 AND LENGTH(IFNULL(v_party_name, '')) > 0 THEN
							
						SELECT COUNT(*) INTO TEMP_CNT FROM Wholesaler WHERE PARTY_CD = v_party_cd AND PLANT_ID = TEMP_PLANT_ID;

						IF IFNULL(TEMP_CNT, 0) = 0 THEN
							
							SELECT IFNULL(MAX(ID), 0) + 1 INTO TEMP_Wholesaler_ID FROM Wholesaler;
                            
                            INSERT INTO Wholesaler (
							  ID, PLANT_ID, party_cd, party_name, addr1, tehsil_cd, 
							  pin_cd, phone_no_1, tin_no, email, 
							  warehousing, handling, sales, tptn, 
							  inv, agency_cd, distt_cd, state_cd, 
							  wh_capacity, consignee, fsc, port_wh, 
							  active, dealer_type, dealer_nature, 
							  wholesales_license_no, pan_no, mobile_no, 
							  panchayat, village_cd, village_name, 
							  nic_village_cd, text, mfms_id_wholesaler, 
							  tin_no_effective_dt, rkvy, fertiliser_lecence_validity, 
							  virtual_entity, gstin, gstin_effective_dt, 
							  speciality_fertiliser_activist, CREATED_DATETIME
							) 
							VALUES 
							  (
								TEMP_Wholesaler_ID, TEMP_PLANT_ID, v_party_cd, v_party_name, v_addr1, 
								v_tehsil_cd, v_pin_cd, v_phone_no_1, 
								v_tin_no, v_email, v_warehousing, 
								v_handling, v_sales, v_tptn, v_inv, 
								v_agency_cd, v_distt_cd, v_state_cd, 
								v_wh_capacity, v_consignee, v_fsc, 
								v_port_wh, v_active, v_dealer_type, 
								v_dealer_nature, v_wholesales_license_no, 
								v_pan_no, v_mobile_no, v_panchayat, 
								v_village_cd, v_village_name, v_nic_village_cd, 
								v_text, v_mfms_id_wholesaler, v_tin_no_effective_dt, 
								v_rkvy, v_fertiliser_lecence_validity, 
								v_virtual_entity, v_gstin, v_gstin_effective_dt, 
								v_speciality_fertiliser_activist, NOW()
							  );
                            
							COMMIT;
						END IF;
					END IF;
				
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_JSON_LIST, '[^<#>]+', 1, v_counter);				
                    
				END WHILE;
				
                COMMIT;
				SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_Wholesaler_ID);            
          
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_TRANSPORTER_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_TRANSPORTER_GET(
    IN P_ID INT,
    IN P_ISACTIVE VARCHAR(1),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #,    OUT P_RESULT CURSOR
)
BEGIN
    IF P_ID > 0 THEN
        SELECT TRANS_SYS_ID AS ID, TPTR_NAME AS NAME, TPTR_CD, IS_ENTRY_MANUAL, PLANT_ID, CASE WHEN X.IS_ACTIVE = 'Y' THEN 1 ELSE 0 END AS IS_ACTIVE
        FROM TRANSPORTER_MASTER X
        WHERE PLANT_ID = P_PLANT_ID AND X.TRANS_SYS_ID = P_ID; -- AND X.IS_ACTIVE = CASE WHEN IFNULL(P_ISACTIVE, '') = '' THEN X.IS_ACTIVE ELSE P_ISACTIVE END;
    ELSE
        SELECT TRANS_SYS_ID AS ID, TPTR_NAME AS NAME, TPTR_CD, IS_ENTRY_MANUAL, PLANT_ID, CASE WHEN X.IS_ACTIVE = 'Y' THEN 1 ELSE 0 END AS IS_ACTIVE
        FROM TRANSPORTER_MASTER X
        WHERE PLANT_ID = P_PLANT_ID; -- AND 1 = CASE WHEN IFNULL(P_ISACTIVE, '') = '' THEN 1 ELSE (CASE WHEN X.IS_ACTIVE = P_ISACTIVE THEN 1 ELSE 0 END) END;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_USER_DELETE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_USER_DELETE(
    IN P_ID INT,
    IN P_ISACTIVE VARCHAR(1),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_NUM INT;
    
    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT = 'E|You are not authorized to perform this operation.|0';    
    #ELSE
    IF P_ID > 0 THEN
        
        DELETE FROM USER_MASTER_NEW WHERE ID = P_ID AND IS_ACTIVE = COALESCE(P_ISACTIVE, IS_ACTIVE);
        
        SET P_RESULT = 'S|Record deleted successfully|';
        
    END IF;


    -- Error handling
    -- Error handling in MySQL stored procedures is simpler compared to Oracle
    -- You might want to handle exceptions based on specific error codes
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_USER_DELETE_NEW */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_USER_DELETE_NEW(
    IN P_ID INT,
    IN P_ISACTIVE VARCHAR(1),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_NUM INT;
    
    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT = 'E|You are not authorized to perform this operation.|0';    
    #ELSE
    IF P_ID > 0 THEN
        
        DELETE FROM system_users WHERE ID = P_ID AND IS_ACTIVE = COALESCE(P_ISACTIVE, IS_ACTIVE);
        
        SET P_RESULT = 'S|Record deleted successfully|';
        
    END IF;


    -- Error handling
    -- Error handling in MySQL stored procedures is simpler compared to Oracle
    -- You might want to handle exceptions based on specific error codes
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_USER_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_USER_GET(
    IN P_ID INT,
    IN P_ISACTIVE VARCHAR(1),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #OUT P_RESULT CURSOR
)
BEGIN
    
    DECLARE STRPLANTROLE VARCHAR(2000);
    DECLARE DEFAULT_PLANT INT;
    DECLARE TEMP_NUM INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error
        ROLLBACK;
    END;
    
    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) > 0 THEN
        IF P_ID > 0 THEN
            SELECT GROUP_CONCAT(PLANT_ROLE SEPARATOR ',') INTO STRPLANTROLE
            FROM (
                SELECT DISTINCT PLANT_ID, ROLE_ID, CONCAT(PLANT_ID, '|', ROLE_ID) AS PLANT_ROLE
                FROM USER_ROLE_NEW
                WHERE USER_ID = P_ID
            ) AS temp;
            
            /*
            SELECT COUNT(*) INTO TEMP_NUM
            FROM USER_ROLE_NEW X
            WHERE USER_ID = P_ID AND IS_DEFAULT = 'Y';
            
            IF COALESCE(TEMP_NUM, 0) > 0 THEN
                SELECT PLANT_ID INTO DEFAULT_PLANT
                FROM USER_ROLE_NEW
                WHERE USER_ID = P_ID AND IS_DEFAULT = 'Y' LIMIT 1;
            END IF;
			*/
            
            #OPEN P_RESULT FOR
            SELECT Y.PLANT_ID, ZZ.Plant_Name, Y.ROLE_ID, Z.Role_Name, X.ID, X.USER_NAME, USER_PASSWORD, FIRST_NAME, MIDDLE_NAME, LAST_NAME, MOBILE_NO, ALT_MOBILE_NO, EMAIL_ID, ALT_EMAIL_ID, FULL_ADDRESS, COUNTRY_ID, STATE_ID, DISTRICT_ID, CITY, POSTAL_CODE, EMP_CODE, EMP_DESIGNATION_ID, EMP_WORK_SHIFT_ID, EMP_WORK_STATION_ID, CASE X.IS_LOCK WHEN 'Y' THEN 1 ELSE 0 END AS IS_LOCK, NOTE_FEEDBACK
            , CASE X.IS_ACTIVE WHEN 'Y' THEN 1 ELSE 0 END AS ISACTIVE, CASE Z.IS_ADMIN WHEN 'Y' THEN 1 ELSE 0 END AS ISADMIN, STRPLANTROLE AS PLANT_ROLE, DEFAULT_PLANT
            FROM USER_MASTER_NEW X 
            LEFT JOIN USER_ROLE_NEW Y ON X.ID = Y.USER_ID
            LEFT JOIN ROLE_MASTER_NEW Z ON Y.ROLE_ID = Z.ROLE_ID
            LEFT JOIN PLANT_MASTER ZZ ON Y.PLANT_ID = ZZ.PLANTID 
            WHERE X.ID = P_ID AND X.IS_ACTIVE = COALESCE(NULLIF(P_ISACTIVE, ''), X.IS_ACTIVE) AND Y.ROLE_ID > 1 AND X.ID > 1;
            
        ELSEIF P_ID = 0 THEN
            
            #OPEN P_RESULT FOR
            SELECT DISTINCT Y.PLANT_ID, ZZ.Plant_Name, Y.ROLE_ID, Z.Role_Name, X.ID, X.USER_NAME, USER_PASSWORD, FIRST_NAME, MIDDLE_NAME, LAST_NAME, MOBILE_NO, ALT_MOBILE_NO, EMAIL_ID, ALT_EMAIL_ID, FULL_ADDRESS, COUNTRY_ID, STATE_ID, DISTRICT_ID, CITY, POSTAL_CODE, EMP_CODE, EMP_DESIGNATION_ID, EMP_WORK_SHIFT_ID, EMP_WORK_STATION_ID, CASE X.IS_LOCK WHEN 'Y' THEN 1 ELSE 0 END AS IS_LOCK, NOTE_FEEDBACK
            , CASE X.IS_ACTIVE WHEN 'Y' THEN 1 ELSE 0 END AS ISACTIVE, CASE Z.IS_ADMIN WHEN 'Y' THEN 1 ELSE 0 END AS ISADMIN, NULL AS PLANT_ROLE, NULL AS DEFAULT_PLANT
            FROM USER_MASTER_NEW X 
            LEFT JOIN USER_ROLE_NEW Y ON X.ID = Y.USER_ID
            LEFT JOIN ROLE_MASTER_NEW Z ON Y.ROLE_ID = Z.ROLE_ID
            LEFT JOIN PLANT_MASTER ZZ ON Y.PLANT_ID = ZZ.PLANTID 
            WHERE X.IS_ACTIVE = COALESCE(NULLIF(P_ISACTIVE, ''), X.IS_ACTIVE) AND Y.ROLE_ID > 1 AND X.ID > 1 AND Y.PLANT_ID = P_PLANT_ID;
            
        END IF;
    #END IF;
    
    -- Exception handling
    -- Error handling in MySQL stored procedures is limited compared to Oracle
    -- You might want to handle exceptions based on specific error codes
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_USER_GET_NEW */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_USER_GET_NEW(
    IN P_ID INT,
    IN P_ISACTIVE VARCHAR(1),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #OUT P_RESULT CURSOR
)
BEGIN
    
    DECLARE STRPLANTROLE VARCHAR(2000);
    DECLARE DEFAULT_PLANT INT;
    DECLARE TEMP_NUM INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error
        ROLLBACK;
    END;
    
    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) > 0 THEN
        IF P_ID > 0 THEN
            SELECT GROUP_CONCAT(PLANT_ROLE SEPARATOR ',') INTO STRPLANTROLE
            FROM (
                SELECT DISTINCT PLANT_ID, ROLE_ID, CONCAT(PLANT_ID, '|', ROLE_ID) AS PLANT_ROLE
                FROM access_rights
                WHERE USER_ID = P_ID
            ) AS temp;
            
            SELECT COUNT(*) INTO TEMP_NUM
            FROM access_rights X
            WHERE USER_ID = P_ID AND IS_DEFAULT = 'Y';
            
            IF COALESCE(TEMP_NUM, 0) > 0 THEN
                SELECT PLANT_ID INTO DEFAULT_PLANT
                FROM access_rights
                WHERE USER_ID = P_ID AND IS_DEFAULT = 'Y';
            END IF;
    
            #OPEN P_RESULT FOR
            SELECT Y.PLANT_ID, ZZ.Plant_Name, Y.ROLE_ID, Z.Role_Name, X.ID, X.USER_NAME, USER_PASSWORD, FIRST_NAME, MIDDLE_NAME, LAST_NAME, MOBILE_NO, ALT_MOBILE_NO, EMAIL_ID, ALT_EMAIL_ID, FULL_ADDRESS, COUNTRY_ID, STATE_ID, DISTRICT_ID, CITY, POSTAL_CODE, EMP_CODE, EMP_DESIGNATION_ID, EMP_WORK_SHIFT_ID, EMP_WORK_STATION_ID, CASE X.IS_LOCK WHEN 'Y' THEN 1 ELSE 0 END AS IS_LOCK, NOTE_FEEDBACK
            , CASE X.IS_ACTIVE WHEN 'Y' THEN 1 ELSE 0 END AS ISACTIVE, CASE Z.IS_ADMIN WHEN 'Y' THEN 1 ELSE 0 END AS ISADMIN, STRPLANTROLE AS PLANT_ROLE, DEFAULT_PLANT
            FROM system_users X 
            LEFT JOIN access_rights Y ON X.ID = Y.USER_ID
            LEFT JOIN ROLE_MASTER Z ON Y.ROLE_ID = Z.ROLE_ID
            LEFT JOIN PLANT_MASTER ZZ ON Y.PLANT_ID = ZZ.PLANTID 
            WHERE X.ID = P_ID AND X.IS_ACTIVE = COALESCE(NULLIF(P_ISACTIVE, ''), X.IS_ACTIVE) AND Y.ROLE_ID > 1 AND X.ID > 1;
            
        ELSEIF P_ID = 0 THEN
            
            #OPEN P_RESULT FOR
            SELECT Y.PLANT_ID, ZZ.Plant_Name, Y.ROLE_ID, Z.Role_Name, X.ID, X.USER_NAME, USER_PASSWORD, FIRST_NAME, MIDDLE_NAME, LAST_NAME, MOBILE_NO, ALT_MOBILE_NO, EMAIL_ID, ALT_EMAIL_ID, FULL_ADDRESS, COUNTRY_ID, STATE_ID, DISTRICT_ID, CITY, POSTAL_CODE, EMP_CODE, EMP_DESIGNATION_ID, EMP_WORK_SHIFT_ID, EMP_WORK_STATION_ID, CASE X.IS_LOCK WHEN 'Y' THEN 1 ELSE 0 END AS IS_LOCK, NOTE_FEEDBACK
            , CASE X.IS_ACTIVE WHEN 'Y' THEN 1 ELSE 0 END AS ISACTIVE, CASE Z.IS_ADMIN WHEN 'Y' THEN 1 ELSE 0 END AS ISADMIN, NULL AS PLANT_ROLE, NULL AS DEFAULT_PLANT
            FROM system_users X 
            LEFT JOIN access_rights Y ON X.ID = Y.USER_ID
            LEFT JOIN ROLE_MASTER Z ON Y.ROLE_ID = Z.ROLE_ID
            LEFT JOIN PLANT_MASTER ZZ ON Y.PLANT_ID = ZZ.PLANTID 
            WHERE X.IS_ACTIVE = COALESCE(NULLIF(P_ISACTIVE, ''), X.IS_ACTIVE) AND Y.ROLE_ID > 1 AND X.ID > 1 AND Y.PLANT_ID = P_PLANT_ID;
            
        END IF;
    #END IF;
    
    -- Exception handling
    -- Error handling in MySQL stored procedures is limited compared to Oracle
    -- You might want to handle exceptions based on specific error codes
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_USER_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_USER_SAVE(
IN P_ID INT,
IN P_USER_NAME VARCHAR(255),
IN P_USER_PASSWORD VARCHAR(255),
IN P_FIRST_NAME VARCHAR(255),
IN P_MIDDLE_NAME VARCHAR(255),
IN P_LAST_NAME VARCHAR(255),
IN P_MOBILE_NO VARCHAR(255),
IN P_ALT_MOBILE_NO VARCHAR(255),
IN P_EMAIL_ID VARCHAR(255),
IN P_ALT_EMAIL_ID VARCHAR(255),
IN P_FULL_ADDRESS TEXT,
IN P_COUNTRY_ID INT,
IN P_STATE_ID INT,
IN P_DISTRICT_ID INT,
IN P_CITY VARCHAR(255),
IN P_POSTAL_CODE VARCHAR(255),
IN P_EMP_CODE VARCHAR(255),
IN P_EMP_DESIGNATION_ID INT,
IN P_EMP_WORK_SHIFT_ID INT,
IN P_EMP_WORK_STATION_ID INT,
IN P_IS_LOCK VARCHAR(2),
IN P_NOTE_FEEDBACK TEXT,
IN P_ISACTIVE VARCHAR(2),
IN P_PLANT_ROLE TEXT,
IN P_DEFAULT_PLANT INT,
IN P_PLANT_ID INT,
IN P_USER_ID INT,
IN P_ROLE_ID INT,
IN P_MENU_ID INT,
OUT P_RESULT VARCHAR(255)
)
BEGIN
DECLARE TEMP_NUM INT DEFAULT 0;
DECLARE v_counter INT DEFAULT 0;
DECLARE v_plant_role VARCHAR(255);
             
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

-- Check if the username already exists
SELECT COUNT(*)
INTO TEMP_NUM
FROM USER_MASTER_NEW X
WHERE X.USER_NAME = P_USER_NAME AND X.ID != P_ID;

IF TEMP_NUM > 0 THEN
	SET P_RESULT = 'E|User name already exists.|0';
ELSEIF P_ID > 0 THEN
			-- Update existing user
			UPDATE USER_MASTER_NEW
			SET USER_NAME = P_USER_NAME,
			USER_PASSWORD = IF(P_USER_PASSWORD IS NOT NULL AND P_USER_PASSWORD != '', P_USER_PASSWORD, USER_PASSWORD),
			FIRST_NAME = P_FIRST_NAME,
			MIDDLE_NAME = P_MIDDLE_NAME,
			LAST_NAME = P_LAST_NAME,
			MOBILE_NO = P_MOBILE_NO,
			ALT_MOBILE_NO = P_ALT_MOBILE_NO,
			EMAIL_ID = P_EMAIL_ID,
			ALT_EMAIL_ID = P_ALT_EMAIL_ID,
			FULL_ADDRESS = P_FULL_ADDRESS,
			COUNTRY_ID = P_COUNTRY_ID,
			STATE_ID = P_STATE_ID,
			DISTRICT_ID = P_DISTRICT_ID,
			CITY = P_CITY,
			POSTAL_CODE = P_POSTAL_CODE,
			EMP_CODE = P_EMP_CODE,
			EMP_DESIGNATION_ID = P_EMP_DESIGNATION_ID,
			EMP_WORK_SHIFT_ID = P_EMP_WORK_SHIFT_ID,
			EMP_WORK_STATION_ID = P_EMP_WORK_STATION_ID,
			IS_LOCK = P_IS_LOCK,
			NOTE_FEEDBACK = P_NOTE_FEEDBACK,
			IS_ACTIVE = P_ISACTIVE,
			MODIFIED_BY = P_USER_ID,
			MODIFIED_DATETIME = NOW()
			WHERE ID = P_ID;

			DELETE FROM USER_ROLE_NEW WHERE USER_ID = P_ID;

			IF LENGTH(IFNULL(P_PLANT_ROLE, '')) > 0 THEN
            
				IF INSTR(P_PLANT_ROLE, ',') > 0 THEN
						
					SET v_counter = 1;
					SET v_plant_role  = '';

					SET v_plant_role = REGEXP_SUBSTR(P_PLANT_ROLE, '[^,]+', 1, v_counter);

					WHILE v_plant_role IS NOT NULL DO
					
						INSERT INTO USER_ROLE_NEW (USER_ID, PLANT_ID, ROLE_ID, CREATED_BY, CREATED_DATETIME)
						VALUES (P_ID, CAST(SUBSTRING_INDEX(v_plant_role, '|', 1) AS DECIMAL(10, 0)), CAST(SUBSTRING_INDEX(v_plant_role, '|', -1) AS DECIMAL(10, 0)), P_USER_ID, NOW());
						
						SET v_counter = v_counter + 1;
						SET v_plant_role = REGEXP_SUBSTR(P_PLANT_ROLE, '[^,]+', 1, v_counter);
					END WHILE;
				ELSE
                
					SET v_plant_role = P_PLANT_ROLE;
                    
						INSERT INTO USER_ROLE_NEW (USER_ID, PLANT_ID, ROLE_ID, CREATED_BY, CREATED_DATETIME)
						VALUES (P_ID, CAST(SUBSTRING_INDEX(v_plant_role, '|', 1) AS DECIMAL(10, 0)), CAST(SUBSTRING_INDEX(v_plant_role, '|', -1) AS DECIMAL(10, 0)), P_USER_ID, NOW());
						
				END IF;
			END IF;
						
			-- Set default plant role
			UPDATE USER_ROLE_NEW
			SET IS_DEFAULT = 'Y'
			WHERE USER_ID = P_ID AND PLANT_ID = P_DEFAULT_PLANT;

			SET P_RESULT = 'S|Record updated successfully|';
ELSE
		-- Insert new user
		SELECT IFNULL(MAX(ID), 0) + 1 INTO TEMP_NUM FROM USER_MASTER_NEW;

		INSERT INTO USER_MASTER_NEW (ID, USER_NAME, USER_PASSWORD, FIRST_NAME, MIDDLE_NAME, LAST_NAME, MOBILE_NO, ALT_MOBILE_NO, EMAIL_ID, ALT_EMAIL_ID, FULL_ADDRESS, COUNTRY_ID, STATE_ID, DISTRICT_ID, CITY, POSTAL_CODE, EMP_CODE, EMP_DESIGNATION_ID, EMP_WORK_SHIFT_ID, EMP_WORK_STATION_ID, IS_LOCK, NOTE_FEEDBACK, IS_ACTIVE, CREATED_BY, CREATED_DATETIME)
		VALUES(TEMP_NUM, P_USER_NAME, P_USER_PASSWORD, P_FIRST_NAME, P_MIDDLE_NAME, P_LAST_NAME, P_MOBILE_NO, P_ALT_MOBILE_NO, P_EMAIL_ID, P_ALT_EMAIL_ID, P_FULL_ADDRESS, P_COUNTRY_ID, P_STATE_ID, P_DISTRICT_ID, P_CITY, P_POSTAL_CODE, P_EMP_CODE, P_EMP_DESIGNATION_ID, P_EMP_WORK_SHIFT_ID, P_EMP_WORK_STATION_ID, P_IS_LOCK, P_NOTE_FEEDBACK, 'Y', P_USER_ID, NOW());


			IF LENGTH(IFNULL(P_PLANT_ROLE, '')) > 0 THEN
            
				IF INSTR(P_PLANT_ROLE, ',') > 0 THEN
							
					SET v_counter = 1;
					SET v_plant_role  = '';

					SET v_plant_role = REGEXP_SUBSTR(P_PLANT_ROLE, '[^,]+', 1, v_counter);

					WHILE v_plant_role IS NOT NULL DO
					
						INSERT INTO USER_ROLE_NEW (USER_ID, PLANT_ID, ROLE_ID, CREATED_BY, CREATED_DATETIME)
						VALUES (TEMP_NUM, CAST(SUBSTRING_INDEX(v_plant_role, '|', 1) AS DECIMAL(10, 0)), CAST(SUBSTRING_INDEX(v_plant_role, '|', -1) AS DECIMAL(10, 0)), P_USER_ID, NOW());
						
						SET v_counter = v_counter + 1;
						SET v_plant_role = REGEXP_SUBSTR(P_PLANT_ROLE, '[^,]+', 1, v_counter);
					END WHILE;
				ELSE
                
					SET v_plant_role = P_PLANT_ROLE;
                    
					INSERT INTO USER_ROLE_NEW (USER_ID, PLANT_ID, ROLE_ID, CREATED_BY, CREATED_DATETIME)
					VALUES (TEMP_NUM, CAST(SUBSTRING_INDEX(v_plant_role, '|', 1) AS DECIMAL(10, 0)), CAST(SUBSTRING_INDEX(v_plant_role, '|', -1) AS DECIMAL(10, 0)), P_USER_ID, NOW());
                    
				END IF;
			END IF;
            

			-- Set default plant role
			UPDATE USER_ROLE_NEW
			SET IS_DEFAULT = 'Y'
			WHERE USER_ID = TEMP_NUM AND PLANT_ID = P_DEFAULT_PLANT;
            
			SET P_RESULT = 'S|Record saved successfully|';
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_VENDOR_CHANGEPASSWORD */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_VENDOR_CHANGEPASSWORD(
    IN P_VENDOR_ID INT,
    IN P_OLD_PASSWORD VARCHAR(255),
    IN P_CONFIRM_PASSWORD VARCHAR(255),
    IN P_NEW_PASSWORD VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_NUM INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
		SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';
		END;

    IF P_NEW_PASSWORD = P_CONFIRM_PASSWORD THEN
        SELECT COUNT(*) INTO TEMP_NUM 
        FROM VENDOR_MASTER X 
        WHERE X.VENDOR_SYS_ID = P_VENDOR_ID AND X.PASSWORD = P_OLD_PASSWORD;   

        IF TEMP_NUM > 0 THEN
            UPDATE VENDOR_MASTER SET PASSWORD = P_NEW_PASSWORD WHERE VENDOR_SYS_ID = P_VENDOR_ID;  
            SET P_RESULT := 'S|Password Updated Successfully|';
        ELSE
            SET P_RESULT := 'E|Old Password is wrong|';
        END IF;
    ELSE
        SET P_RESULT := 'E|New Password and Confirm Password do not match|';
    END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_VENDOR_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_VENDOR_GET(
    IN P_ID INT,
    IN P_VENDOR_CODE INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(1),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #,
    #OUT P_RESULT CURSOR,
    #OUT P_SITES CURSOR
)
BEGIN
    DECLARE STRPLANTS VARCHAR(2000);
    DECLARE TEMP_VENDOR_CODE INT;

    -- IF IFNULL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) > 0 THEN
        IF IFNULL(P_VENDOR_CODE, 0) > 0 THEN
            SELECT VENDOR_SYS_ID AS ID, PLANT_ID, NULL AS SITE_CODE, NULL AS SITE_NAME, ORGANIZATION_NAME, VENDOR_CODE, VENDOR_CODE_TEMP, VENDOR_TYPE,
            FIRST_NAME, MIDDLE_NAME, LAST_NAME, PRIMARY_MOBILE AS MOBILE_NO, NULL AS ALT_MOBILE_NO, PRIMARY_EMAIL AS EMAIL_ID, NULL AS ALT_EMAIL_ID, NULL AS FULL_ADDRESS, NULL AS COUNTRY_ID, NULL AS STATE_ID, NULL AS DISTRICT_ID, NULL AS CITY, NULL AS POSTAL_CODE, PRINT_LABEL_QTY,
            CASE WHEN IS_SYSTEM_USER = 'Y' THEN 1 ELSE 0 END AS IS_SYSTEM_USER, CASE WHEN X.IS_POSTED = 'Y' THEN 1 ELSE 0 END AS IS_POSTED, CASE WHEN X.USER_LOCK = 1 THEN 1 ELSE 0 END AS IS_LOCK, CASE WHEN X.ACTIVE = 1 THEN 1 ELSE 0 END AS ISACTIVE, NULL AS PLANTS, CASE WHEN COALESCE(X.VENDOR_CODE, 0) = COALESCE(X.VENDOR_CODE_TEMP, 0) THEN 'No' ELSE 'Yes' END AS IS_ERP_VENDOR
            FROM VENDOR_MASTER X
            WHERE X.VENDOR_CODE = P_VENDOR_CODE OR X.VENDOR_CODE_TEMP = P_VENDOR_CODE;

            SELECT DISTINCT VENDOR_SYS_ID AS ID, Z.PLANT_ID, Y.SITE_ID, Y.SITE_CODE, Y.SITE_NAME, ORGANIZATION_NAME, VENDOR_CODE, VENDOR_CODE_TEMP, VENDOR_TYPE,
            FIRST_NAME, MIDDLE_NAME, LAST_NAME, Y.PRIMARY_MOBILE AS ALT_MOBILE_NO, NULL AS MOBILE_NO, Y.PRIMARY_EMAIL AS ALT_EMAIL_ID, NULL AS EMAIL_ID, Y.ADDRESS AS FULL_ADDRESS, X.COUNTRY_ID, Y.STATE_ID, DISTRICT_ID, Y.CITY, Y.PIN_CODE AS POSTAL_CODE, NULL AS PRINT_LABEL_QTY,
            CASE WHEN IS_SYSTEM_USER = 'Y' THEN 1 ELSE 0 END AS IS_SYSTEM_USER, CASE WHEN X.IS_POSTED = 'Y' THEN 1 ELSE 0 END AS IS_POSTED, CASE WHEN X.USER_LOCK = 1 THEN 1 ELSE 0 END AS IS_LOCK, CASE WHEN X.ACTIVE = 1 THEN 1 ELSE 0 END AS ISACTIVE, NULL AS PLANTS, CASE WHEN COALESCE(X.VENDOR_CODE, 0) = COALESCE(X.VENDOR_CODE_TEMP, 0) THEN 'No' ELSE 'Yes' END AS IS_ERP_VENDOR
            FROM VENDOR_MASTER X, SITE_MASTER Y, SITE_MASTER_PLANT Z
            WHERE X.VENDOR_SYS_ID = Y.VENDER_ID AND Y.SITE_ID = Z.SITE_ID AND Z.PLANT_ID = CASE WHEN P_VENDOR_CODE = P_ID THEN Z.PLANT_ID ELSE P_PLANT_ID END AND (X.VENDOR_CODE = P_VENDOR_CODE OR X.VENDOR_CODE_TEMP = P_VENDOR_CODE);

        ELSEIF P_ID > 0 THEN
            SELECT VENDOR_SYS_ID AS ID, Z.PLANT_ID,
            NULL AS SITE_CODE, NULL AS SITE_NAME, ORGANIZATION_NAME, VENDOR_CODE, VENDOR_TYPE,
            FIRST_NAME, MIDDLE_NAME, LAST_NAME, X.PRIMARY_MOBILE AS MOBILE_NO, NULL AS ALT_MOBILE_NO, X.PRIMARY_EMAIL AS EMAIL_ID, NULL AS ALT_EMAIL_ID, NULL AS FULL_ADDRESS, NULL AS COUNTRY_ID, NULL AS STATE_ID, NULL AS DISTRICT_ID, NULL AS CITY, NULL AS POSTAL_CODE, PRINT_LABEL_QTY,
            CASE WHEN IS_SYSTEM_USER = 'Y' THEN 1 ELSE 0 END AS IS_SYSTEM_USER, CASE WHEN X.IS_POSTED = 'Y' THEN 1 ELSE 0 END AS IS_POSTED, CASE WHEN X.USER_LOCK = 1 THEN 1 ELSE 0 END AS IS_LOCK, CASE WHEN X.ACTIVE = 1 THEN 1 ELSE 0 END AS ISACTIVE, NULL AS PLANTS, CASE WHEN COALESCE(X.VENDOR_CODE, 0) = COALESCE(X.VENDOR_CODE_TEMP, 0) THEN 'No' ELSE 'Yes' END AS IS_ERP_VENDOR
            FROM VENDOR_MASTER X, SITE_MASTER Y, SITE_MASTER_PLANT Z
            WHERE X.VENDOR_SYS_ID = Y.VENDER_ID AND Y.SITE_ID = Z.SITE_ID AND X.VENDOR_SYS_ID = P_ID AND Z.PLANT_ID = P_PLANT_ID AND X.ACTIVE = CASE WHEN IFNULL(P_ISACTIVE, '') = '' THEN X.ACTIVE ELSE CASE WHEN P_ISACTIVE = 'Y' THEN 1 ELSE 0 END END;

            SELECT DISTINCT VENDOR_SYS_ID AS ID, Z.PLANT_ID, Y.SITE_ID, Y.SITE_CODE, Y.SITE_NAME, ORGANIZATION_NAME, VENDOR_CODE, VENDOR_CODE_TEMP, VENDOR_TYPE,
            FIRST_NAME, MIDDLE_NAME, LAST_NAME, Y.PRIMARY_MOBILE AS ALT_MOBILE_NO, NULL AS MOBILE_NO, Y.PRIMARY_EMAIL AS ALT_EMAIL_ID, NULL AS EMAIL_ID, Y.ADDRESS AS FULL_ADDRESS, X.COUNTRY_ID, Y.STATE_ID, DISTRICT_ID, Y.CITY, Y.PIN_CODE AS POSTAL_CODE, NULL AS PRINT_LABEL_QTY,
            CASE WHEN IS_SYSTEM_USER = 'Y' THEN 1 ELSE 0 END AS IS_SYSTEM_USER, CASE WHEN X.IS_POSTED = 'Y' THEN 1 ELSE 0 END AS IS_POSTED, CASE WHEN X.USER_LOCK = 1 THEN 1 ELSE 0 END AS IS_LOCK, CASE WHEN X.ACTIVE = 1 THEN 1 ELSE 0 END AS ISACTIVE, NULL AS PLANTS, CASE WHEN COALESCE(X.VENDOR_CODE, 0) = COALESCE(X.VENDOR_CODE_TEMP, 0) THEN 'No' ELSE 'Yes' END AS IS_ERP_VENDOR
            FROM VENDOR_MASTER X, SITE_MASTER Y, SITE_MASTER_PLANT Z
            WHERE X.VENDOR_SYS_ID = Y.VENDER_ID AND Y.SITE_ID = Z.SITE_ID AND X.VENDOR_SYS_ID = P_ID AND Z.PLANT_ID = P_PLANT_ID AND X.ACTIVE = CASE WHEN IFNULL(P_ISACTIVE, '') = '' THEN X.ACTIVE ELSE CASE WHEN P_ISACTIVE = 'Y' THEN 1 ELSE 0 END END;

        ELSEIF P_ID = 0 THEN
            SELECT MAX(VENDOR_SYS_ID) AS ID, Z.PLANT_ID, X.ORGANIZATION_NAME, X.VENDOR_CODE, X.VENDOR_TYPE, X.FIRST_NAME, X.MIDDLE_NAME, X.LAST_NAME, X.PRIMARY_MOBILE AS MOBILE_NO, X.PRIMARY_EMAIL AS EMAIL_ID,
            CASE WHEN IS_SYSTEM_USER = 'Y' THEN 1 ELSE 0 END AS IS_SYSTEM_USER, CASE WHEN X.IS_POSTED = 'Y' THEN 1 ELSE 0 END AS IS_POSTED, CASE WHEN X.USER_LOCK = 1 THEN 1 ELSE 0 END AS IS_LOCK, CASE WHEN X.ACTIVE = 1 THEN 1 ELSE 0 END AS ISACTIVE, NULL AS PLANTS, CASE WHEN COALESCE(X.VENDOR_CODE, 0) = COALESCE(X.VENDOR_CODE_TEMP, 0) THEN 'No' ELSE 'Yes' END AS IS_ERP_VENDOR
            FROM VENDOR_MASTER X, SITE_MASTER Y, SITE_MASTER_PLANT Z
            WHERE X.VENDOR_SYS_ID = Y.VENDER_ID AND Y.SITE_ID = Z.SITE_ID AND Z.PLANT_ID = P_PLANT_ID AND X.ACTIVE = CASE WHEN IFNULL(P_ISACTIVE, '') = '' THEN X.ACTIVE ELSE CASE WHEN P_ISACTIVE = 'Y' THEN 1 ELSE 0 END END
            AND 1 = (CASE WHEN LENGTH(IFNULL(P_SEARCHTERM, '')) > 0 THEN (CASE WHEN TRIM(UPPER(ORGANIZATION_NAME)) LIKE CONCAT('%', TRIM(UPPER(P_SEARCHTERM)), '%') THEN 1 ELSE 0 END) ELSE 1 END)
            GROUP BY Z.PLANT_ID, X.ORGANIZATION_NAME, X.VENDOR_CODE, X.VENDOR_CODE_TEMP, X.VENDOR_TYPE, X.FIRST_NAME, X.MIDDLE_NAME, X.LAST_NAME, X.PRIMARY_MOBILE, X.PRIMARY_EMAIL, X.IS_SYSTEM_USER, X.IS_POSTED, X.USER_LOCK, X.ACTIVE;
        END IF;
    -- END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_VENDOR_LOGIN_AUTH */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_VENDOR_LOGIN_AUTH(
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_SITE_ID INT,
    IN P_VENDOR_CODE INT,
    IN P_PASSWORD VARCHAR(255)
)
BEGIN
    DECLARE TEMP_NUM INT;

    -- First Result Set (equivalent to P_RESULT)
    SELECT 
        X.VENDOR_SYS_ID AS ID, 
        X.VENDOR_CODE, 
        X.VENDOR_TYPE, 
        X.FIRST_NAME, 
        X.MIDDLE_NAME, 
        X.LAST_NAME,  
        X.COUNTRY_ID, 
        X.STATE_ID, 
        X.DISTRICT_ID,
        X.CITY,  
        X.IS_SYSTEM_USER, 
        X.USER_LOCK, 
        X.IS_POSTED, 
        X.ACTIVE AS IS_ACTIVE, 
        X.PASSWORD, 
        Z.PLANT_ID, 
        X.VENDOR_CODE_TEMP, 
        X.ORGANIZATION_NAME, 
        X.PRINT_LABEL_QTY 
    FROM 
        VENDOR_MASTER X
        JOIN SITE_MASTER Y ON X.VENDOR_SYS_ID = Y.VENDER_ID
        JOIN SITE_MASTER_PLANT Z ON Y.SITE_ID = Z.SITE_ID
    WHERE 
        X.VENDOR_CODE = P_VENDOR_CODE;

    -- Second Result Set (equivalent to P_USER_ACCESS)
    SELECT 
        ID AS MENU_ID, 
        PARENT_ID, 
        AREA, 
        CONTROLLER, 
        DISPLAY_NAME, 
        URL, 
        DISPLAYORDER, 
        IF(ISADMIN = 'Y', 1, 0) AS ISADMIN,  
        IF(IS_ACTIVE = 'Y', 1, 0) AS ISACTIVE 
    FROM 
        MENU_MASTER 
    WHERE 
        AREA = 'Vendor'
    ORDER BY 
        PARENT_ID, 
        DISPLAYORDER, 
        MENU_ID;

    -- Third Result Set (equivalent to P_PLANTS)
    SELECT 
        ZZ.PLANTID AS PLANT_ID, 
        ZZ.Plant_Name 
    FROM 
        PLANT_MASTER ZZ 
    WHERE 
        ZZ.PLANTID > 0 
        AND ZZ.IS_ACTIVE = 'Y';

    -- Error Handling
   -- DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle exception (if needed)
    END;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_WEIGHMENT_IN_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_WEIGHMENT_IN_GET(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error
        ROLLBACK;
    END;
    
    SELECT 
        GATE_SYS_ID ID, 
        DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT,
        DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT,
        INWARD_SYS_ID,
        (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE,
        MDA_NO COMMON_NO, MDA_SYS_ID COMMON_SYS_ID, TRANS_SYS_ID,
        (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME,
        VEHICLE_NO TRUCK_NO, DRIVER_ID_TYPE,
        (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT,
        DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER,
        X.RFSYSID, XZ.RFIDSRNO, XZ.RFIDCODE,
        VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
        #X.VENDOR_SYS_ID, VM.VENDOR_CODE, VM.ORGANIZATION_NAME AS VENDOR_NAME,
        NULL VENDOR_SYS_ID, NULL VENDOR_CODE, NULL VENDOR_NAME
        , NULL CUST_CD, NULL CUST_NAME, NULL CUST_SITE_CD, NULL SITE_NAME, X.STATION_ID, X.PLANT_ID, PM.PLANT_NAME, PM.PLANTCODE AS PLANT_CODE
    FROM (
        SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
		, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
				FROM fg_gate_in_out X, 
				(SELECT Z.* FROM mda_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID AND OUT_TIME IS NULL
					AND ((Z.VEHICLE_NO = P_SEARCHTERM 
							OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM OR XZ.MDA_SYS_ID = IFNULL(P_ID,0)) 
							OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID IN (125, 1))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0)
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.VEHICLE_NO 
                 AND 0 = (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID)
                AND 1 = (CASE WHEN IFNULL(P_SEARCHTERM,'') = '' THEN (CASE WHEN COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL THEN 1 ELSE 0 END ) ELSE 1 END ) 
    ) X
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID;
    #LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID;
    #where X.ID not in (select GATE_SYS_ID FROM fg_weighment_detail where Plant_ID = X.PLANT_ID);
    # where condition add by ashish bcz once we weignin it should not come in weign in again needed check to cancle case 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_WEIGHMENT_IN_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_WEIGHMENT_IN_SAVE(
    IN P_ID INT, 
    IN P_INWARD_SYS_ID INT, 
    IN P_TARE_WT DECIMAL(10,2), 
    IN P_TARE_WT_MANUALLY INT, 
    IN P_TARE_WT_NOTE VARCHAR(255), 
    IN P_STATION_ID INT, 
    IN P_PLANT_ID INT, 
    IN P_USER_ID INT, 
    IN P_ROLE_ID INT, 
    IN P_MENU_ID INT, 
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_NUM INT DEFAULT 0;
    DECLARE AUTH_RESULT INT DEFAULT 0;
          
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;


    -- Initial default result
    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    -- Authorization check
    #SET AUTH_RESULT = (SELECT COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0));
    
    #IF AUTH_RESULT <= 0 THEN
        #SET P_RESULT = 'E|You are not authorized to perform this operation.|0';
    #ELSE
    IF P_ID > 0 THEN
        -- Check for conditions in FG_GATE_IN_OUT
        IF COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 1 THEN
        
        SELECT COUNT(*) INTO TEMP_NUM FROM FG_WEIGHMENT_DETAIL X WHERE X.GATE_SYS_ID = P_ID;
        
          /*SELECT COUNT(*) INTO TEMP_NUM 
            FROM FG_GATE_IN_OUT 
            WHERE GATE_SYS_ID = P_ID 
                AND COALESCE(CANCEL_GATE_IN, 0) = 0 
                AND GATE_OUT_DT IS NULL 
                AND 0 = (SELECT COUNT(*) 
                         FROM FG_WEIGHMENT_DETAIL X 
                         WHERE X.GATE_SYS_ID = P_ID);*/
        END IF;


            IF IFNULL(P_TARE_WT, 0) <= 0 THEN
                SET P_RESULT = 'E|Tare weight require.|0';
            ELSE

				IF COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 1 AND COALESCE(TEMP_NUM, 0) = 0 THEN
				
					-- Get the next WT_SYS_ID
					SELECT COALESCE(MAX(WT_SYS_ID), 0) + 1 INTO TEMP_NUM FROM FG_WEIGHMENT_DETAIL;

					-- Insert the record
					INSERT INTO FG_WEIGHMENT_DETAIL (WT_SYS_ID, GATE_SYS_ID, TARE_WT, TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME) 
					VALUES (TEMP_NUM, P_ID, P_TARE_WT, NOW(), 1, P_TARE_WT_NOTE, 7, P_PLANT_ID, P_USER_ID, NOW());

					SET P_RESULT = 'S|Record saved successfully|';
				ELSE
					SET P_RESULT = 'E|Weighment Details already exist.|';
				END IF;
                
            END IF;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_WEIGHMENT_IN_SLIP_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_WEIGHMENT_IN_SLIP_GET(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_gate_sys_id INT;
    DECLARE v_common_sys_id INT;
    DECLARE v_common_no VARCHAR(255);
    #DECLARE cur_result CURSOR FOR
    
        SELECT X.WT_SYS_ID ID, X.TARE_WT, DATE_FORMAT(X.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, X.TARE_WT_MANUALLY, X.TARE_WT_NOTE,
               GATE_SYS_ID Gate_In_Id, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') GATE_OUT_DT,
               INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) INWARD_TYPE, COMMON_NO, COMMON_SYS_ID,
               TRANS_SYS_ID, (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) TRANSPORTER_NAME,
               TRUCK_NO, DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) DRIVER_ID_TYPE_TEXT,
               DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER, IS_UNLOAD_TRUCK,
               X.RFSYSID, XZ.RFIDSRNO RFID_NO, XZ.RFIDCODE,
               VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, NULL VERIFIED_OFFICER_NAME, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
               X.VENDOR_SYS_ID, VM.VENDOR_CODE, VM.ORGANIZATION_NAME VENDOR_NAME,
               X.CUST_CD, X.CUST_NAME, X.CUST_SITE_CD, X.SITE_NAME, X.STATION_ID, X.PLANT_ID, PM.PLANT_NAME, PM.PLANTCODE PLANT_CODE, X.IS_POSTED,
               X.WT_SYS_ID, X.TARE_WT, X.TARE_WT_DT, X.TARE_WT_MANUALLY, X.TARE_WT_NOTE, 
               (CASE WHEN GATE_SYS_ID_OLD > 0 THEN 'Weighment Slip - TRANSFER OF GOODS' ELSE 'Weighment Slip - Weigh In' END) REPORT_TITLE
        FROM (
            SELECT ZZ.WT_SYS_ID, ZZ.TARE_WT, ZZ.TARE_WT_DT, ZZ.TARE_WT_MANUALLY, ZZ.TARE_WT_NOTE,
                   X.GATE_SYS_ID, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, X.MDA_SYS_ID COMMON_SYS_ID,
                   CAST(XZ.MDA_NO AS CHAR) COMMON_NO, XZ.TRANS_SYS_ID, TRUCK_NO, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER, NULL IS_UNLOAD_TRUCK,
                   RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
                   NULL VENDOR_SYS_ID, XZ.WH_CD CUST_CD, XZ.PARTY_NAME CUST_NAME, NULL CUST_SITE_CD, NULL SITE_NAME, X.STATION_ID, X.PLANT_ID, X.IS_POSTED
            FROM FG_GATE_IN_OUT X
            RIGHT JOIN MDA_HEADER XZ ON X.MDA_SYS_ID = XZ.MDA_SYS_ID
            LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
            WHERE (X.TRUCK_NO = P_SEARCHTERM OR X.GATE_SYS_ID = IFNULL(P_ID,0)) AND COALESCE(CANCEL_GATE_IN, 0) = 0 AND 1 = IF(IFNULL(P_ID,0), IF( GATE_OUT_DT IS NULL, 1,0), 1) AND GATE_IN_DT IS NOT NULL            
        ) X
        LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID -- AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
        LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
        LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID;
    
    #DECLARE cur_dtls CURSOR FOR
    
        SELECT X.MDA_DTL_SYS_ID ID, COMMON_SYS_ID, COMMON_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i') MDA_DT, X.PROD_SYS_ID, PROD.SKU_CODE, PROD.SKU_NAME, PROD.PRD_CD, PROD.PRD_DESC
				, X.SHIPMENT_NO, X.BAG_NOS no_of_bottle, (CASE WHEN COALESCE(X.BAG_NOS, 0) = 0 THEN 0 ELSE (X.BAG_NOS / 24) END) no_of_Box, X.GROSS_QTY,
               INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) INWARD_TYPE,
               TRANS_SYS_ID, (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) TRANSPORTER_NAME,
               TRUCK_NO, DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) DRIVER_ID_TYPE_TEXT,
               DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER, IS_UNLOAD_TRUCK,
               X.RFSYSID, XZ.RFIDSRNO, XZ.RFIDCODE,
               VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, NULL VERIFIED_OFFICER_NAME, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
               X.VENDOR_SYS_ID, VM.VENDOR_CODE, VM.ORGANIZATION_NAME VENDOR_NAME,
               X.CUST_CD, X.CUST_NAME, X.CUST_SITE_CD, X.SITE_NAME, X.STATION_ID, X.PLANT_ID, PM.PLANT_NAME, PM.PLANTCODE PLANT_CODE, X.IS_POSTED, DIST, desp_place
        FROM (
            SELECT ZZ.MDA_DTL_SYS_ID, ZZ.PROD_SNO, XZ.MDA_DT, ZZ.PROD_SYS_ID, ZZ.SHIPMENT_NO, ZZ.BAG_NOS, ZZ.NETT_QTY, ZZ.GROSS_QTY,
                   X.GATE_SYS_ID, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, X.MDA_SYS_ID COMMON_SYS_ID,
                   CAST(XZ.MDA_NO AS CHAR) COMMON_NO, XZ.TRANS_SYS_ID, TRUCK_NO, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER, NULL IS_UNLOAD_TRUCK,
                   RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
                   NULL VENDOR_SYS_ID, XZ.WH_CD CUST_CD, XZ.PARTY_NAME CUST_NAME, NULL CUST_SITE_CD, NULL SITE_NAME, X.STATION_ID, X.PLANT_ID, X.IS_POSTED, DIST, desp_place
            FROM FG_GATE_IN_OUT X
            RIGHT JOIN MDA_HEADER XZ ON X.MDA_SYS_ID = XZ.MDA_SYS_ID
            LEFT JOIN MDA_DETAIL ZZ ON X.MDA_SYS_ID = ZZ.MDA_SYS_ID
            WHERE  (X.TRUCK_NO = P_SEARCHTERM OR X.GATE_SYS_ID = IFNULL(P_ID,0)) AND COALESCE(CANCEL_GATE_IN, 0) = 0  AND 1 = IF(IFNULL(P_ID,0), IF( GATE_OUT_DT IS NULL, 1,0), 1) AND GATE_IN_DT IS NOT NULL                         
        ) X
        LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID -- AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
        LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
        LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID
        LEFT JOIN PRODUCT_MASTER PROD ON X.PROD_SYS_ID = PROD.PROD_SYS_ID;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_WEIGHMENT_IN_SLIP_GET_NEW */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_WEIGHMENT_IN_SLIP_GET_NEW(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_gate_sys_id INT;
    DECLARE v_common_sys_id INT;
    DECLARE v_common_no VARCHAR(255);
    #DECLARE cur_result CURSOR FOR
    

	WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
		, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
				FROM fg_gate_in_out X, 
				(SELECT Z.* FROM mda_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID 
					AND ((Z.VEHICLE_NO = P_SEARCHTERM
							OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM) 
							OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID IN (125, 1))
						 )
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.MDA_SYS_ID = Y.MDA_SYS_ID AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
				-- AND 0 > (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0)
	)
	SELECT X.PLANT_ID, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.MDA_SYS_ID COMMON_SYS_ID, X.MDA_NO COMMON_NO, X.VEHICLE_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
	, X.TRANS_SYS_ID, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.TARE_WT_NOTE
    , XZ.RFSYSID, XZ.RFIDSRNO RFID_NO, XZ.RFIDCODE
    , (CASE WHEN GATE_SYS_ID_OLD > 0 THEN 'Weighment Slip - TRANSFER OF GOODS' ELSE 'Weighment Slip - Weigh In' END) REPORT_TITLE
	FROM TBL_MAIN X 
	LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID
	WHERE ZZ.TARE_WT IS NOT NULL AND IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.GROSS_WT_DT IS NULL AND IFNULL(ZZ.GROSS_WT,0) = 0
	ORDER BY X.GATE_IN_DT DESC, X.MDA_DT DESC;


	WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
		, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
				FROM fg_gate_in_out X, 
				(SELECT Z.* FROM mda_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID 
					AND ((Z.VEHICLE_NO = P_SEARCHTERM
							OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM) 
							OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID IN (125, 1))
						 )
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.VEHICLE_NO AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
	)
	SELECT X.PLANT_ID, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.MDA_SYS_ID COMMON_SYS_ID, X.MDA_NO COMMON_NO, X.VEHICLE_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(X.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
    , PROD.PROD_SYS_ID, PROD.SKU_CODE, PROD.SKU_NAME, PROD.PRD_CD, PROD.PRD_DESC
    , MD.SHIPMENT_NO, MD.BAG_NOS no_of_bottle, (CASE WHEN COALESCE(MD.BAG_NOS, 0) = 0 THEN 0 ELSE (MD.BAG_NOS / 24) END) no_of_Box, MD.GROSS_QTY
    , X.DIST, X.desp_place
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
	, X.TRANS_SYS_ID, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.TARE_WT_NOTE
    , XZ.RFSYSID, XZ.RFIDSRNO RFID_NO, XZ.RFIDCODE
    , (CASE WHEN GATE_SYS_ID_OLD > 0 THEN 'Weighment Slip - TRANSFER OF GOODS' ELSE 'Weighment Slip - Weigh In' END) REPORT_TITLE
	FROM TBL_MAIN X 
    LEFT JOIN MDA_DETAIL MD ON X.MDA_SYS_ID = MD.MDA_SYS_ID AND MD.PLANT_ID = X.PLANT_ID
    LEFT JOIN PRODUCT_MASTER PROD ON MD.PROD_SYS_ID = PROD.PROD_SYS_ID AND MD.PLANT_ID = X.PLANT_ID
	LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID
	WHERE ZZ.TARE_WT IS NOT NULL AND IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.GROSS_WT_DT IS NULL AND IFNULL(ZZ.GROSS_WT,0) = 0
	ORDER BY X.GATE_IN_DT DESC, X.MDA_DT DESC;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_WEIGHMENT_OUT_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_WEIGHMENT_OUT_GET(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(10),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
    
    WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
		, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
				FROM fg_gate_in_out X, 
				(SELECT Z.* FROM mda_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID AND OUT_TIME IS NULL
					AND ((Z.VEHICLE_NO = P_SEARCHTERM
							OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM OR XZ.MDA_SYS_ID = IFNULL(P_ID,0)) 
							OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID IN (125, 1))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0)
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.VEHICLE_NO AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0)
	)
	SELECT X.PLANT_ID, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.MDA_SYS_ID COMMON_SYS_ID, X.MDA_NO COMMON_NO, X.VEHICLE_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
	, X.TRANS_SYS_ID, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT
	FROM TBL_MAIN X 
	LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
	-- WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL
	ORDER BY X.GATE_IN_DT DESC, X.MDA_DT DESC;
		
    /*
    -- Open the result set
    SELECT 
        X.WT_SYS_ID AS ID,
        X.TARE_WT, 
        DATE_FORMAT(X.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT,
        X.TARE_WT_MANUALLY, 
        X.TARE_WT_NOTE,
        GATE_SYS_ID AS Gate_In_Id,
        DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT,
        DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT,
        INWARD_SYS_ID,
        (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE,
        COMMON_NO,
        COMMON_SYS_ID,
        TRANS_SYS_ID,
        (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Plant_ID = P_PLANT_ID LIMIT 1) AS TRANSPORTER_NAME,
        TRUCK_NO,
        DRIVER_ID_TYPE,
        (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT,
        DRIVER_ID_NUMBER,
        DRIVER_NAME,
        DRIVER_CONTACT,
        DRIVER_CHANGED,
        DRIVER_NAME_NEW,
        DRIVER_CONTACT_NEW,
        TRUCK_VALIDATION,
        IS_GOODS_TRANSFER,
        IS_UNLOAD_TRUCK,
        X.RFSYSID,
        XZ.RFIDSRNO,
        XZ.RFIDCODE,
        VERIFIED_DOCUMENTS,
        RFID_RECEIVE,
        VERIFIED_OFFICER_ID,
        NULL AS VERIFIED_OFFICER_NAME,
        GATE_SYS_ID_OLD,
        CANCEL_GATE_IN,
        CANCEL_GATE_REASON,
        X.VENDOR_SYS_ID,
        NULL AS VENDOR_CODE,
        NULL AS VENDOR_NAME,
        X.CUST_CD,
        X.CUST_NAME,
        X.CUST_SITE_CD,
        X.SITE_NAME,
        X.STATION_ID,
        X.PLANT_ID,
        PM.PLANT_NAME,
        PM.PLANTCODE AS PLANT_CODE,
        X.IS_POSTED,
        X.WT_SYS_ID,
        X.TARE_WT,
        X.TARE_WT_DT,
        X.TARE_WT_MANUALLY,
        X.TARE_WT_NOTE
    FROM (
        SELECT 
            ZZ.WT_SYS_ID, 
            ZZ.TARE_WT, 
            ZZ.TARE_WT_DT, 
            ZZ.TARE_WT_MANUALLY, 
            ZZ.TARE_WT_NOTE,
            X.GATE_SYS_ID, 
            GATE_IN_DT, 
            GATE_OUT_DT, 
            INWARD_SYS_ID, 
            X.MDA_SYS_ID AS COMMON_SYS_ID,
            CAST(XZ.MDA_NO AS CHAR) AS COMMON_NO, 
             XZ.TRANS_SYS_ID, 
            TRUCK_NO, 
            DRIVER_ID_TYPE, 
            DRIVER_ID_NUMBER, 
            DRIVER_NAME, 
            DRIVER_CONTACT, 
            DRIVER_CHANGED, 
            DRIVER_NAME_NEW, 
            DRIVER_CONTACT_NEW, 
            TRUCK_VALIDATION, 
            IS_GOODS_TRANSFER, 
            NULL AS IS_UNLOAD_TRUCK,
            RFSYSID, 
            VERIFIED_DOCUMENTS, 
            RFID_RECEIVE, 
            VERIFIED_OFFICER_ID, 
            GATE_SYS_ID_OLD, 
            CANCEL_GATE_IN, 
            CANCEL_GATE_REASON,
            NULL AS VENDOR_SYS_ID, 
            XZ.WH_CD AS CUST_CD, 
            XZ.PARTY_NAME AS CUST_NAME, 
            NULL AS CUST_SITE_CD, 
            NULL AS SITE_NAME, 
            X.STATION_ID, 
            X.PLANT_ID, 
            X.IS_POSTED
        FROM (
            SELECT * FROM FG_GATE_IN_OUT X
            WHERE X.PLANT_ID = P_PLANT_ID AND IFNULL(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL AND X.PLANT_ID = P_PLANT_ID
            AND (
			1 = (CASE WHEN CHAR_LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN 
                        (CASE WHEN X.MDA_SYS_ID IN (SELECT Z.MDA_SYS_ID FROM MDA_HEADER Z WHERE Z.PLANT_ID = P_PLANT_ID AND Z.MDA_NO = P_VEHICLE_NO OR Z.VEHICLE_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END)                        
                ELSE 1 END)
			OR
			1 = (CASE WHEN CHAR_LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN 
                        (CASE WHEN RFSYSID IN (SELECT Z.RFSYSID FROM RFID_MASTER Z WHERE Z.RFIDSRNO = P_RFID_NO OR Z.RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END)
                ELSE 1 END)
			) 
            #AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL X WHERE Z.GATE_SYS_ID = X.GATE_SYS_ID AND TARE_WT IS NOT NULL AND IFNULL(X.TARE_WT,0) > 0 AND GROSS_WT_DT IS NULL AND IFNULL(X.GROSS_WT,0) = 0)
            #AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL Z WHERE Z.PLANT_ID = P_PLANT_ID AND Z.GATE_SYS_ID = X.GATE_SYS_ID AND TARE_WT IS NOT NULL AND IFNULL(Z.TARE_WT,0) > 0 AND GROSS_WT_DT IS NULL)
        ) X
        LEFT JOIN MDA_HEADER XZ ON X.MDA_SYS_ID = XZ.MDA_SYS_ID
        LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
        WHERE XZ.OUT_TIME IS NULL 
        UNION ALL
        SELECT 
            ZZ.WT_SYS_ID, 
            ZZ.TARE_WT, 
            ZZ.TARE_WT_DT, 
            ZZ.TARE_WT_MANUALLY, 
            ZZ.TARE_WT_NOTE,
            X.GATE_SYS_ID, 
            GATE_IN_DT, 
            GATE_OUT_DT, 
            INWARD_SYS_ID, 
            X.PO_SYS_ID AS COMMON_SYS_ID,
            CAST(XZ.PO_NO AS CHAR) AS COMMON_NO, 
            NULL AS TRANS_SYS_ID, 
            X.TRUCK_NO, 
            DRIVER_ID_TYPE, 
            DRIVER_ID_NUMBER, 
            DRIVER_NAME, 
            DRIVER_CONTACT, 
            DRIVER_CHANGED, 
            DRIVER_NAME_NEW, 
            DRIVER_CONTACT_NEW, 
            TRUCK_VALIDATION, 
            NULL AS IS_GOODS_TRANSFER, 
            IS_UNLOAD_TRUCK,
            RFSYSID, 
            VERIFIED_DOCUMENTS, 
            RFID_RECEIVE, 
            VERIFIED_OFFICER_ID, 
            NULL AS GATE_SYS_ID_OLD, 
            CANCEL_GATE_IN, 
            CANCEL_GATE_REASON,
            XZ.VENDOR_SYS_ID, 
            NULL AS CUST_CD, 
            NULL AS CUST_NAME, 
            NULL AS CUST_SITE_CD, 
            NULL AS SITE_NAME, 
            X.STATION_ID, 
            X.PLANT_ID, 
            X.IS_POSTED
        FROM (
            SELECT * FROM RM_GATE_IN_OUT Z
            WHERE IFNULL(CANCEL_GATE_IN, 0) = 0 
            AND GATE_OUT_DT IS NULL  
            AND GATE_IN_DT IS NOT NULL 
            AND (
            #1 = (CASE WHEN LENGTH(IFNULL(P_VEHICLE_NO, '')) > 0 THEN 
                #(CASE WHEN PO_SYS_ID IN (SELECT PO_SYS_ID FROM PO_HEADER WHERE PO_NO = P_VEHICLE_NO OR TRUCK_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 1 END) 
                #OR 
                (1 = (CASE WHEN LENGTH(IFNULL(P_RFID_NO, '')) > 0 THEN 
                (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 1 END))
            ) 
            AND 0 < (SELECT COUNT(*) FROM RM_WEIGHMENT_DETAIL X WHERE Z.GATE_SYS_ID = X.GATE_SYS_ID AND TARE_WT IS NOT NULL AND IFNULL(X.TARE_WT,0) > 0 AND GROSS_WT_DT IS NULL AND IFNULL(X.GROSS_WT,0) = 0)
        ) X
        LEFT JOIN PO_HEADER XZ ON X.PO_SYS_ID = XZ.PO_SYS_ID
        LEFT JOIN RM_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
        UNION ALL
        SELECT 
            ZZ.WT_SYS_ID, 
            ZZ.TARE_WT, 
            ZZ.TARE_WT_DT, 
            ZZ.TARE_WT_MANUALLY, 
            ZZ.TARE_WT_NOTE,
            X.GATE_SYS_ID, 
            GATE_IN_DT, 
            GATE_OUT_DT, 
            INWARD_SYS_ID, 
            X.SO_SYS_ID AS COMMON_SYS_ID,
            CAST(XZ.SO_NO AS CHAR) AS COMMON_NO, 
            X.TRANS_SYS_ID, 
            X.TRUCK_NO, 
            DRIVER_ID_TYPE, 
            DRIVER_ID_NUMBER, 
            DRIVER_NAME, 
            DRIVER_CONTACT, 
            DRIVER_CHANGED, 
            DRIVER_NAME_NEW, 
            DRIVER_CONTACT_NEW, 
            TRUCK_VALIDATION, 
            IS_GOODS_TRANSFER, 
            NULL AS IS_UNLOAD_TRUCK,
            RFSYSID, 
            VERIFIED_DOCUMENTS, 
            RFID_RECEIVE, 
            VERIFIED_OFFICER_ID, 
            GATE_SYS_ID_OLD, 
            CANCEL_GATE_IN, 
            CANCEL_GATE_REASON,
            XZ.VENSOR_SYS_ID AS VENDOR_SYS_ID, 
            CAST(XZ.CUST_CD AS CHAR) AS CUST_CD, 
            XZ.CUST_NAME, 
            XZ.CUST_SITE_CD, 
            XZ.SITE_NAME, 
            X.STATION_ID, 
            X.PLANT_ID, 
            X.IS_POSTED
        FROM (
            SELECT * FROM SP_GATE_IN_OUT Z
            WHERE IFNULL(CANCEL_GATE_IN, 0) = 0 
            AND GATE_OUT_DT IS NULL  
            AND GATE_IN_DT IS NOT NULL 
            AND (
            #1 = (CASE WHEN LENGTH(IFNULL(P_VEHICLE_NO, '')) > 0 THEN 
                #(CASE WHEN SO_SYS_ID IN (SELECT SO_SYS_ID FROM SO_HEADER WHERE SO_NO = P_VEHICLE_NO OR TENDER_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 1 END) 
                #OR 
                (1 = (CASE WHEN LENGTH(IFNULL(P_RFID_NO, '')) > 0 THEN 
                (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 1 END))
            ) 
            AND 0 < (SELECT COUNT(*) FROM SP_WEIGHMENT_DETAIL X WHERE Z.GATE_SYS_ID = X.GATE_SYS_ID AND TARE_WT IS NOT NULL AND IFNULL(X.TARE_WT,0) > 0 AND GROSS_WT_DT IS NULL AND IFNULL(X.GROSS_WT,0) = 0)
        ) X
        LEFT JOIN SO_HEADER XZ ON X.SO_SYS_ID = XZ.SO_SYS_ID
        LEFT JOIN SP_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
    ) X
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID;
*/
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_WEIGHMENT_OUT_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_WEIGHMENT_OUT_SAVE(
    IN P_ID INT,
    IN P_GATE_IN_ID INT,
    IN P_GROSS_WT DECIMAL(10,2),
    IN P_GROSS_WT_NOTE VARCHAR(255),
    IN P_NET_WT_MANUALLY DECIMAL(10,2),
    IN P_STATION_ID INT,
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
	DECLARE TEMP_STATION_ID INT DEFAULT 7;
    DECLARE TEMP_NUM INT;
    DECLARE TEMP_TARE_WT DECIMAL(10,2);
    DECLARE TEMP_INWARD_SYS_ID INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator1|1';
        ROLLBACK;
    END;

    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    -- Authorization check
    #IF IFNULL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT = 'E|You are not authorized to perform this operation.|0';
    #ELSE
    IF P_ID > 0 AND P_GATE_IN_ID > 0 THEN
        -- Fetch INWARD_SYS_ID
        SELECT INWARD_SYS_ID INTO TEMP_INWARD_SYS_ID
        FROM FG_GATE_IN_OUT
        WHERE GATE_SYS_ID = P_GATE_IN_ID AND IFNULL(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND STATION_ID = TEMP_STATION_ID;

        -- IF IFNULL(TEMP_INWARD_SYS_ID, 0) > 0 AND TEMP_INWARD_SYS_ID = 125 THEN
            -- Fetch TARE_WT
            SELECT IFNULL(TARE_WT, 0) INTO TEMP_TARE_WT
            FROM FG_WEIGHMENT_DETAIL
            WHERE WT_SYS_ID = P_ID AND GATE_SYS_ID = P_GATE_IN_ID;

            -- Validate gross weight
            IF IFNULL(P_GROSS_WT, 0) < IFNULL(TEMP_TARE_WT, 0) THEN
                SET P_RESULT = 'E|Gross weight is less than Tare weight.|0';
            ELSE
                -- Update record
                UPDATE FG_WEIGHMENT_DETAIL
                SET GROSS_WT = P_GROSS_WT,
                    GROSS_WT_DT = NOW(),
                    GROSS_WT_MANUALLY = 1,
                    GROSS_WT_NOTE = P_GROSS_WT_NOTE,
                    NET_WT = (IFNULL(P_GROSS_WT, 0) - IFNULL(TEMP_TARE_WT, 0))
                WHERE WT_SYS_ID = P_ID AND GATE_SYS_ID = P_GATE_IN_ID;

                SET P_RESULT = 'S|Record saved successfully|0';
            END IF;
        -- END IF;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_WEIGHMENT_OUT_SLIP_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_WEIGHMENT_OUT_SLIP_GET(
    IN P_ID INT,
    IN P_RFID_NO VARCHAR(255),
    IN P_VEHICLE_NO VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
    #,OUT P_RESULT CURSOR,
    #OUT P_DTLS CURSOR
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
		, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
				FROM fg_gate_in_out X, 
				(SELECT Z.* FROM mda_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID AND Z.OUT_TIME IS NULL
					AND ((Z.VEHICLE_NO = P_VEHICLE_NO
							OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_VEHICLE_NO) 
							OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_VEHICLE_NO) AND XZ.INWARD_SYS_ID IN (125, 1))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0)
                         )
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.MDA_SYS_ID = Y.MDA_SYS_ID 
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_IN_DT IS NOT NULL -- AND X.GATE_OUT_DT IS NULL
				-- AND 0 > (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0)
	)
	SELECT X.PLANT_ID, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.MDA_SYS_ID COMMON_SYS_ID, X.MDA_NO COMMON_NO, X.VEHICLE_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
	, X.TRANS_SYS_ID, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.TARE_WT_NOTE
	, ZZ.GROSS_WT, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, ZZ.GROSS_WT_NOTE, ZZ.TOLERANCE_WT, ZZ.NET_WT, NULL Skip_LILO_Remarks
    , XZ.RFSYSID, XZ.RFIDSRNO RFID_NO, XZ.RFIDCODE
    , (CASE WHEN GATE_SYS_ID_OLD > 0 THEN 'Weighment Slip - TRANSFER OF GOODS' ELSE 'Weighment Slip - Weigh Out' END) REPORT_TITLE
	FROM TBL_MAIN X 
	LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID
	WHERE ZZ.TARE_WT IS NOT NULL AND IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.GROSS_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) > 0
	ORDER BY X.GATE_IN_DT DESC, X.MDA_DT DESC;


	WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
		, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
				FROM fg_gate_in_out X, 
				(SELECT Z.* FROM mda_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID AND Z.OUT_TIME IS NULL
					AND ((Z.VEHICLE_NO = P_VEHICLE_NO
							OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_VEHICLE_NO) 
							OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_VEHICLE_NO) AND XZ.INWARD_SYS_ID IN (125, 1))
						 ))
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.MDA_SYS_ID = Y.MDA_SYS_ID AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_IN_DT IS NOT NULL
                -- AND  X.GATE_OUT_DT >= '2024-07-01' -- temp add by ashish
                -- AND X.GATE_OUT_DT IS NULL
				-- AND 0 > (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0)
	)
	SELECT X.PLANT_ID, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.MDA_SYS_ID COMMON_SYS_ID, X.MDA_NO COMMON_NO, X.VEHICLE_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(X.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
    , PROD.PROD_SYS_ID, PROD.SKU_CODE, PROD.SKU_NAME, PROD.PRD_CD, PROD.PRD_DESC
    , MD.SHIPMENT_NO, MD.BAG_NOS no_of_bottle, (CASE WHEN COALESCE(MD.BAG_NOS, 0) = 0 THEN 0 ELSE (MD.BAG_NOS / 24) END) no_of_Box, MD.GROSS_QTY
    , X.DIST, X.desp_place
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
	, X.TRANS_SYS_ID, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.TARE_WT_NOTE
	, ZZ.GROSS_WT, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, ZZ.GROSS_WT_NOTE, ZZ.TOLERANCE_WT, ZZ.NET_WT
    -- , (SELECT COUNT(*) FROM mda_loading XZ WHERE XZ.MDA_SYS_ID = COMMON_SYS_ID) no_of_Box_Loaded    
	-- SELECT COUNT(*) INTO Total_LOADED_SHIPPER FROM MDA_Loading Z WHERE GATE_SYS_ID = P_GATE_IN_ID AND MDA_SYS_ID = P_MDA_ID AND PROD_SYS_ID = P_PRODUCT_ID AND PLANT_ID = P_PLANT_ID;
    , (SELECT COUNT(*) FROM QR_CODE_SUCCESSLIST_LOG QCS WHERE QCS.MDA_NO = X.MDA_NO) no_of_Box_Loaded
    , XZ.RFSYSID, XZ.RFIDSRNO RFID_NO, XZ.RFIDCODE
    , (CASE WHEN GATE_SYS_ID_OLD > 0 THEN 'Weighment Slip - TRANSFER OF GOODS' ELSE 'Weighment Slip - Weigh Out' END) REPORT_TITLE
	FROM TBL_MAIN X 
    LEFT JOIN MDA_DETAIL MD ON X.MDA_SYS_ID = MD.MDA_SYS_ID AND MD.PLANT_ID = X.PLANT_ID
    LEFT JOIN PRODUCT_MASTER PROD ON MD.PROD_SYS_ID = PROD.PROD_SYS_ID AND MD.PLANT_ID = X.PLANT_ID
	LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID
	WHERE ZZ.TARE_WT IS NOT NULL AND IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.GROSS_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) > 0
    -- AND DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y') >= DATE_FORMAT(curdate()-3, '%d/%m/%Y')
	ORDER BY X.GATE_IN_DT DESC, X.MDA_DT DESC;


/*
    -- Cursor for P_RESULT
    #DECLARE cur_result CURSOR FOR
    SELECT 
        X.WT_SYS_ID AS ID, 
        X.TARE_WT, 
        DATE_FORMAT(X.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, 
        X.TARE_WT_MANUALLY, 
        X.TARE_WT_NOTE,
        GATE_SYS_ID AS Gate_In_Id, 
        DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, 
        DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT,
        INWARD_SYS_ID, 
        (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE, 
        COMMON_NO, 
        COMMON_SYS_ID,
        TRANS_SYS_ID, 
        (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) AS TRANSPORTER_NAME,
        TRUCK_NO, 
        DRIVER_ID_TYPE, 
        (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT,
        DRIVER_ID_NUMBER, 
        DRIVER_NAME, 
        DRIVER_CONTACT, 
        DRIVER_CHANGED, 
        DRIVER_NAME_NEW, 
        DRIVER_CONTACT_NEW, 
        TRUCK_VALIDATION, 
        IS_GOODS_TRANSFER, 
        IS_UNLOAD_TRUCK,
        X.RFSYSID, 
        (SELECT RFIDSRNO FROM RFID_MASTER Z WHERE Z.RFSYSID = X.RFSYSID LIMIT 1) AS RFID_NO,
        XZ.RFIDSRNO, 
        XZ.RFIDCODE,
        VERIFIED_DOCUMENTS, 
        RFID_RECEIVE, 
        VERIFIED_OFFICER_ID, 
        NULL AS VERIFIED_OFFICER_NAME, 
        GATE_SYS_ID_OLD, 
        CANCEL_GATE_IN, 
        CANCEL_GATE_REASON,
        X.VENDOR_SYS_ID, 
        VM.VENDOR_CODE, 
        VM.ORGANIZATION_NAME AS VENDOR_NAME,
        X.CUST_CD, 
        X.CUST_NAME, 
        X.CUST_SITE_CD, 
        X.SITE_NAME, 
        X.STATION_ID, 
        X.PLANT_ID, 
        PM.PLANT_NAME, 
        PM.PLANTCODE AS PLANT_CODE, 
        X.IS_POSTED,
        X.WT_SYS_ID, 
        X.TARE_WT, 
        DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, 
        X.TARE_WT_MANUALLY, 
        X.TARE_WT_NOTE,
        GROSS_WT, 
        DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, 
        GROSS_WT_MANUALLY, 
        GROSS_WT_NOTE, 
        NET_WT, 
        OUT_OF_TOLERANCE_WT, 
        TOLERANCE_WT, 
        ALLOW_TOLERANCE_WT,
        NULL Skip_LILO_Remarks,
        (CASE WHEN GATE_SYS_ID_OLD > 0 THEN 'Weighment Slip - TRANSFER OF GOODS' ELSE 'Weighment Slip - Weight Out' END) AS REPORT_TITLE
    FROM (
        SELECT 
            ZZ.WT_SYS_ID, 
            ZZ.TARE_WT, 
            ZZ.TARE_WT_DT, 
            ZZ.TARE_WT_MANUALLY, 
            ZZ.TARE_WT_NOTE,
            GROSS_WT, 
            GROSS_WT_DT, 
            GROSS_WT_MANUALLY, 
            GROSS_WT_NOTE, 
            NET_WT,
            OUT_OF_TOLERANCE_WT, 
            TOLERANCE_WT, 
            ALLOW_TOLERANCE_WT,
            X.GATE_SYS_ID, 
            GATE_IN_DT, 
            GATE_OUT_DT, 
            INWARD_SYS_ID, 
            X.MDA_SYS_ID AS COMMON_SYS_ID,
            CAST(XZ.MDA_NO AS CHAR) AS COMMON_NO, 
            XZ.TRANS_SYS_ID, 
            TRUCK_NO, 
            DRIVER_ID_TYPE, 
            DRIVER_ID_NUMBER, 
            DRIVER_NAME, 
            DRIVER_CONTACT, 
            DRIVER_CHANGED, 
            DRIVER_NAME_NEW, 
            DRIVER_CONTACT_NEW, 
            TRUCK_VALIDATION, 
            IS_GOODS_TRANSFER, 
            NULL AS IS_UNLOAD_TRUCK,
            RFSYSID, 
            VERIFIED_DOCUMENTS, 
            RFID_RECEIVE, 
            VERIFIED_OFFICER_ID, 
            GATE_SYS_ID_OLD, 
            CANCEL_GATE_IN, 
            CANCEL_GATE_REASON,
            NULL AS VENDOR_SYS_ID, 
            XZ.WH_CD AS CUST_CD, 
            XZ.PARTY_NAME AS CUST_NAME, 
            NULL AS CUST_SITE_CD, 
            NULL AS SITE_NAME, 
            X.STATION_ID, 
            X.PLANT_ID, 
            X.IS_POSTED
        FROM FG_GATE_IN_OUT X
        LEFT JOIN MDA_HEADER XZ ON X.MDA_SYS_ID = XZ.MDA_SYS_ID
        LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
        WHERE X.TRUCK_NO = P_VEHICLE_NO AND COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL  AND GATE_IN_DT IS NOT NULL 
    ) X
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID -- AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
    LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID;
*/

/*
    -- Cursor for P_DTLS
    #DECLARE cur_dtls CURSOR FOR
    SELECT 
        X.MDA_DTL_SYS_ID AS ID, 
        COMMON_SYS_ID, 
        COMMON_NO, 
        DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT, 
        X.PROD_SYS_ID, 
        PROD.SKU_CODE, 
        PROD.SKU_NAME, 
        PROD.PRD_CD, 
        PROD.PRD_DESC, 
        X.SHIPMENT_NO, 
        X.BAG_NOS no_of_bottle, (CASE WHEN COALESCE(X.BAG_NOS, 0) = 0 THEN 0 ELSE (X.BAG_NOS / 24) END) no_of_Box
        , (SELECT COUNT(*) FROM mda_loading XZ WHERE XZ.MDA_SYS_ID = COMMON_SYS_ID) no_of_Box_Loaded,
        X.GROSS_QTY,
        INWARD_SYS_ID, 
        (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE,
        TRANS_SYS_ID, 
        (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) AS TRANSPORTER_NAME,
        TRUCK_NO, 
        DRIVER_ID_TYPE, 
        (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT,
        DRIVER_ID_NUMBER, 
        DRIVER_NAME, 
        DRIVER_CONTACT, 
        DRIVER_CHANGED, 
        DRIVER_NAME_NEW, 
        DRIVER_CONTACT_NEW, 
        TRUCK_VALIDATION, 
        IS_GOODS_TRANSFER, 
        IS_UNLOAD_TRUCK,
        X.RFSYSID, 
        XZ.RFIDSRNO, 
        XZ.RFIDCODE,
        VERIFIED_DOCUMENTS, 
        RFID_RECEIVE, 
        VERIFIED_OFFICER_ID, 
        NULL AS VERIFIED_OFFICER_NAME, 
        GATE_SYS_ID_OLD, 
        CANCEL_GATE_IN, 
        CANCEL_GATE_REASON,
        X.VENDOR_SYS_ID, 
        VM.VENDOR_CODE, 
        VM.ORGANIZATION_NAME AS VENDOR_NAME,
        X.CUST_CD, 
        X.CUST_NAME, 
        X.CUST_SITE_CD, 
        X.SITE_NAME, 
        X.STATION_ID, 
        X.PLANT_ID, 
        PM.PLANT_NAME, 
        PM.PLANTCODE AS PLANT_CODE, 
        X.IS_POSTED
    FROM (
        SELECT 
            ZZ.MDA_DTL_SYS_ID, 
            ZZ.PROD_SNO, 
            XZ.MDA_DT, 
            ZZ.PROD_SYS_ID, 
            ZZ.SHIPMENT_NO, 
            ZZ.BAG_NOS, 
            ZZ.NETT_QTY, 
            ZZ.GROSS_QTY,
            X.GATE_SYS_ID, 
            GATE_IN_DT, 
            GATE_OUT_DT, 
            INWARD_SYS_ID, 
            X.MDA_SYS_ID AS COMMON_SYS_ID,
            CAST(XZ.MDA_NO AS CHAR) AS COMMON_NO, 
            XZ.TRANS_SYS_ID, 
            TRUCK_NO, 
            DRIVER_ID_TYPE, 
            DRIVER_ID_NUMBER, 
            DRIVER_NAME, 
            DRIVER_CONTACT, 
            DRIVER_CHANGED, 
            DRIVER_NAME_NEW, 
            DRIVER_CONTACT_NEW, 
            TRUCK_VALIDATION, 
            IS_GOODS_TRANSFER, 
            NULL AS IS_UNLOAD_TRUCK,
            RFSYSID, 
            VERIFIED_DOCUMENTS, 
            RFID_RECEIVE, 
            VERIFIED_OFFICER_ID, 
            GATE_SYS_ID_OLD, 
            CANCEL_GATE_IN, 
            CANCEL_GATE_REASON,
            NULL AS VENDOR_SYS_ID, 
            XZ.WH_CD AS CUST_CD, 
            XZ.PARTY_NAME AS CUST_NAME, 
            NULL AS CUST_SITE_CD, 
            NULL AS SITE_NAME, 
            X.STATION_ID, 
            X.PLANT_ID, 
            X.IS_POSTED
        FROM FG_GATE_IN_OUT X
		INNER JOIN MDA_HEADER XZ ON XZ.MDA_SYS_ID = X.MDA_SYS_ID
        LEFT JOIN MDA_DETAIL ZZ ON X.MDA_SYS_ID = ZZ.MDA_SYS_ID
        WHERE X.TRUCK_NO = P_VEHICLE_NO AND COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL
    ) X
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID -- AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
    LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID
    LEFT JOIN PRODUCT_MASTER PROD ON X.PROD_SYS_ID = PROD.PROD_SYS_ID;
*/

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_WEIGHT_IN_OUT_GET */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE PC_WEIGHT_IN_OUT_GET(IN P_SEARCHTERM VARCHAR(255), IN P_PLANT_ID INT)
BEGIN
	WITH TBL_MAIN AS 
		(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
			, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
			, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER
			, Y.DI_NO, Y.PLANT_CD, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
					FROM fg_gate_in_out X, 
					(SELECT Z.* FROM mda_header Z
						WHERE Z.PLANT_ID = 4 AND OUT_TIME IS NULL
						AND ((Z.VEHICLE_NO = P_SEARCHTERM
								OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM mda_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM) 
								OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = '') AND XZ.INWARD_SYS_ID IN (125, 1))
							 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '', 1, 0)
							)
					) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.VEHICLE_NO AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
					AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 
													AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0)
		)
		SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, ZZ.WT_SYS_ID, X.MDA_NO, X.VEHICLE_NO, X.PLANT_CD
		, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
		, (X.BAG_NOS / 24) Required_Shipper, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT
		, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
		, X.TRANS_SYS_ID, TM.tptr_cd, TM.TPTR_NAME
		, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
		, X.WH_CD, X.PARTY_NAME, X.DIST
		FROM TBL_MAIN X 
		INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
		INNER JOIN TRANSPORTER_MASTER TM ON TM.TRANS_SYS_ID = X.TRANS_SYS_ID and TM.Plant_ID = X.PLANT_ID
		WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL
		ORDER BY 3 DESC, 4 DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Add_Qty_Request */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE SP_Add_Qty_Request(IN `_GATE_SYS_ID` INT(11), IN `_MDA_SYS_ID` INT(11), IN `_PROD_SYS_ID` INT(11), IN `_REQUIRED_SHIPPER_QTY` INT(11), IN `_REASON` VARCHAR(20), IN `_REQUEST_STATUS` VARCHAR(10), IN `_RESPONSE_MSG` VARCHAR(30), IN `_Created_DateTime` DATETIME, IN `_Created_BY_ID` INT(11), IN `_PLANT_ID` INT(11))
BEGIN
INSERT INTO mda_add_qty_request
(
GATE_SYS_ID,
MDA_SYS_ID,
PROD_SYS_ID,
REQUIRED_SHIPPER_QTY,
REASON,
REQUEST_STATUS,
RESPONSE_MSG,
Created_DateTime, 
Created_BY_ID,
PLANT_ID
)
VALUES
(
_GATE_SYS_ID,
_MDA_SYS_ID,
_PROD_SYS_ID,
_REQUIRED_SHIPPER_QTY,
_REASON,
_REQUEST_STATUS,
_RESPONSE_MSG,
_Created_DateTime, 
_Created_BY_ID,
_PLANT_ID
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Add_Role_To_Url */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Add_Role_To_Url(IN `_Url_Id` INT(11), IN `_Role_Id` INT(11), IN `_Plant_Id` INT(11), IN `_Status` TINYINT(1))
BEGIN
INSERT INTO roleto_user
(
Url_Id,
Role_Id,
Plant_Id,
Status
)
VALUES
(
_User_Id,
_Role_Id,
_Plant_Id,
_Status
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Add_Role_To_User */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Add_Role_To_User(IN `_User_Id` INT(11), IN `_Role_Id` INT(11), IN `_Plant_Id` INT(11))
BEGIN
INSERT INTO roleto_user
(
User_Id,
Role_Id,
Plant_Id
)
VALUES
(
_User_Id,
_Role_Id,
_Plant_Id
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Add_VenderSite */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Add_VenderSite(IN `SITE_ID` INT(11), IN `SITE_NAME` VARCHAR(50), IN `PLANT_ID` INT(11), IN `VENDER_ID` INT(11), IN `CREATED_BY` INT(11), IN `CREATED_DATETIME` DATETIME, IN `IS_ACTIVE` INT(11))
BEGIN
INSERT INTO site_master
(
SITE_ID,
SITE_NAME,
PLANT_ID,
VENDER_ID,
CREATED_BY,
CREATED_DATETIME,
IS_ACTIVE
)
VALUES
(
_SITE_ID,
_SITE_NAME,
_PLANT_ID,
_VENDER_ID,
_CREATED_BY,
_CREATED_DATETIME,
_IS_ACTIVE
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_BELT_CHANGE_STATUS */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_BELT_CHANGE_STATUS(
IN _GATE_SYS_ID INT(11),
IN _MDA_NO VARCHAR(45),
IN _SKU_CODE VARCHAR(45),
IN _LOADING_BAY VARCHAR(45),
IN _LOADING_BAY_SYS_ID INT(11),
IN _PLANT_ID INT(11)
)
BEGIN
DECLARE _PROD_SYS_ID INT;
SET _PROD_SYS_ID=0;

select PROD_SYS_ID into _PROD_SYS_ID from mda_requisition_data 
where MDA_NO=_MDA_NO and SKU_CODE=_SKU_CODE and GATE_SYS_ID=_GATE_SYS_ID and PLANT_ID=_PLANT_ID;


update mda_requisition_data set LOADING_BAY=_LOADING_BAY, LOADING_BAY_SYS_ID=_LOADING_BAY_SYS_ID 
where MDA_NO=_MDA_NO and SKU_CODE=_SKU_CODE and GATE_SYS_ID=_GATE_SYS_ID and PLANT_ID=_PLANT_ID;

update qr_code_successlist set BELT_NO = _LOADING_BAY_SYS_ID 
where  MDA_NO=_MDA_NO and Product_SYS_ID=_PROD_SYS_ID and PLANT_ID=_PLANT_ID;

update qr_code_rejectlist set BELT_NO = _LOADING_BAY_SYS_ID 
where  MDA_NO=_MDA_NO and Product_SYS_ID=_PROD_SYS_ID and PLANT_ID=_PLANT_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_BELT_SETTING_UPDATE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE SP_BELT_SETTING_UPDATE(
IN _BeltSysID INT(11),
IN _PLANT_ID INT(11),
IN _ShipperRejectionCount INT(11),
IN _WmsByPass varchar(3)
)
BEGIN
UPDATE belt_master
SET
ShipperRejectionCount = _ShipperRejectionCount,
WmsByPass = _WmsByPass
WHERE BeltSysID=_BeltSysID AND PLANT_ID=_PLANT_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_BELT_STATUS_INSERT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_BELT_STATUS_INSERT(IN `_HardwareUID` VARCHAR(45), IN `_BELT_STATUS` INT(11))
BEGIN
DECLARE _BeltSysID INT;
DECLARE _PLANT_ID INT;
SET _BeltSysID=0;
 SET _PLANT_ID=0;

INSERT INTO kios_api_response
(HARDWARE,ShipperQRCode,BELT_STATUS,API_NAME)
VALUES
(_HardwareUID,'',_BELT_STATUS,'BELT_STATUS_INSERT');

SELECT BeltSysID INTO _BeltSysID FROM belt_master WHERE HardwareUID=_HardwareUID;
SELECT PLANT_ID INTO _PLANT_ID FROM belt_master WHERE HardwareUID=_HardwareUID;
DELETE FROM belt_loading_status WHERE BeltSysID=_BeltSysID and PLANT_ID=_PLANT_ID; 
INSERT INTO belt_loading_status
(
PLANT_ID,
BeltSysID,
BELT_STATUS
)
VALUES
(
_PLANT_ID,
_BeltSysID,
_BELT_STATUS
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Change_Lost_RFID */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Change_Lost_RFID(IN `_REF_SYS_ID` INT(11), IN `_INWARD_SYS_ID` INT(11), IN `_NewRFSYSID` INT(11), IN `_REASON` VARCHAR(50), IN `_REMARK` VARCHAR(50), IN `_RFID_LOST_DATE` DATETIME, IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME, IN `_OldRFSYSID` INT(11))
BEGIN
INSERT INTO rfid_lost
(
REF_SYS_ID,
INWARD_SYS_ID,
RFSYSID,
REASON,
REMARK,
RFID_LOST_DATE,
STATION_ID,
PLANT_ID,
Created_BY_ID,
Created_DateTime
)
VALUES
(
_REF_SYS_ID,
_INWARD_SYS_ID,
_OldRFSYSID,
_REASON,
_REMARK,
_RFID_LOST_DATE,
_STATION_ID,
_PLANT_ID,
_Created_BY_ID,
_Created_DateTime
);

UPDATE fg_gate_in_out SET RFSYSID=_NewRFSYSID where GATE_SYS_ID=_REF_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_CountryMaster_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_CountryMaster_Insert(IN `_COUNTRY_ID` INT(11), IN `_COUNTRY_NAME` VARCHAR(45), IN `_PLANT_ID` INT(11), IN `_CREATED_BY` INT(11), IN `_CREATED_DATETIME` DATETIME)
BEGIN
INSERT INTO countrymaster
(
COUNTRY_ID,
COUNTRY_NAME,
PLANT_ID,
CREATED_BY,
CREATED_DATETIME
)
VALUES
(
_COUNTRY_ID,
_COUNTRY_NAME,
_PLANT_ID,
_CREATED_BY,
_CREATED_DATETIME
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_CountryMaster_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_CountryMaster_Update(IN `_COUNTRY_ID` INT(11), IN `_COUNTRY_NAME` VARCHAR(45), IN `_PLANT_ID` INT(11))
BEGIN
UPDATE countrymaster
SET
COUNTRY_NAME=_COUNTRY_NAME
WHERE PLANT_ID=_PLANT_ID AND COUNTRY_ID=_COUNTRY_ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_CountryMaster_View */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_CountryMaster_View(IN `_PLANT_ID` INT(11))
BEGIN
SELECT COUNTRY_ID,
    COUNTRY_NAME,
    PLANT_ID,
    CREATED_BY,
    CREATED_DATETIME
FROM countrymaster;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Designation_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Designation_Insert(IN `_DESG_SYS_ID` INT(11), IN `_DESG_NAME` VARCHAR(45), IN `_PLANT_ID` INT(11), IN `_CREATED_BY` INT(11), IN `_CREATED_DATETIME` DATETIME)
BEGIN
INSERT INTO designation_master
(
DESG_SYS_ID,
DESG_NAME,
PLANT_ID,
CREATED_BY,
CREATED_DATETIME
)
VALUES
(
_DESG_SYS_ID,
_DESG_NAME,
_PLANT_ID,
_CREATED_BY,
_CREATED_DATETIME
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Designation_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Designation_Update(IN `_DESG_SYS_ID` INT(11), IN `_DESG_NAME` VARCHAR(45), IN `_PLANT_ID` INT(11))
BEGIN
UPDATE designation_master
SET
DESG_NAME=_DESG_NAME
WHERE PLANT_ID=_PLANT_ID AND DESG_SYS_ID=_DESG_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Designation_View */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Designation_View(IN `_PLANT_ID` INT(11))
BEGIN
SELECT DESG_SYS_ID,
    DESG_NAME,
    PLANT_ID,
    CREATED_BY,
    CREATED_DATETIME
FROM designation_master;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_DistrictMaster_By_StCt_ID */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_DistrictMaster_By_StCt_ID(IN `_PLANT_ID` INT(11), IN `_STATE_ID` INT(11))
BEGIN
SELECT DISTRICT_ID,
    DISTRICT_NAME,
    STATE_ID,
    COUNTRY_ID,
    PLANT_ID,
    CREATED_BY,
    CREATED_DATETIME
FROM districtmaster WHERE STATE_ID=_STATE_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_DistrictMaster_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_DistrictMaster_Insert(IN `_DISTRICT_ID` INT(11), IN `_DISTRICT_NAME` VARCHAR(45), IN `_STATE_ID` INT(11), IN `_COUNTRY_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_CREATED_BY` INT(11), IN `_CREATED_DATETIME` DATETIME)
BEGIN
INSERT INTO districtmaster
(
DISTRICT_ID,
DISTRICT_NAME,
STATE_ID,
COUNTRY_ID,
PLANT_ID,
CREATED_BY,
CREATED_DATETIME
)
VALUES
(
_DISTRICT_ID,
_DISTRICT_NAME,
_STATE_ID,
_COUNTRY_ID,
_PLANT_ID,
_CREATED_BY,
_CREATED_DATETIME
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_DistrictMaster_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_DistrictMaster_Update(IN `_DISTRICT_ID` INT(11), IN `_DISTRICT_NAME` VARCHAR(45), IN `_STATE_ID` INT(11), IN `_COUNTRY_ID` INT(11), IN `_PLANT_ID` INT(11))
BEGIN
UPDATE districtmaster
SET
DISTRICT_NAME=_DISTRICT_NAME,
STATE_ID=_STATE_ID,
COUNTRY_ID=_COUNTRY_ID
WHERE PLANT_ID=_PLANT_ID AND DISTRICT_ID=_DISTRICT_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_DistrictMaster_View */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_DistrictMaster_View(IN `_PLANT_ID` INT(11), IN `_DISTRICT_ID` INT(11))
BEGIN
SELECT DISTRICT_ID,
    DISTRICT_NAME,
    STATE_ID,
    COUNTRY_ID,
    PLANT_ID,
    CREATED_BY,
    CREATED_DATETIME
FROM districtmaster WHERE DISTRICT_ID=_DISTRICT_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_Change_Lost_RFID */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_FG_Change_Lost_RFID(IN `_REF_SYS_ID` INT(11), IN `_INWARD_SYS_ID` INT(11), IN `_NewRFSYSID` INT(11), IN `_REASON` VARCHAR(50), IN `_REMARK` VARCHAR(50), IN `_RFID_LOST_DATE` DATETIME, IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME, IN `_OldRFSYSID` INT(11))
BEGIN
INSERT INTO rfid_lost
(
REF_SYS_ID,
INWARD_SYS_ID,
RFSYSID,
REASON,
REMARK,
RFID_LOST_DATE,
STATION_ID,
PLANT_ID,
Created_BY_ID,
Created_DateTime
)
VALUES
(
_REF_SYS_ID,
_INWARD_SYS_ID,
_OldRFSYSID,
_REASON,
_REMARK,
_RFID_LOST_DATE,
_STATION_ID,
_PLANT_ID,
_Created_BY_ID,
_Created_DateTime
);

UPDATE fg_gate_in_out SET RFSYSID=_NewRFSYSID where GATE_SYS_ID=_REF_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_GateInOutReport */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_FG_GateInOutReport(IN `_GATE_IN_DT_From` DATE, IN `_GATE_IN_DT_To` DATE)
BEGIN
SELECT 
gt.GATE_SYS_ID,
gt.GATE_IN_DT,
gt.GATE_OUT_DT,
gt.INWARD_SYS_ID,
gt.MDA_SYS_ID,
gt.TRUCK_NO,
gt.DRIVER_ID_TYPE,
gt.DRIVER_ID_NUMBER,
gt.DRIVER_NAME,
gt.DRIVER_CONTACT,
gt.DRIVER_CHANGED,
gt.DRIVER_NAME_NEW,
gt.DRIVER_CONTACT_NEW,
gt.TRUCK_VALIDATION,
gt.RFSYSID,
gt.VERIFIED_DOCUMENTS,
gt.RFID_RECEIVE,
gt.VERIFIED_OFFICER_ID,
gt.CANCEL_GATE_IN,
gt.CANCEL_GATE_REASON,
gt.GATE_SYS_ID_OLD,
gt.IS_GOODS_TRANSFER,
gt.STATION_ID,
gt.PLANT_ID,
gt.Created_BY_ID,
gt.Created_DateTime,
gt.IS_POSTED,
mh.MDA_NO,
wt.TARE_WT,
wt.TARE_WT_DT,
wt.GROSS_WT,
wt.GROSS_WT_DT,
wt.NET_WT,
wt.OUT_OF_TOLERANCE_WT,
wt.TOLERANCE_WT,
wt.ALLOW_TOLERANCE_WT,
wt.WT_SYS_ID,
tm.tptr_name ,
rfid.RFIDSRNO As RFIDCODE,
rfid.STATUS
FROM fg_gate_in_out gt
inner join rfid_master rfid on gt.RFSYSID = rfid.RFSYSID
inner join mda_header mh on gt.MDA_SYS_ID = mh.MDA_SYS_ID
INNER JOIN transporter_master tm on mh.TRANS_SYS_ID=tm.TRANS_SYS_ID
left outer join fg_weighment_detail wt on gt.GATE_SYS_ID = wt.GATE_SYS_ID 
WHERE DATE_FORMAT(gt.GATE_IN_DT,'%y-%m-%d') between DATE_FORMAT(_GATE_IN_DT_From,'%y-%m-%d') and DATE_FORMAT(_GATE_IN_DT_To,'%y-%m-%d');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_GateIn_Cancel_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_FG_GateIn_Cancel_Update(IN `_GATE_SYS_ID` INT(11), IN `_GATE_OUT_DT` DATETIME, IN `_RFID_RECEIVE` TINYINT(1), IN `_VERIFIED_DOCUMENTS` TINYINT(1), IN `_VERIFIED_OFFICER_ID` VARCHAR(50), IN `_CANCEL_GATE_IN` TINYINT(1), IN `_CANCEL_GATE_REASON` VARCHAR(50))
BEGIN
UPDATE fg_gate_in_out
SET
GATE_OUT_DT = _GATE_OUT_DT,
RFID_RECEIVE = _RFID_RECEIVE,
VERIFIED_DOCUMENTS = _VERIFIED_DOCUMENTS,
VERIFIED_OFFICER_ID = _VERIFIED_OFFICER_ID,
CANCEL_GATE_IN = _CANCEL_GATE_IN,
CANCEL_GATE_REASON = _CANCEL_GATE_REASON
WHERE GATE_SYS_ID = _GATE_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_GateIn_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_FG_GateIn_Insert(IN `_GATE_SYS_ID` INT(11), IN `_GATE_SYS_ID_OLD` INT(11), IN `_GATE_IN_DT` DATETIME, IN `_INWARD_SYS_ID` INT(11), IN `_MDA_SYS_ID` INT(11), IN `_TRUCK_NO` VARCHAR(10), IN `_DRIVER_ID_TYPE` VARCHAR(20), IN `_DRIVER_ID_NUMBER` VARCHAR(30), IN `_DRIVER_NAME` VARCHAR(30), IN `_DRIVER_CONTACT` VARCHAR(10), IN `_DRIVER_CHANGED` TINYINT(1), IN `_DRIVER_NAME_NEW` VARCHAR(30), IN `_DRIVER_CONTACT_NEW` VARCHAR(10), IN `_TRUCK_VALIDATION` TINYINT(1), IN `_RFSYSID` INT(11), IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN
INSERT INTO fg_gate_in_out
(
GATE_SYS_ID_OLD,
GATE_IN_DT,
INWARD_SYS_ID,
MDA_SYS_ID,
TRUCK_NO,
DRIVER_ID_TYPE,
DRIVER_ID_NUMBER,
DRIVER_NAME,
DRIVER_CONTACT,
DRIVER_CHANGED,
DRIVER_NAME_NEW,
DRIVER_CONTACT_NEW,
TRUCK_VALIDATION,
RFSYSID,
STATION_ID,
PLANT_ID,
Created_BY_ID,
Created_DateTime
)
VALUES(
_GATE_SYS_ID_OLD,
_GATE_IN_DT,
_INWARD_SYS_ID,
_MDA_SYS_ID,
_TRUCK_NO,
_DRIVER_ID_TYPE,
_DRIVER_ID_NUMBER,
_DRIVER_NAME,
_DRIVER_CONTACT,
_DRIVER_CHANGED,
_DRIVER_NAME_NEW,
_DRIVER_CONTACT_NEW,
_TRUCK_VALIDATION,
_RFSYSID,
_STATION_ID,
_PLANT_ID,
_Created_BY_ID,
_Created_DateTime
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_GateOut_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_FG_GateOut_Update(IN `_GATE_SYS_ID` INT(11), IN `_GATE_OUT_DT` DATETIME, IN `_RFID_RECEIVE` TINYINT(1), IN `_VERIFIED_DOCUMENTS` TINYINT(1), IN `_VERIFIED_OFFICER_ID` varchar(150))
BEGIN
UPDATE fg_gate_in_out
SET
GATE_OUT_DT=_GATE_OUT_DT,
RFID_RECEIVE=_RFID_RECEIVE,
VERIFIED_DOCUMENTS=_VERIFIED_DOCUMENTS,
VERIFIED_OFFICER_ID=_VERIFIED_OFFICER_ID
WHERE GATE_SYS_ID=_GATE_SYS_ID;

update mda_header set OUT_TIME=_GATE_OUT_DT WHERE MDA_SYS_ID IN(SELECT MDA_SYS_ID FROM mda_sequence WHERE GATE_SYS_ID=_GATE_SYS_ID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_GetDataRFID */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_FG_GetDataRFID(IN `_RFIDSRNO` VARCHAR(49))
BEGIN
SELECT 
gt.GATE_SYS_ID,
gt.GATE_IN_DT,
gt.GATE_OUT_DT,
gt.INWARD_SYS_ID,
gt.MDA_SYS_ID,
gt.TRUCK_NO,
gt.DRIVER_ID_TYPE,
gt.DRIVER_ID_NUMBER,
gt.DRIVER_NAME,
gt.DRIVER_CONTACT,
gt.DRIVER_CHANGED,
gt.DRIVER_NAME_NEW,
gt.DRIVER_CONTACT_NEW,
gt.TRUCK_VALIDATION,
gt.RFSYSID,
gt.VERIFIED_DOCUMENTS,
gt.RFID_RECEIVE,
gt.VERIFIED_OFFICER_ID,
gt.CANCEL_GATE_IN,
gt.CANCEL_GATE_REASON,
gt.GATE_SYS_ID_OLD,
gt.IS_GOODS_TRANSFER,
gt.STATION_ID,
gt.PLANT_ID,
gt.Created_BY_ID,
gt.Created_DateTime,
gt.IS_POSTED,
mh.MDA_NO,
wt.TARE_WT,
wt.TARE_WT_DT,
wt.GROSS_WT,
wt.GROSS_WT_DT,
wt.NET_WT,
wt.OUT_OF_TOLERANCE_WT,
wt.TOLERANCE_WT,
wt.ALLOW_TOLERANCE_WT,
wt.WT_SYS_ID,
tm.tptr_name,
rfid.RFIDSRNO,
rfid.RFIDCODE
FROM fg_gate_in_out gt
inner join rfid_master rfid on gt.RFSYSID = rfid.RFSYSID
inner join mda_header mh on gt.MDA_SYS_ID = mh.MDA_SYS_ID
INNER JOIN transporter_master tm on mh.TRANS_SYS_ID=tm.TRANS_SYS_ID
left outer join fg_weighment_detail wt on gt.GATE_SYS_ID = wt.GATE_SYS_ID 
WHERE (rfid.RFIDSRNO=_RFIDSRNO or rfid.RFIDCODE=_RFIDSRNO) and rfid.STATUS='Assigned' and gt.GATE_OUT_DT is null ORDER BY gt.GATE_SYS_ID DESC LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_SHIPPERLIST_BY_BATCH_COUNT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_FG_SHIPPERLIST_BY_BATCH_COUNT(
IN _MDA_NO varchar(15),
IN _PLANT_ID INT(11)
)
BEGIN
select  shapi.batch_no, count(*) as Count
from mda_header as mh inner join mda_detail as md on mh.MDA_SYS_ID = md.MDA_SYS_ID and mh.PLANT_ID=md.PLANT_ID
inner join product_master as pm on md.PROD_SYS_ID = pm.PROD_SYS_ID and md.PLANT_ID = pm.PLANT_ID
inner join mda_requisition_data as mrd on md.MDA_NO = mrd.MDA_NO and md.PLANT_ID = mrd.PLANT_ID and md.PROD_SYS_ID = mrd.PROD_SYS_ID
inner join mda_loading ml on ml.MDA_SYS_ID=mh.MDA_SYS_ID
inner join shipper_qrcode shq on ml.SHIPPER_QR_CODE=shq.shipper_qrcode
inner join shipper_qrcode_api shapi on shq.shipper_qrcode_api_sysId=shapi.shipper_qrcode_api_sysId
where  mh.MDA_NO=_MDA_NO and mh.PLANT_ID=_PLANT_ID GROUP BY shapi.batch_no;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_SHIPPERLIST_BY_MDA_NO */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE SP_FG_SHIPPERLIST_BY_MDA_NO(
IN _MDA_NO varchar(15),
IN _PLANT_ID INT(11)
)
BEGIN
select mh.MDA_NO, mh.MDA_DT, CONCAT(mh.PARTY_NAME , '  ' , mh.WH_CD) AS PARTY_NAME, mh.VEHICLE_NO, pm.PRD_DESC, md.BAG_NOS as Bottle, (md.BAG_NOS/pm.PROD_PER_SHIPPER) as Box,  
mrd.LOADED_ITEM, ml.SHIPPER_QR_CODE, shapi.batch_no 
from mda_header as mh inner join mda_detail as md on mh.MDA_SYS_ID = md.MDA_SYS_ID and mh.PLANT_ID=md.PLANT_ID
inner join product_master as pm on md.PROD_SYS_ID = pm.PROD_SYS_ID and md.PLANT_ID = pm.PLANT_ID
inner join mda_requisition_data as mrd on md.MDA_NO = mrd.MDA_NO and md.PLANT_ID = mrd.PLANT_ID and md.PROD_SYS_ID = mrd.PROD_SYS_ID
inner join mda_loading ml on ml.MDA_SYS_ID=mh.MDA_SYS_ID
inner join shipper_qrcode shq on ml.SHIPPER_QR_CODE=shq.shipper_qrcode
inner join shipper_qrcode_api shapi on shq.shipper_qrcode_api_sysId=shapi.shipper_qrcode_api_sysId
where  mh.MDA_NO=_MDA_NO and mh.PLANT_ID=_PLANT_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_Tolerance_Wt_Cal */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_FG_Tolerance_Wt_Cal(IN `_GATE_SYS_ID` INT(11), IN `_PLANT_ID` INT(11))
BEGIN
select pm.PROD_SYS_ID, (pm.SHIP_WT_FILL*sum(mrd.LOADED_ITEM)) as NetWt_Shipper, ((pm.SHIP_WT_FILL*sum(mrd.LOADED_ITEM))+ifnull(pm.TOLERANCE_PER,0))  as NetWt_Tolerance  from fg_gate_in_out as fg 
inner join fg_weighment_detail as fgwd on fg.GATE_SYS_ID = fgwd.GATE_SYS_ID and fg.PLANT_ID = fgwd.PLANT_ID
inner join mda_requisition_data as mrd on fg.GATE_SYS_ID = mrd.GATE_SYS_ID and fg.PLANT_ID = mrd.PLANT_ID
inner join product_master as pm on mrd.PLANT_ID=pm.PLANT_ID and mrd.PROD_SYS_ID=pm.PROD_SYS_ID
where mrd.LOADING_PROGRESS='Completed' and fg.GATE_SYS_ID=_GATE_SYS_ID and fg.PLANT_ID=_PLANT_ID group by pm.PROD_SYS_ID;
/*select pm.PROD_SYS_ID, (pm.SHIP_WT_FILL*sum(mrd.LOADED_ITEM)) as NetWt_Shipper, (((pm.SHIP_WT_FILL*sum(mrd.LOADED_ITEM))*pm.TOLERANCE_PER)/100) as NetWt_Tolerance  from fg_gate_in_out as fg 
inner join fg_weighment_detail as fgwd on fg.GATE_SYS_ID = fgwd.GATE_SYS_ID and fg.PLANT_ID = fgwd.PLANT_ID
inner join mda_requisition_data as mrd on fg.GATE_SYS_ID = mrd.GATE_SYS_ID and fg.PLANT_ID = mrd.PLANT_ID
inner join product_master as pm on mrd.PLANT_ID=pm.PLANT_ID and mrd.PROD_SYS_ID=pm.PROD_SYS_ID
where mrd.LOADING_PROGRESS='Completed' and fg.GATE_SYS_ID=_GATE_SYS_ID and fg.PLANT_ID=_PLANT_ID group by pm.PROD_SYS_ID;*/
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_TRUCK_CHECK */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_FG_TRUCK_CHECK(
_PLANT_ID INT(11),
_TRUCK_NO varchar(15)
)
BEGIN
SELECT fg.GATE_SYS_ID, fg.GATE_IN_DT, fg.TRUCK_NO, mh.MDA_NO FROM fg_gate_in_out fg 
inner join mda_header mh on fg.MDA_SYS_ID = mh.MDA_SYS_ID 
where fg.TRUCK_NO=_TRUCK_NO and fg.GATE_OUT_DT is null and fg.PLANT_ID=_PLANT_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_WeighmentIn_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_FG_WeighmentIn_Insert(IN `_WT_SYS_ID` INT(11), IN `_GATE_SYS_ID` INT(11), IN `_TARE_WT` DOUBLE, IN `_TARE_WT_DT` DATETIME, IN `_TARE_WT_MANUALLY` TINYINT(1), IN `_TARE_WT_NOTE` VARCHAR(50), IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN
	if(select count(*) from fg_weighment_detail where GATE_SYS_ID=_GATE_SYS_ID and PLANT_ID=_PLANT_ID)=0 then
		begin
			INSERT INTO fg_weighment_detail
			(
			GATE_SYS_ID,
			TARE_WT,
			TARE_WT_DT,
			TARE_WT_MANUALLY,
			TARE_WT_NOTE,
			STATION_ID,
			PLANT_ID,
			Created_BY_ID,
			Created_DateTime
			)
			VALUES
			(
			_GATE_SYS_ID,
			_TARE_WT,
			_TARE_WT_DT,
			_TARE_WT_MANUALLY,
			_TARE_WT_NOTE,
			_STATION_ID,
			_PLANT_ID,
			_Created_BY_ID,
			_Created_DateTime
			);
		end;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_WeighmentOut_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_FG_WeighmentOut_Update(IN `_WT_SYS_ID` INT(11), IN `_GROSS_WT` DOUBLE, IN `_GROSS_WT_DT` DATETIME, IN `_GROSS_WT_MANUALLY` TINYINT(1), IN `_GROSS_WT_NOTE` VARCHAR(50), IN `_NET_WT` DOUBLE, IN `_OUT_OF_TOLERANCE_WT` TINYINT(1), IN `_TOLERANCE_WT` DOUBLE, IN `_ALLOW_TOLERANCE_WT` TINYINT(1))
BEGIN
UPDATE fg_weighment_detail
SET
GROSS_WT = _GROSS_WT,
GROSS_WT_DT = _GROSS_WT_DT,
GROSS_WT_MANUALLY = _GROSS_WT_MANUALLY,
GROSS_WT_NOTE = _GROSS_WT_NOTE,
NET_WT = _NET_WT,
OUT_OF_TOLERANCE_WT = _OUT_OF_TOLERANCE_WT,
TOLERANCE_WT = _TOLERANCE_WT,
ALLOW_TOLERANCE_WT = _ALLOW_TOLERANCE_WT
WHERE WT_SYS_ID = _WT_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_FG_WEIGHTMENT_REPORT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_FG_WEIGHTMENT_REPORT(IN `_GATE_SYS_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_STATION_ID` INT(11))
BEGIN
SELECT 
gt.GATE_SYS_ID,
gt.GATE_IN_DT,
gt.GATE_OUT_DT,
gt.INWARD_SYS_ID,
gt.MDA_SYS_ID,
gt.TRUCK_NO,
gt.DRIVER_ID_TYPE,
gt.DRIVER_ID_NUMBER,
gt.DRIVER_NAME,
gt.DRIVER_CONTACT,
gt.DRIVER_CHANGED,
gt.DRIVER_NAME_NEW,
gt.DRIVER_CONTACT_NEW,
gt.TRUCK_VALIDATION,
gt.RFSYSID,
gt.VERIFIED_DOCUMENTS,
gt.RFID_RECEIVE,
gt.VERIFIED_OFFICER_ID,
gt.CANCEL_GATE_IN,
gt.CANCEL_GATE_REASON,
gt.GATE_SYS_ID_OLD,
gt.IS_GOODS_TRANSFER,
gt.STATION_ID,
gt.PLANT_ID,
gt.Created_BY_ID,
gt.Created_DateTime,
gt.IS_POSTED,
mh.MDA_NO,
mh.MDA_DT,
ifnull(wt.TARE_WT,0) as TARE_WT,
wt.TARE_WT_MANUALLY,
wt.TARE_WT_DT,
ifnull(wt.GROSS_WT,0) as GROSS_WT,
wt.GROSS_WT_DT,
wt.GROSS_WT_MANUALLY,
ifnull(wt.NET_WT,0) as NET_WT,
wt.OUT_OF_TOLERANCE_WT,
wt.TOLERANCE_WT,
wt.ALLOW_TOLERANCE_WT,
wt.WT_SYS_ID,
tm.tptr_name,
wt.TARE_WT_NOTE,
wt.GROSS_WT_NOTE,
rfid.RFIDSRNO,
pm.Plant_Name,
pm.PlantAddress,
PM.PlantCode  
FROM fg_gate_in_out as gt
inner join rfid_master rfid on gt.RFSYSID = rfid.RFSYSID
inner join mda_header mh on gt.MDA_SYS_ID = mh.MDA_SYS_ID
INNER JOIN transporter_master tm on mh.TRANS_SYS_ID=tm.TRANS_SYS_ID
inner join plant_master as pm on gt.PLANT_ID = pm.PlantID
left outer join fg_weighment_detail wt on gt.GATE_SYS_ID = wt.GATE_SYS_ID 
where gt.GATE_SYS_ID=_GATE_SYS_ID AND gt.PLANT_ID=_PLANT_ID AND gt.STATION_ID=_STATION_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GateIn_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GateIn_Insert(IN `_GATE_SYS_ID` INT(11), IN `_GATE_IN_DT` DATETIME, IN `_INWARD_SYS_ID` INT(11), IN `_MDA_SYS_ID` INT(11), IN `_TRUCK_NO` VARCHAR(10), IN `_DRIVER_ID_TYPE` VARCHAR(20), IN `_DRIVER_ID_NUMBER` INT(11), IN `_DRIVER_NAME` VARCHAR(30), IN `_DRIVER_CONTACT` VARCHAR(10), IN `_DRIVER_CHANGED` TINYINT(1), IN `_DRIVER_NAME_NEW` VARCHAR(30), IN `_DRIVER_CONTACT_NEW` VARCHAR(10), IN `_TRUCK_VALIDATION` TINYINT(1), IN `_RFSYSID` INT(11), IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN
INSERT INTO fg_gate_in_out
(
GATE_SYS_ID,
GATE_IN_DT,
INWARD_SYS_ID,
MDA_SYS_ID,
TRUCK_NO,
DRIVER_ID_TYPE,
DRIVER_ID_NUMBER,
DRIVER_NAME,
DRIVER_CONTACT,
DRIVER_CHANGED,
DRIVER_NAME_NEW,
DRIVER_CONTACT_NEW,
TRUCK_VALIDATION,
RFSYSID,
STATION_ID,
PLANT_ID,
Created_BY_ID,
Created_DateTime
)
VALUES(
_GATE_SYS_ID,
_GATE_IN_DT,
_INWARD_SYS_ID,
_MDA_SYS_ID,
_TRUCK_NO,
_DRIVER_ID_TYPE,
_DRIVER_ID_NUMBER,
_DRIVER_NAME,
_DRIVER_CONTACT,
_DRIVER_CHANGED,
_DRIVER_NAME_NEW,
_DRIVER_CONTACT_NEW,
_TRUCK_VALIDATION,
_RFSYSID,
_STATION_ID,
_PLANT_ID,
_Created_BY_ID,
_Created_DateTime
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GateOut_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GateOut_Update(IN `_GATE_SYS_ID` INT(11), IN `_GATE_OUT_DT` DATETIME, IN `_RFID_RECEIVE` TINYINT(1), IN `_VERIFIED_DOCUMENTS` TINYINT(1), IN `_VERIFIED_OFFICER_ID` VARCHAR(50))
BEGIN
UPDATE fg_gate_in_out
SET
GATE_OUT_DT=_GATE_OUT_DT,
RFID_RECEIVE=_RFID_RECEIVE,
VERIFIED_DOCUMENTS=_VERIFIED_DOCUMENTS,
VERIFIED_OFFICER_ID=_VERIFIED_OFFICER_ID
WHERE GATE_SYS_ID=_GATE_SYS_ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetBeltData */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetBeltData(IN `_HardwareUID` VARCHAR(45))
BEGIN
select BeltSysID, BeltNum, HardwareUID, BeltStatus, PLANT_ID, 
ifnull(ShipperRejectionCount,0) as ShipperRejectionCount, ifnull(WmsByPass,'NO') as WmsByPass,
 ifnull(ShipperRejectionCountCurrent,0) as ShipperRejectionCountCurrent
from belt_master where HardwareUID=_HardwareUID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetBeltStatus */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetBeltStatus(IN `_HardwareUID` VARCHAR(45))
BEGIN

INSERT INTO kios_api_response
(HARDWARE,ShipperQRCode,BELT_STATUS,API_NAME)
VALUES
(_HardwareUID,'','','GetBeltStatus');

select ifnull(BLS.BELT_STATUS,-1) as BELT_STATUS from belt_loading_status BLS 
INNER JOIN belt_master BM ON BLS.BeltSysID=BM.BeltSysID AND BLS.PLANT_ID = BM.PLANT_ID
WHERE BM.HardwareUID=_HardwareUID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetInvoiceQrCode */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetInvoiceQrCode(IN `_PLANT_ID` INT(11))
BEGIN
SELECT * FROM mda_invoice_qr where PLANT_ID=_PLANT_ID and ifnull(IS_DISPATCHED,0)=0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetInvoiceQrCodeByGateSysID */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetInvoiceQrCodeByGateSysID(IN `_PLANT_ID` INT(11), IN `_GATE_SYS_ID` INT(11))
BEGIN
SELECT * FROM mda_invoice_qr where PLANT_ID=_PLANT_ID and ifnull(IS_DISPATCHED,0)=0 and GATE_SYS_ID=_GATE_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetMax_shipper_qrcode_Api */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetMax_shipper_qrcode_Api()
BEGIN
    	select ifnull(max(shipper_qrcode_api_sysId),0)+1  from shipper_qrcode_api;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GETMAX_SHIPPER_QRCODE_SYS_ID */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GETMAX_SHIPPER_QRCODE_SYS_ID()
BEGIN
select ifnull(max(shipper_qrcode_sysId),0)+1  from shipper_qrcode;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetMDADetails */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetMDADetails(IN `_PLANT_ID` INT(11), IN `_MDA_NO` VARCHAR(15))
BEGIN
select mdahdr.MDA_SYS_ID, mdahdr.MDA_NO, mdahdr.MDA_DT, mdahdr.VEHICLE_NO, pdm.PROD_SYS_ID, pdm.SKU_CODE, pdm.SKU_NAME, mdadtl.BAG_NOS, mdadtl.NETT_QTY, mdadtl.GROSS_QTY
from mda_header mdahdr 
inner join mda_detail mdadtl on mdahdr.MDA_SYS_ID = mdadtl.MDA_SYS_ID
inner join product_master pdm on mdadtl.PROD_SYS_ID = pdm.PROD_SYS_ID
where mdahdr.PLANT_ID=_PLANT_ID and mdahdr.MDA_NO=_MDA_NO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetMDAForInVoiceQr */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetMDAForInVoiceQr(IN `_GATE_SYS_ID` INT(11), IN `_PLANT_ID` INT(11))
BEGIN
select mh.MDA_SYS_ID, mrd.MDA_NO from fg_gate_in_out as fg 
inner join mda_requisition_data as mrd on fg.GATE_SYS_ID=mrd.GATE_SYS_ID and fg.PLANT_ID=mrd.PLANT_ID
inner join mda_header as mh on mrd.MDA_NO = mh.MDA_NO and mrd.PLANT_ID = mh.PLANT_ID
where fg.GATE_SYS_ID=_GATE_SYS_ID and fg.PLANT_ID=_PLANT_ID group by mrd.MDA_NO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetPO_Dtl_By_PoNo */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetPO_Dtl_By_PoNo(IN `_PLANT_ID` INT(11), IN `_PO_NO` INT(11))
BEGIN
SELECT vpd.vpo_sys_id_dtl,
    vpd.vpo_sys_id,
    vpd.PLANT_ID,
    vpd.LINE_ITEM_NO,
    vpd.LINE_ITEM_DESC,
    vpd.LINE_QTY,
    vpd.UMO,
    vpd.ADJUSTED_QTY
FROM vendor_po_dtl vpd inner join vendor_po_hdr vph ON vpd.vpo_sys_id = vph.vpo_sys_id
where PLANT_ID=_PLANT_ID and vph.PO_NO=_PO_NO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetProductDetails */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetProductDetails(IN `_PLANT_ID` INT(11), IN `_SKU_CODE` VARCHAR(5))
BEGIN
SELECT PROD_SYS_ID,
    SKU_CODE,
    SKU_NAME,
    PRD_CD,
    PRD_DESC,
    PLANT_ID,
    Created_DateTime,
    IS_POSTED
FROM product_master where PLANT_ID=_PLANT_ID AND SKU_CODE=_SKU_CODE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetShipperQrCodeByPalletCode */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetShipperQrCodeByPalletCode(IN `_HardwareUID` VARCHAR(45), IN `_ShipperQRCode` VARCHAR(45))
BEGIN

	DECLARE _BeltSysID INT;
    DECLARE _PROD_SYS_ID INT;
    DECLARE _PLANT_ID INT;
    SET _BeltSysID=0;    
    SET _PROD_SYS_ID=0;
    SET _PLANT_ID=0;
    
    SELECT PLANT_ID INTO _PLANT_ID FROM belt_master WHERE HardwareUID=_HardwareUID;
    SELECT BeltSysID INTO _BeltSysID FROM belt_master WHERE HardwareUID=_HardwareUID;
    
    SELECT PROD_SYS_ID INTO _PROD_SYS_ID FROM mda_requisition_data 
	where LOADING_BAY_SYS_ID=(_BeltSysID) and LOADING_PROGRESS='IN PROGRESS' order by SKU_ORDER limit 1;

select distinct sqr.shipper_qrcode from shipper_qrcode sqr 
inner join bottle_qrcode bqr on sqr.shipper_qrcode_sysId = bqr.shipper_qrcode_sysId and sqr.plant_id=bqr.plant_id
inner join pallet_qrcode_api pqr on sqr.pallet_qrcode_api_sysId = pqr.pallet_qrcode_api_sysId and sqr.plant_id=pqr.plant_id
where pqr.pallet_qrcode=_ShipperQRCode and bqr.product_id=_PROD_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetTransporterData */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetTransporterData(IN `_PLANT_ID` INT(11), IN `_tptr_name` VARCHAR(50))
BEGIN
SELECT * FROM transporter_master WHERE PLANT_ID=_PLANT_ID AND (tptr_name=_tptr_name);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetTruckDetails_st6 */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetTruckDetails_st6(IN `_PLANT_ID` INT(11), IN `_STATION_ID` INT(11), IN `_TRUCK_NO` VARCHAR(10))
BEGIN
SELECT 
gt.GATE_SYS_ID,
gt.MDA_SYS_ID,
gt.TRUCK_NO,
gt.DRIVER_NAME,
gt.DRIVER_CONTACT,
gt.DRIVER_CHANGED,
gt.DRIVER_NAME_NEW,
gt.DRIVER_CONTACT_NEW,
gt.RFSYSID,
gt.STATION_ID,
gt.PLANT_ID,
mh.MDA_NO,
tm.tptr_name
FROM fg_gate_in_out gt
inner join rfid_master rfid on gt.RFSYSID = rfid.RFSYSID
inner join mda_header mh on gt.MDA_SYS_ID = mh.MDA_SYS_ID
INNER JOIN transporter_master tm on mh.TRANS_SYS_ID=tm.TRANS_SYS_ID
INNER JOIN fg_weighment_detail wt on gt.GATE_SYS_ID = wt.GATE_SYS_ID 
LEFT OUTER JOIN mda_sequence msq on gt.GATE_SYS_ID = msq.GATE_SYS_ID and wt.GATE_SYS_ID = msq.GATE_SYS_ID
WHERE gt.PLANT_ID=_PLANT_ID and gt.TRUCK_NO=_TRUCK_NO and wt.TARE_WT is not null and gt.gate_out_dt is null 
and rfid.STATUS='Assigned' and ifnull(msq.MDA_STATUS,'')<>'Completed';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetTruckList_st6 */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetTruckList_st6(IN `_PLANT_ID` INT(11))
BEGIN
SELECT distinct
gt.GATE_SYS_ID,
gt.MDA_SYS_ID,
gt.GATE_IN_DT,
gt.TRUCK_NO,
gt.DRIVER_NAME,
gt.DRIVER_CONTACT,
gt.DRIVER_CHANGED,
gt.DRIVER_NAME_NEW,
gt.DRIVER_CONTACT_NEW,
gt.RFSYSID,
gt.STATION_ID,
gt.PLANT_ID,
mh.MDA_NO,
tm.tptr_name
FROM fg_gate_in_out gt
inner join rfid_master rfid on gt.RFSYSID = rfid.RFSYSID
inner join mda_header mh on gt.MDA_SYS_ID = mh.MDA_SYS_ID
INNER JOIN transporter_master tm on mh.TRANS_SYS_ID=tm.TRANS_SYS_ID
INNER JOIN fg_weighment_detail wt on gt.GATE_SYS_ID = wt.GATE_SYS_ID 
LEFT OUTER JOIN mda_sequence msq on gt.GATE_SYS_ID = msq.GATE_SYS_ID and wt.GATE_SYS_ID = msq.GATE_SYS_ID
WHERE gt.PLANT_ID=_PLANT_ID and wt.TARE_WT is not null and gt.gate_out_dt is null 
and rfid.STATUS='Assigned' and ifnull(msq.MDA_STATUS,'')<>'Completed' order by gt.GATE_IN_DT asc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GetVendor_By_VENDOR_SYS_ID */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GetVendor_By_VENDOR_SYS_ID(IN `_VENDOR_SYS_ID` INT(11), IN `_PLANT_ID` INT(11))
BEGIN
SELECT PLANT_ID,
    VENDOR_SYS_ID,
    VENDOR_CODE,
    ORGANIZATION_NAME,
    VENDOR_SITE,
    FIRST_NAME,
    MIDDLE_NAME,
    LAST_NAME,
    PRIMARY_MOBILE,
    ALTERNATIVE_MOBILE,
    PRIMARY_EMAIL,
    ALTERNATIVE_EMAIL,
    PHONE_NUMBER,
    COUNTRY_ID,
    STATE_ID,
    DISTRICT_ID,
    CITY,
    ADDRESS,
    IS_SYSTEM_USER,
    PASSWORD,
    ACTIVE,
    USER_LOCK,
    Created_DateTime,
    IS_POSTED,
    VENDOR_TYPE,
    VENDOR_CODE_TEMP,
    PRINT_LABEL_QTY
FROM vendor_master where PLANT_ID=_PLANT_ID and VENDOR_SYS_ID=_VENDOR_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Get_ActiveUser_View */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Get_ActiveUser_View(IN `_PLANT_ID` INT(11))
BEGIN
SELECT USER_ID,
    concat(FIRST_NAME,' ', MIDDLE_NAME,' ',LAST_NAME) as Name
   FROM system_users where PLANT_ID=1 AND  IS_LOCK=false AND IS_ACTIVE=true order by access_rights.Url_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Get_All_RolesUrls */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Get_All_RolesUrls(IN `_Role_Id` INT(11), IN `_Plant_Id` INT(11))
BEGIN
select access_rights.Url_id,all_urls.url,all_urls.url_name,all_urls.menu_name,access_rights.Status,
access_rights.Role_Id,access_rights.Plant_Id,access_rights.Id
from access_rights inner join all_urls on access_rights.Url_id=all_urls.Id
where access_rights.Role_Id=_Role_Id and access_rights.Plant_Id=_Plant_Id
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Get_All_Urls */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Get_All_Urls()
BEGIN
select * from all_urls;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GET_BOTTLE_QRCODE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GET_BOTTLE_QRCODE()
BEGIN
SELECT bottle_qrcode_sysId, bottle_qrcode, product_id, status, shipper_qrcode_sysId, plant_id, created_by, created_datetime, QR_REQUEST_ID,
    QR_REQUEST_FILE_NO, Current_Holder_Type, Current_Holder_SYS_ID FROM bottle_qrcode
where ifnull(IS_SYNCED,0)=0 AND shipper_qrcode_sysId IN(SELECT IFNULL(shipper_qrcode_sysId,0) AS shipper_qrcode_sysId FROM shipper_qrcode
where shipper_qrcode_api_sysId IN(SELECT IFNULL(shipper_qrcode_api_sysId,0) as shipper_qrcode_api_sysId FROM shipper_qrcode_api
where date_format(eventtime,'%Y-%m-%d') >= date_format(CURDATE()-1,'%Y-%m-%d')));
/*SELECT bottle_qrcode_sysId,
    bottle_qrcode,
    product_id,
    status,
    shipper_qrcode_sysId,
    plant_id,
    created_by,
    created_datetime,
    QR_REQUEST_ID,
    QR_REQUEST_FILE_NO,
    Current_Holder_Type,
    Current_Holder_SYS_ID
FROM bottle_qrcode
where ifnull(IS_SYNCED,0)=0;*/
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GET_BOTTLE_QRCODE_UPDATE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GET_BOTTLE_QRCODE_UPDATE(IN `_BOTTLE_QRCODE_SYSID` INT(11), IN `_IS_SYNCED` INT(11), IN _IS_SYNCED_DATETIME datetime)
BEGIN
UPDATE bottle_qrcode
SET
IS_SYNCED=_IS_SYNCED, IS_SYNCED_DATETIME = _IS_SYNCED_DATETIME
WHERE bottle_qrcode_sysId=_BOTTLE_QRCODE_SYSID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Get_Menu_RolesUrls */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Get_Menu_RolesUrls(IN `_Role_Id` INT(11), IN `_Plant_Id` INT(11))
BEGIN
select access_rights.Url_id,all_urls.url,all_urls.url_name,all_urls.menu_name,access_rights.Status,
access_rights.Role_Id,access_rights.Plant_Id,access_rights.Id
from access_rights inner join all_urls on access_rights.Url_id=all_urls.Id
where access_rights.Role_Id=_Role_Id and access_rights.Plant_Id=_Plant_Id and access_rights.Status=1
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GET_PALLET_QRCODE_API */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GET_PALLET_QRCODE_API()
BEGIN
SELECT pallet_qrcode_api_sysId,
    pallet_qrcode,
    total_shipper_qty,
    status,
    plant_id,
    created_by,
    created_datetime,
    palletization_datetime,
    palletization_mode,
    palletization_station,
    Current_Holder_Type,
    Current_Holder_SYS_ID,
    PalletID
FROM pallet_qrcode_api
where ifnull(IS_SYNCED,0)=0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GET_PALLET_QRCODE_API_UPDATE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GET_PALLET_QRCODE_API_UPDATE(IN `_PALLET_QRCODE_API_SYSID` INT(11), IN `_IS_SYNCED` INT(11), IN _IS_SYNCED_DATETIME datetime)
BEGIN
UPDATE pallet_qrcode_api
SET
IS_SYNCED=_IS_SYNCED, IS_SYNCED_DATETIME = _IS_SYNCED_DATETIME
WHERE pallet_qrcode_api_sysId=_PALLET_QRCODE_API_SYSID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Get_ProductList */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Get_ProductList(IN `_PLANT_ID` INT(11))
BEGIN
select PROD_SYS_ID, SKU_NAME from product_master WHERE PLANT_ID=_PLANT_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GET_REQUISITION_WMS_RESP */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GET_REQUISITION_WMS_RESP(IN `_GATE_SYS_ID` INT(11), IN `_LOADING_BAY_SYS_ID` INT(11), IN `_PLANT_ID` INT(11))
BEGIN
select mrd.SKU_ORDER, mrd.MDA_NO, mh.MDA_DT, mrd.SKU_CODE, mrd.SKU_NAME, IFNULL(mrd.API_RESULT,'') AS API_RESULT, IFNULL(mrd.API_REMARK,'') AS API_REMARK,
mrd.BOTTLE_QTY, mrd.CARTON_QTY, mrd.PROD_SYS_ID, mh.MDA_SYS_ID, mrd.LOADING_BAY, mrd.LOADING_BAY_SYS_ID, ifnull(LOADED_ITEM,0) AS LOADED_QTY, 
desp_place as Destination, mh.PARTY_NAME, mrd.SKU_ORDER
from mda_requisition_data mrd 
INNER JOIN fg_gate_in_out fg ON mrd.GATE_SYS_ID = fg.GATE_SYS_ID
INNER JOIN mda_header mh ON mrd.MDA_NO = mh.MDA_NO
where mrd.GATE_SYS_ID=_GATE_SYS_ID AND mrd.PLANT_ID=_PLANT_ID order by mrd.SKU_ORDER;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Get_RoleTo_User */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Get_RoleTo_User(IN `_Plant_Id` INT(11))
BEGIN
select roleto_user.Id,role_master.ROLE_NAME,concat(system_users.FIRST_NAME,' ',system_users.MIDDLE_NAME,' ',system_users.LAST_NAME) as UserName 
,roleto_user.USER_ID,roleto_user.ROLE_ID from roleto_user inner join system_users on roleto_user.User_Id=system_users.USER_ID
inner join role_master on roleto_user.Role_Id=role_master.ROLE_ID Where roleto_user.Plant_Id=_Plant_Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GET_SHIPPER_QRCODE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GET_SHIPPER_QRCODE()
BEGIN
SELECT shipper_qrcode_sysId, shipper_qrcode, total_bottles_qty, status, action, old_shipper_qrcode_sysId, shipper_qrcode_api_sysId, pallet_qrcode_api_sysId,
    plant_id, created_by, created_datetime, Current_Holder_Type, Current_Holder_SYS_ID FROM shipper_qrcode
where ifnull(IS_SYNCED,0)=0 AND shipper_qrcode_api_sysId IN(SELECT IFNULL(shipper_qrcode_api_sysId,0) as shipper_qrcode_api_sysId FROM shipper_qrcode_api
where date_format(eventtime,'%Y-%m-%d') >= date_format(CURDATE()-1,'%Y-%m-%d'));
/*SELECT shipper_qrcode_sysId,
    shipper_qrcode,
    total_bottles_qty,
    status,
    action,
    old_shipper_qrcode_sysId,
    shipper_qrcode_api_sysId,
    pallet_qrcode_api_sysId,
    plant_id,
    created_by,
    created_datetime,
    Current_Holder_Type,
    Current_Holder_SYS_ID
FROM shipper_qrcode
where ifnull(IS_SYNCED,0)=0;*/
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GET_SHIPPER_QRCODE_API */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GET_SHIPPER_QRCODE_API()
BEGIN
SELECT shipper_qrcode_api_sysId, batch_no, mfg_date, expiry_date, eventtime, plant_id, created_by, created_datetime,
    response_status, total_shipper_qty, Current_Holder_Type, Current_Holder_SYS_ID, ManufacturedBy, MarketedBy
FROM shipper_qrcode_api
where ifnull(IS_SYNCED,0)=0 AND date_format(eventtime,'%Y-%m-%d') >= date_format(CURDATE()-1,'%Y-%m-%d');
/*SELECT shipper_qrcode_api_sysId,
    batch_no,
    mfg_date,
    expiry_date,
    eventtime,
    plant_id,
    created_by,
    created_datetime,
    response_status,
    total_shipper_qty,
    Current_Holder_Type,
    Current_Holder_SYS_ID
FROM shipper_qrcode_api
where ifnull(IS_SYNCED,0)=0;*/
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GET_SHIPPER_QRCODE_API_UPDATE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GET_SHIPPER_QRCODE_API_UPDATE(IN `_SHIPPER_QRCODE_API_SYSID` INT(11), IN `_IS_SYNCED` INT(11), IN _IS_SYNCED_DATETIME datetime)
BEGIN
UPDATE shipper_qrcode_api
SET
IS_SYNCED=_IS_SYNCED, IS_SYNCED_DATETIME = _IS_SYNCED_DATETIME
WHERE shipper_qrcode_api_sysId=_SHIPPER_QRCODE_API_SYSID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_GET_SHIPPER_QRCODE_UPDATE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_GET_SHIPPER_QRCODE_UPDATE(IN `_SHIPPER_QRCODE_SYSID` INT(11), IN `_IS_SYNCED` INT(11), IN _IS_SYNCED_DATETIME datetime)
BEGIN
UPDATE shipper_qrcode
SET
IS_SYNCED=_IS_SYNCED, IS_SYNCED_DATETIME = _IS_SYNCED_DATETIME
WHERE shipper_qrcode_sysId=_SHIPPER_QRCODE_SYSID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Get_Tot_REQUEST_QTY */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Get_Tot_REQUEST_QTY(IN `_vpo_sys_id` INT(11), IN `_PLANT_ID` INT(11), IN `_LINE_ITEM_NO` INT(22))
BEGIN
select 
ifnull(sum(REQUEST_QTY),0) as REQUEST_QTY 
from qr_code_generation 
WHERE qr_code_generation.vpo_sys_id=_vpo_sys_id AND qr_code_generation.PLANT_ID=_PLANT_ID and  
  qr_code_generation.LINE_ITEM_NO=_LINE_ITEM_NO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_InvoiceQrCode_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_InvoiceQrCode_Update(IN `_PLANT_ID` INT(11), IN `_MDAInvQr_SYS_ID` INT(11))
BEGIN
update mda_invoice_qr set IS_DISPATCHED=1 where PLANT_ID=_PLANT_ID and MDAInvQr_SYS_ID=_MDAInvQr_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Login_Details */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Login_Details(IN `_EMAIL_ID` VARCHAR(30), 
IN `_USER_PASSWORD` VARCHAR(50))
BEGIN
if (select count(*) from system_users where system_users.EMP_CODE=_EMAIL_ID and system_users.USER_PASSWORD=_USER_PASSWORD)>0 then
begin
SELECT sysuser.USER_ID, sysuser.FIRST_NAME, plant_master.Plant_Name,sysuser.LAST_NAME, ws.WS_SYS_ID as StationId, ws.WS_NAME as Workstation, sysuser.PLANT_ID, sysuser.ROLE_ID  
FROM system_users sysuser inner join work_station_master ws on sysuser.EMP_WORK_STATION_ID = ws.WS_SYS_ID
inner join plant_master on sysuser.PLANT_ID =plant_master.PlantID
where sysuser.EMP_CODE=_EMAIL_ID and sysuser.USER_PASSWORD=_USER_PASSWORD;
end;
else
begin
select vendor_master.PLANT_ID,vendor_master.VENDOR_CODE,vendor_master.ORGANIZATION_NAME,vendor_master.VENDOR_SYS_ID,vendor_master.Role_Id as ROLE_ID
,plant_master.Plant_Name 
from vendor_master inner join plant_master on vendor_master.PLANT_ID=plant_master.PlantID where vendor_master.PRIMARY_EMAIL=_EMAIL_ID and vendor_master.PASSWORD=_USER_PASSWORD;
end;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_MDASequence_Requisition_ByTruckNo */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_MDASequence_Requisition_ByTruckNo(IN `_TRUCK_NO` VARCHAR(10))
BEGIN
SELECT GATE_OUT_DT,
    MDA_SYS_ID,
    TRUCK_NO,
    DRIVER_NAME,
    DRIVER_CONTACT,
    TRANS_SYS_ID,
    tptr_name
FROM fg_gate_in_out inner join transporter_master inner join mda_header
on fg_gate_in_out.MDA_SYS_ID = mda_header.MDA_SYS_ID and mda_header.TRANS_SYS_ID = transporter_master.TRANS_SYS_ID
where TRUCK_NO=_TRUCK_NO and GATE_OUT_DT = null ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_MDA_Cancel */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_MDA_Cancel(
IN _GATE_SYS_ID INT(11), 
IN _MDA_SYS_ID INT(11), 
IN _MDA_NO VARCHAR(50),
IN _PLANT_ID INT(11)
)
BEGIN
DELETE FROM mda_sequence WHERE PLANT_ID=_PLANT_ID and GATE_SYS_ID=_GATE_SYS_ID and MDA_SYS_ID=_MDA_SYS_ID;

DELETE FROM mda_requisition_data WHERE PLANT_ID=_PLANT_ID and GATE_SYS_ID=_GATE_SYS_ID and MDA_NO=_MDA_NO;

DELETE FROM mda_loading WHERE PLANT_ID=_PLANT_ID and GATE_SYS_ID=_GATE_SYS_ID and MDA_SYS_ID=_MDA_SYS_ID;

DELETE FROM qr_code_successlist WHERE PLANT_ID=_PLANT_ID and MDA_SYS_ID=_MDA_SYS_ID;

DELETE FROM qr_code_rejectlist WHERE PLANT_ID=_PLANT_ID  and MDA_SYS_ID=_MDA_SYS_ID;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Mda_Detail */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Mda_Detail()
BEGIN
SELECT dtl.MDA_DTL_SYS_ID,
    dtl.MDA_SYS_ID,
    dtl.MDA_NO,
    dtl.PROD_SNO,
    dtl.MDA_DT,
    dtl.PROD_SYS_ID,
    dtl.SHIPMENT_NO,
    dtl.BAG_NOS,
    dtl.NETT_QTY,
    dtl.GROSS_QTY,
    dtl.PLANT_ID,
    dtl.Created_DateTime,
    dtl.IS_POSTED
FROM mda_detail as dtl inner join mda_header as mh on dtl.MDA_SYS_ID=mh.MDA_SYS_ID and dtl.PLANT_ID=mh.PLANT_ID
where dtl.IS_POSTED=0 and mh.IS_POSTED=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_MDA_DETAILS_REPORT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_MDA_DETAILS_REPORT(IN `_PLANT_ID` INT(11), IN `_VEHICLE_NO` VARCHAR(20), IN `_GATE_SYS_ID` INT(11))
BEGIN
if(select count(*) from mda_requisition_data where GATE_SYS_ID=_GATE_SYS_ID)>0 then
	begin
		select mh.MDA_NO, pm.PRD_DESC, md.BAG_NOS as Bottle, (md.BAG_NOS/pm.PROD_PER_SHIPPER) as Box,  mrd.LOADED_ITEM, invqr.INVOICEQrCODE, 
		invqr.BASE64InvQrCode, ifnull(invqr.IS_POSTED,0) as InvPosted, pln.PlantCode, desp_place as Destination, ifnull(mh.Dist,0) as Distance  
		from mda_header as mh 
		inner join mda_detail as md on mh.MDA_SYS_ID = md.MDA_SYS_ID and mh.PLANT_ID=md.PLANT_ID
		inner join product_master as pm on md.PROD_SYS_ID = pm.PROD_SYS_ID and md.PLANT_ID = pm.PLANT_ID
		left outer join mda_requisition_data as mrd on md.MDA_NO = mrd.MDA_NO and md.PLANT_ID = mrd.PLANT_ID and md.PROD_SYS_ID = mrd.PROD_SYS_ID
		left outer join mda_invoice_qr as invqr on mh.MDA_SYS_ID = invqr.MDA_SYS_ID and mh.PLANT_ID = invqr.PLANT_ID
		left outer join plant_master as pln on mh.PLANT_ID = pln.PlantID
		where mh.VEHICLE_NO=_VEHICLE_NO and mh.PLANT_ID=_PLANT_ID and mrd.GATE_SYS_ID=_GATE_SYS_ID order by mh.MDA_NO;
	end;
else
	begin
		select mh.MDA_NO, pm.PRD_DESC, md.BAG_NOS as Bottle, (md.BAG_NOS/pm.PROD_PER_SHIPPER) as Box,  mrd.LOADED_ITEM, invqr.INVOICEQrCODE, 
		invqr.BASE64InvQrCode, ifnull(invqr.IS_POSTED,0) as InvPosted, pln.PlantCode, desp_place as Destination, ifnull(mh.Dist,0) as Distance  
		from mda_header as mh 
		inner join mda_detail as md on mh.MDA_SYS_ID = md.MDA_SYS_ID and mh.PLANT_ID=md.PLANT_ID
		inner join product_master as pm on md.PROD_SYS_ID = pm.PROD_SYS_ID and md.PLANT_ID = pm.PLANT_ID
		left outer join mda_requisition_data as mrd on md.MDA_NO = mrd.MDA_NO and md.PLANT_ID = mrd.PLANT_ID and md.PROD_SYS_ID = mrd.PROD_SYS_ID
		left outer join mda_invoice_qr as invqr on mh.MDA_SYS_ID = invqr.MDA_SYS_ID and mh.PLANT_ID = invqr.PLANT_ID
		left outer join plant_master as pln on mh.PLANT_ID = pln.PlantID
		where mh.VEHICLE_NO=_VEHICLE_NO and mh.PLANT_ID=_PLANT_ID and mh.OUT_TIME is null order by mh.MDA_NO;
	end;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_mda_detail_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_mda_detail_Insert(IN `_MDA_SYS_ID` INT(11), IN `_MDA_NO` VARCHAR(15), IN `_PROD_SNO` INT(11), IN `_MDA_DT` DATETIME, IN `_PROD_SYS_ID` INT(11), IN `_SHIPMENT_NO` INT(11), IN `_BAG_NOS` INT(11), IN `_NETT_QTY` INT(11), IN `_GROSS_QTY` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN
DECLARE _MDA_DTL_SYS_ID INT;
SET _MDA_DTL_SYS_ID=0;
IF(SELECT COUNT(*) FROM mda_detail WHERE MDA_SYS_ID=_MDA_SYS_ID AND PROD_SYS_ID=_PROD_SYS_ID AND PLANT_ID=_PLANT_ID)=0 THEN
	begin
		INSERT INTO mda_detail
		(MDA_SYS_ID, MDA_NO, PROD_SNO, MDA_DT, PROD_SYS_ID, SHIPMENT_NO, BAG_NOS, NETT_QTY, GROSS_QTY, PLANT_ID, Created_DateTime)
		VALUES
		(_MDA_SYS_ID, _MDA_NO, _PROD_SNO, _MDA_DT, _PROD_SYS_ID, _SHIPMENT_NO, _BAG_NOS, _NETT_QTY, _GROSS_QTY, _PLANT_ID, _Created_DateTime);
	end;
ELSE
		begin
			SELECT MDA_DTL_SYS_ID into _MDA_DTL_SYS_ID FROM mda_detail WHERE MDA_SYS_ID=_MDA_SYS_ID AND PROD_SYS_ID=_PROD_SYS_ID AND PLANT_ID=_PLANT_ID;
            
            UPDATE mda_detail SET MDA_SYS_ID=_MDA_SYS_ID, MDA_NO=_MDA_NO, PROD_SNO=_PROD_SNO, MDA_DT=_MDA_DT, PROD_SYS_ID=_PROD_SYS_ID,
            SHIPMENT_NO=_SHIPMENT_NO, BAG_NOS=_BAG_NOS, NETT_QTY=_NETT_QTY, GROSS_QTY=_GROSS_QTY, Created_DateTime=_Created_DateTime
            WHERE PLANT_ID=_PLANT_ID AND MDA_DTL_SYS_ID=_MDA_DTL_SYS_ID;
        end;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_mda_header_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_mda_header_Insert(IN `_MDA_NO` VARCHAR(15), IN `_DI_NO` VARCHAR(15), IN `_PLANT_CD` VARCHAR(5), IN `_MDA_DT` DATETIME, IN `_TRANS_SYS_ID` INT(11), IN `_WH_CD` VARCHAR(15), IN `_PARTY_NAME` VARCHAR(50), IN `_DRIVER` VARCHAR(50), IN `_VEHICLE_NO` VARCHAR(10), IN `_MOBILE_NO` VARCHAR(10), IN `_DIST` INT(11), IN `_BAG_NOS` INT(11), IN `_NETT_QTY` INT(11), IN `_GROSS_QTY` INT(11), IN `_ECHIT_NO` VARCHAR(50), IN `_GST_NO` VARCHAR(20), IN `_OUT_TIME` DATETIME, IN `_PLANT_ID` INT(11), IN `_Created_DateTime` DATETIME, IN _desp_place VARCHAR(150))
BEGIN
DECLARE _MDA_SYS_ID INT;
SET _MDA_SYS_ID=0;
IF(SELECT COUNT(*) FROM mda_header WHERE MDA_NO=_MDA_NO AND PLANT_ID=_PLANT_ID)=0 THEN
	begin
		INSERT INTO mda_header
		(MDA_NO, DI_NO, PLANT_CD, MDA_DT, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO, MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY,
		ECHIT_NO, GST_NO, OUT_TIME, PLANT_ID, Created_DateTime, desp_place)
		VALUES
		(_MDA_NO, _DI_NO, _PLANT_CD, _MDA_DT, _TRANS_SYS_ID, _WH_CD, _PARTY_NAME, _DRIVER, _VEHICLE_NO, _MOBILE_NO, _DIST, _BAG_NOS, _NETT_QTY,
		_GROSS_QTY, _ECHIT_NO, _GST_NO, _OUT_TIME, _PLANT_ID, _Created_DateTime, _desp_place);
	end;
else
	begin
		SELECT MDA_SYS_ID INTO _MDA_SYS_ID FROM mda_header WHERE MDA_NO=_MDA_NO AND PLANT_ID=_PLANT_ID;
        
        UPDATE mda_header SET MDA_NO=_MDA_NO, DI_NO=_DI_NO, PLANT_CD=_PLANT_CD, MDA_DT=_MDA_DT, TRANS_SYS_ID=_TRANS_SYS_ID, WH_CD=_WH_CD,
        PARTY_NAME=_PARTY_NAME, DRIVER=_DRIVER, VEHICLE_NO=_VEHICLE_NO, MOBILE_NO=_MOBILE_NO, DIST=_DIST, BAG_NOS=_BAG_NOS, NETT_QTY=_NETT_QTY,
        GROSS_QTY=_GROSS_QTY, ECHIT_NO=_ECHIT_NO, GST_NO=_GST_NO, Created_DateTime=_Created_DateTime, desp_place=_desp_place
        WHERE PLANT_ID=_PLANT_ID AND MDA_SYS_ID=_MDA_SYS_ID;
	end;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_mda_header_list_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_mda_header_list_Insert(IN `_MDA_NO` VARCHAR(15), IN `_DI_NO` VARCHAR(15), IN `_PLANT_CD` VARCHAR(5), IN `_MDA_DT` DATETIME, IN `_TRANS_SYS_ID` INT(11), IN `_WH_CD` VARCHAR(15), IN `_PARTY_NAME` VARCHAR(50), IN `_DRIVER` VARCHAR(50), IN `_VEHICLE_NO` VARCHAR(10), IN `_MOBILE_NO` VARCHAR(10), IN `_DIST` INT(11), IN `_BAG_NOS` INT(11), IN `_NETT_QTY` INT(11), IN `_GROSS_QTY` INT(11), IN `_ECHIT_NO` VARCHAR(20), IN `_GST_NO` VARCHAR(20), IN `_OUT_TIME` DATETIME, IN `_PLANT_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN

IF(SELECT COUNT(*) FROM mda_header_list WHERE MDA_NO=_MDA_NO AND PLANT_ID=_PLANT_ID)=0 THEN
begin
INSERT INTO mda_header_list
(
MDA_NO,
DI_NO,
PLANT_CD,
MDA_DT,
TRANS_SYS_ID,
WH_CD,
PARTY_NAME,
DRIVER,
VEHICLE_NO,
MOBILE_NO,
DIST,
BAG_NOS,
NETT_QTY,
GROSS_QTY,
ECHIT_NO,
GST_NO,
OUT_TIME,
PLANT_ID,
Created_DateTime
)
VALUES
(
_MDA_NO,
_DI_NO,
_PLANT_CD,
_MDA_DT,
_TRANS_SYS_ID,
_WH_CD,
_PARTY_NAME,
_DRIVER,
_VEHICLE_NO,
_MOBILE_NO,
_DIST,
_BAG_NOS,
_NETT_QTY,
_GROSS_QTY,
_ECHIT_NO,
_GST_NO,
_OUT_TIME,
_PLANT_ID,
_Created_DateTime
);
end;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_MDA_Invoice_Qr */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_MDA_Invoice_Qr(IN `_GATE_SYS_ID` INT(11), IN `_MDA_SYS_ID` INT(11), IN `_MDA_NO` VARCHAR(30), IN `_INVOICEQrCODE` VARCHAR(30), IN `_BASE64InvQrCode` LONGTEXT, IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME, IN `_PLANT_ID` INT(11))
BEGIN
if(select count(*) from mda_invoice_qr where GATE_SYS_ID=_GATE_SYS_ID and MDA_SYS_ID=_MDA_SYS_ID)=0 then
begin
INSERT INTO mda_invoice_qr
(
GATE_SYS_ID, 
MDA_SYS_ID, 
MDA_NO,
INVOICEQrCODE, 
BASE64InvQrCode, 
Created_BY_ID, 
Created_DateTime,
PLANT_ID
)
VALUES
(
_GATE_SYS_ID, 
_MDA_SYS_ID, 
_MDA_NO,
_INVOICEQrCODE, 
_BASE64InvQrCode, 
_Created_BY_ID, 
_Created_DateTime,
_PLANT_ID
);
end;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_MDA_Loading */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_MDA_Loading(IN `_GATE_SYS_ID` INT(11), IN `_MDA_SYS_ID` INT(11), IN `_PROD_SYS_ID` INT(11), IN `_REQUIRED_SHIPPER` INT, IN `_LOADED_SHIPPER` INT, IN `_SHIPPER_QR_CODE` VARCHAR(50), IN `_IS_MANUAL_SCAN` TINYINT(1), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME, IN `_PLANT_ID` INT(11))
BEGIN
DECLARE _MDA_NO varchar(100);
SET _MDA_NO=0;
IF(SELECT COUNT(*) FROM mda_loading WHERE GATE_SYS_ID=_GATE_SYS_ID AND MDA_SYS_ID=_MDA_SYS_ID AND PROD_SYS_ID=_PROD_SYS_ID AND SHIPPER_QR_CODE=_SHIPPER_QR_CODE)=0 THEN
BEGIN

select MDA_NO into _MDA_NO from mda_header where MDA_SYS_ID=_MDA_SYS_ID;

INSERT INTO mda_loading
(
GATE_SYS_ID, 
MDA_SYS_ID, 
PROD_SYS_ID, 
REQUIRED_SHIPPER, 
LOADED_SHIPPER, 
SHIPPER_QR_CODE, 
IS_MANUAL_SCAN, 
Created_BY_ID, 
Created_DateTime,
PLANT_ID
)
VALUES
(
_GATE_SYS_ID, 
_MDA_SYS_ID, 
_PROD_SYS_ID, 
_REQUIRED_SHIPPER, 
_LOADED_SHIPPER, 
_SHIPPER_QR_CODE, 
_IS_MANUAL_SCAN, 
_Created_BY_ID, 
_Created_DateTime,
_PLANT_ID
);

UPDATE mda_sequence SET MDA_STATUS='Completed' where GATE_SYS_ID=_GATE_SYS_ID AND MDA_SYS_ID=_MDA_SYS_ID;

UPDATE mda_requisition_data SET LOADING_PROGRESS ='Completed' WHERE GATE_SYS_ID=_GATE_SYS_ID AND MDA_NO=_MDA_NO;
END;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_MDA_Loading_GetStartTimeAndEndTime */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_MDA_Loading_GetStartTimeAndEndTime(
_GATE_SYS_ID INT(11),
_MDA_NO VARCHAR(45),
_PLANT_ID INT(11)
)
BEGIN
SELECT LOAD_IN_TIME, LOAD_OUT_TIME FROM mda_requisition_data 
where GATE_SYS_ID=_GATE_SYS_ID and MDA_NO=_MDA_NO AND PLANT_ID=_PLANT_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_MDA_Loading_Validate */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_MDA_Loading_Validate(IN _LOADING_BAY_SYS_ID INT(11),IN _PLANT_ID INT(11))
BEGIN
SELECT * FROM mda_requisition_data where PLANT_ID=_PLANT_ID and LOADING_BAY_SYS_ID=_LOADING_BAY_SYS_ID AND LOADING_PROGRESS<>'Completed';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_MDA_Loading_Validate_Delete */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_MDA_Loading_Validate_Delete(IN _GATE_SYS_ID INT(11),IN _LOADING_BAY_SYS_ID INT(11),IN _PLANT_ID INT(11))
BEGIN
DELETE FROM mda_sequence WHERE GATE_SYS_ID=_GATE_SYS_ID AND PLANT_ID=_PLANT_ID;
DELETE FROM mda_requisition_data WHERE GATE_SYS_ID=_GATE_SYS_ID AND PLANT_ID=_PLANT_ID;
DELETE FROM mda_loading WHERE GATE_SYS_ID=_GATE_SYS_ID AND PLANT_ID=_PLANT_ID;
DELETE FROM mda_add_qty_request WHERE GATE_SYS_ID=_GATE_SYS_ID AND PLANT_ID=_PLANT_ID;
DELETE FROM qr_code_successlist WHERE BELT_NO=_LOADING_BAY_SYS_ID AND PLANT_ID=_PLANT_ID;
DELETE FROM qr_code_rejectlist WHERE BELT_NO=_LOADING_BAY_SYS_ID AND PLANT_ID=_PLANT_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_mda_requisition_data_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_mda_requisition_data_Insert(IN `_GATE_SYS_ID` INT(11), IN `_TRUCK_NO` VARCHAR(15), IN `_MDA_NO` VARCHAR(45), IN `_MDA_DATE` DATE, IN `_PROD_SYS_ID` INT(11), IN `_SKU_CODE` VARCHAR(45), IN `_SKU_NAME` VARCHAR(45), IN `_BOTTLE_QTY` INT(11), IN `_CARTON_QTY` INT(11), IN `_LOADING_BAY` VARCHAR(45), IN `_LOADING_BAY_SYS_ID` INT(11), IN `_SKU_ORDER` INT(11), IN `_STATUS_CODE` VARCHAR(45), IN `_LOADING_STATUS` VARCHAR(45), IN `_LOADED_QTY` INT(11), IN `_SHORT_QTY` INT(11), IN `_ADDITIONAL_QTY` INT(11), IN `_REASON` VARCHAR(45), IN `_PLANT_ID` INT(11), IN `_LOADING_PROGRESS` VARCHAR(45))
BEGIN
IF(SELECT COUNT(*) FROM mda_requisition_data WHERE GATE_SYS_ID=_GATE_SYS_ID AND MDA_NO=_MDA_NO AND PROD_SYS_ID=_PROD_SYS_ID)=0 THEN
BEGIN
INSERT INTO mda_requisition_data
(
GATE_SYS_ID,
TRUCK_NO,
MDA_NO,
MDA_DATE,
PROD_SYS_ID,
SKU_CODE,
SKU_NAME,
BOTTLE_QTY,
CARTON_QTY,
LOADING_BAY,
LOADING_BAY_SYS_ID,
SKU_ORDER,
STATUS_CODE,
LOADING_STATUS,
LOADED_QTY,
SHORT_QTY,
ADDITIONAL_QTY,
REASON,
PLANT_ID,
LOADING_PROGRESS
)
VALUES
(
_GATE_SYS_ID,
_TRUCK_NO,
_MDA_NO,
_MDA_DATE,
_PROD_SYS_ID,
_SKU_CODE,
_SKU_NAME,
_BOTTLE_QTY,
_CARTON_QTY,
_LOADING_BAY,
_LOADING_BAY_SYS_ID,
_SKU_ORDER,
_STATUS_CODE,
_LOADING_STATUS,
_LOADED_QTY,
_SHORT_QTY,
_ADDITIONAL_QTY,
_REASON,
_PLANT_ID,
_LOADING_PROGRESS
);
END;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_MDA_Sequence_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_MDA_Sequence_Insert(IN `_MDA_Seq_SYS_ID` INT(11), IN `_GATE_SYS_ID` INT(11), IN `_MDA_SYS_ID` INT(11), IN `_MDA_Sequence_No` INT(11), IN `_MDA_STATUS` VARCHAR(15), IN `_MDA_REASON` VARCHAR(50), IN `_MDA_REMARK` VARCHAR(50), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME, IN `_PLANT_ID` INT(11))
BEGIN
	IF(SELECT COUNT(*) FROM mda_sequence WHERE GATE_SYS_ID=_GATE_SYS_ID AND MDA_SYS_ID=_MDA_SYS_ID AND PLANT_ID=_PLANT_ID)=0 THEN
		BEGIN
			INSERT INTO mda_sequence
			(			
			GATE_SYS_ID, 
			MDA_SYS_ID, 
			MDA_Sequence_No,
			MDA_STATUS, 
			MDA_REASON, 	
			MDA_REMARK,
			Created_BY_ID, 
			Created_DateTime,
			PLANT_ID
			)
			VALUES
			(			
			_GATE_SYS_ID, 
			_MDA_SYS_ID, 
			_MDA_Sequence_No,
			_MDA_STATUS, 
			_MDA_REASON, 
			_MDA_REMARK,
			_Created_BY_ID, 
			_Created_DateTime,
			_PLANT_ID
			);
		END;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_MDA_Sequence_Loading_Status_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_MDA_Sequence_Loading_Status_Update(IN `_MDA_Seq_SYS_ID` INT(11), IN `_GATE_SYS_ID` INT(11), IN `_MDA_SYS_ID` INT(11), IN `_MDA_STATUS` VARCHAR(15), IN `_MDA_REASON` VARCHAR(50), IN `_MDA_REMARK` VARCHAR(50))
BEGIN
UPDATE mda_sequence
SET

MDA_STATUS = _MDA_STATUS, 
MDA_REASON = _MDA_REASON, 
MDA_REMARK= _MDA_REMARK

where MDA_Seq_SYS_ID = _MDA_Seq_SYS_ID and GATE_SYS_ID = _GATE_SYS_ID and MDA_SYS_ID = _MDA_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_MDA_Sequence_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_MDA_Sequence_Update(IN `_GATE_SYS_ID` INT(11), IN `_MDA_SYS_ID` INT(11), IN `_MDA_STATUS` VARCHAR(15), IN `_MDA_REASON` VARCHAR(50), IN `_MDA_REMARK` VARCHAR(50))
BEGIN
UPDATE mda_sequence
SET
MDA_STATUS = _MDA_STATUS, 
MDA_REASON = _MDA_REASON, 
MDA_REMARK= _MDA_REMARK,
MDA_STATUS_DATETIME=now()

where GATE_SYS_ID = _GATE_SYS_ID and MDA_SYS_ID = _MDA_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_PalletShipper_PalletData_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_PalletShipper_PalletData_Insert(IN `_pallet_qrcode` VARCHAR(45), IN `_total_shipper_qty` INT(11), IN `_status` VARCHAR(45), IN `_plant_code` VARCHAR(45), IN `_PalletID` VARCHAR(45), IN `_created_datetime` DATETIME, IN `_palletization_datetime` DATETIME, IN `_palletization_mode` VARCHAR(45), IN `_palletization_station` VARCHAR(45))
BEGIN
declare Gplant_Id int;
declare isDuplicate int(11);
set isDuplicate=0;
set Gplant_Id=0;
select plantid into Gplant_Id from plant_master where plant_master.plantcode=_plant_code;
if(select count(*) from pallet_qrcode_api where PalletID=_PalletID)=0 then
begin
INSERT INTO  pallet_qrcode_api
(
pallet_qrcode,total_shipper_qty,status,plant_id,created_datetime,
palletization_datetime,palletization_mode,palletization_station,PalletID
)
VALUES(
_pallet_qrcode,_total_shipper_qty,_status,Gplant_Id,_created_datetime,_palletization_datetime,
_palletization_mode,_palletization_station,_PalletID
);
set isDuplicate=0;
end;
else
begin
	set isDuplicate=1;
end;
end if;
select isDuplicate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_PalletShipper_shipper_qrcode_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_PalletShipper_shipper_qrcode_Insert(IN `_shipper_qrcode` VARCHAR(45), IN `_pallet_Id` VARCHAR(45), IN `_plant_code` VARCHAR(45), IN `_created_datetime` DATETIME)
Begin
declare notFound int(11);
set notFound=0;
if(select count(*) from shipper_qrcode where shipper_qrcode=_shipper_qrcode)=1 then
begin
declare pallet_sys_id int;
declare Gplant_Id int;
set pallet_sys_id=0;
select pallet_qrcode_api_sysId into pallet_sys_id from pallet_qrcode_api where PalletID=_pallet_Id LIMIT 1;
set Gplant_Id=0;
select plantid into Gplant_Id from plant_master where plant_master.plantcode=_plant_code;
update `shipper_qrcode` set pallet_qrcode_api_sysId=pallet_sys_id where shipper_qrcode=_shipper_qrcode ;
/*INSERT INTO `shipper_qrcode`
(
shipper_qrcode,
pallet_qrcode_api_sysId,
plant_id,
created_datetime
)
VALUES(
_shipper_qrcode,
pallet_sys_id,
Gplant_Id,
_created_datetime
);*/
end;
else 
begin

set notFound=1;
end;
end if;
select notFound;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_FG_GateInOut */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_FG_GateInOut()
BEGIN
SELECT GATE_SYS_ID,
    GATE_IN_DT,
    GATE_OUT_DT,
    INWARD_SYS_ID,
    MDA_SYS_ID,
    TRUCK_NO,
    DRIVER_ID_TYPE,
    DRIVER_ID_NUMBER,
    DRIVER_NAME,
    DRIVER_CONTACT,
    DRIVER_CHANGED,
    DRIVER_NAME_NEW,
    DRIVER_CONTACT_NEW,
    TRUCK_VALIDATION,
    RFSYSID,
    VERIFIED_DOCUMENTS,
    RFID_RECEIVE,
    VERIFIED_OFFICER_ID,
    CANCEL_GATE_IN,
    CANCEL_GATE_REASON,
    GATE_SYS_ID_OLD,
    IS_GOODS_TRANSFER,
    STATION_ID,
    PLANT_ID,
    Created_BY_ID,
    Created_DateTime,
    IS_POSTED
FROM fg_gate_in_out
where ifnull(IS_POSTED,0)=0 AND GATE_OUT_DT is not null;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_FG_GateInOut_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_FG_GateInOut_Update(IN `_GATE_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(11))
BEGIN
UPDATE fg_gate_in_out set IS_POSTED=_IS_POSTED where GATE_SYS_ID=_GATE_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_FG_Weightment_Detail */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_FG_Weightment_Detail()
BEGIN
SELECT WT.WT_SYS_ID,
WT.GATE_SYS_ID,
WT.GROSS_WT,
WT.GROSS_WT_DT,
WT.GROSS_WT_MANUALLY,
WT.GROSS_WT_NOTE,
WT.TARE_WT,
WT.TARE_WT_DT,
WT.TARE_WT_MANUALLY,
WT.TARE_WT_NOTE,
WT.NET_WT,
WT.OUT_OF_TOLERANCE_WT,
WT.TOLERANCE_WT,
WT.ALLOW_TOLERANCE_WT,
WT.STATION_ID,
WT.PLANT_ID,
WT.Created_BY_ID,
WT.Created_DateTime,
WT.IS_POSTED
FROM fg_weighment_detail WT 
INNER JOIN fg_gate_in_out GT ON WT.GATE_SYS_ID=GT.GATE_SYS_ID AND WT.PLANT_ID=GT.PLANT_ID AND WT.STATION_ID=GT.STATION_ID
WHERE GT.IS_POSTED=1 AND GT.GATE_OUT_DT is not null and WT.GROSS_WT IS NOT NULL and WT.TARE_WT IS NOT NULL AND ifnull(WT.IS_POSTED,0)=0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_FG_Weightment_Detail_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_FG_Weightment_Detail_Update(IN `_WT_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(11))
BEGIN
UPDATE fg_weighment_detail set IS_POSTED=_IS_POSTED where WT_SYS_ID=_WT_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_AddQty */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_AddQty()
BEGIN
SELECT adq.MDA_ADD_SYS_ID,
    adq.GATE_SYS_ID,
    adq.MDA_SYS_ID,
    adq.PROD_SYS_ID,
    adq.REQUIRED_SHIPPER_QTY,
    adq.REASON,
    adq.REQUEST_STATUS,
    adq.RESPONSE_MSG,
    adq.Created_BY_ID,
    adq.Created_DateTime,
    adq.PLANT_ID,
    adq.IS_POSTED
FROM mda_add_qty_request adq 
INNER JOIN mda_sequence sq on adq.GATE_SYS_ID=sq.GATE_SYS_ID 
WHERE ifnull(adq.IS_POSTED,0)=0 and ifnull(sq.IS_POSTED,0)=1 AND IFNULL(sq.MDA_STATUS,'')='Completed';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_AddQty_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_AddQty_Update(IN `_MDA_ADD_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
update mda_add_qty_request set IS_POSTED=_IS_POSTED where MDA_ADD_SYS_ID=_MDA_ADD_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_Detail */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_Detail()
BEGIN
SELECT dtl.MDA_DTL_SYS_ID,
    dtl.MDA_SYS_ID,
    dtl.MDA_NO,
    dtl.PROD_SNO,
    dtl.MDA_DT,
    dtl.PROD_SYS_ID,
    dtl.SHIPMENT_NO,
    dtl.BAG_NOS,
    dtl.NETT_QTY,
    dtl.GROSS_QTY,
    dtl.PLANT_ID,
    dtl.Created_DateTime,
    dtl.IS_POSTED
FROM mda_detail as dtl inner join mda_header as mh on dtl.MDA_SYS_ID=mh.MDA_SYS_ID and dtl.PLANT_ID=mh.PLANT_ID
where ifnull(dtl.IS_POSTED,0)=0 and ifnull(mh.IS_POSTED,0)=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_Detail_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_Detail_Update(IN `_MDA_DTL_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
UPDATE mda_detail SET IS_POSTED=_IS_POSTED WHERE MDA_DTL_SYS_ID=_MDA_DTL_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_Header */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_Header()
BEGIN
SELECT MDA_SYS_ID,
    MDA_NO,
    DI_NO,
    PLANT_CD,
    MDA_DT,
    TRANS_SYS_ID,
    WH_CD,
    PARTY_NAME,
    DRIVER,
    VEHICLE_NO,
    MOBILE_NO,
    DIST,
    BAG_NOS,
    NETT_QTY,
    GROSS_QTY,
    ECHIT_NO,
    GST_NO,
    OUT_TIME,
    PLANT_ID,
    Created_DateTime,
    IS_POSTED
FROM mda_header WHERE (ifnull(IS_POSTED,0)=0) and OUT_TIME is not null;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_Header_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_Header_Update(IN `_MDA_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
UPDATE mda_header SET IS_POSTED=_IS_POSTED WHERE MDA_SYS_ID=_MDA_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_Invoice_Qr */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_Invoice_Qr()
BEGIN
SELECT inv.MDAInvQr_SYS_ID,
    inv.GATE_SYS_ID,
    inv.MDA_SYS_ID,
    inv.MDA_NO,
    inv.INVOICEQrCODE,
    inv.BASE64InvQrCode,
    inv.Created_BY_ID,
    inv.Created_DateTime,
    inv.PLANT_ID,
    inv.IS_POSTED,
    inv.IS_DISPATCHED
FROM mda_invoice_qr inv
INNER JOIN fg_gate_in_out fg ON inv.GATE_SYS_ID = fg.GATE_SYS_ID
WHERE ifnull(inv.IS_POSTED,0)=0 and ifnull(fg.IS_POSTED,0)=1 AND fg.GATE_OUT_DT is not null;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_Invoice_Qr_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_Invoice_Qr_Update(IN `_MDAInvQr_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
update mda_invoice_qr set IS_POSTED=_IS_POSTED where MDAInvQr_SYS_ID=_MDAInvQr_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_Loading */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_Loading()
BEGIN
SELECT ml.MDA_LOD_SYS_ID,
    ml.GATE_SYS_ID,
    ml.MDA_SYS_ID,
    ml.PROD_SYS_ID,
    ml.REQUIRED_SHIPPER,
    ml.LOADED_SHIPPER,
    ml.SHIPPER_QR_CODE,
    ml.IS_MANUAL_SCAN,
    ml.Created_BY_ID,
    ml.Created_DateTime,
    ml.PLANT_ID,
    ml.IS_POSTED
FROM mda_loading ml
INNER JOIN mda_sequence sq on ml.GATE_SYS_ID=sq.GATE_SYS_ID 
WHERE ifnull(ml.IS_POSTED,0)=0 and ifnull(sq.IS_POSTED,0)=1 AND IFNULL(sq.MDA_STATUS,'')='Completed';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_Loading_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_Loading_Update(IN `_MDA_LOD_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
UPDATE mda_loading SET IS_POSTED=_IS_POSTED WHERE MDA_LOD_SYS_ID=_MDA_LOD_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_Requisition_Data */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_Requisition_Data()
BEGIN
SELECT  mq.MDA_REQ_SYS_ID,
    mq.GATE_SYS_ID,
    mq.TRUCK_NO,
    mq.MDA_NO,
    mq.MDA_DATE,
    mq.PROD_SYS_ID,
    mq.SKU_CODE,
    mq.SKU_NAME,
    mq.BOTTLE_QTY,
    mq.CARTON_QTY,
    mq.LOADING_BAY,
    mq.LOADING_BAY_SYS_ID,
    mq.SKU_ORDER,
    mq.STATUS_CODE,
    mq.LOADING_STATUS,
    mq.LOADED_QTY,
    mq.SHORT_QTY,
    mq.ADDITIONAL_QTY,
    mq.REASON,
    mq.PLANT_ID,
    mq.LOADING_PROGRESS,
    mq.LOADED_ITEM,
    mq.API_RESULT,
    mq.API_REMARK
FROM mda_requisition_data mq 
INNER JOIN mda_sequence sq on mq.GATE_SYS_ID=sq.GATE_SYS_ID 
WHERE ifnull(mq.IS_POSTED,0)=0 and ifnull(sq.IS_POSTED,0)=1 AND IFNULL(sq.MDA_STATUS,'')='Completed';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_Requisition_Data_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_Requisition_Data_Update(IN `_MDA_REQ_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
update mda_requisition_data set IS_POSTED=_IS_POSTED where MDA_REQ_SYS_ID=_MDA_REQ_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_Sequence */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_Sequence()
BEGIN
SELECT sq.MDA_Seq_SYS_ID,
    sq.GATE_SYS_ID,
    sq.MDA_SYS_ID,
    sq.MDA_Sequence_No,
    sq.MDA_STATUS,
    sq.MDA_REASON,
    sq.MDA_REMARK,
    sq.Created_BY_ID,
    sq.Created_DateTime,
    sq.PLANT_ID,
    sq.IS_POSTED,
    sq.MDA_STATUS_DATETIME
FROM mda_sequence sq
INNER JOIN fg_gate_in_out fg ON sq.GATE_SYS_ID = fg.GATE_SYS_ID
where ifnull(sq.IS_POSTED,0)=0 AND IFNULL(sq.MDA_STATUS,'')='Completed' and ifnull(fg.IS_POSTED,0)=1 AND fg.GATE_OUT_DT is not null;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Mda_Sequence_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Mda_Sequence_Update(IN `_MDA_Seq_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
UPDATE mda_sequence SET IS_POSTED=_IS_POSTED WHERE MDA_Seq_SYS_ID=_MDA_Seq_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Po_Detail */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Po_Detail()
BEGIN
SELECT Dtl.PO_DTL_SYS_ID,
 Dtl.PO_SYS_ID,
    Dtl.PO_LINE_NO,
    Dtl.LINE_DESC,
    Dtl.UMO,
    Dtl.LINE_QTY,
    Dtl.Created_DateTime,
    Dtl.IS_POSTED,
    Dtl.PLANT_ID
FROM po_detail Dtl INNER JOIN po_header Hdr ON Hdr.PO_SYS_ID=Dtl.PO_SYS_ID AND Hdr.PLANT_ID=Dtl.PLANT_ID
where ifnull(Dtl.IS_POSTED,0)=0 AND ifnull(Hdr.IS_POSTED,0)=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Po_Detail_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Po_Detail_Update(IN `_PO_DTL_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
UPDATE po_detail SET IS_POSTED=_IS_POSTED WHERE PO_DTL_SYS_ID=_PO_DTL_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Po_Header */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Po_Header()
BEGIN
SELECT 
PO_SYS_ID,
PO_NO,
PO_DATE,
VENDOR_SYS_ID,
COST_CENTER,
PO_DESCCRIPTION,
TRANS_SYS_ID,
TRUCK_NO,
IS_PO_MANUAL,
STATION_ID,
PLANT_ID,
Created_BY_ID,
Created_DateTime,
IS_POSTED
FROM po_header
WHERE ifnull(IS_POSTED,0)=0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Po_Header_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Po_Header_Update(IN `_PO_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
UPDATE po_header SET IS_POSTED=_IS_POSTED WHERE PO_SYS_ID=_PO_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Rfid_Lost */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Rfid_Lost()
BEGIN
SELECT REF_SYS_ID,
    INWARD_SYS_ID,
    RFSYSID,
    REASON,
    REMARK,
    RFID_LOST_DATE,
    STATION_ID,
    PLANT_ID,
    Created_BY_ID,
    Created_DateTime,
    IS_POSTED
FROM rfid_lost WHERE ifnull(IS_POSTED,0)=0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Rfid_Master */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Rfid_Master()
BEGIN
SELECT RFSYSID,
    RFIDSRNO,
    RFIDCODE,
    STATUS,
    REASONFOREDIT,
    STATION_ID,
    PLANT_ID,
    Created_BY_ID,
    Created_DateTime,
    IS_POSTED
FROM rfid_master WHERE ifnull(IS_POSTED,0)=0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Rm_Gate_In_Out */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Rm_Gate_In_Out()
BEGIN
SELECT GATE_SYS_ID,
    GATE_IN_DT,
    GATE_OUT_DT,
    INWARD_SYS_ID,
    PO_SYS_ID,
    TRANSPORTER_NAME,
    TRUCK_NO,
    DRIVER_ID_TYPE,
    DRIVER_ID_NUMBER,
    DRIVER_NAME,
    DRIVER_CONTACT,
    DRIVER_CHANGED,
    DRIVER_NAME_NEW,
    DRIVER_CONTACT_NEW,
    TRUCK_VALIDATION,
    RFSYSID,
    VERIFIED_DOCUMENTS,
    RFID_RECEIVE,
    VERIFIED_OFFICER_ID,
    CANCEL_GATE_IN,
    CANCEL_GATE_REASON,
    IS_UNLOAD_TRUCK,
    STATION_ID,
    PLANT_ID,
    Created_BY_ID,
    Created_DateTime,
    IS_POSTED
FROM rm_gate_in_out where ifnull(IS_POSTED,0)=0 AND GATE_OUT_DT is not null;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Rm_Gate_In_Out_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Rm_Gate_In_Out_Update(IN `_GATE_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
UPDATE rm_gate_in_out SET IS_POSTED=_IS_POSTED WHERE GATE_SYS_ID=_GATE_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Rm_Weighment_Detail */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Rm_Weighment_Detail()
BEGIN
SELECT WT.WT_SYS_ID,
    WT.GATE_SYS_ID,
    WT.GROSS_WT,
    WT.GROSS_WT_DT,
    WT.GROSS_WT_MANUALLY,
    WT.GROSS_WT_NOTE,
    WT.TARE_WT,
    WT.TARE_WT_DT,
    WT.TARE_WT_MANUALLY,
    WT.TARE_WT_NOTE,
    WT.NET_WT,
    WT.STATION_ID,
    WT.PLANT_ID,
    WT.Created_BY_ID,
    WT.Created_DateTime,
    WT.IS_POSTED
FROM rm_weighment_detail WT
INNER JOIN rm_gate_in_out GT ON WT.GATE_SYS_ID=GT.GATE_SYS_ID AND WT.PLANT_ID=GT.PLANT_ID AND WT.STATION_ID=GT.STATION_ID
WHERE ifnull(GT.IS_POSTED,0)=1 AND GT.GATE_OUT_DT is not null AND WT.GROSS_WT IS NOT NULL AND WT.TARE_WT IS NOT NULL AND ifnull(WT.IS_POSTED,0)=0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Rm_Weighment_Detail_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Rm_Weighment_Detail_Update(IN `_WT_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
UPDATE rm_weighment_detail SET IS_POSTED=_IS_POSTED WHERE WT_SYS_ID=_WT_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_So_Detail */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_So_Detail()
BEGIN
SELECT Dtl.SO_SYS_ID,
    Dtl.UNIT_CODE,
    Dtl.SO_NO,
    Dtl.SLNO,
    Dtl.SCRAP_CD,
    Dtl.SCRAP_DESC,
    Dtl.UOM,
    Dtl.ERP_UOM_CD,
    Dtl.SO_QTY,
    Dtl.BASIC_AMT,
    Dtl.IS_POSTED,
    Dtl.PLANT_ID
FROM so_detail Dtl INNER JOIN so_header Hdr ON Hdr.SO_SYS_ID=Dtl.SO_SYS_ID AND Hdr.PLANT_ID=Dtl.PLANT_ID
where ifnull(Dtl.IS_POSTED,0)=0 AND ifnull(Hdr.IS_POSTED,0)=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_So_Detail_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_So_Detail_Update(IN `_SO_DTL_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
UPDATE so_detail SET IS_POSTED=_IS_POSTED WHERE SO_DTL_SYS_ID=_SO_DTL_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_So_Header */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_So_Header()
BEGIN
SELECT SO_SYS_ID,
    UNIT_CODE,
    SO_NO,
    SO_DATE,
    SO_RELEASE_DATE,
    SO_VALID_DATE,
    SEQUENCE_NO,
    TENDER_NO,
    TENDER_DATE,
    VENSOR_SYS_ID,
    CUST_CD,
    CUST_NAME,
    CUST_SITE_CD,
    SITE_NAME,
    ADD1,
    ADD2,
    ADD3,
    CITY,
    PIN,
    STATE,
    STATE_CD,
    GSTN_NO,
    PAN_NO,
    CUST_NON_GST,
    TEL_NO,
    SO_REMARKS,
    STATUS,
    STATUS_DATE,
    STATUS_REMARKS,
    EMD_AMT,
    TERMS_PRICE,
    TERMS_PYMT_TERM,
    TERMS_LIFTING_PERIOD_DAYS,
    TENDER_TYPE,
    AMEND_NO,
    AMEND_RELEASE_DATE,
    Created_DateTime,
    IS_POSTED,
    PLANT_ID
FROM so_header WHERE ifnull(IS_POSTED,0)=0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_So_Header_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_So_Header_Update(IN `_SO_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
UPDATE so_header SET IS_POSTED=_IS_POSTED WHERE SO_SYS_ID=_SO_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Sp_Gate_In_Out */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Sp_Gate_In_Out()
BEGIN
SELECT GATE_SYS_ID,
    GATE_IN_DT,
    GATE_OUT_DT,
    INWARD_SYS_ID,
    SO_SYS_ID,
    TRANS_SYS_ID,
    TRANSPORTER_NAME,
    TRUCK_NO,
    DRIVER_ID_TYPE,
    DRIVER_ID_NUMBER,
    DRIVER_NAME,
    DRIVER_CONTACT,
    DRIVER_CHANGED,
    DRIVER_NAME_NEW,
    DRIVER_CONTACT_NEW,
    TRUCK_VALIDATION,
    RFSYSID,
    VERIFIED_DOCUMENTS,
    RFID_RECEIVE,
    VERIFIED_OFFICER_ID,
    CANCEL_GATE_IN,
    CANCEL_GATE_REASON,
    GATE_SYS_ID_OLD,
    IS_GOODS_TRANSFER,
    STATION_ID,
    PLANT_ID,
    Created_BY_ID,
    Created_DateTime,
    IS_POSTED
FROM sp_gate_in_out WHERE ifnull(IS_POSTED,0)=0 AND GATE_OUT_DT is  not null;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Sp_Gate_In_Out_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Sp_Gate_In_Out_Update(IN `_GATE_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
UPDATE sp_gate_in_out SET IS_POSTED=_IS_POSTED WHERE GATE_SYS_ID=_GATE_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Sp_Weighment_Detail */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Sp_Weighment_Detail()
BEGIN
SELECT WT.WT_SYS_ID,
    WT.GATE_SYS_ID,
    WT.GROSS_WT,
    WT.GROSS_WT_DT,
    WT.GROSS_WT_MANUALLY,
    WT.GROSS_WT_NOTE,
    WT.TARE_WT,
    WT.TARE_WT_DT,
    WT.TARE_WT_MANUALLY,
    WT.TARE_WT_NOTE,
    WT.NET_WT,
    WT.OUT_OF_TOLERANCE_WT,
    WT.TOLERANCE_WT,
    WT.ALLOW_TOLERANCE_WT,
    WT.STATION_ID,
    WT.PLANT_ID,
    WT.Created_BY_ID,
    WT.Created_DateTime,
    WT.IS_POSTED
FROM sp_weighment_detail WT
INNER JOIN sp_gate_in_out GT ON WT.GATE_SYS_ID=GT.GATE_SYS_ID AND WT.PLANT_ID=GT.PLANT_ID AND WT.STATION_ID=GT.STATION_ID
WHERE ifnull(GT.IS_POSTED,0)=1 AND GT.GATE_OUT_DT is not null AND WT.GROSS_WT IS NOT NULL AND WT.TARE_WT IS NOT NULL AND ifnull(WT.IS_POSTED,0)=0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_POST_Sp_Weighment_Detail_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_POST_Sp_Weighment_Detail_Update(IN `_WT_SYS_ID` INT(11), IN `_IS_POSTED` TINYINT(1))
BEGIN
UPDATE sp_weighment_detail SET IS_POSTED=_IS_POSTED WHERE WT_SYS_ID=_WT_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_po_detail_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_po_detail_Insert(IN `_PO_SYS_ID` INT(11), IN `_PO_LINE_NO` INT(11), IN `_LINE_DESC` VARCHAR(500), IN `_UMO` VARCHAR(50), IN `_LINE_QTY` INT(11), IN `_Created_DateTime` DATETIME, IN `_PLANT_ID` INT(11))
BEGIN
IF(SELECT COUNT(*) FROM po_detail WHERE PO_SYS_ID=_PO_SYS_ID AND PO_LINE_NO= _PO_LINE_NO AND PLANT_ID=_PLANT_ID)=0 THEN
	BEGIN
		INSERT INTO po_detail
		(PO_SYS_ID,PO_LINE_NO,LINE_DESC,UMO,LINE_QTY,Created_DateTime,PLANT_ID)
		VALUES
		(_PO_SYS_ID,_PO_LINE_NO,_LINE_DESC,_UMO,_LINE_QTY,_Created_DateTime,_PLANT_ID);
	END;
else
	BEGIN
		UPDATE po_detail
			SET LINE_DESC = _LINE_DESC, UMO = _UMO, LINE_QTY = _LINE_QTY, Created_DateTime = _Created_DateTime
			WHERE PO_SYS_ID = _PO_SYS_ID AND PO_LINE_NO = _PO_LINE_NO AND PLANT_ID = _PLANT_ID;
	END;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_po_GetMaxId */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_po_GetMaxId()
BEGIN
select ifnull(max(PO_SYS_ID),0)+1 from po_header;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_po_header_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_po_header_Insert(IN `_PO_SYS_ID` INT(11), IN `_PO_NO` varchar(15), IN `_PO_DATE` DATETIME, IN `_VENDOR_SYS_ID` INT(11), IN `_COST_CENTER` INT(11), IN `_PO_DESCCRIPTION` VARCHAR(1000), IN `_TRANS_SYS_ID` INT(11), IN `_TRUCK_NO` VARCHAR(10), IN `_IS_PO_MANUAL` TINYINT(1), IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN
IF(SELECT COUNT(*) FROM po_header WHERE PO_NO=_PO_NO AND PLANT_ID=_PLANT_ID)=0 THEN
	BEGIN
		INSERT INTO po_header
		(
		PO_SYS_ID,PO_NO,PO_DATE,VENDOR_SYS_ID,COST_CENTER,PO_DESCCRIPTION,TRANS_SYS_ID,TRUCK_NO,IS_PO_MANUAL,STATION_ID,PLANT_ID,
		Created_BY_ID,Created_DateTime
		)
		VALUES
		(
		_PO_SYS_ID,_PO_NO,_PO_DATE,_VENDOR_SYS_ID,_COST_CENTER,_PO_DESCCRIPTION,_TRANS_SYS_ID,_TRUCK_NO,_IS_PO_MANUAL,_STATION_ID,
		_PLANT_ID,_Created_BY_ID,_Created_DateTime
		);
	END;
else
	BEGIN
		UPDATE po_header
		SET
		PO_NO = _PO_NO, PO_DATE = _PO_DATE, VENDOR_SYS_ID = _VENDOR_SYS_ID, COST_CENTER = _COST_CENTER, PO_DESCCRIPTION = _PO_DESCCRIPTION,
		TRANS_SYS_ID = _TRANS_SYS_ID, TRUCK_NO = _TRUCK_NO,	IS_PO_MANUAL = _IS_PO_MANUAL, STATION_ID = _STATION_ID,
		Created_BY_ID = _Created_BY_ID,	Created_DateTime = _Created_DateTime		
		WHERE PO_SYS_ID = _PO_SYS_ID AND PLANT_ID = _PLANT_ID;
	END;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_product_master_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_product_master_Insert(IN `_SKU_CODE` VARCHAR(5), IN `_SKU_NAME` VARCHAR(30), IN `_PRD_CD` VARCHAR(5), IN `_PRD_DESC` VARCHAR(50), IN `_PLANT_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN

 INSERT INTO product_master
(
SKU_CODE,
SKU_NAME,
PRD_CD,
PRD_DESC,
PLANT_ID,
Created_DateTime
)
VALUES
(
_SKU_CODE,
_SKU_NAME,
_PRD_CD,
_PRD_DESC,
_PLANT_ID,
_Created_DateTime
);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_QrCode_ShipperList */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_QrCode_ShipperList(IN `_PLANT_ID` INT(11), IN `_BELT_NO` INT(11), IN `_MDA_NO` varchar(45))
BEGIN
SELECT QRCODE, Product_SYS_ID, Flag, REJECT_REASON, MDA_NO, SID, RID FROM (
SELECT QRCODE, Product_SYS_ID, 'A' as Flag, '' as REJECT_REASON, MDA_NO, SID, 0 AS RID FROM qr_code_successlist where PLANT_ID=_PLANT_ID and BELT_NO=_BELT_NO and MDA_NO=_MDA_NO
UNION all
SELECT QRCODE, Product_SYS_ID, 'R' as Flag, REJECT_REASON, MDA_NO, 0 AS SID, RID FROM qr_code_rejectlist where PLANT_ID=_PLANT_ID and BELT_NO=_BELT_NO and MDA_NO=_MDA_NO
) t order by t.SID DESC, t.RID DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_qr_code_numbers_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_qr_code_numbers_Insert(IN `_QR_CODE_SYS_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_VENDER_ID` INT(11), IN `_SERIAL_NO` VARCHAR(45), IN `_QRCD_FILE_NAME` VARCHAR(45), IN `_CREATED_BY` INT(11), IN `_CREATED_DATETIME` DATETIME)
BEGIN
INSERT INTO qr_code_numbers
(
QR_CODE_SYS_ID,
PLANT_ID,
VENDER_ID,
SERIAL_NO,
QRCD_FILE_NAME,
CREATED_BY,
CREATED_DATETIME
)
VALUES
(
_QR_CODE_SYS_ID,
_PLANT_ID,
_VENDER_ID,
_SERIAL_NO,
_QRCD_FILE_NAME,
_CREATED_BY,
_CREATED_DATETIME
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_qr_code_rejectlist_delete */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_qr_code_rejectlist_delete(IN `_PLANT_ID` INT(11), IN `_BELT_NO` INT(11), IN `_Product_SYS_ID` INT(11), IN `_ShipperQRCode` VARCHAR(50))
BEGIN
/*DELETE FROM qr_code_rejectlist WHERE PLANT_ID=_PLANT_ID AND BELT_NO=_BELT_NO AND Product_SYS_ID=_Product_SYS_ID AND QRCODE=_ShipperQRCode ;*/
DELETE FROM qr_code_rejectlist WHERE PLANT_ID=_PLANT_ID AND BELT_NO=_BELT_NO AND QRCODE=_ShipperQRCode ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_qr_code_rejectlist_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_qr_code_rejectlist_Insert(IN `_PLANT_ID` INT(11), IN `_BELT_NO` INT(11), IN `_QRCODE` VARCHAR(50), IN `_Product_SYS_ID` INT(11), IN `_MDA_NO` VARCHAR(50))
BEGIN
INSERT INTO qr_code_rejectlist
(
PLANT_ID,
BELT_NO,
QRCODE,
Product_SYS_ID,
MDA_NO
)
VALUES
(
_PLANT_ID,
_BELT_NO,
_QRCODE,
_Product_SYS_ID,
_MDA_NO
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_qr_code_rejectlist_Insert_API */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_qr_code_rejectlist_Insert_API(
IN _HardwareUID VARCHAR(45), 
IN _ShipperQRCode VARCHAR(1000),
IN _REJECT_REASON VARCHAR(500))
BEGIN

 DECLARE _BELT_NO INT;
 DECLARE _PLANT_ID INT; 
 DECLARE _MDA_NO VARCHAR(45);
 
 SET _BELT_NO=0;  
 SET _PLANT_ID=0;
 SET _MDA_NO=''; 
 
 SELECT PLANT_ID INTO _PLANT_ID FROM belt_master WHERE HardwareUID=_HardwareUID;
 SELECT BeltSysID INTO _BELT_NO FROM belt_master WHERE HardwareUID=_HardwareUID;
 
 SELECT MDA_NO INTO _MDA_NO FROM mda_requisition_data 
 where LOADING_BAY_SYS_ID=(_BELT_NO) and Plant_id=_PLANT_ID and LOADING_PROGRESS='IN PROGRESS' order by SKU_ORDER limit 1;

INSERT INTO qr_code_rejectlist
(PLANT_ID,BELT_NO,QRCODE,Product_SYS_ID,MDA_NO,REJECT_REASON)
VALUES
(_PLANT_ID,_BELT_NO,_ShipperQRCode,0,_MDA_NO,_REJECT_REASON);

UPDATE belt_master SET ShipperRejectionCountCurrent =(ifnull(ShipperRejectionCountCurrent,0)+1) WHERE BeltSysID=_BELT_NO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_qr_code_rejectlist_RPT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_qr_code_rejectlist_RPT(IN _MDA_NO varchar(45))
BEGIN
SELECT PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON FROM qr_code_rejectlist_log WHERE MDA_NO=_MDA_NO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_qr_code_successlist_delete */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_qr_code_successlist_delete(IN `_PLANT_ID` INT(11), IN `_BELT_NO` INT(11), IN `_Product_SYS_ID` INT(11), IN `_ShipperQRCode` VARCHAR(50))
BEGIN

DELETE FROM qr_code_successlist WHERE PLANT_ID=_PLANT_ID AND BELT_NO=_BELT_NO AND Product_SYS_ID=_Product_SYS_ID AND QRCODE=_ShipperQRCode ;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_qr_code_successlist_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_qr_code_successlist_Insert(IN `_PLANT_ID` INT(11), IN `_BELT_NO` INT(11), IN `_QRCODE` VARCHAR(50), IN `_Product_SYS_ID` INT(11), IN `_MDA_NO` VARCHAR(50))
BEGIN
INSERT INTO qr_code_successlist
(
PLANT_ID,
BELT_NO,
QRCODE,
Product_SYS_ID,
MDA_NO
)
VALUES
(
_PLANT_ID,
_BELT_NO,
_QRCODE,
_Product_SYS_ID,
_MDA_NO
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_qr_code_success_reject_delete */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_qr_code_success_reject_delete(IN `_PLANT_ID` INT(11), IN `_BELT_NO` INT(11), IN `_MDA_NO` VARCHAR(45))
BEGIN
DELETE FROM qr_code_successlist WHERE PLANT_ID=_PLANT_ID AND BELT_NO=_BELT_NO AND MDA_NO=_MDA_NO;
DELETE FROM qr_code_rejectlist WHERE PLANT_ID=_PLANT_ID AND BELT_NO=_BELT_NO AND MDA_NO=_MDA_NO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Report_MDA_Status */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Report_MDA_Status(IN `_PLANT_ID` INT(11), IN `_FromDate` DATE, IN `_ToDate` DATE, IN `_MDA_NO` VARCHAR(45), IN `_VEHICLE_NO` VARCHAR(20), IN `_INVOICEQrCODE` VARCHAR(30))
BEGIN
select mh.MDA_NO,mh.Created_DateTime as Mda_rec_Date,mh.VEHICLE_NO as Truck_No,mh.DRIVER as Driver_Name,
mh.PARTY_NAME as cust_name,mh.WH_CD,'' as Destination, ms.Created_DateTime as Loading_in_datetime, ms.MDA_STATUS_DATETIME as Loading_out_datetime, 
ms.MDA_Sequence_No as LIFO_Loading_Sequence,mr.LOADING_BAY, concat(sysur.FIRST_NAME, " ", sysur.LAST_NAME) as Loading_Bay_Operator,
'' as LI_LO_SKIP,mr.SKU_CODE,mr.SKU_NAME, (md.BAG_NOS/24) as MDA_Qty_Shipper, (md.BAG_NOS/24) as MDA_Updated_Qty_Shipper,
mr.LOADED_ITEM as LOADED_QTY_shipper, ms.MDA_STATUS as MDA_Status, fg.GATE_OUT_DT as Disp_Date_Time,'' as Invoice_Qr_Code
from fg_gate_in_out as fg 
inner join mda_requisition_data as mr on fg.PLANT_ID=mr.PLANT_ID and fg.GATE_SYS_ID=mr.GATE_SYS_ID
inner join mda_header as mh on mr.PLANT_ID=mh.PLANT_ID and mr.MDA_NO=mh.MDA_NO
inner join mda_detail as md on mh.MDA_SYS_ID = md.MDA_SYS_ID and mh.PLANT_ID = md.PLANT_ID and md.PROD_SYS_ID = mr.PROD_SYS_ID
inner join mda_sequence as ms on fg.PLANT_ID=ms.PLANT_ID and fg.MDA_SYS_ID=ms.MDA_SYS_ID and fg.GATE_SYS_ID=ms.GATE_SYS_ID
inner join mda_invoice_qr as invqr on mr.PLANT_ID = invqr.PLANT_ID and mr.MDA_NO = invqr.MDA_NO  
inner join system_users as sysur on ms.Created_BY_ID = sysur.USER_ID
where fg.PLANT_ID=_PLANT_ID and (DATE_FORMAT(mh.MDA_DT ,'%y-%m-%d') between DATE_FORMAT(_FromDate,'%y-%m-%d') and DATE_FORMAT(_ToDate,'%y-%m-%d')
OR mh.MDA_NO=_MDA_NO OR mh.VEHICLE_NO=_VEHICLE_NO OR invqr.INVOICEQrCODE=_INVOICEQrCODE);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RFID_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RFID_Insert(IN `_RFIDSRNO` VARCHAR(30), IN `_RFIDCODE` VARCHAR(30), IN `_STATUS` VARCHAR(10), IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN
	insert into rfid_master (RFIDSRNO, RFIDCODE, STATUS, STATION_ID, PLANT_ID, Created_BY_ID, Created_DateTime) 
	values (_RFIDSRNO, _RFIDCODE, _STATUS, _STATION_ID, _PLANT_ID, _Created_BY_ID, _Created_DateTime);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RFID_List */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RFID_List(IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11))
BEGIN
select * from rfid_master where PLANT_ID=_PLANT_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RFID_List_By_Code */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RFID_List_By_Code(IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_RFIDCODE` VARCHAR(30))
BEGIN
select * from rfid_master where PLANT_ID=_PLANT_ID and RFIDCODE=_RFIDCODE and STATUS='Active';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RFID_List_By_SerialNo */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RFID_List_By_SerialNo(IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_RFIDSRNO` VARCHAR(30))
BEGIN
select * from rfid_master where PLANT_ID=_PLANT_ID and RFIDSRNO=_RFIDSRNO and STATUS='Active';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RFID_STATUS_UPDATE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RFID_STATUS_UPDATE(IN `_RFSYSID` INT(11), IN `_STATUS` VARCHAR(10))
BEGIN
UPDATE rfid_master SET STATUS = _STATUS WHERE RFSYSID = _RFSYSID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RFID_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RFID_Update(IN `_RFSYSID` INT(11), IN `_RFIDSRNO` VARCHAR(30), IN `_RFIDCODE` VARCHAR(30), IN `_STATUS` VARCHAR(10), IN `_REASONFOREDIT` VARCHAR(100), IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11))
BEGIN
		UPDATE rfid_master SET RFIDSRNO = _RFIDSRNO, RFIDCODE = _RFIDCODE, STATUS = _STATUS, REASONFOREDIT = _REASONFOREDIT,
		 PLANT_ID = _PLANT_ID WHERE RFSYSID = _RFSYSID;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RFID_ValidateCard */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RFID_ValidateCard(IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_RFIDSRNO` VARCHAR(30))
BEGIN
select count(*) from rfid_master where STATION_ID=_STATION_ID and PLANT_ID=_PLANT_ID and RFIDSRNO=_RFIDSRNO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RM_Change_Lost_RFID */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RM_Change_Lost_RFID(IN `_REF_SYS_ID` INT(11), IN `_INWARD_SYS_ID` INT(11), IN `_NewRFSYSID` INT(11), IN `_REASON` VARCHAR(50), IN `_REMARK` VARCHAR(50), IN `_RFID_LOST_DATE` DATETIME, IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME, IN `_OldRFSYSID` INT(11))
BEGIN
INSERT INTO rfid_lost
(
REF_SYS_ID,
INWARD_SYS_ID,
RFSYSID,
REASON,
REMARK,
RFID_LOST_DATE,
STATION_ID,
PLANT_ID,
Created_BY_ID,
Created_DateTime
)
VALUES
(
_REF_SYS_ID,
_INWARD_SYS_ID,
_OldRFSYSID,
_REASON,
_REMARK,
_RFID_LOST_DATE,
_STATION_ID,
_PLANT_ID,
_Created_BY_ID,
_Created_DateTime
);

UPDATE rm_gate_in_out SET RFSYSID=_NewRFSYSID where GATE_SYS_ID=_REF_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RM_GateInOutReport */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RM_GateInOutReport(IN `_GATE_IN_DT_From` DATE, IN `_GATE_IN_DT_To` DATE)
BEGIN
SELECT rm.GATE_SYS_ID,
rm.GATE_IN_DT,
rm.GATE_OUT_DT,
rm.INWARD_SYS_ID,
rm.PO_SYS_ID,
rm.TRANSPORTER_NAME,
rm.TRUCK_NO,
rm.DRIVER_ID_TYPE,
rm.DRIVER_ID_NUMBER,
rm.DRIVER_NAME,
rm.DRIVER_CONTACT,
rm.DRIVER_CHANGED,
rm.DRIVER_NAME_NEW,
rm.DRIVER_CONTACT_NEW,
rm.TRUCK_VALIDATION,
rm.RFSYSID,
rm.VERIFIED_DOCUMENTS,
rm.RFID_RECEIVE,
rm.VERIFIED_OFFICER_ID,
rm.CANCEL_GATE_IN,
rm.CANCEL_GATE_REASON,
rm.IS_UNLOAD_TRUCK,
rm.STATION_ID,
rm.PLANT_ID,
rm.Created_BY_ID,
rm.Created_DateTime,
rm.IS_POSTED,
ph.PO_NO,
ph.PO_DATE,
ph.VENDOR_SYS_ID,
vm.ORGANIZATION_NAME,
vm.VENDOR_CODE,
wt.TARE_WT,
wt.TARE_WT_DT,
wt.GROSS_WT,
wt.GROSS_WT_DT,
wt.NET_WT,
wt.WT_SYS_ID,
rfid.RFIDCODE,
rfid.STATUS
FROM rm_gate_in_out rm 
inner join rfid_master rfid on rm.RFSYSID=rfid.RFSYSID
inner join po_header ph on rm.PO_SYS_ID = ph.PO_SYS_ID
inner join vendor_master vm on ph.VENDOR_SYS_ID=vm.VENDOR_SYS_ID
left outer join rm_weighment_detail wt on rm.GATE_SYS_ID = wt.GATE_SYS_ID 
WHERE DATE_FORMAT(rm.GATE_IN_DT,'%y-%m-%d') between DATE_FORMAT(_GATE_IN_DT_From,'%y-%m-%d') and DATE_FORMAT(_GATE_IN_DT_To,'%y-%m-%d');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RM_GateIn_Cancel_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RM_GateIn_Cancel_Update(IN `_GATE_SYS_ID` INT(11), IN `_GATE_OUT_DT` DATETIME, IN `_RFID_RECEIVE` TINYINT(1), IN `_VERIFIED_DOCUMENTS` TINYINT(1), IN `_VERIFIED_OFFICER_ID` VARCHAR(50), IN `_CANCEL_GATE_IN` TINYINT(1), IN `_CANCEL_GATE_REASON` VARCHAR(50))
BEGIN
UPDATE rm_gate_in_out
SET
GATE_OUT_DT = _GATE_OUT_DT,
RFID_RECEIVE = _RFID_RECEIVE,
VERIFIED_DOCUMENTS = _VERIFIED_DOCUMENTS,
VERIFIED_OFFICER_ID = _VERIFIED_OFFICER_ID,
CANCEL_GATE_IN = _CANCEL_GATE_IN,
CANCEL_GATE_REASON = _CANCEL_GATE_REASON
WHERE GATE_SYS_ID = _GATE_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RM_GateIn_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RM_GateIn_Insert(IN `_GATE_SYS_ID` INT(11), IN `_GATE_IN_DT` DATETIME, IN `_INWARD_SYS_ID` INT(11), IN `_PO_SYS_ID` INT(11), IN `_TRANSPORTER_NAME` VARCHAR(50), IN `_TRUCK_NO` VARCHAR(10), IN `_DRIVER_ID_TYPE` VARCHAR(20), IN `_DRIVER_ID_NUMBER` VARCHAR(30), IN `_DRIVER_NAME` VARCHAR(30), IN `_DRIVER_CONTACT` VARCHAR(10), IN `_DRIVER_CHANGED` TINYINT(1), IN `_DRIVER_NAME_NEW` VARCHAR(30), IN `_DRIVER_CONTACT_NEW` VARCHAR(10), IN `_TRUCK_VALIDATION` TINYINT(1), IN `_RFSYSID` INT(11), IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN
INSERT INTO rm_gate_in_out
(
GATE_IN_DT,
INWARD_SYS_ID,
PO_SYS_ID,
TRANSPORTER_NAME,
TRUCK_NO,
DRIVER_ID_TYPE,
DRIVER_ID_NUMBER,
DRIVER_NAME,
DRIVER_CONTACT,
DRIVER_CHANGED,
DRIVER_NAME_NEW,
DRIVER_CONTACT_NEW,
TRUCK_VALIDATION,
RFSYSID,
STATION_ID,
PLANT_ID,
Created_BY_ID,
Created_DateTime
)
VALUES
(
_GATE_IN_DT,
_INWARD_SYS_ID,
_PO_SYS_ID,
_TRANSPORTER_NAME,
_TRUCK_NO,
_DRIVER_ID_TYPE,
_DRIVER_ID_NUMBER,
_DRIVER_NAME,
_DRIVER_CONTACT,
_DRIVER_CHANGED,
_DRIVER_NAME_NEW,
_DRIVER_CONTACT_NEW,
_TRUCK_VALIDATION,
_RFSYSID,
_STATION_ID,
_PLANT_ID,
_Created_BY_ID,
_Created_DateTime
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RM_GateOut_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RM_GateOut_Update(IN `_GATE_SYS_ID` INT(11), IN `_GATE_OUT_DT` DATETIME, IN `_RFID_RECEIVE` TINYINT(1), IN `_VERIFIED_DOCUMENTS` TINYINT(1), IN `_VERIFIED_OFFICER_ID` VARCHAR(50))
BEGIN
UPDATE rm_gate_in_out
SET
GATE_OUT_DT=_GATE_OUT_DT,
RFID_RECEIVE=_RFID_RECEIVE,
VERIFIED_DOCUMENTS=_VERIFIED_DOCUMENTS,
VERIFIED_OFFICER_ID=_VERIFIED_OFFICER_ID
WHERE GATE_SYS_ID=_GATE_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RM_GetDataByRFID */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RM_GetDataByRFID(IN `_RFIDSRNO` VARCHAR(49))
BEGIN
SELECT rm.GATE_SYS_ID,
rm.GATE_IN_DT,
rm.GATE_OUT_DT,
rm.INWARD_SYS_ID,
rm.PO_SYS_ID,
rm.TRANSPORTER_NAME,
rm.TRUCK_NO,
rm.DRIVER_ID_TYPE,
rm.DRIVER_ID_NUMBER,
rm.DRIVER_NAME,
rm.DRIVER_CONTACT,
rm.DRIVER_CHANGED,
rm.DRIVER_NAME_NEW,
rm.DRIVER_CONTACT_NEW,
rm.TRUCK_VALIDATION,
rm.RFSYSID,
rm.VERIFIED_DOCUMENTS,
rm.RFID_RECEIVE,
rm.VERIFIED_OFFICER_ID,
rm.CANCEL_GATE_IN,
rm.CANCEL_GATE_REASON,
rm.IS_UNLOAD_TRUCK,
rm.STATION_ID,
rm.PLANT_ID,
rm.Created_BY_ID,
rm.Created_DateTime,
rm.IS_POSTED,
ph.PO_NO,
ph.PO_DATE,
ph.VENDOR_SYS_ID,
vm.ORGANIZATION_NAME,
vm.VENDOR_CODE,
wt.TARE_WT,
wt.TARE_WT_DT,
wt.GROSS_WT,
wt.GROSS_WT_DT,
wt.NET_WT,
wt.WT_SYS_ID,
rfid.RFIDSRNO,
rfid.RFIDCODE
FROM rm_gate_in_out rm 
inner join rfid_master rfid on rm.RFSYSID=rfid.RFSYSID
inner join po_header ph on rm.PO_SYS_ID = ph.PO_SYS_ID
inner join vendor_master vm on ph.VENDOR_SYS_ID=vm.VENDOR_SYS_ID
left outer join rm_weighment_detail wt on rm.GATE_SYS_ID = wt.GATE_SYS_ID 
WHERE (rfid.RFIDSRNO=_RFIDSRNO or rfid.RFIDCODE=_RFIDSRNO) and rfid.STATUS='Assigned' ORDER BY rm.GATE_SYS_ID DESC LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RM_WeighmentIn_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RM_WeighmentIn_Insert(IN `_WT_SYS_ID` INT(11), IN `_GATE_SYS_ID` INT(11), IN `_GROSS_WT` DOUBLE, IN `_GROSS_WT_DT` DATETIME, IN `_GROSS_WT_MANUALLY` TINYINT(1), IN `_GROSS_WT_NOTE` VARCHAR(50), IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN
	if(select count(*) from rm_weighment_detail where GATE_SYS_ID=_GATE_SYS_ID and PLANT_ID=_PLANT_ID)=0 then
		begin
			INSERT INTO rm_weighment_detail
			(
			GATE_SYS_ID,
			GROSS_WT ,
			GROSS_WT_DT ,
			GROSS_WT_MANUALLY ,
			GROSS_WT_NOTE ,
			STATION_ID,
			PLANT_ID,
			Created_BY_ID,
			Created_DateTime
			)
			VALUES
			(
			_GATE_SYS_ID,
			_GROSS_WT,
			_GROSS_WT_DT,
			_GROSS_WT_MANUALLY,
			_GROSS_WT_NOTE,
			_STATION_ID,
			_PLANT_ID,
			_Created_BY_ID,
			_Created_DateTime
			);
		end;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RM_WeighmentOut_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RM_WeighmentOut_Update(IN `_WT_SYS_ID` INT(11), IN `_TARE_WT` DOUBLE, IN `_TARE_WT_DT` DATETIME, IN `_TARE_WT_MANUALLY` TINYINT(1), IN `_TARE_WT_NOTE` VARCHAR(50), IN `_NET_WT` DOUBLE)
BEGIN
UPDATE rm_weighment_detail
SET
TARE_WT = _TARE_WT,
TARE_WT_DT = _TARE_WT_DT,
TARE_WT_MANUALLY = _TARE_WT_MANUALLY,
TARE_WT_NOTE = _TARE_WT_NOTE,
NET_WT = _NET_WT
WHERE WT_SYS_ID = _WT_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_RM_WEIGHTMENT_REPORT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_RM_WEIGHTMENT_REPORT(IN `_GATE_SYS_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_STATION_ID` INT(11))
BEGIN
SELECT 
rm.GATE_SYS_ID,
rm.GATE_IN_DT,
rm.GATE_OUT_DT,
rm.INWARD_SYS_ID,
rm.PO_SYS_ID,
rm.TRANSPORTER_NAME,
rm.TRUCK_NO,
rm.DRIVER_ID_TYPE,
rm.DRIVER_ID_NUMBER,
rm.DRIVER_NAME,
rm.DRIVER_CONTACT,
rm.DRIVER_CHANGED,
rm.DRIVER_NAME_NEW,
rm.DRIVER_CONTACT_NEW,
rm.TRUCK_VALIDATION,
rm.RFSYSID,
rm.VERIFIED_DOCUMENTS,
rm.RFID_RECEIVE,
rm.VERIFIED_OFFICER_ID,
rm.CANCEL_GATE_IN,
rm.CANCEL_GATE_REASON,
rm.IS_UNLOAD_TRUCK,
rm.STATION_ID,
rm.PLANT_ID,
rm.Created_BY_ID,
rm.Created_DateTime,
rm.IS_POSTED,
ph.PO_NO,
ph.PO_DATE,
ph.VENDOR_SYS_ID,
ph.PO_DESCCRIPTION as Material,
vm.ORGANIZATION_NAME as Supplier,
vm.VENDOR_CODE,
ifnull(wt.TARE_WT,0) as TARE_WT,
wt.TARE_WT_DT,
wt.TARE_WT_MANUALLY,
ifnull(wt.GROSS_WT,0) as GROSS_WT,
wt.GROSS_WT_DT,
wt.GROSS_WT_MANUALLY,
ifnull(wt.NET_WT, 0) as NET_WT,
wt.WT_SYS_ID,
wt.TARE_WT_NOTE,
wt.GROSS_WT_NOTE,
rfid.RFIDSRNO,
pm.Plant_Name,
pm.PlantAddress 
FROM rm_gate_in_out rm 
inner join rfid_master rfid on rm.RFSYSID=rfid.RFSYSID
inner join po_header ph on rm.PO_SYS_ID = ph.PO_SYS_ID
inner join vendor_master vm on ph.VENDOR_SYS_ID=vm.VENDOR_SYS_ID
inner join plant_master as pm on rm.PLANT_ID = pm.PlantID
left outer join rm_weighment_detail wt on rm.GATE_SYS_ID = wt.GATE_SYS_ID 
where rm.GATE_SYS_ID=_GATE_SYS_ID AND rm.PLANT_ID=_PLANT_ID AND rm.STATION_ID=_STATION_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Role_Master_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Role_Master_Insert(IN `_ROLE_NAME` VARCHAR(45), IN `_PLANT_ID` INT(11), IN `_CREATED_BY` INT(11), IN `_CREATED_DATETIME` DATETIME)
BEGIN
declare isDuplicate int(11);
set isDuplicate=0;

iF(SELECT COUNT(*) FROM role_master WHERE ROLE_NAME=_ROLE_NAME AND PLANT_ID=_PLANT_ID)=0 THEN
begin
DECLARE _role_id int(11);
DECLARE _url_id int(11);
DECLARE _output TEXT DEFAULT '';
declare done tinyint default 0;
declare cur1 cursor for SELECT Id from all_urls;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
INSERT INTO role_master
(ROLE_NAME,PLANT_ID,CREATED_BY,CREATED_DATETIME)
VALUES
(_ROLE_NAME,_PLANT_ID,_CREATED_BY,_CREATED_DATETIME);

select role_id into _role_id from role_master where ROLE_NAME=_ROLE_NAME and PLANT_ID=_PLANT_ID;
OPEN cur1;

REPEAT
  FETCH cur1 INTO _url_id;
/*IF NOT done THEN*/
if(select count(*) from access_rights where Role_Id=_role_id and Url_Id=_url_id and Plant_Id=_PLANT_ID)=0 then
begin
   insert into access_rights(Role_Id, Url_Id, Plant_Id, Status) values(_role_id, _url_id, _PLANT_ID, 0);
   end;
   end if;
  /*END IF;UNTIL done*/
 UNTIL done END REPEAT;
CLOSE cur1;
set isDuplicate=1;
end;
else
begin
set isDuplicate=2;	
end;
End if;
select isDuplicate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Role_Master_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Role_Master_Update(IN `_ROLE_ID` INT(11), IN `_ROLE_NAME` VARCHAR(45), IN `_PLANT_ID` INT(11))
BEGIN
declare isDuplicate int(11);
set isDuplicate=0;
iF(SELECT COUNT(*) FROM role_master WHERE ROLE_NAME=_ROLE_NAME AND PLANT_ID=_PLANT_ID)=0 THEN
begin
UPDATE role_master
SET
ROLE_NAME = _ROLE_NAME 
WHERE ROLE_ID = _ROLE_ID AND PLANT_ID = _PLANT_ID;
set isDuplicate=1;
end;
else
begin
set isDuplicate=2;
end;
end if;
select isDuplicate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Role_Master_View */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Role_Master_View(IN `_PLANT_ID` INT(11))
BEGIN
SELECT ROLE_ID,
    ROLE_NAME,
    PLANT_ID,
    CREATED_BY,
    CREATED_DATETIME
FROM role_master WHERE PLANT_ID=_PLANT_ID and ROLE_ID not in (1,3);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Role_To_Url_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Role_To_Url_Update(IN `_Id` INT(11), IN `_Plant_Id` INT(11), IN `_Status` TINYINT(1), IN `_Role_Id` INT(11))
BEGIN
UPDATE access_rights
SET
Status=_Status
WHERE Id = _ID AND Plant_Id = _Plant_Id And Role_Id=_Role_Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Role_To_User_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Role_To_User_Update(IN `_Id` INT(11), IN `_User_Id` INT(11), IN `_Role_Id` INT(11), IN `_Plant_Id` INT(11))
BEGIN
UPDATE roleto_user
SET
User_Id = _User_Id, Role_Id=_Role_Id
WHERE Id = _ID AND Plant_Id = _Plant_Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Set_ShipperRejectionCountCurrent */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Set_ShipperRejectionCountCurrent(
IN _HardwareUID VARCHAR(45)
)
BEGIN
UPDATE belt_master SET ShipperRejectionCountCurrent =0 WHERE HardwareUID=_HardwareUID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_shipperBottle_api_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_shipperBottle_api_Insert(
IN `_shipper_qrcode_api_sysId` VARCHAR(45), 
IN `_Batch_no` VARCHAR(45), 
IN `_Mfg_Date` VARCHAR(45), 
IN `_Expiry_Date` VARCHAR(45), 
IN `_EventTime` VARCHAR(45), 
IN `_plant_code` VARCHAR(45), 
IN `_created_datetime` DATETIME,
IN `_ManufacturedBy` VARCHAR(100), 
IN `_MarketedBy` VARCHAR(100)
)
Begin
declare Gplant_Id int(15);
set Gplant_Id=0;
select plantid into Gplant_Id from plant_master where plant_master.plantcode=_plant_code;
INSERT INTO shipper_qrcode_api
(
shipper_qrcode_api_sysId,
Batch_no,
Mfg_Date,
Expiry_Date,
EventTime,
plant_id,
created_datetime,
ManufacturedBy,
MarketedBy
)
VALUES
(
_shipper_qrcode_api_sysId,
_Batch_no,
_Mfg_Date,
_Expiry_Date,
_EventTime,
Gplant_Id,
_created_datetime,
_ManufacturedBy,
_MarketedBy
);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_shipper_BottleQRCode_qrcode_Files */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=iffco@`%` PROCEDURE SP_shipper_BottleQRCode_qrcode_Files(IN `_BottleQRCode` VARCHAR(45), IN `_plant_code` VARCHAR(45), IN `_created_datetime` VARCHAR(45), IN `_shipper_qrcode_sysId` VARCHAR(45), IN `_GTIN` VARCHAR(45))
Begin
declare notFound int(11);
declare Gplant_Id int(15);
    declare product_Id int(11);
    declare qrcodecount int(11); 
set Gplant_Id=0;
    set product_Id=0;
    set notFound=0;
    set qrcodecount=0;
    
select plantid into Gplant_Id from plant_master where plant_master.plantcode=_plant_code;

select PROD_SYS_ID into product_Id from product_master where GTIN=_GTIN;

/*INSERT INTO qr_codes_cloud(REQUEST_NO,SERIAL_NO) VALUES('FILE000000000001',_BottleQRCode);*/

INSERT INTO bottle_qrcode
(
bottle_qrcode,
plant_id,
created_datetime,
shipper_qrcode_sysId,
status,
product_id
)
VALUES(
_BottleQRCode,
Gplant_Id,
_created_datetime,
_shipper_qrcode_sysId,
'A',
product_Id
);
set notFound=1;

select notFound;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_shipper_BottleQRCode_qrcode_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_shipper_BottleQRCode_qrcode_Insert(IN `_BottleQRCode` VARCHAR(45), IN `_plant_code` VARCHAR(45), IN `_created_datetime` VARCHAR(45), IN `_shipper_qrcode_sysId` VARCHAR(45), IN `_GTIN` VARCHAR(45))
Begin
declare notFound int(11);
declare Gplant_Id int(15);
    declare product_Id int(11);
    declare qrcodecount int(11); 
set Gplant_Id=0;
    set product_Id=0;
    set notFound=0;
    set qrcodecount=0;
    
select plantid into Gplant_Id from plant_master where plant_master.plantcode=_plant_code;

select PROD_SYS_ID into product_Id from product_master where GTIN=_GTIN;
    
select count(*) into qrcodecount FROM qr_codes_cloud 
where qr_codes_cloud.SERIAL_NO=_BottleQRCode;
If(qrcodecount =1) then
begin
INSERT INTO bottle_qrcode
(
bottle_qrcode,
plant_id,
created_datetime,
shipper_qrcode_sysId,
status,
product_id

)
VALUES(
_BottleQRCode,
Gplant_Id,
_created_datetime,
_shipper_qrcode_sysId,
'A',
product_Id

);

set notFound=1;
end;
else
begin
set notFound=0;
end;
end if;
select notFound;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Shipper_Bottle_qrcode_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Shipper_Bottle_qrcode_Insert(IN `_shipper_qrcode_sysId` VARCHAR(45), IN `_shipper_qrcode` VARCHAR(45), IN `_shipper_qrcode_api_sysId` VARCHAR(45), IN `_plant_code` VARCHAR(45), IN `_created_datetime` VARCHAR(45), 
IN `_OldShipperQRCode` VARCHAR(45), IN `_BottlesQuantity` VARCHAR(45), IN `_EventTime` VARCHAR(45) )
Begin
declare Gplant_Id int(15);
declare old_shipper_qrcode_sysId int(15);
set Gplant_Id=0;
    set old_shipper_qrcode_sysId=0;
select plantid into Gplant_Id from plant_master where plant_master.plantcode=_plant_code;

SELECT shipper_qrcode_sysId into old_shipper_qrcode_sysId FROM shipper_qrcode
 where shipper_qrcode=_OldShipperQRCode;
INSERT INTO shipper_qrcode
(
shipper_qrcode_sysId,
shipper_qrcode,
shipper_qrcode_api_sysId,
plant_id,
created_datetime,
old_shipper_qrcode_sysId,
total_bottles_qty,
EventTime
)
VALUES(
_shipper_qrcode_sysId, 
_shipper_qrcode,
_shipper_qrcode_api_sysId,
Gplant_Id,
_created_datetime,
old_shipper_qrcode_sysId,
_BottlesQuantity,
_EventTime
);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_so_detail_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_so_detail_Insert(IN `_SO_SYS_ID` INT(11), IN `_UNIT_CODE` INT(11), 
IN `_SO_NO` INT(11), IN `_SLNO` INT(11), IN `_SCRAP_CD` INT(11), IN `_SCRAP_DESC` VARCHAR(500), IN `_UOM` VARCHAR(10), 
IN `_ERP_UOM_CD` INT(11), IN `_SO_QTY` INT(11), IN `_BASIC_AMT` DOUBLE, IN `_PLANT_ID` INT(11))
BEGIN
IF(SELECT COUNT(*) FROM so_detail WHERE SO_SYS_ID=_SO_SYS_ID AND SLNO= _SLNO AND PLANT_ID=_PLANT_ID)=0 THEN
	BEGIN
		INSERT INTO so_detail
		(SO_SYS_ID,UNIT_CODE,SO_NO,SLNO,SCRAP_CD,SCRAP_DESC,UOM,ERP_UOM_CD,SO_QTY,BASIC_AMT,PLANT_ID)
		VALUES
		(_SO_SYS_ID,_UNIT_CODE,_SO_NO,_SLNO,_SCRAP_CD,_SCRAP_DESC,_UOM,_ERP_UOM_CD,_SO_QTY,_BASIC_AMT,_PLANT_ID);
	END;
else
	BEGIN
		UPDATE so_detail
		SET
		UNIT_CODE = _UNIT_CODE, SLNO = _SLNO, SCRAP_CD = _SCRAP_CD, SCRAP_DESC = _SCRAP_DESC,
		UOM = _UOM, ERP_UOM_CD = _ERP_UOM_CD, SO_QTY = _SO_QTY, BASIC_AMT = _BASIC_AMT
		WHERE SO_SYS_ID=_SO_SYS_ID AND SLNO= _SLNO AND PLANT_ID=_PLANT_ID;
	END;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_so_GetMaxId */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_so_GetMaxId()
BEGIN
select ifnull(max(SO_SYS_ID),0)+1 from so_header;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_so_header_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_so_header_Insert(IN `_SO_SYS_ID` INT(11), IN `_UNIT_CODE` INT(11), IN `_SO_NO` INT(11), 
IN `_SO_DATE` DATETIME, IN `_SO_RELEASE_DATE` DATETIME, IN `_SO_VALID_DATE` DATETIME, IN `_SEQUENCE_NO` INT(11), IN `_TENDER_NO` INT(11), 
IN `_TENDER_DATE` DATETIME, IN `_VENSOR_SYS_ID` INT(11), IN `_CUST_CD` INT(11), IN `_CUST_NAME` VARCHAR(30), IN `_CUST_SITE_CD` INT(11), 
IN `_SITE_NAME` VARCHAR(50), IN `_ADD1` VARCHAR(500), IN `_ADD2` VARCHAR(500), IN `_ADD3` VARCHAR(500), IN `_CITY` VARCHAR(10), IN `_PIN` INT(11), 
IN `_STATE` VARCHAR(15), IN `_STATE_CD` VARCHAR(10), IN `_GSTN_NO` VARCHAR(20), IN `_PAN_NO` VARCHAR(10), IN `_CUST_NON_GST` INT(11), 
IN `_TEL_NO` VARCHAR(10), IN `_SO_REMARKS` VARCHAR(1000), IN `_STATUS` VARCHAR(1000), IN `_STATUS_DATE` DATETIME, IN `_STATUS_REMARKS` VARCHAR(1000), 
IN `_EMD_AMT` DOUBLE, IN `_TERMS_PRICE` VARCHAR(500), IN `_TERMS_PYMT_TERM` VARCHAR(1000), IN `_TERMS_LIFTING_PERIOD_DAYS` INT(11), IN `_TENDER_TYPE` VARCHAR(20), 
IN `_AMEND_NO` INT(11), IN `_AMEND_RELEASE_DATE` DATETIME, IN `_Created_DateTime` DATETIME, IN `_PLANT_ID` INT(11), IN `_RIVISION` VARCHAR(50))
BEGIN
IF(SELECT COUNT(*) FROM so_header WHERE SO_NO=_SO_NO AND PLANT_ID=_PLANT_ID)=0 THEN
	BEGIN
		INSERT INTO so_header
		(
		SO_SYS_ID,UNIT_CODE,SO_NO,SO_DATE,SO_RELEASE_DATE,SO_VALID_DATE,SEQUENCE_NO,TENDER_NO,TENDER_DATE,VENSOR_SYS_ID,CUST_CD,CUST_NAME,CUST_SITE_CD,
		SITE_NAME,ADD1,ADD2,ADD3,CITY,PIN,STATE,STATE_CD,GSTN_NO,PAN_NO,CUST_NON_GST,TEL_NO,SO_REMARKS,STATUS,STATUS_DATE,STATUS_REMARKS,EMD_AMT,
		TERMS_PRICE,TERMS_PYMT_TERM,TERMS_LIFTING_PERIOD_DAYS,TENDER_TYPE,AMEND_NO,AMEND_RELEASE_DATE,Created_DateTime,PLANT_ID,RIVISION
		)
		VALUES
		(
		_SO_SYS_ID,_UNIT_CODE,_SO_NO,_SO_DATE,_SO_RELEASE_DATE,_SO_VALID_DATE,_SEQUENCE_NO,_TENDER_NO,_TENDER_DATE,_VENSOR_SYS_ID,_CUST_CD,_CUST_NAME,
		_CUST_SITE_CD,_SITE_NAME,_ADD1,_ADD2,_ADD3,_CITY,_PIN,_STATE,_STATE_CD,_GSTN_NO,_PAN_NO,_CUST_NON_GST,_TEL_NO,_SO_REMARKS,_STATUS,_STATUS_DATE,
		_STATUS_REMARKS,_EMD_AMT,_TERMS_PRICE,_TERMS_PYMT_TERM,_TERMS_LIFTING_PERIOD_DAYS,_TENDER_TYPE,_AMEND_NO,_AMEND_RELEASE_DATE,_Created_DateTime,
		_PLANT_ID,_RIVISION
		);
	END;
else
	BEGIN
		UPDATE so_header
		SET
		UNIT_CODE = _UNIT_CODE, SO_NO = _SO_NO, SO_DATE = _SO_DATE, SO_RELEASE_DATE = _SO_RELEASE_DATE, SO_VALID_DATE = _SO_VALID_DATE,
		SEQUENCE_NO = _SEQUENCE_NO, TENDER_NO = _TENDER_NO, TENDER_DATE = _TENDER_DATE, VENSOR_SYS_ID = _VENSOR_SYS_ID, CUST_CD = _CUST_CD, CUST_NAME = _CUST_NAME,
		CUST_SITE_CD = _CUST_SITE_CD, SITE_NAME = _SITE_NAME, ADD1 = _ADD1, ADD2 = _ADD2, ADD3 = _ADD3, CITY = _CITY, PIN = _PIN, STATE = _STATE, STATE_CD = _STATE_CD,
		GSTN_NO = _GSTN_NO, PAN_NO = _PAN_NO, CUST_NON_GST = _CUST_NON_GST, TEL_NO = _TEL_NO, SO_REMARKS = _SO_REMARKS, STATUS = _STATUS, STATUS_DATE = _STATUS_DATE,
		STATUS_REMARKS = _STATUS_REMARKS, EMD_AMT = _EMD_AMT, TERMS_PRICE = _TERMS_PRICE, TERMS_PYMT_TERM = _TERMS_PYMT_TERM, TERMS_LIFTING_PERIOD_DAYS = _TERMS_LIFTING_PERIOD_DAYS,
		TENDER_TYPE = _TENDER_TYPE, AMEND_NO = _AMEND_NO, AMEND_RELEASE_DATE = _AMEND_RELEASE_DATE, Created_DateTime = _Created_DateTime,
		RIVISION = _RIVISION WHERE SO_SYS_ID = _SO_SYS_ID AND PLANT_ID=_PLANT_ID;
	END;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_SP_Change_Lost_RFID */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_SP_Change_Lost_RFID(IN `_NewRFSYSID` INT(11), IN `_INWARD_SYS_ID` INT(11), IN `_REF_SYS_ID_OLD` INT(11), IN `_REASON` VARCHAR(50), IN `_REMARK` VARCHAR(50), IN `_RFID_LOST_DATE` DATETIME, IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME, IN `_FormType` INT)
BEGIN
INSERT INTO rfid_lost
(
REF_SYS_ID,
INWARD_SYS_ID,
REF_SYS_ID_OLD,
REASON,
REMARK,
RFID_LOST_DATE,
STATION_ID,
PLANT_ID,
Created_BY_ID,
Created_DateTime
)
VALUES
(
_NewRFSYSID,
_INWARD_SYS_ID,
_REF_SYS_ID_OLD,
_REASON,
_REMARK,
_RFID_LOST_DATE,
_STATION_ID,
_PLANT_ID,
_Created_BY_ID,
_Created_DateTime
);
IF _FormType=0 THEN
UPDATE fg_gate_in_out SET RFSYSID=_NewRFSYSID where GATE_SYS_ID=_INWARD_SYS_ID;
ELSEIF _FormType=1 THEN
UPDATE rm_gate_in_out SET RFSYSID=_NewRFSYSID where GATE_SYS_ID=_INWARD_SYS_ID;
ELSEIF _FormType=2 THEN
UPDATE sp_gate_in_out SET RFSYSID=_NewRFSYSID where GATE_SYS_ID=_INWARD_SYS_ID;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_SP_GateInOutReport */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_SP_GateInOutReport(IN `_GATE_IN_DT_From` DATE, IN `_GATE_IN_DT_To` DATE)
BEGIN
SELECT 
gt.GATE_SYS_ID,
gt.GATE_IN_DT,
gt.GATE_OUT_DT,
gt.INWARD_SYS_ID,
gt.SO_SYS_ID,
gt.TRANS_SYS_ID,
gt.TRANSPORTER_NAME,
gt.TRUCK_NO,
gt.DRIVER_ID_TYPE,
gt.DRIVER_ID_NUMBER,
gt.DRIVER_NAME,
gt.DRIVER_CONTACT,
gt.DRIVER_CHANGED,
gt.DRIVER_NAME_NEW,
gt.DRIVER_CONTACT_NEW,
gt.TRUCK_VALIDATION,
gt.RFSYSID,
gt.VERIFIED_DOCUMENTS,
gt.RFID_RECEIVE,
gt.VERIFIED_OFFICER_ID,
gt.CANCEL_GATE_IN,
gt.CANCEL_GATE_REASON,
gt.GATE_SYS_ID_OLD,
gt.IS_GOODS_TRANSFER,
gt.STATION_ID,
gt.PLANT_ID,
gt.Created_BY_ID,
gt.Created_DateTime,
gt.IS_POSTED,
sh.SO_NO,
sh.SO_DATE,
sh.CUST_NAME,
wt.TARE_WT,
wt.TARE_WT_DT,
wt.GROSS_WT,
wt.GROSS_WT_DT,
wt.NET_WT,
wt.OUT_OF_TOLERANCE_WT,
wt.TOLERANCE_WT,
wt.ALLOW_TOLERANCE_WT,
wt.WT_SYS_ID,
rfid.RFIDCODE,
rfid.STATUS
FROM sp_gate_in_out gt 
inner join rfid_master rfid on gt.RFSYSID = rfid.RFSYSID
inner join so_header sh on gt.SO_SYS_ID = sh.SO_SYS_ID
left outer join sp_weighment_detail wt on gt.GATE_SYS_ID = wt.GATE_SYS_ID 
WHERE DATE_FORMAT(gt.GATE_IN_DT,'%y-%m-%d') between DATE_FORMAT(_GATE_IN_DT_From,'%y-%m-%d') and DATE_FORMAT(_GATE_IN_DT_To,'%y-%m-%d');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_SP_GateIn_Cancel_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_SP_GateIn_Cancel_Update(IN `_GATE_SYS_ID` INT(11), IN `_GATE_OUT_DT` DATETIME, IN `_RFID_RECEIVE` TINYINT(1), IN `_VERIFIED_DOCUMENTS` TINYINT(1), IN `_VERIFIED_OFFICER_ID` VARCHAR(50), IN `_CANCEL_GATE_IN` TINYINT(1), IN `_CANCEL_GATE_REASON` VARCHAR(50))
BEGIN
UPDATE sp_gate_in_out
SET
GATE_OUT_DT = _GATE_OUT_DT,
RFID_RECEIVE = _RFID_RECEIVE,
VERIFIED_DOCUMENTS = _VERIFIED_DOCUMENTS,
VERIFIED_OFFICER_ID = _VERIFIED_OFFICER_ID,
CANCEL_GATE_IN = _CANCEL_GATE_IN,
CANCEL_GATE_REASON = _CANCEL_GATE_REASON
WHERE GATE_SYS_ID = _GATE_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_SP_GateOut_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_SP_GateOut_Update(IN `_GATE_SYS_ID` INT(11), IN `_GATE_OUT_DT` DATETIME, IN `_RFID_RECEIVE` TINYINT(1), IN `_VERIFIED_DOCUMENTS` TINYINT(1), IN `_VERIFIED_OFFICER_ID` VARCHAR(50))
BEGIN
UPDATE sp_gate_in_out
SET
GATE_OUT_DT=_GATE_OUT_DT,
RFID_RECEIVE=_RFID_RECEIVE,
VERIFIED_DOCUMENTS=_VERIFIED_DOCUMENTS,
VERIFIED_OFFICER_ID=_VERIFIED_OFFICER_ID
WHERE GATE_SYS_ID=_GATE_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_SP_Gate_In_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_SP_Gate_In_Insert(IN `_GATE_SYS_ID` INT(11), IN `_GATE_SYS_ID_OLD` INT(11), IN `_GATE_IN_DT` DATETIME, IN `_INWARD_SYS_ID` INT(11), IN `_SO_SYS_ID` INT(11), IN `_TRANSPORTER_NAME` VARCHAR(50), IN `_TRUCK_NO` VARCHAR(10), IN `_DRIVER_ID_TYPE` VARCHAR(20), IN `_DRIVER_ID_NUMBER` VARCHAR(30), IN `_DRIVER_NAME` VARCHAR(30), IN `_DRIVER_CONTACT` VARCHAR(10), IN `_DRIVER_CHANGED` TINYINT(1), IN `_DRIVER_NAME_NEW` VARCHAR(30), IN `_DRIVER_CONTACT_NEW` VARCHAR(10), IN `_TRUCK_VALIDATION` TINYINT(1), IN `_RFSYSID` INT(11), IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN
INSERT INTO sp_gate_in_out
(
GATE_SYS_ID_OLD,
GATE_IN_DT,
INWARD_SYS_ID,
SO_SYS_ID,
TRANSPORTER_NAME,
TRUCK_NO,
DRIVER_ID_TYPE,
DRIVER_ID_NUMBER,
DRIVER_NAME,
DRIVER_CONTACT,
DRIVER_CHANGED,
DRIVER_NAME_NEW,
DRIVER_CONTACT_NEW,
TRUCK_VALIDATION,
RFSYSID,
STATION_ID,
PLANT_ID,
Created_BY_ID,
Created_DateTime
)
VALUES
(
_GATE_SYS_ID_OLD,
_GATE_IN_DT,
_INWARD_SYS_ID,
_SO_SYS_ID,
_TRANSPORTER_NAME,
_TRUCK_NO,
_DRIVER_ID_TYPE,
_DRIVER_ID_NUMBER,
_DRIVER_NAME,
_DRIVER_CONTACT,
_DRIVER_CHANGED,
_DRIVER_NAME_NEW,
_DRIVER_CONTACT_NEW,
_TRUCK_VALIDATION,
_RFSYSID,
_STATION_ID,
_PLANT_ID,
_Created_BY_ID,
_Created_DateTime
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_SP_GetDataByRFID */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_SP_GetDataByRFID(IN `_RFIDSRNO` VARCHAR(49))
BEGIN
SELECT 
gt.GATE_SYS_ID,
gt.GATE_IN_DT,
gt.GATE_OUT_DT,
gt.INWARD_SYS_ID,
gt.SO_SYS_ID,
gt.TRANS_SYS_ID,
gt.TRANSPORTER_NAME,
gt.TRUCK_NO,
gt.DRIVER_ID_TYPE,
gt.DRIVER_ID_NUMBER,
gt.DRIVER_NAME,
gt.DRIVER_CONTACT,
gt.DRIVER_CHANGED,
gt.DRIVER_NAME_NEW,
gt.DRIVER_CONTACT_NEW,
gt.TRUCK_VALIDATION,
gt.RFSYSID,
gt.VERIFIED_DOCUMENTS,
gt.RFID_RECEIVE,
gt.VERIFIED_OFFICER_ID,
gt.CANCEL_GATE_IN,
gt.CANCEL_GATE_REASON,
gt.GATE_SYS_ID_OLD,
gt.IS_GOODS_TRANSFER,
gt.STATION_ID,
gt.PLANT_ID,
gt.Created_BY_ID,
gt.Created_DateTime,
gt.IS_POSTED,
sh.SO_NO,
sh.SO_DATE,
sh.CUST_NAME,
wt.TARE_WT,
wt.TARE_WT_DT,
wt.GROSS_WT,
wt.GROSS_WT_DT,
wt.NET_WT,
wt.OUT_OF_TOLERANCE_WT,
wt.TOLERANCE_WT,
wt.ALLOW_TOLERANCE_WT,
wt.WT_SYS_ID,
rfid.RFIDSRNO,
rfid.RFIDCODE
FROM sp_gate_in_out gt 
inner join rfid_master rfid on gt.RFSYSID = rfid.RFSYSID
inner join so_header sh on gt.SO_SYS_ID = sh.SO_SYS_ID
left outer join sp_weighment_detail wt on gt.GATE_SYS_ID = wt.GATE_SYS_ID 
WHERE (rfid.RFIDSRNO=_RFIDSRNO or rfid.RFIDCODE=_RFIDSRNO) and rfid.STATUS='Assigned' ORDER BY gt.GATE_SYS_ID DESC LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_SP_WeighmentIn_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_SP_WeighmentIn_Insert(IN `_WT_SYS_ID` INT(11), IN `_GATE_SYS_ID` INT(11), IN `_TARE_WT` DOUBLE, IN `_TARE_WT_DT` DATETIME, IN `_TARE_WT_MANUALLY` TINYINT(1), IN `_TARE_WT_NOTE` VARCHAR(50), IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_BY_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN
INSERT INTO sp_weighment_detail
(
GATE_SYS_ID,
TARE_WT,
TARE_WT_DT,
TARE_WT_MANUALLY,
TARE_WT_NOTE,
STATION_ID,
PLANT_ID,
Created_BY_ID,
Created_DateTime
)
VALUES
(
_GATE_SYS_ID,
_TARE_WT,
_TARE_WT_DT,
_TARE_WT_MANUALLY,
_TARE_WT_NOTE,
_STATION_ID,
_PLANT_ID,
_Created_BY_ID,
_Created_DateTime
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_SP_WeighmentOut_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_SP_WeighmentOut_Update(IN `_WT_SYS_ID` INT(11), IN `_GROSS_WT` DOUBLE, IN `_GROSS_WT_DT` DATETIME, IN `_GROSS_WT_MANUALLY` TINYINT(1), IN `_GROSS_WT_NOTE` VARCHAR(50), IN `_NET_WT` DOUBLE, IN `_OUT_OF_TOLERANCE_WT` TINYINT(1), IN `_TOLERANCE_WT` DOUBLE, IN `_ALLOW_TOLERANCE_WT` TINYINT(1))
BEGIN
UPDATE sp_weighment_detail
SET
GROSS_WT = _GROSS_WT,
GROSS_WT_DT = _GROSS_WT_DT,
GROSS_WT_MANUALLY = _GROSS_WT_MANUALLY,
GROSS_WT_NOTE = _GROSS_WT_NOTE,
NET_WT = _NET_WT,
OUT_OF_TOLERANCE_WT = _OUT_OF_TOLERANCE_WT,
TOLERANCE_WT = _TOLERANCE_WT,
ALLOW_TOLERANCE_WT = _ALLOW_TOLERANCE_WT
WHERE WT_SYS_ID = _WT_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_SP_WEIGHTMENT_REPORT */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_SP_WEIGHTMENT_REPORT(IN `_GATE_SYS_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_STATION_ID` INT(11))
BEGIN
SELECT 
gt.GATE_SYS_ID, gt.GATE_IN_DT, gt.GATE_OUT_DT, gt.INWARD_SYS_ID, gt.SO_SYS_ID, gt.TRANS_SYS_ID, gt.TRANSPORTER_NAME, gt.TRUCK_NO,
gt.DRIVER_ID_TYPE, gt.DRIVER_ID_NUMBER, gt.DRIVER_NAME, gt.DRIVER_CONTACT, gt.DRIVER_CHANGED, gt.DRIVER_NAME_NEW, gt.DRIVER_CONTACT_NEW,
gt.TRUCK_VALIDATION, gt.RFSYSID, gt.VERIFIED_DOCUMENTS, gt.RFID_RECEIVE, gt.VERIFIED_OFFICER_ID, gt.CANCEL_GATE_IN, gt.CANCEL_GATE_REASON,
gt.GATE_SYS_ID_OLD, gt.IS_GOODS_TRANSFER, gt.STATION_ID, gt.PLANT_ID, gt.Created_BY_ID, gt.Created_DateTime, gt.IS_POSTED, sh.SO_NO,
sh.SO_DATE, sh.CUST_NAME, ifnull(wt.TARE_WT,0) as TARE_WT, wt.TARE_WT_DT, wt.TARE_WT_MANUALLY, ifnull(wt.GROSS_WT,0) as GROSS_WT , wt.GROSS_WT_DT, wt.GROSS_WT_MANUALLY, ifnull(wt.NET_WT,0) as NET_WT,
wt.OUT_OF_TOLERANCE_WT, wt.TOLERANCE_WT, wt.ALLOW_TOLERANCE_WT, wt.WT_SYS_ID, wt.TARE_WT_NOTE, wt.GROSS_WT_NOTE, rfid.RFIDSRNO, pm.Plant_Name,
pm.PlantAddress, '' as Party, sh.CUST_NAME as Supplier, sd.SCRAP_DESC AS Material
FROM sp_gate_in_out gt 
inner join rfid_master rfid on gt.RFSYSID = rfid.RFSYSID
inner join so_header sh on gt.SO_SYS_ID = sh.SO_SYS_ID
inner join so_detail sd on sd.SO_SYS_ID = sh.SO_SYS_ID
inner join plant_master as pm on gt.PLANT_ID = pm.PlantID
left outer join sp_weighment_detail wt on gt.GATE_SYS_ID = wt.GATE_SYS_ID  
where gt.GATE_SYS_ID=_GATE_SYS_ID AND gt.PLANT_ID=_PLANT_ID AND gt.STATION_ID=_STATION_ID;

/*SELECT 
gt.GATE_SYS_ID, gt.GATE_IN_DT, gt.GATE_OUT_DT, gt.INWARD_SYS_ID, gt.SO_SYS_ID, gt.TRANS_SYS_ID, gt.TRANSPORTER_NAME, gt.TRUCK_NO,
gt.DRIVER_ID_TYPE, gt.DRIVER_ID_NUMBER, gt.DRIVER_NAME, gt.DRIVER_CONTACT, gt.DRIVER_CHANGED, gt.DRIVER_NAME_NEW, gt.DRIVER_CONTACT_NEW,
gt.TRUCK_VALIDATION, gt.RFSYSID, gt.VERIFIED_DOCUMENTS, gt.RFID_RECEIVE, gt.VERIFIED_OFFICER_ID, gt.CANCEL_GATE_IN, gt.CANCEL_GATE_REASON,
gt.GATE_SYS_ID_OLD, gt.IS_GOODS_TRANSFER, gt.STATION_ID, gt.PLANT_ID, gt.Created_BY_ID, gt.Created_DateTime, gt.IS_POSTED, sh.SO_NO,
sh.SO_DATE, sh.CUST_NAME, wt.TARE_WT, wt.TARE_WT_DT, wt.TARE_WT_MANUALLY, wt.GROSS_WT, wt.GROSS_WT_DT, wt.GROSS_WT_MANUALLY, wt.NET_WT,
wt.OUT_OF_TOLERANCE_WT, wt.TOLERANCE_WT, wt.ALLOW_TOLERANCE_WT, wt.WT_SYS_ID, wt.TARE_WT_NOTE, wt.GROSS_WT_NOTE, rfid.RFIDSRNO, pm.Plant_Name,
pm.PlantAddress, vm.ORGANIZATION_NAME as Party, sh.CUST_NAME as Supplier
FROM sp_gate_in_out gt 
inner join rfid_master rfid on gt.RFSYSID = rfid.RFSYSID
inner join so_header sh on gt.SO_SYS_ID = sh.SO_SYS_ID
inner join plant_master as pm on gt.PLANT_ID = pm.PlantID
inner join vendor_master vm on sh.VENSOR_SYS_ID = vm.VENDOR_SYS_ID AND sh.PLANT_ID = vm.PLANT_ID
left outer join sp_weighment_detail wt on gt.GATE_SYS_ID = wt.GATE_SYS_ID  
where gt.GATE_SYS_ID=_GATE_SYS_ID AND gt.PLANT_ID=_PLANT_ID AND gt.STATION_ID=_STATION_ID;*/
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_StateMaster_By_ContryID */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_StateMaster_By_ContryID(IN `_PLANT_ID` INT(11), IN `_COUNTRY_ID` INT(11))
BEGIN
SELECT STATE_ID,
    STATE_NAME,
    COUNTRY_ID,
    PLANT_ID,
    CREATED_BY,
    CREATED_DATETIME
FROM statemaster WHERE COUNTRY_ID=_COUNTRY_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_StateMaster_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_StateMaster_Insert(IN `_STATE_ID` INT(11), IN `_STATE_NAME` VARCHAR(45), IN `_COUNTRY_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_CREATED_BY` INT(11), IN `_CREATED_DATETIME` DATETIME)
BEGIN
INSERT INTO statemaster
(
STATE_ID,
STATE_NAME,
COUNTRY_ID,
PLANT_ID,
CREATED_BY,
CREATED_DATETIME
)
VALUES
(
_STATE_ID,
_STATE_NAME,
_COUNTRY_ID,
_PLANT_ID,
_CREATED_BY,
_CREATED_DATETIME
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_StateMaster_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_StateMaster_Update(IN `_STATE_ID` INT(11), IN `_STATE_NAME` VARCHAR(45), IN `_COUNTRY_ID` INT(11), IN `_PLANT_ID` INT(11))
BEGIN
UPDATE statemaster
SET
STATE_NAME=_STATE_NAME,
COUNTRY_ID=_COUNTRY_ID
WHERE PLANT_ID=_PLANT_ID AND STATE_ID=_STATE_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_StateMaster_View */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_StateMaster_View(IN `_PLANT_ID` INT(11))
BEGIN
SELECT STATE_ID,
    STATE_NAME,
    COUNTRY_ID,
    PLANT_ID,
    CREATED_BY,
    CREATED_DATETIME
FROM statemaster;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_SystemUser_View */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_SystemUser_View(IN `_PLANT_ID` INT(11), IN `_EMP_CODE` VARCHAR(10), IN `_EMP_WORK_STATION_ID` INT(11), IN `_MOBILE_NO` VARCHAR(10), IN `_FIRST_NAME` VARCHAR(50), IN `_LAST_NAME` VARCHAR(50), IN `_IS_LOCK` INT(11), IN `_USER_ID` INT(11))
BEGIN
SELECT USER_ID,
    FIRST_NAME,
    MIDDLE_NAME,
    LAST_NAME,
    MOBILE_NO,
    ALT_MOBILE_NO,
    EMAIL_ID,
    ALT_EMAIL_ID,
    FULL_ADDRESS,
    COUNTRY_ID,
    STATE_ID,
    DISTRICT_ID,
    CITY,
    POSTAL_CODE,
    EMP_CODE,
    EMP_DESIGNATION_ID,
    EMP_WORK_SHIFT_ID,
    EMP_WORK_STATION_ID,
    USER_PASSWORD,
    ROLE_ID,
    IS_ACTIVE,
    IS_LOCK,
    NOTE_FEEDBACK,
    PLANT_ID,
    CREATED_BY,
    CREATED_DATETIME
FROM system_users where PLANT_ID=_PLANT_ID AND (EMP_CODE=_EMP_CODE or EMP_WORK_STATION_ID=_EMP_WORK_STATION_ID 
or MOBILE_NO=_MOBILE_NO or FIRST_NAME=_FIRST_NAME or LAST_NAME=_LAST_NAME or IS_LOCK=_IS_LOCK OR USER_ID=_USER_ID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_System_Users_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_System_Users_Insert(IN `_USER_ID` INT(11), IN `_FIRST_NAME` VARCHAR(45), IN `_MIDDLE_NAME` VARCHAR(45), IN `_LAST_NAME` VARCHAR(45), IN `_MOBILE_NO` VARCHAR(10), IN `_ALT_MOBILE_NO` VARCHAR(10), IN `_EMAIL_ID` VARCHAR(30), IN `_ALT_EMAIL_ID` VARCHAR(30), IN `_FULL_ADDRESS` VARCHAR(200), IN `_COUNTRY_ID` INT(11), IN `_STATE_ID` INT(11), IN `_DISTRICT_ID` INT(11), IN `_CITY` VARCHAR(30), IN `_POSTAL_CODE` VARCHAR(8), IN `_EMP_CODE` VARCHAR(10), IN `_EMP_DESIGNATION_ID` INT(11), IN `_EMP_WORK_SHIFT_ID` INT(11), IN `_EMP_WORK_STATION_ID` INT(11), IN `_USER_PASSWORD` VARCHAR(12), IN `_ROLE_ID` INT(11), IN `_IS_ACTIVE` TINYINT(1), IN `_IS_LOCK` TINYINT(1), IN `_NOTE_FEEDBACK` VARCHAR(100), IN `_PLANT_ID` INT(11), IN `_CREATED_BY` INT(11), IN `_CREATED_DATETIME` DATETIME)
BEGIN
declare mob_duplicate int(11);
declare email_duplicate int(11);
declare emp_code_duplicate int(11);

declare isDuplicate int(11);
set isDuplicate=0;
SELECT COUNT(*) into email_duplicate FROM system_users WHERE EMAIL_ID=_EMAIL_ID AND PLANT_ID=_PLANT_ID;
SELECT COUNT(*) into mob_duplicate FROM system_users WHERE MOBILE_NO=_MOBILE_NO AND PLANT_ID=_PLANT_ID;
SELECT COUNT(*) into emp_code_duplicate FROM system_users WHERE EMP_CODE=_EMP_CODE AND PLANT_ID=_PLANT_ID;
iF(emp_code_duplicate=0 and email_duplicate=0 and mob_duplicate=0) THEN

begin
INSERT INTO system_users
(
FIRST_NAME,
MIDDLE_NAME,
LAST_NAME,
MOBILE_NO,
ALT_MOBILE_NO,
EMAIL_ID,
ALT_EMAIL_ID,
FULL_ADDRESS,
COUNTRY_ID,
STATE_ID,
DISTRICT_ID,
CITY,
POSTAL_CODE,
EMP_CODE,
EMP_DESIGNATION_ID,
EMP_WORK_SHIFT_ID,
EMP_WORK_STATION_ID,
USER_PASSWORD,
ROLE_ID,
IS_ACTIVE,
IS_LOCK,
NOTE_FEEDBACK,
PLANT_ID,
CREATED_BY,
CREATED_DATETIME
)
VALUES
(
_FIRST_NAME,
_MIDDLE_NAME,
_LAST_NAME,
_MOBILE_NO,
_ALT_MOBILE_NO,
_EMAIL_ID,
_ALT_EMAIL_ID,
_FULL_ADDRESS,
_COUNTRY_ID,
_STATE_ID,
_DISTRICT_ID,
_CITY,
_POSTAL_CODE,
_EMP_CODE,
_EMP_DESIGNATION_ID,
_EMP_WORK_SHIFT_ID,
_EMP_WORK_STATION_ID,
_USER_PASSWORD,
_ROLE_ID,
_IS_ACTIVE,
_IS_LOCK,
_NOTE_FEEDBACK,
_PLANT_ID,
_CREATED_BY,
_CREATED_DATETIME
);
set isDuplicate=1;
end;
else
begin
	if(email_duplicate!=0) then
		begin
			set isDuplicate=3;
		end;
	end if;
	if(mob_duplicate!=0) then
		begin
			set isDuplicate=4;
		end;
	end if;
	if(emp_code_duplicate!=0) then
		begin
			set isDuplicate=5;
		end;
	end if;
End;
end if;
select isDuplicate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_System_Users_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_System_Users_Update(IN `_USER_ID` INT(11), IN `_FIRST_NAME` VARCHAR(45), IN `_MIDDLE_NAME` VARCHAR(45), IN `_LAST_NAME` VARCHAR(45), IN `_MOBILE_NO` VARCHAR(10), IN `_ALT_MOBILE_NO` VARCHAR(10), IN `_EMAIL_ID` VARCHAR(30), IN `_ALT_EMAIL_ID` VARCHAR(30), IN `_FULL_ADDRESS` VARCHAR(200), IN `_COUNTRY_ID` INT(11), IN `_STATE_ID` INT(11), IN `_DISTRICT_ID` INT(11), IN `_CITY` VARCHAR(30), IN `_POSTAL_CODE` VARCHAR(8), IN `_EMP_CODE` VARCHAR(10), IN `_EMP_DESIGNATION_ID` INT(11), IN `_EMP_WORK_SHIFT_ID` INT(11), IN `_EMP_WORK_STATION_ID` INT(11), IN `_USER_PASSWORD` VARCHAR(12), IN `_ROLE_ID` INT(11), IN `_IS_ACTIVE` TINYINT(1), IN `_IS_LOCK` TINYINT(1), IN `_NOTE_FEEDBACK` VARCHAR(100), IN `_PLANT_ID` INT(11))
BEGIN
UPDATE system_users
SET
FIRST_NAME=_FIRST_NAME,
MIDDLE_NAME=_MIDDLE_NAME,
LAST_NAME=_LAST_NAME,
MOBILE_NO=_MOBILE_NO,
ALT_MOBILE_NO=_ALT_MOBILE_NO,
EMAIL_ID=_EMAIL_ID,
ALT_EMAIL_ID=_ALT_EMAIL_ID,
FULL_ADDRESS=_FULL_ADDRESS,
COUNTRY_ID=_COUNTRY_ID,
STATE_ID=_STATE_ID,
DISTRICT_ID=_DISTRICT_ID,
CITY=_CITY,
POSTAL_CODE=_POSTAL_CODE,
EMP_CODE=_EMP_CODE,
EMP_DESIGNATION_ID=_EMP_DESIGNATION_ID,
EMP_WORK_SHIFT_ID=_EMP_WORK_SHIFT_ID,
EMP_WORK_STATION_ID=_EMP_WORK_STATION_ID,
USER_PASSWORD=_USER_PASSWORD,
ROLE_ID=_ROLE_ID,
IS_ACTIVE=_IS_ACTIVE,
IS_LOCK=_IS_LOCK,
NOTE_FEEDBACK=_NOTE_FEEDBACK
WHERE PLANT_ID=_PLANT_ID AND USER_ID=_USER_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_transporter_insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_transporter_insert(IN `_tptr_cd` VARCHAR(50), IN `_tptr_name` VARCHAR(50), IN `_IS_ENTRY_MANUAL` TINYINT(1), IN `_PLANT_ID` INT(11), IN `_Created_DateTime` DATETIME)
BEGIN
INSERT INTO transporter_master
(
tptr_cd,
tptr_name,
IS_ENTRY_MANUAL,
PLANT_ID,
Created_DateTime
)
VALUES
(
_tptr_cd,
_tptr_name,
_IS_ENTRY_MANUAL,
_PLANT_ID,
_Created_DateTime
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_user_log_details_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_user_log_details_Insert(IN `_USER_SYS_ID` INT(11), IN `_FORM_NAME` VARCHAR(100), IN `_RECORD_ADD` TINYINT(1), IN `_RECORD_MODIFY` TINYINT(1), IN `_RECORD_DELETE` TINYINT(1), IN `_RECORD_VIEW` TINYINT(1), IN `_REMARK` VARCHAR(1000), IN `_STATION_ID` INT(11), IN `_PLANT_ID` INT(11), IN `_Created_DateTime` DATETIME, IN `_IS_POSTED` TINYINT(1), IN `_LOG_TYPE` VARCHAR(1))
BEGIN
INSERT INTO user_log_details
(
USER_SYS_ID,
FORM_NAME,
RECORD_ADD,
RECORD_MODIFY,
RECORD_DELETE,
RECORD_VIEW,
REMARK,
STATION_ID,
PLANT_ID,
Created_DateTime,
IS_POSTED,
LOG_TYPE
)
VALUES
(
_USER_SYS_ID,
_FORM_NAME,
_RECORD_ADD,
_RECORD_MODIFY,
_RECORD_DELETE,
_RECORD_VIEW,
_REMARK,
_STATION_ID,
_PLANT_ID,
_Created_DateTime,
_IS_POSTED,
_LOG_TYPE
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ValidateMDA */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ValidateMDA(IN `_VEHICLE_NO` VARCHAR(15))
BEGIN
SELECT mda.MDA_SYS_ID, mda.MDA_NO, mdtl.PROD_SYS_ID, mdtl.BAG_NOS mod 24 as BAG_NOS, mdtl.NETT_QTY, mdtl.GROSS_QTY  
    FROM mda_header mda 
    INNER JOIN mda_detail mdtl on mda.MDA_SYS_ID = mdtl.MDA_SYS_ID
    INNER JOIN transporter_master tm on mda.TRANS_SYS_ID=tm.TRANS_SYS_ID
	WHERE mda.VEHICLE_NO=_VEHICLE_NO and mda.OUT_TIME is null and mda.MDA_SYS_ID NOT IN(select MDA_SYS_ID from fg_gate_in_out);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ValidatePallet */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ValidatePallet(IN `_HardwareUID` VARCHAR(45), IN `_ShipperQRCode` VARCHAR(45))
BEGIN
	DECLARE _BeltSysID INT;
    DECLARE _PROD_SYS_ID INT;
    DECLARE _PLANT_ID INT;
    SET _BeltSysID=0;    
    SET _PROD_SYS_ID=0;
    SET _PLANT_ID=0;
    
    SELECT PLANT_ID INTO _PLANT_ID FROM belt_master WHERE HardwareUID=_HardwareUID;
    SELECT BeltSysID INTO _BeltSysID FROM belt_master WHERE HardwareUID=_HardwareUID;
    
    SELECT PROD_SYS_ID INTO _PROD_SYS_ID FROM mda_requisition_data 
	where LOADING_BAY_SYS_ID=(_BeltSysID) and LOADING_PROGRESS='IN PROGRESS' order by SKU_ORDER limit 1;
    
select count(*) as PalletCount from shipper_qrcode sqr 
inner join bottle_qrcode bqr on sqr.shipper_qrcode_sysId = bqr.shipper_qrcode_sysId and sqr.plant_id=bqr.plant_id
inner join pallet_qrcode_api pqr on sqr.pallet_qrcode_api_sysId = pqr.pallet_qrcode_api_sysId and sqr.plant_id=pqr.plant_id
where pqr.pallet_qrcode=_ShipperQRCode and bqr.product_id=_PROD_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_validateQR */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_validateQR(IN `_HardwareUID` VARCHAR(45), IN `_ShipperQRCode` VARCHAR(1000))
BEGIN

 DECLARE StatusCode INT;
 DECLARE _BeltSysID INT;
 DECLARE _PROD_SYS_ID INT;
 DECLARE _PROD_SYS_ID_MASTER INT;
 DECLARE _PLANT_ID INT;
 DECLARE _MDA_REQ_SYS_ID INT;
 DECLARE _MDA_NO VARCHAR(45);
 DECLARE _DateDiff INT;
 DECLARE _GTIN VARCHAR(45);
 DECLARE _MDACurrentBoxSequenceNo INT;
 DECLARE _MDATotalBoxQty INT;
 DECLARE _EXPIRYDAYS INT;
 DECLARE _SuccessCount INT;

 SET StatusCode=0;
 SET _BeltSysID=0; 
 SET _PROD_SYS_ID=0;
 SET _PROD_SYS_ID_MASTER=0;
 SET _PLANT_ID=0;
 SET _MDA_REQ_SYS_ID=0;
 SET _MDA_NO=''; 
 SET _DateDiff=0;
 SET _GTIN='';
 SET _MDACurrentBoxSequenceNo=0;
 SET _MDATotalBoxQty=0;
 SET _EXPIRYDAYS=0;
 SET _SuccessCount=0;

 INSERT INTO kios_api_response
(HARDWARE,ShipperQRCode,BELT_STATUS,API_NAME)
VALUES
(_HardwareUID,_ShipperQRCode,'','validateQR');

 SELECT PLANT_ID INTO _PLANT_ID FROM belt_master WHERE HardwareUID=_HardwareUID;
 SELECT BeltSysID INTO _BeltSysID FROM belt_master WHERE HardwareUID=_HardwareUID;
 SELECT PROD_SYS_ID INTO _PROD_SYS_ID FROM mda_requisition_data 
 where LOADING_BAY_SYS_ID=(_BeltSysID) and Plant_id=_PLANT_ID and LOADING_PROGRESS='IN PROGRESS' order by SKU_ORDER limit 1;
 /*SELECT PROD_SYS_ID INTO _PROD_SYS_ID_MASTER FROM product_master 
 WHERE PLANT_ID=_PLANT_ID AND SUBSTRING(SUBSTRING_INDEX(GTIN,'(',2), 2, 12) in(select SUBSTRING(SUBSTRING_INDEX(_ShipperQRCode,'(',2), 6, 12));*/
 SELECT PROD_SYS_ID INTO _PROD_SYS_ID_MASTER FROM product_master 
 WHERE PLANT_ID=_PLANT_ID AND GTIN LIKE concat('%',(select SUBSTRING(SUBSTRING_INDEX(_ShipperQRCode,'(',2), 6, 12)),'%');
 SELECT MDA_REQ_SYS_ID INTO _MDA_REQ_SYS_ID FROM mda_requisition_data 
 where LOADING_BAY_SYS_ID=(_BeltSysID) and Plant_id=_PLANT_ID and LOADING_PROGRESS='IN PROGRESS' order by SKU_ORDER limit 1; 
SELECT IFNULL(BPEX,'0') INTO _EXPIRYDAYS FROM product_master WHERE PROD_SYS_ID=_PROD_SYS_ID;

 SELECT MDA_NO INTO _MDA_NO FROM mda_requisition_data 
 where LOADING_BAY_SYS_ID=(_BeltSysID) and LOADING_PROGRESS='IN PROGRESS' order by SKU_ORDER limit 1;

 select DATEDIFF(DATE_FORMAT(expiry_date,'%Y-%m-%d'), DATE_FORMAT(CURRENT_DATE(),'%Y-%m-%d')) INTO _DateDiff
 from shipper_qrcode_api where shipper_qrcode_api_sysId in(
 select shipper_qrcode_api_sysId from shipper_qrcode where shipper_qrcode=_ShipperQRCode) limit 1;

	IF(SELECT COUNT(*) FROM qr_code_successlist WHERE QRCODE=_ShipperQRCode and BELT_NO=_BeltSysID and MDA_NO=_MDA_NO)=0 THEN
	BEGIN
		IF(select count(*) as ShipperCount from shipper_qrcode where shipper_qrcode = _ShipperQRCode)>0 THEN
		BEGIN
			IF(_PROD_SYS_ID=_PROD_SYS_ID_MASTER) THEN
			BEGIN
				IF(_DateDiff>=_EXPIRYDAYS) THEN
				BEGIN
						SET StatusCode=1;
						INSERT INTO qr_code_successlist(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO)
						VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO);

						INSERT INTO qr_code_successlist_log(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO)
						VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO); 
                        
                        select COUNT(*) INTO _SuccessCount from qr_code_successlist WHERE PLANT_ID=_PLANT_ID AND BELT_NO=_BeltSysID AND Product_SYS_ID=_PROD_SYS_ID AND MDA_NO=_MDA_NO;

						UPDATE mda_requisition_data SET LOADED_ITEM =_SuccessCount WHERE MDA_REQ_SYS_ID=_MDA_REQ_SYS_ID;
						
						IF(SELECT COUNT(*) FROM mda_requisition_data WHERE MDA_REQ_SYS_ID=_MDA_REQ_SYS_ID AND LOADED_ITEM=CARTON_QTY)=1 THEN
							BEGIN
								UPDATE mda_requisition_data SET LOADING_PROGRESS ='Completed' WHERE MDA_REQ_SYS_ID=_MDA_REQ_SYS_ID;
							END;					
						END IF;
						
						UPDATE belt_master SET ShipperRejectionCountCurrent =0 WHERE BeltSysID=_BeltSysID;
                END;
                ELSE
					BEGIN
						SET StatusCode=5;
						INSERT INTO qr_code_rejectlist(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
						VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO, 'Shipperbox expiry is within a month');

						INSERT INTO qr_code_rejectlist_log(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
						VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO, 'Shipperbox expiry is within a month'); 
						
						UPDATE belt_master SET ShipperRejectionCountCurrent =(ifnull(ShipperRejectionCountCurrent,0)+1) WHERE BeltSysID=_BeltSysID;
					END;
                END IF;	
			END;
			ELSE
				BEGIN
					SET StatusCode=2;
					INSERT INTO qr_code_rejectlist(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
					VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO,'Product In Shipper are different.');
							
					INSERT INTO qr_code_rejectlist_log(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
					VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO,'Product In Shipper are different.');
                    
                    UPDATE belt_master SET ShipperRejectionCountCurrent =(ifnull(ShipperRejectionCountCurrent,0)+1) WHERE BeltSysID=_BeltSysID;
				END;
			END IF; 
		END;
		ELSE
			BEGIN
				SET StatusCode=3;
				INSERT INTO qr_code_rejectlist(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
				VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO,'Shipper not found into system.');
				
				INSERT INTO qr_code_rejectlist_log(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
				VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO,'Shipper not found into system.'); 
                
                UPDATE belt_master SET ShipperRejectionCountCurrent =(ifnull(ShipperRejectionCountCurrent,0)+1) WHERE BeltSysID=_BeltSysID;
			END;
		END IF;
	END; 
	ELSE 
		BEGIN
			SET StatusCode=4;
			INSERT INTO qr_code_rejectlist(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
			VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO, 'Duplicate shipper QR Code');

			INSERT INTO qr_code_rejectlist_log(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
			VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO, 'Duplicate shipper QR Code'); 
            
            UPDATE belt_master SET ShipperRejectionCountCurrent =(ifnull(ShipperRejectionCountCurrent,0)+1) WHERE BeltSysID=_BeltSysID;
			END;
	END IF;
/*SELECT LOADED_ITEM INTO _MDACurrentBoxSequenceNo FROM mda_requisition_data WHERE MDA_REQ_SYS_ID=_MDA_REQ_SYS_ID;*/
select COUNT(*) INTO _SuccessCount from qr_code_successlist WHERE PLANT_ID=_PLANT_ID AND BELT_NO=_BeltSysID AND Product_SYS_ID=_PROD_SYS_ID AND MDA_NO=_MDA_NO;
	SET _MDACurrentBoxSequenceNo = _SuccessCount;
SELECT CARTON_QTY INTO _MDATotalBoxQty FROM mda_requisition_data WHERE MDA_REQ_SYS_ID=_MDA_REQ_SYS_ID;
insert into user_log_details(FORM_NAME,REMARK) values('ValidateQR-Response',concat('MDANo:',_MDA_NO,'StCode:', StatusCode,'CurntMDA:',_MDACurrentBoxSequenceNo,'TotalMDAQty:',_MDATotalBoxQty));
 SELECT StatusCode, _MDACurrentBoxSequenceNo, _MDATotalBoxQty;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_validateQR_old */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_validateQR_old(IN `_HardwareUID` VARCHAR(45), IN `_ShipperQRCode` VARCHAR(1000))
BEGIN

 DECLARE StatusCode INT;
 DECLARE _BeltSysID INT;
 DECLARE _PROD_SYS_ID INT;
 DECLARE _PROD_SYS_ID_MASTER INT;
 DECLARE _PLANT_ID INT;
 DECLARE _MDA_REQ_SYS_ID INT;
 DECLARE _MDA_NO VARCHAR(45);
 DECLARE _DateDiff INT;
 DECLARE _GTIN VARCHAR(45);
 DECLARE _MDACurrentBoxSequenceNo INT;
 DECLARE _MDATotalBoxQty INT;
 DECLARE _EXPIRYDAYS INT;
 DECLARE _SuccessCount INT;

 SET StatusCode=0;
 SET _BeltSysID=0; 
 SET _PROD_SYS_ID=0;
 SET _PROD_SYS_ID_MASTER=0;
 SET _PLANT_ID=0;
 SET _MDA_REQ_SYS_ID=0;
 SET _MDA_NO=''; 
 SET _DateDiff=0;
 SET _GTIN='';
 SET _MDACurrentBoxSequenceNo=0;
 SET _MDATotalBoxQty=0;
 SET _EXPIRYDAYS=0;
 SET _SuccessCount=0;

 INSERT INTO kios_api_response
(HARDWARE,ShipperQRCode,BELT_STATUS,API_NAME)
VALUES
(_HardwareUID,_ShipperQRCode,'','validateQR');

 SELECT PLANT_ID INTO _PLANT_ID FROM belt_master WHERE HardwareUID=_HardwareUID;
 SELECT BeltSysID INTO _BeltSysID FROM belt_master WHERE HardwareUID=_HardwareUID;
 SELECT PROD_SYS_ID INTO _PROD_SYS_ID FROM mda_requisition_data 
 where LOADING_BAY_SYS_ID=(_BeltSysID) and Plant_id=_PLANT_ID and LOADING_PROGRESS='IN PROGRESS' order by SKU_ORDER limit 1;
 /*SELECT PROD_SYS_ID INTO _PROD_SYS_ID_MASTER FROM product_master 
 WHERE PLANT_ID=_PLANT_ID AND SUBSTRING(SUBSTRING_INDEX(GTIN,'(',2), 2, 12) in(select SUBSTRING(SUBSTRING_INDEX(_ShipperQRCode,'(',2), 6, 12));*/
 SELECT PROD_SYS_ID INTO _PROD_SYS_ID_MASTER FROM product_master 
 WHERE PLANT_ID=_PLANT_ID AND GTIN LIKE concat('%',(select SUBSTRING(SUBSTRING_INDEX(_ShipperQRCode,'(',2), 6, 12)),'%');
 SELECT MDA_REQ_SYS_ID INTO _MDA_REQ_SYS_ID FROM mda_requisition_data 
 where LOADING_BAY_SYS_ID=(_BeltSysID) and Plant_id=_PLANT_ID and LOADING_PROGRESS='IN PROGRESS' order by SKU_ORDER limit 1; 
SELECT IFNULL(BPEX,'0') INTO _EXPIRYDAYS FROM product_master WHERE PROD_SYS_ID=_PROD_SYS_ID;

 SELECT MDA_NO INTO _MDA_NO FROM mda_requisition_data 
 where LOADING_BAY_SYS_ID=(_BeltSysID) and LOADING_PROGRESS='IN PROGRESS' order by SKU_ORDER limit 1;

 select DATEDIFF(DATE_FORMAT(expiry_date,'%Y-%m-%d'), DATE_FORMAT(CURRENT_DATE(),'%Y-%m-%d')) INTO _DateDiff
 from shipper_qrcode_api where shipper_qrcode_api_sysId in(
 select shipper_qrcode_api_sysId from shipper_qrcode where shipper_qrcode=_ShipperQRCode) limit 1;

	IF(SELECT COUNT(*) FROM qr_code_successlist WHERE QRCODE=_ShipperQRCode)=0 and 
		(select count(*) from mda_loading where SHIPPER_QR_CODE=_ShipperQRCode and PROD_SYS_ID=_PROD_SYS_ID)=0 THEN
	BEGIN
		IF(select count(*) as ShipperCount from shipper_qrcode where shipper_qrcode = _ShipperQRCode)>0 THEN
		BEGIN
			IF(_PROD_SYS_ID=_PROD_SYS_ID_MASTER) THEN
			BEGIN
				IF(_DateDiff>=_EXPIRYDAYS) THEN
				BEGIN
						SET StatusCode=1;
						INSERT INTO qr_code_successlist(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO)
						VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO);

						INSERT INTO qr_code_successlist_log(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO)
						VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO); 
                        
                        select COUNT(*) INTO _SuccessCount from qr_code_successlist WHERE PLANT_ID=_PLANT_ID AND BELT_NO=_BeltSysID AND Product_SYS_ID=_PROD_SYS_ID AND MDA_NO=_MDA_NO;

						UPDATE mda_requisition_data SET LOADED_ITEM =_SuccessCount WHERE MDA_REQ_SYS_ID=_MDA_REQ_SYS_ID;
						
						IF(SELECT COUNT(*) FROM mda_requisition_data WHERE MDA_REQ_SYS_ID=_MDA_REQ_SYS_ID AND LOADED_ITEM=CARTON_QTY)=1 THEN
							BEGIN
								UPDATE mda_requisition_data SET LOADING_PROGRESS ='Completed' WHERE MDA_REQ_SYS_ID=_MDA_REQ_SYS_ID;
							END;					
						END IF;
						
						UPDATE belt_master SET ShipperRejectionCountCurrent =0 WHERE BeltSysID=_BeltSysID;
                END;
                ELSE
					BEGIN
						SET StatusCode=5;
						INSERT INTO qr_code_rejectlist(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
						VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO, 'Shipperbox expiry is within a month');

						INSERT INTO qr_code_rejectlist_log(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
						VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO, 'Shipperbox expiry is within a month'); 
						
						UPDATE belt_master SET ShipperRejectionCountCurrent =(ifnull(ShipperRejectionCountCurrent,0)+1) WHERE BeltSysID=_BeltSysID;
					END;
                END IF;	
			END;
			ELSE
				BEGIN
					SET StatusCode=2;
					INSERT INTO qr_code_rejectlist(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
					VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO,'Product In Shipper are different.');
							
					INSERT INTO qr_code_rejectlist_log(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
					VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO,'Product In Shipper are different.');
                    
                    UPDATE belt_master SET ShipperRejectionCountCurrent =(ifnull(ShipperRejectionCountCurrent,0)+1) WHERE BeltSysID=_BeltSysID;
				END;
			END IF; 
		END;
		ELSE
			BEGIN
				SET StatusCode=3;
				INSERT INTO qr_code_rejectlist(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
				VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO,'Shipper not found into system.');
				
				INSERT INTO qr_code_rejectlist_log(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
				VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO,'Shipper not found into system.'); 
                
                UPDATE belt_master SET ShipperRejectionCountCurrent =(ifnull(ShipperRejectionCountCurrent,0)+1) WHERE BeltSysID=_BeltSysID;
			END;
		END IF;
	END; 
	ELSE 
		BEGIN
			SET StatusCode=4;
			INSERT INTO qr_code_rejectlist(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
			VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO, 'Duplicate shipper QR Code');

			INSERT INTO qr_code_rejectlist_log(PLANT_ID, BELT_NO, QRCODE, Product_SYS_ID, MDA_NO, REJECT_REASON)
			VALUES(_PLANT_ID, _BeltSysID, _ShipperQRCode, _PROD_SYS_ID, _MDA_NO, 'Duplicate shipper QR Code'); 
            
            UPDATE belt_master SET ShipperRejectionCountCurrent =(ifnull(ShipperRejectionCountCurrent,0)+1) WHERE BeltSysID=_BeltSysID;
			END;
	END IF;
/*SELECT LOADED_ITEM INTO _MDACurrentBoxSequenceNo FROM mda_requisition_data WHERE MDA_REQ_SYS_ID=_MDA_REQ_SYS_ID;*/
select COUNT(*) INTO _SuccessCount from qr_code_successlist WHERE PLANT_ID=_PLANT_ID AND BELT_NO=_BeltSysID AND Product_SYS_ID=_PROD_SYS_ID AND MDA_NO=_MDA_NO;
	SET _MDACurrentBoxSequenceNo = _SuccessCount;
SELECT CARTON_QTY INTO _MDATotalBoxQty FROM mda_requisition_data WHERE MDA_REQ_SYS_ID=_MDA_REQ_SYS_ID;
insert into user_log_details(FORM_NAME,REMARK) values('ValidateQR-Response',concat('MDANo:',_MDA_NO,'StCode:', StatusCode,'CurntMDA:',_MDACurrentBoxSequenceNo,'TotalMDAQty:',_MDATotalBoxQty));
 SELECT StatusCode, _MDACurrentBoxSequenceNo, _MDATotalBoxQty;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ValidateShipper */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ValidateShipper(IN `_shipper_qrcode` VARCHAR(50), IN `_product_id` INT(11))
BEGIN
select count(*) as ShipperCount from shipper_qrcode sqr 
inner join bottle_qrcode bqr on sqr.shipper_qrcode_sysId = bqr.shipper_qrcode_sysId and sqr.plant_id=bqr.plant_id
where sqr.shipper_qrcode=_shipper_qrcode and bqr.product_id=_product_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Vendor_Master_Insert */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Vendor_Master_Insert(IN `_PLANT_ID` INT, IN `_VENDOR_CODE` INT, IN `_ORGANIZATION_NAME` VARCHAR(150), IN `_VENDOR_SITE` VARCHAR(50), IN `_FIRST_NAME` VARCHAR(20), IN `_MIDDLE_NAME` VARCHAR(20), IN `_LAST_NAME` VARCHAR(20), IN `_PRIMARY_MOBILE` VARCHAR(10), IN `_ALTERNATIVE_MOBILE` VARCHAR(10), IN `_PRIMARY_EMAIL` VARCHAR(45), IN `_ALTERNATIVE_EMAIL` VARCHAR(45), IN `_PHONE_NUMBER` VARCHAR(15), IN `_COUNTRY_ID` INT, IN `_STATE_ID` INT, IN `_DISTRICT_ID` INT, IN `_ADDRESS` VARCHAR(100), IN `_CITY` VARCHAR(45), IN `_IS_SYSTEM_USER` TINYINT, IN `_PASSWORD` VARCHAR(100), IN `_ACTIVE` TINYINT, IN `_USER_LOCK` TINYINT, IN `_Created_DateTime` DATETIME, IN `_IS_POSTED` TINYINT, IN `_VENDOR_TYPE` VARCHAR(1), IN `_PRINT_LABEL_QTY` INT, IN `_Role_Id` INT(11))
BEGIN
declare mob_duplicate int(11);
declare email_duplicate int(11);
declare emp_code_duplicate int(11);

declare isDuplicate int(11);
set isDuplicate=0;
SELECT COUNT(*) into email_duplicate FROM vendor_master WHERE PRIMARY_EMAIL=_PRIMARY_EMAIL AND PLANT_ID=_PLANT_ID;
SELECT COUNT(*) into mob_duplicate FROM vendor_master WHERE PRIMARY_MOBILE=_PRIMARY_MOBILE AND PLANT_ID=_PLANT_ID;
SELECT COUNT(*) into emp_code_duplicate FROM vendor_master WHERE VENDOR_CODE=_VENDOR_CODE AND PLANT_ID=_PLANT_ID;
iF(emp_code_duplicate=0 and email_duplicate=0 and mob_duplicate=0) THEN

begin
INSERT INTO vendor_master 
(
PLANT_ID,  
VENDOR_CODE, 
ORGANIZATION_NAME, 
VENDOR_SITE, 
FIRST_NAME, 
MIDDLE_NAME, 
LAST_NAME, 
PRIMARY_MOBILE, 
ALTERNATIVE_MOBILE, 
PRIMARY_EMAIL, 
ALTERNATIVE_EMAIL, 
PHONE_NUMBER, 
COUNTRY_ID, 
STATE_ID,
DISTRICT_ID, 
ADDRESS, 
CITY,
IS_SYSTEM_USER, 
PASSWORD, 
ACTIVE, 
USER_LOCK, 
Created_DateTime, 
IS_POSTED,
VENDOR_TYPE,
PRINT_LABEL_QTY,
Role_Id
)
values
(
_PLANT_ID, 
_VENDOR_CODE, 
_ORGANIZATION_NAME, 
_VENDOR_SITE, 
_FIRST_NAME, 
_MIDDLE_NAME, 
_LAST_NAME, 
_PRIMARY_MOBILE, 
_ALTERNATIVE_MOBILE, 
_PRIMARY_EMAIL, 
_ALTERNATIVE_EMAIL, 
_PHONE_NUMBER, 
_COUNTRY_ID, 
_STATE_ID,
_DISTRICT_ID, 
_ADDRESS, 
_CITY,
_IS_SYSTEM_USER, 
_PASSWORD, 
_ACTIVE, 
_USER_LOCK, 
_Created_DateTime, 
_IS_POSTED,
_VENDOR_TYPE,
_PRINT_LABEL_QTY,
_Role_Id
);
set isDuplicate=1;
end;
else
begin
	if(email_duplicate!=0) then
		begin
			set isDuplicate=3;
		end;
	end if;
	if(mob_duplicate!=0) then
		begin
			set isDuplicate=4;
		end;
	end if;
	if(emp_code_duplicate!=0) then
		begin
			set isDuplicate=5;
		end;
	end if;
End;
end if;
select isDuplicate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Vendor_Master_Search */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Vendor_Master_Search(IN `_PLANT_ID` INT(11), IN `_VENDOR_CODE` INT(11), IN `_ORGANIZATION_NAME` VARCHAR(150))
BEGIN
SELECT VENDOR_SYS_ID,
    VENDOR_CODE,
    ORGANIZATION_NAME,
    VENDOR_SITE,
    FIRST_NAME,
    MIDDLE_NAME,
    LAST_NAME,
    PRIMARY_MOBILE,
    ALTERNATIVE_MOBILE,
    PRIMARY_EMAIL,
    ALTERNATIVE_EMAIL,
    PHONE_NUMBER,
    COUNTRY_ID,
    STATE_ID,
    DISTRICT_ID,
    CITY,
    ADDRESS,
    IS_SYSTEM_USER,
    PASSWORD,
    ACTIVE,
    USER_LOCK,
    Created_DateTime,
    IS_POSTED,
    VENDOR_TYPE,
    VENDOR_CODE_TEMP,
    PRINT_LABEL_QTY
FROM vendor_master WHERE PLANT_ID=_PLANT_ID AND (VENDOR_CODE=_VENDOR_CODE OR ORGANIZATION_NAME= _ORGANIZATION_NAME);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Vendor_Master_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Vendor_Master_Update(IN `_PLANT_ID` INT, IN `_VENDOR_SYS_ID` INT, IN `_VENDOR_CODE` INT, IN `_ORGANIZATION_NAME` VARCHAR(150), IN `_VENDOR_SITE` VARCHAR(50), IN `_FIRST_NAME` VARCHAR(20), IN `_MIDDLE_NAME` VARCHAR(20), IN `_LAST_NAME` VARCHAR(20), IN `_PRIMARY_MOBILE` VARCHAR(10), IN `_ALTERNATIVE_MOBILE` VARCHAR(10), IN `_PRIMARY_EMAIL` VARCHAR(45), IN `_ALTERNATIVE_EMAIL` VARCHAR(45), IN `_PHONE_NUMBER` VARCHAR(15), IN `_COUNTRY_ID` INT, IN `_STATE_ID` INT, IN `_DISTRICT_ID` INT, IN `_ADDRESS` VARCHAR(100), IN `_CITY` VARCHAR(45), IN `_IS_SYSTEM_USER` TINYINT, IN `_PASSWORD` VARCHAR(100), IN `_ACTIVE` TINYINT, IN `_USER_LOCK` TINYINT, IN `_Created_DateTime` DATETIME, IN `_IS_POSTED` TINYINT, IN `_VENDOR_TYPE` VARCHAR(1), IN `_PRINT_LABEL_QTY` INT)
BEGIN
UPDATE vendor_master
SET
VENDOR_CODE =_VENDOR_CODE ,
ORGANIZATION_NAME =_ORGANIZATION_NAME ,
VENDOR_SITE =_VENDOR_SITE ,
FIRST_NAME =_FIRST_NAME ,
MIDDLE_NAME =_MIDDLE_NAME ,
LAST_NAME =_LAST_NAME ,
PRIMARY_MOBILE =_PRIMARY_MOBILE ,
ALTERNATIVE_MOBILE =_ALTERNATIVE_MOBILE ,
PRIMARY_EMAIL =_PRIMARY_EMAIL ,
ALTERNATIVE_EMAIL =_ALTERNATIVE_EMAIL ,
PHONE_NUMBER =_PHONE_NUMBER ,
COUNTRY_ID =_COUNTRY_ID ,
STATE_ID =_STATE_ID ,
DISTRICT_ID=_DISTRICT_ID ,
ADDRESS =_ADDRESS ,
CITY=_CITY,
IS_SYSTEM_USER =_IS_SYSTEM_USER ,
PASSWORD =_PASSWORD ,
ACTIVE =_ACTIVE ,
USER_LOCK =_USER_LOCK ,
Created_DateTime =_Created_DateTime ,
IS_POSTED=_IS_POSTED,
VENDOR_TYPE=_VENDOR_TYPE,
PRINT_LABEL_QTY=_PRINT_LABEL_QTY
WHERE PLANT_ID =_PLANT_ID AND VENDOR_SYS_ID =_VENDOR_SYS_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewMDA */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewMDA()
BEGIN
/*
SELECT MDA_SYS_ID, MDA_NO, DI_NO, PLANT_CD, MDA_DT, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO, MOBILE_NO, DIST, BAG_NOS, NETT_QTY,
    GROSS_QTY, ECHIT_NO, GST_NO, OUT_TIME, PLANT_ID, Created_DateTime FROM mda_header;
*/
SELECT MDA_SYS_ID, MDA_NO, DI_NO, PLANT_CD, MDA_DT, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO, MOBILE_NO, DIST, BAG_NOS, NETT_QTY,
    GROSS_QTY, ECHIT_NO, GST_NO, OUT_TIME, PLANT_ID, Created_DateTime FROM mda_header
    WHERE OUT_TIME is null and MDA_SYS_ID NOT IN(select MDA_SYS_ID from fg_gate_in_out);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewMDA_By_MDA_No */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewMDA_By_MDA_No(IN `_MDA_NO` VARCHAR(15))
BEGIN
SELECT mda.MDA_SYS_ID, mda.MDA_NO, mda.DI_NO, mda.PLANT_CD, mda.MDA_DT, mda.TRANS_SYS_ID, mda.WH_CD, mda.PARTY_NAME, mda.DRIVER, mda.VEHICLE_NO, mda.MOBILE_NO, mda.DIST, mda.BAG_NOS, mda.NETT_QTY,
    mda.GROSS_QTY, mda.ECHIT_NO, mda.GST_NO, mda.OUT_TIME, mda.PLANT_ID, mda.Created_DateTime, tm.tptr_name 
    FROM mda_header mda 
    INNER JOIN transporter_master tm on mda.TRANS_SYS_ID=tm.TRANS_SYS_ID WHERE mda.MDA_NO=_MDA_NO and mda.OUT_TIME is null 
    and mda.MDA_SYS_ID NOT IN(select MDA_SYS_ID from fg_gate_in_out);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewMDA_By_Truck_No */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewMDA_By_Truck_No(IN `_VEHICLE_NO` VARCHAR(15))
BEGIN
SELECT mda.MDA_SYS_ID, mda.MDA_NO, mda.DI_NO, mda.PLANT_CD, mda.MDA_DT, mda.TRANS_SYS_ID, mda.WH_CD, mda.PARTY_NAME, mda.DRIVER, mda.VEHICLE_NO, mda.MOBILE_NO, mda.DIST, mda.BAG_NOS, mda.NETT_QTY,
    mda.GROSS_QTY, mda.ECHIT_NO, mda.GST_NO, mda.OUT_TIME, mda.PLANT_ID, mda.Created_DateTime, tm.tptr_name  
    FROM mda_header mda 
    INNER JOIN transporter_master tm on mda.TRANS_SYS_ID=tm.TRANS_SYS_ID
	WHERE mda.VEHICLE_NO=_VEHICLE_NO and mda.OUT_TIME is null and mda.MDA_SYS_ID NOT IN(select MDA_SYS_ID from fg_gate_in_out);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewMDA_By_Truck_No_st6 */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewMDA_By_Truck_No_st6(IN `_VEHICLE_NO` VARCHAR(15))
BEGIN
SELECT mda.MDA_SYS_ID, mda.MDA_NO, mda.DI_NO, mda.PLANT_CD, mda.MDA_DT, mda.TRANS_SYS_ID, mda.WH_CD, mda.PARTY_NAME, mda.DRIVER, mda.VEHICLE_NO, mda.MOBILE_NO, mda.DIST, mda.BAG_NOS, mda.NETT_QTY,
    mda.GROSS_QTY, mda.ECHIT_NO, mda.GST_NO, mda.OUT_TIME, mda.PLANT_ID, mda.Created_DateTime, tm.tptr_name,mds.MDA_STATUS  
    FROM mda_header mda 
    INNER JOIN transporter_master tm on mda.TRANS_SYS_ID=tm.TRANS_SYS_ID 
    LEFT OUTER JOIN mda_sequence mds on mda.MDA_SYS_ID=mds.MDA_SYS_ID and mda.PLANT_ID=mds.PLANT_ID
	WHERE mda.VEHICLE_NO=_VEHICLE_NO and mda.OUT_TIME is null order by mda.DIST desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewMDA_Hdr */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewMDA_Hdr()
BEGIN
SELECT MDA_SYS_ID, MDA_NO, DI_NO, PLANT_CD, MDA_DT, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO, MOBILE_NO, DIST, BAG_NOS, NETT_QTY,
    GROSS_QTY, ECHIT_NO, GST_NO, OUT_TIME, PLANT_ID, Created_DateTime FROM mda_header
    where OUT_TIME is null and MDA_SYS_ID NOT IN(select MDA_SYS_ID from fg_gate_in_out);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewPO */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewPO()
BEGIN
SELECT ph.PO_SYS_ID,
    ph.PO_NO,
    ph.PO_DATE,
    ph.VENDOR_SYS_ID,
    vm.ORGANIZATION_NAME,
    vm.VENDOR_CODE,
    ph.COST_CENTER,
    ph.PO_DESCCRIPTION,
    null as TRANS_SYS_ID,
    '' as tptr_name,
    ph.TRUCK_NO,
    ph.IS_PO_MANUAL,
    ph.STATION_ID,
    ph.PLANT_ID,
    ph.Created_BY_ID,
    ph.Created_DateTime
FROM po_header ph 
inner join vendor_master vm on ph.VENDOR_SYS_ID=vm.VENDOR_SYS_ID
where ph.PO_SYS_ID NOT IN(select PO_SYS_ID from rm_gate_in_out);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewPO_By_No */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewPO_By_No(IN `_PO_NO` VARCHAR(15))
BEGIN
select h.PO_NO, h.PO_DATE, m.VENDOR_CODE, m.FIRST_NAME, m.MIDDLE_NAME, m.LAST_NAME, m.VENDOR_SITE, 
h.COST_CENTER, h.PO_DESCCRIPTION, rm.TRANSPORTER_NAME as tptr_name, rm.TRUCK_NO, d.PO_LINE_NO, d.LINE_DESC, d.LINE_QTY, d.UMO
from po_header as h 
inner join po_detail as d on h.PO_SYS_ID = d.PO_SYS_ID
inner join vendor_master as m on m.VENDOR_SYS_ID = h.VENDOR_SYS_ID 
inner join rm_gate_in_out as rm on h.PO_SYS_ID = rm.PO_SYS_ID
where h.PO_NO=_PO_NO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewPO_By_PO_No */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewPO_By_PO_No(IN `_PO_NO` VARCHAR(15))
BEGIN
SELECT ph.PO_SYS_ID,
    ph.PO_NO,
    ph.PO_DATE,
    ph.VENDOR_SYS_ID,
    vm.ORGANIZATION_NAME,
    vm.VENDOR_CODE,
    ph.COST_CENTER,
    ph.PO_DESCCRIPTION,    
    ph.TRUCK_NO,
    ph.IS_PO_MANUAL,
    ph.STATION_ID,
    ph.PLANT_ID,
    ph.Created_BY_ID,
    ph.Created_DateTime
FROM po_header ph 
inner join vendor_master vm on ph.VENDOR_SYS_ID=vm.VENDOR_SYS_ID
 where ph.PO_NO=_PO_NO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewPO_By_Truck_No */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewPO_By_Truck_No(IN `_TRUCK_NO` VARCHAR(10))
BEGIN
SELECT ph.PO_SYS_ID,
    ph.PO_NO,
    ph.PO_DATE,
    ph.VENDOR_SYS_ID,
    vm.ORGANIZATION_NAME,
    vm.VENDOR_CODE,
    ph.COST_CENTER,
    ph.PO_DESCCRIPTION,
    ph.TRANS_SYS_ID,
    tm.tptr_name,
    ph.TRUCK_NO,
    ph.IS_PO_MANUAL,
    ph.STATION_ID,
    ph.PLANT_ID,
    ph.Created_BY_ID,
    ph.Created_DateTime
FROM po_header ph 
inner join vendor_master vm on ph.VENDOR_SYS_ID=vm.VENDOR_SYS_ID
inner join transporter_master tm on ph.TRANS_SYS_ID=tm.TRANS_SYS_ID
 where ph.TRUCK_NO=_TRUCK_NO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewSO */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewSO()
BEGIN
SELECT SO_SYS_ID, UNIT_CODE, SO_NO, SO_DATE, SO_RELEASE_DATE, SO_VALID_DATE, SEQUENCE_NO, TENDER_NO, TENDER_DATE, VENSOR_SYS_ID,
    CUST_CD, CUST_NAME, CUST_SITE_CD, SITE_NAME, ADD1, ADD2, ADD3, CITY, PIN, STATE, STATE_CD, GSTN_NO, PAN_NO, CUST_NON_GST,
    TEL_NO, SO_REMARKS, STATUS, STATUS_DATE, STATUS_REMARKS, EMD_AMT, TERMS_PRICE, TERMS_PYMT_TERM, TERMS_LIFTING_PERIOD_DAYS,
    TENDER_TYPE, AMEND_NO, AMEND_RELEASE_DATE, Created_DateTime
    FROM so_header where SO_SYS_ID NOT IN(SELECT SO_SYS_ID FROM sp_gate_in_out);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewSO_By_No */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewSO_By_No(IN `_SO_NO` VARCHAR(15))
BEGIN
select * from so_header as h inner join so_detail as d on h.SO_SYS_ID = d.SO_SYS_ID
where h.SO_NO=_SO_NO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewSO_By_SO_No */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewSO_By_SO_No(IN `_SO_NO` INT(11))
BEGIN
SELECT SO_SYS_ID,
    UNIT_CODE,
    SO_NO,
    SO_DATE,
    SO_RELEASE_DATE,
    SO_VALID_DATE,
    SEQUENCE_NO,
    TENDER_NO,
    TENDER_DATE,
    VENSOR_SYS_ID,
    CUST_CD,
    CUST_NAME,
    CUST_SITE_CD,
    SITE_NAME,
    ADD1,
    ADD2,
    ADD3,
    CITY,
    PIN,
    STATE,
    STATE_CD,
    GSTN_NO,
    PAN_NO,
    CUST_NON_GST,
    TEL_NO,
    SO_REMARKS,
    STATUS,
    STATUS_DATE,
    STATUS_REMARKS,
    EMD_AMT,
    TERMS_PRICE,
    TERMS_PYMT_TERM,
    TERMS_LIFTING_PERIOD_DAYS,
    TENDER_TYPE,
    AMEND_NO,
    AMEND_RELEASE_DATE,
    Created_DateTime
FROM so_header where SO_NO=_SO_NO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_ViewTruckList */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_ViewTruckList()
BEGIN
SELECT
    TRUCK_NO,
    tptr_name
FROM fg_gate_in_out inner join transporter_master inner join mda_header
on fg_gate_in_out.MDA_SYS_ID = mda_header.MDA_SYS_ID and mda_header.TRANS_SYS_ID = transporter_master.TRANS_SYS_ID
where GATE_OUT_DT = null ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_WMS_Response_Update */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_WMS_Response_Update(IN `_MDA_ADD_SYS_ID` INT(11), IN `_GATE_SYS_ID` INT(11), IN `_MDA_SYS_ID` INT(11), IN `_PROD_SYS_ID` INT(11), IN `_REQUEST_STATUS` VARCHAR(10), IN `_RESPONSE_MSG` VARCHAR(30))
BEGIN
UPDATE mda_add_qty_request
set

REQUEST_STATUS = _REQUEST_STATUS,
RESPONSE_MSG = _RESPONSE_MSG

where MDA_ADD_SYS_ID = _MDA_ADD_SYS_ID and GATE_SYS_ID = _GATE_SYS_ID and MDA_SYS_ID = _MDA_SYS_ID and PROD_SYS_ID = _PROD_SYS_ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Work_Shift_View */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Work_Shift_View(IN `_PLANT_ID` INT(11))
BEGIN
SELECT SHIFT_SYS_ID,
    SHIFT_NAME,
    PLANT_ID,
    CREATED_BY,
    CREATED_DATETIME
FROM work_shift_master WHERE PLANT_ID=_PLANT_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS SP_Work_Station_View */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE SP_Work_Station_View(IN `_PLANT_ID` INT(11))
BEGIN
SELECT WS_SYS_ID,
    WS_NAME,
    PLANT_ID,
    CREATED_BY,
    CREATED_DATETIME
FROM work_station_master;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS sync_log_details_by_batchno */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE sync_log_details_by_batchno(
_PLANT_ID INT(11),
_LOG_DESC varchar(500)
)
BEGIN
select * from sync_log_details_plant where PLANT_ID=_PLANT_ID and LOG_DESC like _LOG_DESC order by id desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
