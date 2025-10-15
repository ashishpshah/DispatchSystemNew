-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 10.23.91.13    Database: iffco
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `batch_master`
--

DROP TABLE IF EXISTS `batch_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batch_master` (
  `Serial_No` int NOT NULL,
  `Batch_No` varchar(100) NOT NULL,
  `Mfg_Date` datetime DEFAULT NULL,
  `Plant_Code` varchar(45) DEFAULT NULL,
  `Product_Code` varchar(45) DEFAULT NULL,
  `Current_Year` int DEFAULT NULL,
  `Julian_Day` int DEFAULT NULL,
  PRIMARY KEY (`Serial_No`,`Batch_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exp_fg_gate_in_out`
--

DROP TABLE IF EXISTS `exp_fg_gate_in_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exp_fg_gate_in_out` (
  `GATE_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_IN_DT` datetime DEFAULT NULL,
  `GATE_OUT_DT` datetime DEFAULT NULL,
  `INWARD_SYS_ID` int DEFAULT NULL,
  `MDA_SYS_ID` int DEFAULT NULL,
  `TRUCK_NO` varchar(10) DEFAULT NULL,
  `DRIVER_ID_TYPE` varchar(20) DEFAULT NULL,
  `DRIVER_ID_NUMBER` varchar(30) DEFAULT NULL,
  `DRIVER_NAME` varchar(100) DEFAULT NULL,
  `DRIVER_CONTACT` varchar(50) DEFAULT NULL,
  `DRIVER_CHANGED` tinyint(1) DEFAULT NULL,
  `DRIVER_NAME_NEW` varchar(100) DEFAULT NULL,
  `DRIVER_CONTACT_NEW` varchar(50) DEFAULT NULL,
  `TRUCK_VALIDATION` tinyint(1) DEFAULT NULL,
  `EXPECTED_QTY` int DEFAULT NULL,
  `TRANS_SYS_ID` int DEFAULT NULL,
  `RFSYSID` int DEFAULT NULL,
  `VERIFIED_DOCUMENTS` tinyint(1) DEFAULT NULL,
  `RFID_RECEIVE` tinyint(1) DEFAULT NULL,
  `VERIFIED_OFFICER_ID` varchar(50) DEFAULT NULL,
  `CANCEL_GATE_IN` tinyint(1) DEFAULT NULL,
  `CANCEL_GATE_REASON` varchar(500) DEFAULT NULL,
  `GATE_SYS_ID_OLD` int DEFAULT NULL,
  `IS_GOODS_TRANSFER` tinyint(1) DEFAULT NULL,
  `STATION_ID` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`GATE_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exp_fg_weighment_detail`
--

DROP TABLE IF EXISTS `exp_fg_weighment_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exp_fg_weighment_detail` (
  `WT_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_SYS_ID` int DEFAULT NULL,
  `GROSS_WT` double DEFAULT NULL,
  `GROSS_WT_DT` datetime DEFAULT NULL,
  `GROSS_WT_MANUALLY` tinyint(1) DEFAULT NULL,
  `GROSS_WT_NOTE` varchar(50) DEFAULT NULL,
  `TARE_WT` double DEFAULT NULL,
  `TARE_WT_DT` datetime DEFAULT NULL,
  `TARE_WT_MANUALLY` tinyint(1) DEFAULT NULL,
  `TARE_WT_NOTE` varchar(50) DEFAULT NULL,
  `NET_WT` double DEFAULT NULL,
  `OUT_OF_TOLERANCE_WT` tinyint(1) DEFAULT NULL,
  `TOLERANCE_WT` double DEFAULT NULL,
  `ALLOW_TOLERANCE_WT` tinyint(1) DEFAULT NULL,
  `STATION_ID` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`WT_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=457 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exp_mda_pallate_loading`
--

DROP TABLE IF EXISTS `exp_mda_pallate_loading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exp_mda_pallate_loading` (
  `MDA_LOD_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_SYS_ID` int DEFAULT NULL,
  `MDA_SYS_ID` int DEFAULT NULL,
  `Pallate_Id` int DEFAULT NULL,
  `PROD_SYS_ID` int DEFAULT NULL,
  `DI_NO` varchar(45) DEFAULT NULL,
  `PALLATE_NO` varchar(50) DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  PRIMARY KEY (`MDA_LOD_SYS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exp_mda_sequence`
--

DROP TABLE IF EXISTS `exp_mda_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exp_mda_sequence` (
  `MDA_Seq_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_SYS_ID` int DEFAULT NULL,
  `MDA_SYS_ID` int DEFAULT NULL,
  `MDA_Sequence_No` int DEFAULT NULL,
  `MDA_STATUS` varchar(15) DEFAULT NULL,
  `MDA_REASON` varchar(50) DEFAULT NULL,
  `MDA_REMARK` varchar(50) DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  `MDA_STATUS_DATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`MDA_Seq_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=620 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pallate_master`
--

DROP TABLE IF EXISTS `pallate_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pallate_master` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Pallate_No` varchar(45) NOT NULL,
  `Pallate_Type` varchar(45) NOT NULL,
  `Shipper_Qty` int DEFAULT NULL,
  `Dispatch_Mode` varchar(45) DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `PLANT_ID` int DEFAULT NULL,
  `DI_No` varchar(100) DEFAULT NULL,
  `CREATED_BY` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pallate_shipper`
--

DROP TABLE IF EXISTS `pallate_shipper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pallate_shipper` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Pallate_Id` int NOT NULL,
  `Shipper_QR_Code` varchar(45) NOT NULL,
  `DI_No` varchar(45) NOT NULL,
  `Status` varchar(1) NOT NULL,
  `Reason` varchar(100) NOT NULL,
  `CREATED_DATETIME` datetime DEFAULT CURRENT_TIMESTAMP,
  `CREATED_BY` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'iffco'
--
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_GATE_IN_CANCEL_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_GATE_IN_CANCEL_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
)
BEGIN
WITH TBL_GATE_IN_MDA AS (SELECT X.PLANT_ID, X.GATE_SYS_ID, X.TRUCK_NO VEHICLE_NO, X.MDA_SYS_ID, Z.MDA_NO
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER
        , IF(X.DRIVER_CHANGED = 1, X.DRIVER_NAME_NEW, X.DRIVER_NAME) AS DRIVER_NAME
        , IF(X.DRIVER_CHANGED = 1, X.DRIVER_CONTACT_NEW, X.DRIVER_CONTACT) AS DRIVER_CONTACT, X.DRIVER_CHANGED
		, Z.PLANT_CD, X.TRANS_SYS_ID, Z.WH_CD, Z.PARTY_NAME, Z.DIST, Z.DESP_PLACE
        , X.VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID, IFNULL(EXPECTED_QTY, 0) Expected_Shipper
		FROM exp_fg_gate_in_out X
		INNER JOIN mda_header Z ON X.PLANT_ID = Z.PLANT_ID AND Z.MDA_SYS_ID = X.MDA_SYS_ID
		WHERE X.GATE_OUT_DT IS NULL AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND Z.OUT_TIME IS NULL 
        AND IF(TRIM(IFNULL(P_SEARCHTERM,'')) = '', TRUE, 
				(X.TRUCK_NO = TRIM(IFNULL(P_SEARCHTERM,'')) OR Z.MDA_NO = TRIM(IFNULL(P_SEARCHTERM,'')) 
					OR X.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' 
									AND (ZX.RFIDSRNO = TRIM(IFNULL(P_SEARCHTERM,'')) OR ZX.RFIDCODE = TRIM(IFNULL(P_SEARCHTERM,''))))
				))
		-- AND 0 < (SELECT COUNT(*) FROM exp_fg_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0 AND XZ.GROSS_WT_DT IS NOT NULL)
		ORDER BY X.GATE_IN_DT DESC
)
, TBL_RESULT AS (
SELECT X.PLANT_ID, GATE_SYS_ID, VEHICLE_NO, X.MDA_SYS_ID, X.MDA_NO, GATE_IN_DT, GATE_OUT_DT
				, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME
                , DIST, DESP_PLACE, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
                , Expected_Shipper, ZZ.PROD_SYS_ID
                , (SELECT COUNT(*) FROM exp_mda_pallate_loading eml WHERE eml.MDA_SYS_ID = X.MDA_SYS_ID AND eml.GATE_SYS_ID = X.GATE_SYS_ID ) Loaded_Shipper
		FROM TBL_GATE_IN_MDA X
		LEFT JOIN mda_detail ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.MDA_SYS_ID = X.MDA_SYS_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY GATE_IN_DT DESC, GATE_SYS_ID DESC)) AS SR_NO
, X.PLANT_ID, X.GATE_SYS_ID, MDA_SYS_ID, VEHICLE_NO, MDA_NO, Expected_Shipper, Loaded_Shipper
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
    , DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
	, X.PLANT_CD, X.TRANS_SYS_ID, TM.TPTR_NAME AS TRANS_NAME, X.PROD_SYS_ID, WH_CD, PARTY_NAME
    , DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
    , DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, ZZ.WT_SYS_ID, ZZ.TARE_WT WEIGH_IN_WT, ZZ.TARE_WT_NOTE WEIGH_IN_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS WEIGH_IN_WT_DT
, ZZ.GROSS_WT WEIGH_OUT_WT, ZZ.GROSS_WT_NOTE WEIGH_OUT_WT_NOTE, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS WEIGH_OUT_WT_DT, ZZ.NET_WT
FROM TBL_RESULT X
INNER JOIN EXP_FG_WEIGHMENT_DETAIL ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.GATE_SYS_ID = X.GATE_SYS_ID
LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = X.PLANT_ID AND TM.TRANS_SYS_ID = X.TRANS_SYS_ID
LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = X.PLANT_ID AND PM.PROD_SYS_ID = X.PROD_SYS_ID
GROUP BY X.PLANT_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, VEHICLE_NO, MDA_NO, Expected_Shipper, Loaded_Shipper, GATE_IN_DT, GATE_OUT_DT, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, X.PLANT_CD, X.TRANS_SYS_ID, X.PROD_SYS_ID, WH_CD, PARTY_NAME, ZZ.WT_SYS_ID, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, ZZ.TARE_WT_DT, ZZ.GROSS_WT, ZZ.GROSS_WT_NOTE, ZZ.GROSS_WT_DT, ZZ.NET_WT
ORDER BY PLANT_ID, GATE_IN_DT DESC, GATE_SYS_ID DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_GATE_IN_CANCEL_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_GATE_IN_CANCEL_SAVE`(
    IN P_ID INT,
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
    DECLARE TEMP_COUNT_LOAD INT;
    DECLARE TEMP_RFSYSID INT;
    
    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact the system administrator|0';

    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT := 'E|You are not authorized to perform this operation.|0';    
    #ELSE
    IF P_ID > 0 THEN
		
        SELECT COUNT(*) INTO TEMP_NUM FROM exp_fg_gate_in_out X WHERE X.GATE_SYS_ID = COALESCE(P_ID, 0);

        IF COALESCE(TEMP_NUM, 0) > 0 THEN
            SELECT RFSYSID INTO TEMP_RFSYSID FROM exp_fg_gate_in_out X WHERE X.GATE_SYS_ID = COALESCE(P_ID, 0);
        
            SELECT COUNT(*) INTO TEMP_NUM FROM RFID_MASTER WHERE RFSYSID = TEMP_RFSYSID;
        
            IF COALESCE(TEMP_NUM, 0) > 0 THEN
                SELECT RFSYSID INTO TEMP_RFSYSID FROM RFID_MASTER WHERE RFSYSID = TEMP_RFSYSID;
            ELSE
                SET TEMP_RFSYSID := 0;
            END IF;
        ELSE
            SET TEMP_RFSYSID := 0;
        END IF;

        UPDATE exp_fg_gate_in_out 
        SET CANCEL_GATE_IN = 1, CANCEL_GATE_REASON = P_CANCEL_GATE_REASON
        WHERE GATE_SYS_ID = P_ID AND RFSYSID = TEMP_RFSYSID AND COALESCE(CANCEL_GATE_IN, 0) = 0;
  
        UPDATE RFID_MASTER SET STATUS = 'Active' WHERE RFSYSID = TEMP_RFSYSID;

        SET P_RESULT := 'S|Record saved successfully|';
        
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_GATE_IN_MDA_LIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_GATE_IN_MDA_LIST`(IN P_SEARCHTERM VARCHAR(255), IN P_PLANT_ID INT)
BEGIN
WITH TBL_MH AS (SELECT MH.MDA_SYS_ID, MH.VEHICLE_NO, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')MDA_DT 
	FROM mda_header MH 
	WHERE MH.OUT_TIME IS NULL AND ((MH.MDA_NO = TRIM(IFNULL(P_SEARCHTERM,'')) OR MH.VEHICLE_NO = TRIM(IFNULL(P_SEARCHTERM,''))) 
										OR 1 = IF(IFNULL(TRIM(IFNULL(P_SEARCHTERM,'')),'') = '', 1, 0))
    AND 0 = (select COUNT(*) FROM fg_gate_in_out GIO WHERE FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0 AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0)
	GROUP BY MH.MDA_SYS_ID, MH.VEHICLE_NO, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')
)
, TBL_RESULT AS (
	SELECT MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.VEHICLE_NO, MH.MDA_DT, MH.OUT_TIME, MH.PLANT_CD, MH.TRANS_SYS_ID, MD.PROD_SYS_ID
    , MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
    , SUM(IFNULL(MD.BAG_NOS, 0))BAG_NOS, CAST((SUM(IFNULL(MD.BAG_NOS, 0)) / 24) as UNSIGNED) Required_Shipper
	FROM mda_header MH
	INNER JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
	-- WHERE (MH.VEHICLE_NO, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')) IN (SELECT VEHICLE_NO, MDA_DT FROM TBL_MH)
     WHERE MH.MDA_SYS_ID IN (SELECT MDA_SYS_ID FROM TBL_MH)
	AND MH.OUT_TIME IS NULL -- AND MD.PROD_SYS_ID IN (35,55,56)
    GROUP BY MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.VEHICLE_NO, MH.MDA_DT, MH.OUT_TIME, MH.PLANT_CD
    , MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE, MD.PROD_SYS_ID
	ORDER BY MH.MDA_SYS_ID DESC, MH.MDA_DT DESC, MD.PROD_SYS_ID
)
, TBL_LOADED AS (
	SELECT X.PLANT_ID, X.MDA_SYS_ID
    , GROUP_CONCAT(CONCAT(X.GATE_SYS_ID, '|', X.VEHICLE_NO, '|', X.Expected_Shipper, '|', X.Loaded_Shipper
    , '|', IF (IFNULL(Expected_Shipper, 0) <= IFNULL(Loaded_Shipper, 0), 'Completed', 'Loading')) ORDER BY X.GATE_OUT_DT DESC, X.GATE_IN_DT DESC SEPARATOR ',') AS VEHICLE_SHIPPERS
    , SUM(IFNULL(Loaded_Shipper, 0)) Loaded_Shipper
    , SUM(IFNULL(Expected_Shipper, 0)) Expected_Shipper
    FROM (SELECT MH.PLANT_ID, MH.MDA_SYS_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT-- , MH.PROD_SYS_ID
			, (SELECT COUNT(*) FROM exp_mda_pallate_loading eml WHERE eml.PLANT_ID = MH.PLANT_ID AND eml.MDA_SYS_ID = MH.MDA_SYS_ID 
			 	AND eml.GATE_SYS_ID = GIO.GATE_SYS_ID /*AND eml.PROD_SYS_ID = MH.PROD_SYS_ID*/ ) Loaded_Shipper
            , SUM(GIO.EXPECTED_QTY) Expected_Shipper
			FROM TBL_RESULT MH
			LEFT JOIN exp_fg_gate_in_out GIO ON GIO.PLANT_ID = MH.PLANT_ID AND GIO.MDA_SYS_ID = MH.MDA_SYS_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0 -- AND GATE_OUT_DT IS NULL
            INNER JOIN exp_FG_WEIGHMENT_DETAIL XZ ON XZ.GATE_SYS_ID = GIO.GATE_SYS_ID
            WHERE XZ.TARE_WT IS NULL AND IFNULL(XZ.TARE_WT,0) = 0 AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0
            AND 0 = (select COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = GIO.GATE_SYS_ID)
			GROUP BY MH.PLANT_ID, MH.MDA_SYS_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO, GATE_IN_DT, GATE_OUT_DT-- , MH.PROD_SYS_ID
        ) X GROUP BY X.PLANT_ID, X.MDA_SYS_ID-- , X.GATE_SYS_ID, X.VEHICLE_NO, X.PROD_SYS_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY MH.MDA_DT DESC, MH.MDA_NO DESC, MH.VEHICLE_NO ASC)) AS SR_NO
,MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.VEHICLE_NO, VEHICLE_SHIPPERS
, MH.BAG_NOS, MH.Required_Shipper, Loaded_Shipper, Expected_Shipper
, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y') AS MDA_DT, DATE_FORMAT(MH.OUT_TIME, '%d/%m/%Y %H:%i') AS OUT_TIME, MH.PLANT_CD
, MH.PROD_SYS_ID, PM.PRD_CD AS PROD_CD, PM.PRD_DESC AS PROD_NAME
, MH.TRANS_SYS_ID, TM.tptr_cd AS TRANS_CD, TM.TPTR_NAME AS TRANS_NAME
, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
, (ROW_NUMBER() OVER (PARTITION BY MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.MDA_DT ORDER BY MH.DIST DESC)) AS MDA_ORDER
FROM TBL_RESULT MH
LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = MH.PLANT_ID AND TM.TRANS_SYS_ID = MH.TRANS_SYS_ID
LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = MH.PLANT_ID AND PM.PROD_SYS_ID = MH.PROD_SYS_ID
LEFT JOIN TBL_LOADED LD ON LD.MDA_SYS_ID = MH.MDA_SYS_ID -- AND LD.PROD_SYS_ID = MH.PROD_SYS_ID 
WHERE IFNULL(Required_Shipper, 0) > IFNULL(Expected_Shipper, 0)
GROUP BY MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.VEHICLE_NO
, MH.MDA_DT, MH.OUT_TIME, MH.PLANT_CD, MH.PROD_SYS_ID, PM.PRD_CD, PM.PRD_DESC, MH.TRANS_SYS_ID, TM.tptr_cd, TM.TPTR_NAME
, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE, MH.BAG_NOS, MH.Required_Shipper, VEHICLE_SHIPPERS, Loaded_Shipper, Expected_Shipper
ORDER BY MH.MDA_DT DESC, MH.MDA_NO DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_GATE_IN_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_GATE_IN_SAVE`(
IN `P_ID` INT,
IN `P_MDA_SYS_ID` INT,
IN `P_MDA_NO` VARCHAR(255),
IN `P_TRUCK_NO` VARCHAR(255),
IN `P_TRANSPORTER_CODE` VARCHAR(255),
IN `P_DRIVER_ID_TYPE` VARCHAR(255),
IN `P_DRIVER_ID_NUMBER` VARCHAR(255),
IN `P_DRIVER_NAME` VARCHAR(255),
IN `P_DRIVER_CONTACT` VARCHAR(255),
IN `P_DRIVER_CHANGED` INT,
IN `P_DRIVER_NAME_NEW` VARCHAR(255),
IN `P_DRIVER_CONTACT_NEW` VARCHAR(255),
IN `P_EXPECTED_QTY` INT,
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
DECLARE TEMP_MDA_SYS_ID INT DEFAULT 0;
DECLARE TEMP_TRANS_SYS_ID INT DEFAULT 0;
DECLARE TEMP_NUM INT DEFAULT 0;
DECLARE TEMP_NUM_MDA INT DEFAULT 0;
DECLARE TEMP_RFSYSID INT DEFAULT 0;
DECLARE Required_Shipper INT DEFAULT 0;
DECLARE Loaded_Shipper INT DEFAULT 0;
      
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

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

SELECT COUNT(*) INTO TEMP_NUM FROM FG_GATE_IN_OUT WHERE TRUCK_NO = IFNULL(P_TRUCK_NO, '') AND GATE_OUT_DT IS NULL AND COALESCE(CANCEL_GATE_IN, 0) = 0;

SELECT COUNT(*) INTO TEMP_NUM FROM EXP_FG_GATE_IN_OUT WHERE TRUCK_NO = IFNULL(P_TRUCK_NO, '') AND GATE_OUT_DT IS NULL AND COALESCE(CANCEL_GATE_IN, 0) = 0;

IF IFNULL(TEMP_NUM, 0) <= 0 THEN
	SELECT COUNT(*) INTO TEMP_NUM FROM FG_GATE_IN_OUT WHERE TRUCK_NO = IFNULL(P_TRUCK_NO, '') 
			AND (FIND_IN_SET(P_MDA_SYS_ID, MDA_SYS_IDS) > 0 OR MDA_SYS_ID = P_MDA_SYS_ID) AND GATE_SYS_ID != IFNULL(P_ID, 0)AND COALESCE(CANCEL_GATE_IN, 0) = 0 ;
END IF;

IF IFNULL(TEMP_NUM, 0) <= 0 THEN
	SELECT COUNT(*) INTO TEMP_NUM FROM EXP_FG_GATE_IN_OUT WHERE TRUCK_NO = IFNULL(P_TRUCK_NO, '') AND GATE_OUT_DT IS NULL
			AND MDA_SYS_ID = P_MDA_SYS_ID AND GATE_SYS_ID != IFNULL(P_ID, 0)AND COALESCE(CANCEL_GATE_IN, 0) = 0 ;
END IF;

SELECT COUNT(*) INTO TEMP_NUM_MDA FROM mda_header WHERE MDA_NO = IFNULL(P_MDA_NO, '') AND MDA_SYS_ID = P_MDA_SYS_ID;

IF IFNULL(TEMP_NUM, 0) > 0 THEN
	SET P_RESULT = 'E|Entered Gate In details tor this vehicle is already exist.|0';
ELSEIF IFNULL(TEMP_RFSYSID, 0) = 0 THEN
	SET P_RESULT = 'E|RFID does not exist or already assigned.|0';
ELSEIF IFNULL(TEMP_NUM_MDA, 0) = 0 THEN
	SET P_RESULT = 'E|MDA does not exist.|0';
ELSEIF IFNULL(P_EXPECTED_QTY, 0) <= 0 THEN
    SET P_RESULT = CONCAT('E','|','Expected qty always more then 0.|','0');

ELSE

	SELECT CAST((SUM(IFNULL(MD.BAG_NOS, 0)) / 24) as UNSIGNED) INTO Required_Shipper
	FROM mda_header MH
	INNER JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
	WHERE MH.MDA_NO = P_MDA_NO AND MH.MDA_SYS_ID = P_MDA_SYS_ID AND MH.OUT_TIME IS NULL;

	SELECT SUM(IFNULL(Loaded_Shipper, 0)) INTO Loaded_Shipper
		FROM (SELECT MH.PLANT_ID, MH.MDA_SYS_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO
				-- , (SELECT COUNT(*) FROM exp_mda_loading eml WHERE eml.PLANT_ID = MH.PLANT_ID AND eml.MDA_SYS_ID = MH.MDA_SYS_ID 
				-- 		AND eml.GATE_SYS_ID = GIO.GATE_SYS_ID ) Loaded_Shipper
				, SUM(IFNULL(GIO.EXPECTED_QTY, 0)) Loaded_Shipper -- Expected_Shipper
				FROM mda_header MH
				LEFT JOIN exp_fg_gate_in_out GIO ON GIO.PLANT_ID = MH.PLANT_ID AND GIO.MDA_SYS_ID = MH.MDA_SYS_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
				WHERE MH.MDA_NO = P_MDA_NO AND MH.MDA_SYS_ID = P_MDA_SYS_ID
				GROUP BY MH.PLANT_ID, MH.MDA_SYS_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO
			) X GROUP BY X.PLANT_ID, X.MDA_SYS_ID;

	IF IFNULL(Required_Shipper, 0) <= IFNULL(Loaded_Shipper, 0) THEN
		SET P_RESULT = 'E|Selected MDA Loading Completed.|0';
	ELSEIF (IFNULL(Required_Shipper, 0) - IFNULL(Loaded_Shipper, 0)) <= IFNULL(P_EXPECTED_QTY, 0) THEN
		SET Loaded_Shipper = (IFNULL(Required_Shipper, 0) - IFNULL(Loaded_Shipper, 0));
		SET P_RESULT = CONCAT('E','|','You entered expected qty is wrong. Remaining Qty is ',IFNULL(Loaded_Shipper, 0),'|','0');
	ELSE

		IF TRIM(IFNULL(P_TRANSPORTER_CODE, '')) != '' THEN	
			SELECT TRANS_SYS_ID INTO TEMP_TRANS_SYS_ID FROM transporter_master X WHERE X.tptr_cd = TRIM(P_TRANSPORTER_CODE);	
		END IF;

		#SELECT IFNULL(MAX(GATE_SYS_ID), 0) + 1 INTO TEMP_NUM FROM FG_GATE_IN_OUT;
        WITH TBL_AI AS (SELECT `AUTO_INCREMENT` ID FROM  INFORMATION_SCHEMA.TABLES 
		WHERE LOWER(TABLE_SCHEMA) = 'iffco' AND LOWER(TABLE_NAME) = 'exp_fg_gate_in_out')
		, TBL_T AS (SELECT IFNULL(MAX(GATE_SYS_ID), 0) + 1 ID FROM exp_fg_gate_in_out) 
		SELECT IF(X.ID > Z.ID, X.ID, Z.ID) INTO TEMP_NUM FROM TBL_AI X, TBL_T Z;

		INSERT INTO EXP_FG_GATE_IN_OUT (
		GATE_SYS_ID, GATE_IN_DT, INWARD_SYS_ID, MDA_SYS_ID, TRUCK_NO, EXPECTED_QTY,
		TRANS_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, 
		DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION,
		RFSYSID, RFID_RECEIVE, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME
		)
		VALUES (
		TEMP_NUM, NOW(), 1, P_MDA_SYS_ID, P_TRUCK_NO, P_EXPECTED_QTY,
		TEMP_TRANS_SYS_ID, P_DRIVER_ID_TYPE, P_DRIVER_ID_NUMBER, P_DRIVER_NAME, P_DRIVER_CONTACT, 
		IFNULL(P_DRIVER_CHANGED, 0), P_DRIVER_NAME_NEW, P_DRIVER_CONTACT_NEW, IFNULL(P_TRUCK_VALIDATION, 0),
		IFNULL(TEMP_RFSYSID, 0), IFNULL(P_RFID_RECEIVE, 0), TEMP_STATION_ID, P_PLANT_ID, P_USER_ID, NOW()
		);

		UPDATE RFID_MASTER SET STATUS = 'Assigned' WHERE RFSYSID = TEMP_RFSYSID;

		INSERT INTO exp_mda_sequence (PLANT_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_Sequence_No, MDA_STATUS, MDA_REASON, MDA_REMARK, MDA_STATUS_DATETIME
										, Created_BY_ID, Created_DateTime, IS_POSTED)
		SELECT P_PLANT_ID, TEMP_NUM, MH.MDA_SYS_ID, (ROW_NUMBER() OVER (ORDER BY MH.DIST DESC)), NULL, NULL, NULL, NOW(), P_USER_ID, NOW(), 0 
        FROM mda_header MH WHERE MH.MDA_NO = P_MDA_NO AND MH.MDA_SYS_ID = P_MDA_SYS_ID;
		       
		SET P_RESULT = 'S|Record saved successfully|0';
    
	END IF;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_GATE_OUT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_GATE_OUT_GET`(
	IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(10),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
WITH TBL_GATE_IN_MDA AS (SELECT X.PLANT_ID, X.GATE_SYS_ID, X.TRUCK_NO VEHICLE_NO, X.MDA_SYS_ID, Z.MDA_NO
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER
        , IF(X.DRIVER_CHANGED = 1, X.DRIVER_NAME_NEW, X.DRIVER_NAME) AS DRIVER_NAME
        , IF(X.DRIVER_CHANGED = 1, X.DRIVER_CONTACT_NEW, X.DRIVER_CONTACT) AS DRIVER_CONTACT, X.DRIVER_CHANGED
		, Z.PLANT_CD, X.TRANS_SYS_ID, Z.WH_CD, Z.PARTY_NAME, Z.DIST, Z.DESP_PLACE
        , X.VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID, IFNULL(EXPECTED_QTY, 0) Expected_Shipper
		FROM exp_fg_gate_in_out X
		INNER JOIN mda_header Z ON X.PLANT_ID = Z.PLANT_ID AND Z.MDA_SYS_ID = X.MDA_SYS_ID
		WHERE X.GATE_OUT_DT IS NULL AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND Z.OUT_TIME IS NULL 
        AND IF(TRIM(IFNULL(P_SEARCHTERM,'')) = '', TRUE, 
				(X.TRUCK_NO = TRIM(IFNULL(P_SEARCHTERM,'')) OR Z.MDA_NO = TRIM(IFNULL(P_SEARCHTERM,'')) 
					OR X.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' 
									AND (ZX.RFIDSRNO = TRIM(IFNULL(P_SEARCHTERM,'')) OR ZX.RFIDCODE = TRIM(IFNULL(P_SEARCHTERM,''))))
				))
		AND 0 < (SELECT COUNT(*) FROM exp_fg_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0 AND XZ.GROSS_WT_DT IS NOT NULL)
		ORDER BY X.GATE_IN_DT DESC
)
, TBL_RESULT AS (
SELECT X.PLANT_ID, GATE_SYS_ID, VEHICLE_NO, X.MDA_SYS_ID, X.MDA_NO, GATE_IN_DT, GATE_OUT_DT
				, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME
                , DIST, DESP_PLACE, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
                , Expected_Shipper, ZZ.PROD_SYS_ID
                , (SELECT COUNT(*) FROM exp_mda_pallate_loading eml WHERE eml.MDA_SYS_ID = X.MDA_SYS_ID AND eml.GATE_SYS_ID = X.GATE_SYS_ID ) Loaded_Shipper
		FROM TBL_GATE_IN_MDA X
		LEFT JOIN mda_detail ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.MDA_SYS_ID = X.MDA_SYS_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY GATE_IN_DT DESC, GATE_SYS_ID DESC)) AS SR_NO
, X.PLANT_ID, X.GATE_SYS_ID, MDA_SYS_ID, VEHICLE_NO, MDA_NO, Expected_Shipper, Loaded_Shipper
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
    , DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
	, X.PLANT_CD, X.TRANS_SYS_ID, TM.TPTR_NAME AS TRANS_NAME, X.PROD_SYS_ID, WH_CD, PARTY_NAME
    , DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
    , DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, ZZ.WT_SYS_ID, ZZ.TARE_WT WEIGH_IN_WT, ZZ.TARE_WT_NOTE WEIGH_IN_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS WEIGH_IN_WT_DT
, ZZ.GROSS_WT WEIGH_OUT_WT, ZZ.GROSS_WT_NOTE WEIGH_OUT_WT_NOTE, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS WEIGH_OUT_WT_DT, ZZ.NET_WT
FROM TBL_RESULT X
INNER JOIN EXP_FG_WEIGHMENT_DETAIL ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.GATE_SYS_ID = X.GATE_SYS_ID
LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = X.PLANT_ID AND TM.TRANS_SYS_ID = X.TRANS_SYS_ID
LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = X.PLANT_ID AND PM.PROD_SYS_ID = X.PROD_SYS_ID
GROUP BY X.PLANT_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, VEHICLE_NO, MDA_NO, Expected_Shipper, Loaded_Shipper, GATE_IN_DT, GATE_OUT_DT, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, X.PLANT_CD, X.TRANS_SYS_ID, X.PROD_SYS_ID, WH_CD, PARTY_NAME, ZZ.WT_SYS_ID, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, ZZ.TARE_WT_DT, ZZ.GROSS_WT, ZZ.GROSS_WT_NOTE, ZZ.GROSS_WT_DT, ZZ.NET_WT
ORDER BY PLANT_ID, GATE_IN_DT DESC, GATE_SYS_ID DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_GATE_OUT_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_GATE_OUT_SAVE`(
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
    DECLARE TEMP_CURRENT_DATETIME datetime;
DECLARE Required_Shipper INT DEFAULT 0;
DECLARE Loaded_Shipper INT DEFAULT 0;
    
    DECLARE TEMP_GATE_OUT_DT VARCHAR(255) DEFAULT NULL;
      
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
    
            UPDATE RFID_MASTER SET STATUS = 'Active' 
            WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM exp_fg_gate_in_out X
								INNER JOIN mda_header Y ON Y.PLANT_ID = X.PLANT_ID AND Y.MDA_SYS_ID = X.MDA_SYS_ID
								WHERE GATE_OUT_DT IS NULL AND OUT_TIME IS NULL AND CAST(DATE_FORMAT(X.GATE_IN_DT, '%Y') AS UNSIGNED) >= 2024);
            
            
        SELECT DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_GATE_OUT_DT 
        FROM exp_fg_gate_in_out X 
        WHERE X.GATE_SYS_ID = P_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NULL THEN
			
            SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
            
        ELSE
			
			SET P_RESULT = CONCAT('E|Gate Out Details is already saved. Gate Out Date Time : ', IFNULL(TEMP_GATE_OUT_DT, ''), '|0');
            
        END IF;
        
    END;

	SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
		
    IF P_ID > 0 THEN
		
        SET TEMP_CURRENT_DATETIME = NOW();
        
        SELECT DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_GATE_OUT_DT 
        FROM exp_fg_gate_in_out X 
        WHERE X.GATE_SYS_ID = P_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NULL THEN
        
			-- UPDATE mda_requisition_data SET LOADING_PROGRESS = 'Completed', LOAD_OUT_TIME = TEMP_CURRENT_DATETIME
            -- WHERE PLANT_ID = P_PLANT_ID AND GATE_SYS_ID = P_ID;
                                                           
                              
			SELECT CAST((SUM(IFNULL(MD.BAG_NOS, 0)) / 24) as UNSIGNED) INTO Required_Shipper
			FROM mda_header MH
			INNER JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
			WHERE MH.MDA_SYS_ID = P_MDA_SYS_ID ;

			SELECT SUM(IFNULL(Loaded_Shipper, 0)) INTO Loaded_Shipper
				FROM (SELECT MH.PLANT_ID, MH.MDA_SYS_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO
						-- , (SELECT COUNT(*) FROM exp_mda_pallate_loading eml WHERE eml.PLANT_ID = MH.PLANT_ID AND eml.MDA_SYS_ID = MH.MDA_SYS_ID 
						-- 		AND eml.GATE_SYS_ID = GIO.GATE_SYS_ID ) Loaded_Shipper
						, SUM(IFNULL(GIO.EXPECTED_QTY, 0)) Loaded_Shipper -- Expected_Shipper
						FROM mda_header MH
						LEFT JOIN exp_fg_gate_in_out GIO ON GIO.PLANT_ID = MH.PLANT_ID AND GIO.MDA_SYS_ID = MH.MDA_SYS_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
						WHERE MH.MDA_SYS_ID = P_MDA_SYS_ID
						GROUP BY MH.PLANT_ID, MH.MDA_SYS_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO
					) X GROUP BY X.PLANT_ID, X.MDA_SYS_ID;

			IF IFNULL(Required_Shipper, 0) <= IFNULL(Loaded_Shipper, 0) THEN
				SET P_RESULT = 'E|Selected MDA Loading Completed.|0';
			ELSE
				IF IFNULL(Required_Shipper, 0) = IFNULL(Loaded_Shipper, 0) THEN
				
					UPDATE mda_header MH
					SET MH.OUT_TIME = TEMP_CURRENT_DATETIME
					WHERE MH.PLANT_ID = P_PLANT_ID AND MH.MDA_SYS_ID = P_MDA_SYS_ID AND MH.OUT_TIME IS NULL;
					
				END IF;
            
				UPDATE exp_fg_gate_in_out 
				SET GATE_OUT_DT = TEMP_CURRENT_DATETIME, IS_GOODS_TRANSFER = 1
				WHERE GATE_SYS_ID = P_ID AND COALESCE(CANCEL_GATE_IN, 0) = 0 
				AND GATE_OUT_DT IS NULL AND PLANT_ID = P_PLANT_ID;
				
				UPDATE RFID_MASTER SET STATUS = 'Active' 
				WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM exp_fg_gate_in_out X
									INNER JOIN mda_header Y ON Y.PLANT_ID = X.PLANT_ID AND Y.MDA_SYS_ID = X.MDA_SYS_ID
									WHERE GATE_OUT_DT IS NULL AND OUT_TIME IS NULL AND CAST(DATE_FORMAT(X.GATE_IN_DT, '%Y') AS UNSIGNED) >= 2024);
				
				COMMIT;
				
				SET P_RESULT := CONCAT( 'S|Record saved successfully', '|0' );
			END IF;
        ELSE
			  
			SET P_RESULT = CONCAT('E|Gate Out Details is already saved. Gate Out Date Time : ', IFNULL(TEMP_GATE_OUT_DT, ''), '|0');
            
        END IF;
        
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_MDA_PALLATE_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_MDA_PALLATE_GET`(IN P_Gate_In_Id INT, IN P_MDA_Id INT, IN P_DI_No VARCHAR(255), IN P_PLANT_ID INT)
BEGIN

	WITH TBL_MH AS (SELECT MH.MDA_SYS_ID, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')MDA_DT 
		FROM mda_header MH 
		WHERE MH.OUT_TIME IS NULL AND MH.DI_NO = TRIM(IFNULL(P_DI_No,''))
		AND 0 = (select COUNT(*) FROM fg_gate_in_out GIO WHERE FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0 AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0)
		AND 0 < (select COUNT(*) FROM Exp_fg_gate_in_out GIO INNER JOIN exp_fg_weighment_detail WD ON WD.GATE_SYS_ID = GIO.GATE_SYS_ID
    WHERE GIO.PLANT_ID = MH.PLANT_ID AND MH.MDA_SYS_ID = GIO.MDA_SYS_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0 AND IFNULL(WD.TARE_WT,0) > 0 AND WD.TARE_WT_DT IS NOT NULL)
        AND IF(IFNULL(P_MDA_Id, 0) > 0, MH.MDA_SYS_ID = P_MDA_Id, TRUE) 
		GROUP BY MH.MDA_SYS_ID, MH.VEHICLE_NO, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')
	)
	, TBL_RESULT AS (
		SELECT MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.VEHICLE_NO, MH.MDA_DT, MH.OUT_TIME, MH.PLANT_CD, MH.TRANS_SYS_ID, MD.PROD_SYS_ID
		, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
		, SUM(IFNULL(MD.BAG_NOS, 0))BAG_NOS, CAST((SUM(IFNULL(MD.BAG_NOS, 0)) / 24) as UNSIGNED) Required_Shipper
		FROM mda_header MH
		INNER JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
		 WHERE MH.MDA_SYS_ID IN (SELECT MDA_SYS_ID FROM TBL_MH)
		AND MH.OUT_TIME IS NULL
		GROUP BY MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.VEHICLE_NO, MH.MDA_DT, MH.OUT_TIME, MH.PLANT_CD
		, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE, MD.PROD_SYS_ID
		ORDER BY MH.MDA_SYS_ID DESC, MH.MDA_DT DESC, MD.PROD_SYS_ID
	)
	, TBL_GATE_IN AS (SELECT MH.PLANT_ID, MH.MDA_SYS_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO, GATE_IN_DT, SUM(GIO.EXPECTED_QTY) Expected_Shipper
				-- , (SELECT COUNT(*) FROM exp_mda_pallate_loading eml WHERE eml.PLANT_ID = MH.PLANT_ID AND eml.MDA_SYS_ID = MH.MDA_SYS_ID AND eml.GATE_SYS_ID = GIO.GATE_SYS_ID ) Loaded_Pallate				
				FROM TBL_RESULT MH
				LEFT JOIN exp_fg_gate_in_out GIO ON GIO.PLANT_ID = MH.PLANT_ID AND GIO.MDA_SYS_ID = MH.MDA_SYS_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0 -- AND GATE_OUT_DT IS NULL
				LEFT JOIN exp_FG_WEIGHMENT_DETAIL XZ ON XZ.GATE_SYS_ID = GIO.GATE_SYS_ID
				WHERE XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0
				AND IF(IFNULL(P_Gate_In_Id, 0) > 0, GIO.GATE_SYS_ID = P_Gate_In_Id, TRUE) 
				GROUP BY MH.PLANT_ID, MH.MDA_SYS_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO, GATE_IN_DT, GATE_OUT_DT-- , MH.PROD_SYS_ID 
	)
	, TBL_LOADED AS (
		SELECT X.PLANT_ID, X.MDA_SYS_ID, X.GATE_SYS_ID, VEHICLE_NO, GATE_IN_DT, Expected_Shipper
		, COUNT(XZ.MDA_LOD_SYS_ID) Loaded_Pallate
		, IFNULL(SUM((SELECT Shipper_Qty FROM pallate_master Y WHERE Y.Id = XZ.Pallate_Id AND Y.DI_No = XZ.DI_No)), 0) Loaded_Shipper
		FROM TBL_GATE_IN X
		LEFT JOIN exp_mda_pallate_loading XZ ON XZ.MDA_SYS_ID = X.MDA_SYS_ID AND XZ.GATE_SYS_ID = X.GATE_SYS_ID
		GROUP BY X.PLANT_ID, X.MDA_SYS_ID, X.GATE_SYS_ID, VEHICLE_NO, GATE_IN_DT, Expected_Shipper
	)
	SELECT (ROW_NUMBER() OVER (ORDER BY MH.MDA_DT DESC, MH.MDA_NO DESC, MH.VEHICLE_NO ASC)) AS SR_NO
	, MH.PLANT_ID, MH.DI_NO, GIO.GATE_SYS_ID, MH.MDA_SYS_ID, MH.MDA_NO, GIO.VEHICLE_NO
	, MH.BAG_NOS, MH.Required_Shipper, Loaded_Shipper, Expected_Shipper, Loaded_Pallate, (Loaded_Shipper * 24) Loaded_Bottle, (Expected_Shipper * 24) Expected_Bottle
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y') AS MDA_DT, MH.PLANT_CD
	, MH.PROD_SYS_ID, PM.PRD_CD AS PROD_CD, PM.PRD_DESC AS PROD_NAME
	, MH.TRANS_SYS_ID, TM.tptr_cd AS TRANS_CD, TM.TPTR_NAME AS TRANS_NAME
	, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE, IF(IFNULL(Expected_Shipper, 0) <= IFNULL(Loaded_Shipper, 0), 1, 0) IsLoaded
	FROM TBL_RESULT MH
	LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = MH.PLANT_ID AND TM.TRANS_SYS_ID = MH.TRANS_SYS_ID
	LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = MH.PLANT_ID AND PM.PROD_SYS_ID = MH.PROD_SYS_ID
	LEFT JOIN TBL_LOADED GIO ON GIO.MDA_SYS_ID = MH.MDA_SYS_ID -- AND LD.PROD_SYS_ID = MH.PROD_SYS_ID 
	GROUP BY MH.PLANT_ID, MH.DI_NO, GIO.GATE_SYS_ID, MH.MDA_SYS_ID, MH.MDA_NO, GIO.VEHICLE_NO, GATE_IN_DT
	, MH.MDA_DT, MH.OUT_TIME, MH.PLANT_CD, MH.PROD_SYS_ID, PM.PRD_CD, PM.PRD_DESC, MH.TRANS_SYS_ID, TM.tptr_cd, TM.TPTR_NAME
	, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE, MH.BAG_NOS, MH.Required_Shipper, Loaded_Shipper, Expected_Shipper, Loaded_Pallate
	ORDER BY MH.MDA_DT DESC, MH.MDA_NO DESC;
    
	SELECT (ROW_NUMBER() OVER (ORDER BY Created_DateTime DESC)) AS SR_NO
	, MDA_LOD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, X.DI_NO, PROD_SYS_ID, Pallate_Id, X.PALLATE_NO, Pallate_Type, Shipper_Qty, (Shipper_Qty * 24) Bottle_Qty, Dispatch_Mode
    , Created_BY_ID, X.Created_DateTime, X.PLANT_ID
            , (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('Pallate_Type') AND Z.LOV_CODE = Pallate_Type LIMIT 1) AS Pallate_Type_Text
            , (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('DISPATCH_MODE') AND Z.LOV_CODE = Dispatch_Mode LIMIT 1) AS Dispatch_Mode_Text
	FROM exp_mda_pallate_loading X
    LEFT JOIN pallate_master XZ ON XZ.Id = X.Pallate_Id AND XZ.DI_No = X.DI_No
	WHERE X.GATE_SYS_ID = IFNULL(P_Gate_In_Id, 0) AND X.MDA_SYS_ID = IFNULL(P_MDA_Id, 0) AND X.DI_NO = IFNULL(P_DI_No,'');


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_REPORT_GATE_IN_OUT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_REPORT_GATE_IN_OUT`(
IN P_GATE_SYS_ID INT
, IN P_SEARCHTERM VARCHAR(255)
, IN P_FROMDATE VARCHAR(255)
, IN P_TODATE VARCHAR(255)
, IN P_IS_OUT_TIME_NULL INT
, IN P_PLANT_ID INT
)
BEGIN

WITH TBL_MAIN AS (SELECT PLANT_ID, GATE_SYS_ID, MDA_SYS_ID
					FROM exp_fg_gate_in_out
					WHERE COALESCE(CANCEL_GATE_IN, 0) = 0
					AND (CASE WHEN IFNULL(TRIM(P_SEARCHTERM),'') != '' THEN TRUCK_NO = TRIM(P_SEARCHTERM)
							  WHEN IFNULL(TRIM(P_FROMDATE),'') != '' THEN GATE_IN_DT >= STR_TO_DATE(P_FROMDATE, '%d/%m/%Y') 
							  WHEN IFNULL(TRIM(P_TODATE),'') != '' THEN GATE_OUT_DT < (STR_TO_DATE(P_TODATE, '%d/%m/%Y') + INTERVAL 1 DAY) 
							ELSE TRUE END)
					ORDER BY PLANT_ID, GATE_SYS_ID DESC
)
, TBL_MAIN_ AS (SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, VEHICLE_NO
	, GROUP_CONCAT(DISTINCT MDA_NO ORDER BY MDA_SYS_ID SEPARATOR ',') AS MDA_NO
	, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, MAX(TRANS_SYS_ID)TRANS_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
	, GROUP_CONCAT(DISTINCT PLANT_CD ORDER BY PLANT_CD SEPARATOR ',') AS PLANT_CD 
	-- , GROUP_CONCAT(DISTINCT TRANS_SYS_ID ORDER BY TRANS_SYS_ID SEPARATOR ',') AS TRANS_SYS_IDS
	, GROUP_CONCAT(DISTINCT WH_CD ORDER BY WH_CD SEPARATOR ',') AS WH_CD 
	, GROUP_CONCAT(DISTINCT PARTY_NAME ORDER BY PARTY_NAME SEPARATOR ',') AS PARTY_NAME 
	, GROUP_CONCAT(DISTINCT DIST ORDER BY DIST SEPARATOR ',') AS DIST 
	, GROUP_CONCAT(DISTINCT desp_place ORDER BY desp_place SEPARATOR ',') AS desp_place 
	, GROUP_CONCAT(DISTINCT RFSYSID ORDER BY RFSYSID SEPARATOR ',') AS RFSYSID 
	FROM (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, MH.MDA_SYS_ID, MH.MDA_NO, X.TRUCK_NO VEHICLE_NO, MH.PLANT_CD
		, GATE_IN_DT, GATE_OUT_DT, MH.MDA_DT
		, DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, IFNULL(X.DRIVER_NAME, X.DRIVER_NAME_NEW)DRIVER_NAME, IFNULL(X.DRIVER_CONTACT, X.DRIVER_CONTACT_NEW)DRIVER_CONTACT, X.DRIVER_CHANGED -- , X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
		, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DIST, MH.desp_place, X.RFSYSID, INWARD_SYS_ID
		FROM exp_fg_gate_in_out X
		INNER JOIN mda_header MH ON MH.PLANT_ID = X.PLANT_ID AND MH.MDA_SYS_ID = X.MDA_SYS_ID
		WHERE (X.PLANT_ID, X.GATE_SYS_ID) IN (SELECT PLANT_ID, GATE_SYS_ID FROM TBL_MAIN)
        -- AND (CASE WHEN IFNULL(P_IS_OUT_TIME_NULL,0) = 1 THEN MH.OUT_TIME IS NULL AND X.GATE_OUT_DT IS NULL ELSE TRUE END)
        ORDER BY 3 DESC, 4 DESC
	) X
	GROUP BY PLANT_ID, GATE_SYS_ID, MDA_SYS_ID, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
)
SELECT (ROW_NUMBER() OVER (ORDER BY M_G.GATE_IN_DT DESC, M_G.GATE_OUT_DT DESC)) AS SR_NO
, M_G.PLANT_ID, M_G.STATION_ID, M_G.GATE_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO TRUCK_NO, M_G.INWARD_SYS_ID, 'FG' Purpose_Type
, DATE_FORMAT(M_G.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT-- , DATE_FORMAT(M_G.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
, (SELECT CAST((SUM(BAG_NOS) / 24) AS unsigned) FROM mda_detail Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND Z.MDA_SYS_ID = M_G.MDA_SYS_ID) Required_Shipper
, (SELECT COUNT(*) FROM MDA_LOADING Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND Z.GATE_SYS_ID = M_G.GATE_SYS_ID AND Z.MDA_SYS_ID = M_G.MDA_SYS_ID) Loaded_Shipper
-- , MD.BAG_NOS, CAST((MD.BAG_NOS / 24) AS unsigned) Required_Shipper
-- , (SELECT COUNT(*) FROM MDA_LOADING Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND Z.GATE_SYS_ID = M_G.GATE_SYS_ID AND Z.MDA_SYS_ID = M_G.MDA_SYS_ID) Loaded_Shipper
-- , ZZ.TARE_WT, ZZ.GROSS_WT, ZZ.NET_WT, ZZ.TOLERANCE_WT, ZZ.TARE_WT_NOTE, ZZ.GROSS_WT_NOTE
-- , DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT
-- , MD.PROD_SYS_ID, SKU_CODE, SKU_NAME, PRD_CD, PRD_DESC
, M_G.DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED-- , TRUCK_VALIDATION
, M_G.TRANS_SYS_ID, TM.tptr_cd, TM.TPTR_NAME, M_G.WH_CD, M_G.PARTY_NAME, M_G.DIST, M_G.desp_place, M_G.RFSYSID, RM.RFIDSRNO, NULL STATUS, NULL Skip_LILO_Remarks
FROM TBL_MAIN_ M_G
-- INNER JOIN mda_detail MD ON MD.PLANT_ID = M_G.PLANT_ID AND MD.MDA_SYS_ID = M_G.MDA_SYS_ID
-- INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = M_G.GATE_SYS_ID AND ZZ.STATION_ID = M_G.STATION_ID AND ZZ.PLANT_ID = M_G.PLANT_ID
INNER JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = M_G.PLANT_ID AND TM.TRANS_SYS_ID = M_G.TRANS_SYS_ID
-- LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = M_G.PLANT_ID AND PM.PROD_SYS_ID = MD.PROD_SYS_ID
LEFT JOIN rfid_master RM ON RM.PLANT_ID = M_G.PLANT_ID AND RM.RFSYSID = M_G.RFSYSID 
-- WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL 
ORDER BY M_G.GATE_IN_DT  DESC, M_G.GATE_OUT_DT  DESC ;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_WEIGHMENT_IN_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_WEIGHMENT_IN_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
WITH TBL_GATE_IN_MDA AS (SELECT X.PLANT_ID, X.GATE_SYS_ID, X.TRUCK_NO VEHICLE_NO, X.MDA_SYS_ID, Z.MDA_NO
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER
        , IF(X.DRIVER_CHANGED = 1, X.DRIVER_NAME_NEW, X.DRIVER_NAME) AS DRIVER_NAME
        , IF(X.DRIVER_CHANGED = 1, X.DRIVER_CONTACT_NEW, X.DRIVER_CONTACT) AS DRIVER_CONTACT, X.DRIVER_CHANGED
		, Z.PLANT_CD, X.TRANS_SYS_ID, Z.WH_CD, Z.PARTY_NAME, Z.DIST, Z.DESP_PLACE
        , X.VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID, IFNULL(EXPECTED_QTY, 0) Expected_Shipper
		FROM exp_fg_gate_in_out X
		INNER JOIN mda_header Z ON X.PLANT_ID = Z.PLANT_ID AND Z.MDA_SYS_ID = X.MDA_SYS_ID
		WHERE X.GATE_OUT_DT IS NULL AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND Z.OUT_TIME IS NULL 
        AND IF(TRIM(IFNULL(P_SEARCHTERM,'')) = '', TRUE, 
				(X.TRUCK_NO = TRIM(IFNULL(P_SEARCHTERM,'')) OR Z.MDA_NO = TRIM(IFNULL(P_SEARCHTERM,'')) 
					OR X.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' 
									AND (ZX.RFIDSRNO = TRIM(IFNULL(P_SEARCHTERM,'')) OR ZX.RFIDCODE = TRIM(IFNULL(P_SEARCHTERM,''))))
				))
		AND 0 = (SELECT COUNT(*) FROM exp_fg_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID)
		ORDER BY X.GATE_IN_DT DESC
)
, TBL_RESULT AS (
SELECT X.PLANT_ID, GATE_SYS_ID, VEHICLE_NO, X.MDA_SYS_ID, X.MDA_NO, GATE_IN_DT, GATE_OUT_DT
				, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME
                , DIST, DESP_PLACE, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
                , Expected_Shipper, ZZ.PROD_SYS_ID
		FROM TBL_GATE_IN_MDA X
		LEFT JOIN mda_detail ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.MDA_SYS_ID = X.MDA_SYS_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY GATE_IN_DT DESC, GATE_SYS_ID DESC)) AS SR_NO
, X.PLANT_ID, GATE_SYS_ID, MDA_SYS_ID, VEHICLE_NO, MDA_NO, Expected_Shipper
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
    , DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
	, X.PLANT_CD, X.TRANS_SYS_ID, TM.TPTR_NAME AS TRANS_NAME, X.PROD_SYS_ID, WH_CD, PARTY_NAME
    , DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
    , DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
    , X.VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME
FROM TBL_RESULT X
LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = X.PLANT_ID AND TM.TRANS_SYS_ID = X.TRANS_SYS_ID
LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = X.PLANT_ID AND PM.PROD_SYS_ID = X.PROD_SYS_ID
GROUP BY X.PLANT_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, VEHICLE_NO, MDA_NO, Expected_Shipper, GATE_IN_DT, GATE_OUT_DT, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, X.PLANT_CD, X.TRANS_SYS_ID, X.PROD_SYS_ID, WH_CD, PARTY_NAME
ORDER BY PLANT_ID, GATE_IN_DT DESC, GATE_SYS_ID DESC;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_WEIGHMENT_IN_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_WEIGHMENT_IN_SAVE`(
    IN P_ID INT, 
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

    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';


    IF P_ID > 0 THEN
    
        SELECT COUNT(*) INTO TEMP_NUM FROM exp_fg_weighment_detail X WHERE X.GATE_SYS_ID = P_ID;
               
            IF IFNULL(P_TARE_WT, 0) <= 0 THEN
                SET P_RESULT = 'E|Tare weight require.|0';
            ELSEIF COALESCE(TEMP_NUM, 0) > 0 THEN
				SET P_RESULT = 'E|Weighment Details already exist.|';
			ELSE
            
					SELECT COALESCE(MAX(WT_SYS_ID), 0) + 1 INTO TEMP_NUM FROM exp_fg_weighment_detail;

					INSERT INTO exp_fg_weighment_detail (WT_SYS_ID, GATE_SYS_ID, TARE_WT, TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME) 
					VALUES (TEMP_NUM, P_ID, P_TARE_WT, NOW(), 1, P_TARE_WT_NOTE, 7, P_PLANT_ID, P_USER_ID, NOW());

					SET P_RESULT = 'S|Record saved successfully|';
                    
            END IF;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_WEIGHMENT_IN_SLIP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_WEIGHMENT_IN_SLIP`(
    IN P_GATE_SYS_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
)
BEGIN
		SELECT PlantID PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Weighment Slip - Weigh In (Export)' REPORT_TITLE
		FROM PLANT_MASTER WHERE PlantID = P_PLANT_ID;
		
WITH TBL_GATE_IN_MDA AS (SELECT X.PLANT_ID, X.GATE_SYS_ID, X.TRUCK_NO VEHICLE_NO, X.MDA_SYS_ID, Z.MDA_NO
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER
        , IF(X.DRIVER_CHANGED = 1, X.DRIVER_NAME_NEW, X.DRIVER_NAME) AS DRIVER_NAME
        , IF(X.DRIVER_CHANGED = 1, X.DRIVER_CONTACT_NEW, X.DRIVER_CONTACT) AS DRIVER_CONTACT, X.DRIVER_CHANGED
		, Z.PLANT_CD, X.TRANS_SYS_ID, Z.WH_CD, Z.PARTY_NAME, Z.DIST, Z.DESP_PLACE, RFSYSID
        , X.VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID, IFNULL(EXPECTED_QTY, 0) Expected_Shipper
		FROM exp_fg_gate_in_out X
		INNER JOIN mda_header Z ON X.PLANT_ID = Z.PLANT_ID AND Z.MDA_SYS_ID = X.MDA_SYS_ID
		WHERE COALESCE(X.CANCEL_GATE_IN, 0) = 0
        AND IF(IFNULL(P_GATE_SYS_ID,0)= 0, X.GATE_OUT_DT IS NULL AND Z.OUT_TIME IS NULL, X.GATE_SYS_ID = P_GATE_SYS_ID) 
        AND IF(TRIM(IFNULL(P_SEARCHTERM,'')) = '', TRUE, 
				(X.TRUCK_NO = TRIM(IFNULL(P_SEARCHTERM,'')) OR Z.MDA_NO = TRIM(IFNULL(P_SEARCHTERM,'')) 
					OR X.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' 
									AND (ZX.RFIDSRNO = TRIM(IFNULL(P_SEARCHTERM,'')) OR ZX.RFIDCODE = TRIM(IFNULL(P_SEARCHTERM,''))))
				))
		AND 0 < (SELECT COUNT(*) FROM exp_fg_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL)
		ORDER BY X.GATE_IN_DT DESC
)
, TBL_RESULT AS (
SELECT X.PLANT_ID, GATE_SYS_ID, VEHICLE_NO, X.MDA_SYS_ID, X.MDA_NO, GATE_IN_DT, GATE_OUT_DT
				, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME
                , DIST, DESP_PLACE, RFSYSID, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
                , ZZ.BAG_NOS, Expected_Shipper, ZZ.PROD_SYS_ID
                , (SELECT COUNT(*) FROM exp_mda_pallate_loading eml WHERE eml.MDA_SYS_ID = X.MDA_SYS_ID AND eml.GATE_SYS_ID = X.GATE_SYS_ID ) Loaded_Shipper
		FROM TBL_GATE_IN_MDA X
		LEFT JOIN mda_detail ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.MDA_SYS_ID = X.MDA_SYS_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY GATE_IN_DT DESC, GATE_SYS_ID DESC)) AS SR_NO
, X.PLANT_ID, X.GATE_SYS_ID, MDA_SYS_ID, VEHICLE_NO, MDA_NO, X.BAG_NOS, CAST((SUM(IFNULL(X.BAG_NOS, 0)) / 24) as UNSIGNED) Required_Shipper, Expected_Shipper, Loaded_Shipper
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
    , DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
	, X.PLANT_CD, WH_CD, PARTY_NAME, DIST, DESP_PLACE, RM.RFSYSID, RM.RFIDSRNO
	, PM.PROD_SYS_ID, PM.PRD_CD AS PRODUCT_CODE, PM.PRD_DESC AS PRODUCT_DESC
	, TM.TRANS_SYS_ID, TM.TPTR_CD AS TRANSPORTER_CODE, TM.TPTR_NAME AS TRANSPORTER_NAME
    , DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
    , DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, ZZ.WT_SYS_ID, ZZ.TARE_WT WEIGH_IN_WT, ZZ.TARE_WT_NOTE WEIGH_IN_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS WEIGH_IN_WT_DT
, ZZ.GROSS_WT WEIGH_OUT_WT, ZZ.GROSS_WT_NOTE WEIGH_OUT_WT_NOTE, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS WEIGH_OUT_WT_DT
, ZZ.NET_WT, ZZ.TOLERANCE_WT, 'KG' UOM, 'Kg' WEIGHT_UOM
FROM TBL_RESULT X
INNER JOIN EXP_FG_WEIGHMENT_DETAIL ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.GATE_SYS_ID = X.GATE_SYS_ID
LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = X.PLANT_ID AND TM.TRANS_SYS_ID = X.TRANS_SYS_ID
LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = X.PLANT_ID AND PM.PROD_SYS_ID = X.PROD_SYS_ID
LEFT JOIN rfid_master RM ON RM.PLANT_ID = X.PLANT_ID AND RM.RFSYSID = X.RFSYSID 
GROUP BY X.PLANT_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, VEHICLE_NO, MDA_NO, Expected_Shipper, Loaded_Shipper, GATE_IN_DT, GATE_OUT_DT, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, X.PLANT_CD, X.TRANS_SYS_ID, X.PROD_SYS_ID, WH_CD, PARTY_NAME, DIST, DESP_PLACE, RFSYSID, ZZ.WT_SYS_ID, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, ZZ.TARE_WT_DT, ZZ.GROSS_WT, ZZ.GROSS_WT_NOTE, ZZ.GROSS_WT_DT, ZZ.NET_WT, ZZ.TOLERANCE_WT, X.BAG_NOS
ORDER BY PLANT_ID, GATE_IN_DT DESC, GATE_SYS_ID DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_WEIGHMENT_OUT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_WEIGHMENT_OUT_GET`(
	IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(10),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
WITH TBL_GATE_IN_MDA AS (SELECT X.PLANT_ID, X.GATE_SYS_ID, X.TRUCK_NO VEHICLE_NO, X.MDA_SYS_ID, Z.MDA_NO
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER
        , IF(X.DRIVER_CHANGED = 1, X.DRIVER_NAME_NEW, X.DRIVER_NAME) AS DRIVER_NAME
        , IF(X.DRIVER_CHANGED = 1, X.DRIVER_CONTACT_NEW, X.DRIVER_CONTACT) AS DRIVER_CONTACT, X.DRIVER_CHANGED
		, Z.PLANT_CD, X.TRANS_SYS_ID, Z.WH_CD, Z.PARTY_NAME, Z.DIST, Z.DESP_PLACE
        , X.VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID, IFNULL(EXPECTED_QTY, 0) Expected_Shipper
		FROM exp_fg_gate_in_out X
		INNER JOIN mda_header Z ON X.PLANT_ID = Z.PLANT_ID AND Z.MDA_SYS_ID = X.MDA_SYS_ID
		WHERE X.GATE_OUT_DT IS NULL AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND Z.OUT_TIME IS NULL 
        AND IF(TRIM(IFNULL(P_SEARCHTERM,'')) = '', TRUE, 
				(X.TRUCK_NO = TRIM(IFNULL(P_SEARCHTERM,'')) OR Z.MDA_NO = TRIM(IFNULL(P_SEARCHTERM,'')) 
					OR X.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' 
									AND (ZX.RFIDSRNO = TRIM(IFNULL(P_SEARCHTERM,'')) OR ZX.RFIDCODE = TRIM(IFNULL(P_SEARCHTERM,''))))
				))
		AND 0 < (SELECT COUNT(*) FROM exp_fg_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) = 0 AND XZ.GROSS_WT_DT IS NULL)
		ORDER BY X.GATE_IN_DT DESC
)
, TBL_RESULT AS (
SELECT X.PLANT_ID, GATE_SYS_ID, VEHICLE_NO, X.MDA_SYS_ID, X.MDA_NO, GATE_IN_DT, GATE_OUT_DT
				, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME
                , DIST, DESP_PLACE, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
                , Expected_Shipper, ZZ.PROD_SYS_ID
                , (SELECT COUNT(*) FROM exp_mda_pallate_loading eml WHERE eml.MDA_SYS_ID = X.MDA_SYS_ID AND eml.GATE_SYS_ID = X.GATE_SYS_ID ) Loaded_Shipper
		FROM TBL_GATE_IN_MDA X
		LEFT JOIN mda_detail ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.MDA_SYS_ID = X.MDA_SYS_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY GATE_IN_DT DESC, GATE_SYS_ID DESC)) AS SR_NO
, X.PLANT_ID, X.GATE_SYS_ID, MDA_SYS_ID, VEHICLE_NO, MDA_NO, Expected_Shipper, Loaded_Shipper
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
    , DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
	, X.PLANT_CD, X.TRANS_SYS_ID, TM.TPTR_NAME AS TRANS_NAME, X.PROD_SYS_ID, WH_CD, PARTY_NAME
    , DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
    , DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, ZZ.WT_SYS_ID, ZZ.TARE_WT WEIGH_IN_WT, ZZ.TARE_WT_NOTE WEIGH_IN_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS WEIGH_IN_WT_DT
FROM TBL_RESULT X
INNER JOIN EXP_FG_WEIGHMENT_DETAIL ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.GATE_SYS_ID = X.GATE_SYS_ID
LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = X.PLANT_ID AND TM.TRANS_SYS_ID = X.TRANS_SYS_ID
LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = X.PLANT_ID AND PM.PROD_SYS_ID = X.PROD_SYS_ID
GROUP BY X.PLANT_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, VEHICLE_NO, MDA_NO, Expected_Shipper, Loaded_Shipper, GATE_IN_DT, GATE_OUT_DT, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, X.PLANT_CD, X.TRANS_SYS_ID, X.PROD_SYS_ID, WH_CD, PARTY_NAME, ZZ.WT_SYS_ID, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, ZZ.TARE_WT_DT
ORDER BY PLANT_ID, GATE_IN_DT DESC, GATE_SYS_ID DESC;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_WEIGHMENT_OUT_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_EXP_WEIGHMENT_OUT_SAVE`(
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

    IF P_ID > 0 AND P_GATE_IN_ID > 0 THEN
        
            SELECT IFNULL(TARE_WT, 0) INTO TEMP_TARE_WT
            FROM EXP_FG_WEIGHMENT_DETAIL
            WHERE WT_SYS_ID = P_ID AND GATE_SYS_ID = P_GATE_IN_ID;

            -- Validate gross weight
            IF IFNULL(P_GROSS_WT, 0) < IFNULL(TEMP_TARE_WT, 0) THEN
                SET P_RESULT = 'E|Gross weight is less than Tare weight.|0';
            ELSE
                -- Update record
                UPDATE EXP_FG_WEIGHMENT_DETAIL
                SET GROSS_WT = P_GROSS_WT,
                    GROSS_WT_DT = NOW(),
                    GROSS_WT_MANUALLY = 1,
                    GROSS_WT_NOTE = P_GROSS_WT_NOTE,
                    NET_WT = (IFNULL(P_GROSS_WT, 0) - IFNULL(TEMP_TARE_WT, 0))
                WHERE WT_SYS_ID = P_ID AND GATE_SYS_ID = P_GATE_IN_ID;

                SET P_RESULT = 'S|Record saved successfully|0';
            END IF;
            
    END IF;

END ;;
DELIMITER ;

/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_PALLATE_CLOSE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_PALLATE_CLOSE`(IN P_ID INT, IN P_DI_NO VARCHAR(255),IN P_PLANT_ID INT, OUT P_RESULT VARCHAR(16300))
BEGIN

	DECLARE TEMP_REQUIRED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_LOADED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_REJECT_SHIPPER INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

		SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
		
		SELECT Shipper_Qty INTO TEMP_REQUIRED_SHIPPER FROM pallate_master X WHERE Id = IFNULL(P_ID,0) AND X.DI_No = TRIM(IFNULL(P_DI_NO,'')) LIMIT 1;
            
		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_ID,0) AND Z.DI_No = TRIM(IFNULL(P_DI_NO,'')) AND Z.Status = 'S';

        IF TEMP_LOADED_SHIPPER = 0 THEN                        
			SET P_RESULT = 'E|No any shipper load.|';
		ELSEIF TEMP_REQUIRED_SHIPPER <= TEMP_LOADED_SHIPPER THEN                        
			SET P_RESULT = 'E|Pallate is full.|';
		ELSEIF P_ID > 0 THEN
			UPDATE pallate_master SET Shipper_Qty = TEMP_LOADED_SHIPPER WHERE Id = P_ID AND DI_No = TRIM(IFNULL(P_DI_NO,''));
			SET P_RESULT = 'S|Record updated successfully|';
		END IF;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_PALLATE_DELETE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_PALLATE_DELETE`(
    IN P_ID INT,
    IN P_MDA_LOD_SYS_ID INT,
    IN P_ISACTIVE VARCHAR(1),
    IN P_PLANT_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN  
	DECLARE TEMP_NUM BIGINT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;
    
	SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    IF P_ID > 0 AND IFNULL(P_MDA_LOD_SYS_ID, 0) = 0 THEN
        
        SELECT COUNT(*) TEMP_NUM FROM exp_mda_pallate_loading WHERE Pallate_Id = IFNULL(P_ID,0);
        
        IF IFNULL(TEMP_NUM, 0) > 0 THEN			
			SET P_RESULT = 'E|Pallate is Loaded.|';
		ELSE 
			DELETE FROM pallate_master WHERE ID = P_ID;
			
			DELETE FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_ID,0);
			
			SET P_RESULT = 'S|Pallate deleted successfully|';
		END IF;
	ELSEIF P_ID > 0 AND IFNULL(P_MDA_LOD_SYS_ID, 0) > 0 THEN
        
        DELETE FROM exp_mda_pallate_loading WHERE MDA_LOD_SYS_ID = P_MDA_LOD_SYS_ID AND Pallate_Id = IFNULL(P_ID,0);
        
        SET P_RESULT = 'S|Pallate is Unloaded.|';
        
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_PALLATE_DI_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_PALLATE_DI_GET`(
    IN P_ID INT,
    IN P_DI_No VARCHAR(255),
    IN P_SEARCH_TERM VARCHAR(255),
    IN P_DISPLAY_LENGTH INT,
    IN P_DISPLAY_START INT,
    IN P_PLANT_ID INT
)
BEGIN
	WITH TBL_RESULT AS (SELECT MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.MDA_DT, MH.OUT_TIME, MH.PLANT_CD, MD.PROD_SYS_ID, MH.BAG_NOS
		FROM mda_header MH
		LEFT JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
		WHERE MH.OUT_TIME IS NULL
    AND IF(TRIM(IFNULL(P_DI_No,'')) = '', TRUE, MH.MDA_NO = TRIM(IFNULL(P_DI_No,'')) OR MH.DI_NO = TRIM(IFNULL(P_DI_No,'')))
		AND 0 = (select COUNT(*) FROM fg_gate_in_out GIO WHERE GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0 AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0)
	AND IF(IFNULL(P_ID,0) != -2, TRUE, 0 < (select COUNT(*) FROM Exp_fg_gate_in_out GIO INNER JOIN exp_fg_weighment_detail WD ON WD.GATE_SYS_ID = GIO.GATE_SYS_ID
    WHERE GIO.PLANT_ID = MH.PLANT_ID AND MH.MDA_SYS_ID = GIO.MDA_SYS_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0 AND IFNULL(WD.TARE_WT,0) > 0 AND WD.TARE_WT_DT IS NOT NULL))
		GROUP BY MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.MDA_DT, MH.OUT_TIME, MH.PLANT_CD, MD.PROD_SYS_ID, MH.BAG_NOS
		ORDER BY MH.PLANT_ID, MH.MDA_SYS_ID DESC, MH.MDA_DT DESC, MD.PROD_SYS_ID
	)
	SELECT (ROW_NUMBER() OVER (ORDER BY MH.MDA_SYS_ID DESC, MH.MDA_DT DESC)) AS SR_NO
	, MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO
	, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y') AS MDA_DT, DATE_FORMAT(MH.OUT_TIME, '%d/%m/%Y %H:%i') AS OUT_TIME
	, MH.BAG_NOS, CAST((BAG_NOS / 24) AS unsigned) Required_Shipper, MH.PLANT_CD
    , (SELECT COUNT(*) FROM pallate_master X
        WHERE X.DI_No = MH.DI_NO AND 0 = (select COUNT(*) FROM exp_mda_pallate_loading Z WHERE Z.PLANT_ID = X.PLANT_ID AND Z.Pallate_Id = X.ID )) pallate_count
	FROM TBL_RESULT MH
	ORDER BY MH.MDA_SYS_ID DESC, MH.MDA_DT DESC;
    
    IF IFNULL(P_ID,0) < 0 AND TRIM(IFNULL(P_DI_No,'')) != '' THEN
    
		WITH TBL_RESULT AS (SELECT PLANT_ID, Id, DI_No, Pallate_No, Pallate_Type, Shipper_Qty, Dispatch_Mode
            , (ROW_NUMBER() OVER (ORDER BY CREATED_DATETIME)) AS SR_NO
        FROM pallate_master X
        WHERE X.DI_No = TRIM(IFNULL(P_DI_No,'')))
        SELECT (SELECT COUNT(*) FROM TBL_RESULT) AS Count, PLANT_ID, Id, DI_No, Pallate_No, Pallate_Type, Shipper_Qty, (Shipper_Qty * 24) Bottle_Qty, Dispatch_Mode, SR_NO
            , (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('Pallate_Type') AND Z.LOV_CODE = Pallate_Type LIMIT 1) AS Pallate_Type_Text
            , (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('DISPATCH_MODE') AND Z.LOV_CODE = Dispatch_Mode LIMIT 1) AS Dispatch_Mode_Text
        FROM TBL_RESULT X
        WHERE IF(IFNULL(P_ID,0) != -2, TRUE, 0 = (select COUNT(*) FROM exp_mda_pallate_loading Z WHERE Z.PLANT_ID = X.PLANT_ID AND Z.Pallate_Id = X.ID )) 
        AND IF(IFNULL(P_ID,0) != -2, TRUE, 0 < (select COUNT(*) FROM pallate_shipper Z WHERE Z.Pallate_Id = X.ID AND Z.DI_No = X.DI_No ));
            
    ELSEIF IFNULL(P_ID,0) > 0 AND TRIM(IFNULL(P_DI_No,'')) != '' THEN
    
		SELECT NULL Count, Id, DI_No, Pallate_No, Pallate_Type, Shipper_Qty, (Shipper_Qty * 24) Bottle_Qty, Dispatch_Mode
            , (ROW_NUMBER() OVER (ORDER BY CREATED_DATETIME)) AS SR_NO
            , (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('Pallate_Type') AND Z.LOV_CODE = Pallate_Type LIMIT 1) AS Pallate_Type_Text
            , (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('DISPATCH_MODE') AND Z.LOV_CODE = Dispatch_Mode LIMIT 1) AS Dispatch_Mode_Text
        FROM pallate_master X
        WHERE Id = IFNULL(P_ID,0) AND X.DI_No = TRIM(IFNULL(P_DI_No,''));
            
		SELECT Id, Pallate_Id, DI_No, Shipper_QR_Code, Status, Reason, CREATED_DATETIME
            , (ROW_NUMBER() OVER (ORDER BY CREATED_DATETIME DESC)) AS SR_NO
        FROM pallate_shipper X
        WHERE Pallate_Id = IFNULL(P_ID,0) AND X.DI_No = TRIM(IFNULL(P_DI_No,''));
            
    END IF;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_PALLATE_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_PALLATE_GET`(
IN `P_ID` INT,
IN `P_ISACTIVE` VARCHAR(255),
IN `P_SEARCH_TERM` VARCHAR(255),
IN `P_DISPLAY_LENGTH` INT,
IN `P_DISPLAY_START` INT,
IN `P_PLANT_ID` INT,
IN `P_USER_ID` INT,
IN `P_ROLE_ID` INT,
IN `P_MENU_ID` INT
)
BEGIN

		IF P_ID < 0 THEN
            
			SELECT (COUNT(*) + 1) Max_Serial_No FROM pallate_master ;

        ELSEIF P_ID > 0 THEN
            
            SELECT Id, MDA_SYS_ID, Pallate_No, Pallate_Type, Shipper_Qty, Dispatch_Mode, Shipper_QR_Code, Created_DateTime, PLANT_ID
            FROM pallate_master X
            WHERE X.Id = P_ID;

        ELSE
        
            SELECT COUNT(*) AS COUNT_ROW, Id, Pallate_No, Pallate_Type, Shipper_Qty, Dispatch_Mode, Created_DateTime, PLANT_ID
            , (ROW_NUMBER() OVER (ORDER BY Created_DateTime)) AS SR_NO
            , (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('Pallate_Type') AND Z.LOV_CODE = Pallate_Type LIMIT 1) AS Pallate_Type_Text
            , (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('DISPATCH_MODE') AND Z.LOV_CODE = Dispatch_Mode LIMIT 1) AS Dispatch_Mode_Text
			FROM pallate_master X
			GROUP BY Id, Pallate_No, Pallate_Type, Shipper_Qty, Dispatch_Mode, Created_DateTime, PLANT_ID;

        END IF;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_PALLATE_MDA_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_PALLATE_MDA_SAVE`(IN P_MDA_ID          INT, IN P_GATEIN_ID          INT,
                                  IN P_DI_No    VARCHAR(255),
                                  IN P_Pallate_Id    VARCHAR(16300),
                                  IN P_PLANT_ID    INT,
                                  IN P_USER_ID    INT,
								  OUT P_RESULT VARCHAR(16300))
BEGIN
             
	DECLARE TEMP_NUM BIGINT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;
    
		SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
		
        IF IFNULL(P_MDA_ID, 0) > 0 AND IFNULL(P_GATEIN_ID, 0) > 0 AND TRIM(IFNULL(P_DI_No, '')) != '' THEN
			    
			INSERT INTO exp_mda_pallate_loading (GATE_SYS_ID, MDA_SYS_ID, Pallate_Id, DI_NO, PALLATE_NO, Created_BY_ID, Created_DateTime, PLANT_ID)
			WITH RECURSIVE split_values AS (
				SELECT 
					SUBSTRING_INDEX(P_Pallate_Id, ',', 1) AS value,  -- Extract first value
					SUBSTRING(P_Pallate_Id, LENGTH(SUBSTRING_INDEX(P_Pallate_Id, ',', 1)) + 2) AS remaining_string,  -- Get remaining string
					1 AS position
				UNION ALL
				-- Recursion: keep extracting the next values and reduce the string
				SELECT 
					SUBSTRING_INDEX(remaining_string, ',', 1),
					SUBSTRING(remaining_string, LENGTH(SUBSTRING_INDEX(remaining_string, ',', 1)) + 2),
					position + 1
				FROM split_values
				WHERE remaining_string != ''
			)        
			SELECT P_GATEIN_ID, P_MDA_ID, Z.value AS Pallate_Id, P_DI_No, Pallate_No, P_USER_ID, NOW(), P_PLANT_ID
            FROM pallate_master X, split_values Z
            WHERE X.Id = Z.value;

			SET P_RESULT = 'S|Record saved successfully|';
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_PALLATE_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_PALLATE_SAVE`(IN P_ID          INT,
                                  IN P_DI_No    VARCHAR(255),
                                  IN P_Pallate_No    VARCHAR(255),
                                  IN P_Pallate_Type    VARCHAR(255),
                                  IN P_Shipper_Qty    INT,
                                  IN P_Dispatch_Mode   VARCHAR(255),
                                  IN P_PLANT_ID    INT,
                                  IN P_USER_ID    INT,
								  OUT P_RESULT VARCHAR(16300))
BEGIN
             
	DECLARE TEMP_NUM BIGINT;
    
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
		
        SELECT COUNT(*) INTO TEMP_NUM FROM pallate_master X WHERE X.Pallate_No = P_Pallate_No AND X.Id != P_ID;
        
        IF IFNULL(TEMP_NUM, 0) > 0 THEN
			SET P_RESULT = 'E|Pallate already exists.|0';    
		ELSEIF P_ID > 0 THEN

			UPDATE pallate_master SET Pallate_No = P_Pallate_No, Pallate_Type = P_Pallate_Type, Shipper_Qty = P_Shipper_Qty, Dispatch_Mode = P_Dispatch_Mode
			WHERE Id = P_ID AND DI_No = P_DI_No;

			SET P_RESULT = 'S|Record updated successfully|';

		ELSE

			INSERT INTO pallate_master (DI_No, Pallate_No, Pallate_Type, Shipper_Qty, Dispatch_Mode, CREATED_BY, Created_DateTime, PLANT_ID)
			VALUES(P_DI_No, P_Pallate_No, P_Pallate_Type, P_Shipper_Qty, P_Dispatch_Mode, P_USER_ID, NOW(), P_PLANT_ID);

			SET P_RESULT = 'S|Record saved successfully|';
		END IF;
        
	COMMIT;
  

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_PALLATE_SHIPPER_QRCODE_CHECK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE `PC_PALLATE_SHIPPER_QRCODE_CHECK`(
IN P_QR_CODE NVARCHAR(255),
IN P_ID INT,
IN P_DI_NO NVARCHAR(255),
IN P_PLANT_ID INT,
IN P_USER_ID    INT,
OUT P_RESULT VARCHAR(16300))
BEGIN

    DECLARE last_id BIGINT DEFAULT 0;
	DECLARE TEMP_NUM INT DEFAULT 0;
	DECLARE TEMP_REQUIRED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_LOADED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_REJECT_SHIPPER INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;

		SELECT Shipper_Qty INTO TEMP_REQUIRED_SHIPPER FROM pallate_master X WHERE Id = IFNULL(P_ID,0) AND X.DI_No = TRIM(IFNULL(P_DI_NO,'')) LIMIT 1;
            
		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_ID,0) AND Z.DI_No = TRIM(IFNULL(P_DI_NO,'')) AND Z.Status = 'S';

		SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_ID,0) AND Z.DI_No = TRIM(IFNULL(P_DI_NO,'')) AND Z.Status != 'S';

        SET P_RESULT = CONCAT('E|NOK','', @errmsg,'#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|-1');

    END;

		SELECT Shipper_Qty INTO TEMP_REQUIRED_SHIPPER FROM pallate_master X WHERE Id = IFNULL(P_ID,0) AND X.DI_No = TRIM(IFNULL(P_DI_NO,'')) LIMIT 1;
            
		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_ID,0) AND Z.DI_No = TRIM(IFNULL(P_DI_NO,'')) AND Z.Status = 'S';

		SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_ID,0) AND Z.DI_No = TRIM(IFNULL(P_DI_NO,'')) AND Z.Status != 'S';

        SET P_RESULT = CONCAT('E|NOK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|0');

		IF LENGTH(IFNULL(P_QR_CODE, '')) > 0 THEN
			
            SELECT COUNT(*) INTO TEMP_NUM FROM SHIPPER_QRCODE X WHERE X.SHIPPER_QRCODE = P_QR_CODE;

			IF IFNULL(TEMP_NUM, 0) > 0 THEN						
					
				SELECT COUNT(*) INTO TEMP_NUM FROM pallate_shipper Z WHERE Z.Status = 'S' AND Z.SHIPPER_QR_CODE = P_QR_CODE;

				IF IFNULL(TEMP_NUM, 0) = 0 THEN	
										 
					IF TEMP_REQUIRED_SHIPPER >= (TEMP_LOADED_SHIPPER + 1) THEN	
								
						INSERT INTO pallate_shipper (Pallate_Id, Shipper_QR_Code, DI_No, Status, Reason, CREATED_BY, CREATED_DATETIME) 
						VALUES (IFNULL(P_ID,0), P_QR_CODE, P_DI_NO, 'S', '', P_USER_ID, NOW());
						 
						 SET last_id = LAST_INSERT_ID();
						 
						SET TEMP_LOADED_SHIPPER = TEMP_LOADED_SHIPPER + 1;
				
						IF TEMP_REQUIRED_SHIPPER = TEMP_LOADED_SHIPPER THEN                        
							SET P_RESULT = CONCAT('E|OK_Pallte is full.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);
						ELSEIF TEMP_REQUIRED_SHIPPER > TEMP_LOADED_SHIPPER THEN                        
							SET P_RESULT = CONCAT('S|OK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);
						ELSE
							SET P_RESULT = CONCAT('E|NOK_Pallte is full.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);
						END IF;
					ELSE  
							SET P_RESULT = CONCAT('E|NOK_Pallte is full.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);                
					END IF;
				ELSE				
					IF TEMP_REQUIRED_SHIPPER >= (TEMP_LOADED_SHIPPER + 1) THEN	
						SET TEMP_REJECT_SHIPPER = TEMP_REJECT_SHIPPER + 1;
					
						INSERT INTO pallate_shipper (Pallate_Id, Shipper_QR_Code, DI_No, Status, Reason, CREATED_BY, CREATED_DATETIME) 
						VALUES (IFNULL(P_ID,0), P_QR_CODE, P_DI_NO, 'R', 'Duplicate QR Code found.', P_USER_ID, NOW());
						 
						SET last_id = LAST_INSERT_ID();
						 
						SET P_RESULT = CONCAT('E|NOK_Duplicate Shipper QR Code found.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);
					ELSE  
						SET P_RESULT = CONCAT('E|NOK_Pallte is full.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);                
					END IF;   
				END IF;
			ELSE            
					SET TEMP_REJECT_SHIPPER = TEMP_REJECT_SHIPPER + 1;
            
                    INSERT INTO pallate_shipper (Pallate_Id, Shipper_QR_Code, DI_No, Status, Reason, CREATED_BY, CREATED_DATETIME) 
					VALUES (IFNULL(P_ID,0), P_QR_CODE, P_DI_NO, 'R', 'QR Code not found.', P_USER_ID, NOW());
					 
	 				 SET last_id = LAST_INSERT_ID();
                     
					SET P_RESULT = CONCAT('E|NOK_QR Code not found.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);   
			END IF;
                        
		END IF;
        
END ;;
DELIMITER ;

-- Dump completed on 2024-12-16 13:32:33
