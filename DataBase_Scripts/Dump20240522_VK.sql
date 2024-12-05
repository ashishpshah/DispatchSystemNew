CREATE DATABASE  IF NOT EXISTS `iffco` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `iffco`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: iffco
-- ------------------------------------------------------
-- Server version	8.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `qr_code_rejectlist`
--

DROP TABLE IF EXISTS qr_code_rejectlist;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE qr_code_rejectlist (
  PLANT_ID int DEFAULT NULL,
  BELT_NO int DEFAULT NULL,
  QRCODE varchar(50) DEFAULT NULL,
  Product_SYS_ID int DEFAULT NULL,
  MDA_NO varchar(45) DEFAULT NULL,
  REJECT_REASON varchar(100) DEFAULT NULL,
  RID int NOT NULL AUTO_INCREMENT,
  ENTRY_TIME timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  MDA_SYS_ID int DEFAULT NULL,
  PRIMARY KEY (RID),
  KEY getrejlist (PLANT_ID,BELT_NO,Product_SYS_ID,MDA_NO),
  KEY getrejdata (PLANT_ID,BELT_NO,MDA_NO) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=884 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qr_code_successlist`
--

DROP TABLE IF EXISTS qr_code_successlist;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE qr_code_successlist (
  PLANT_ID int DEFAULT NULL,
  BELT_NO int DEFAULT NULL,
  QRCODE varchar(50) DEFAULT NULL,
  Product_SYS_ID int DEFAULT NULL,
  MDA_NO varchar(45) DEFAULT NULL,
  SID int NOT NULL AUTO_INCREMENT,
  ENTRY_TIME timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  MDA_SYS_ID int DEFAULT NULL,
  PRIMARY KEY (SID),
  UNIQUE KEY uniqidx (BELT_NO,MDA_NO,QRCODE) USING BTREE,
  KEY getdata (PLANT_ID,BELT_NO,Product_SYS_ID,MDA_NO),
  KEY getsucdata (PLANT_ID,BELT_NO,MDA_NO) USING BTREE,
  KEY validateshipqr (QRCODE,BELT_NO,MDA_NO) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=8070 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'iffco'
--
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_GATE_IN_SAVE(
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
DECLARE TEMP_NUM INT DEFAULT 0;
DECLARE TEMP_COMMON_SYS_ID INT DEFAULT 0;
DECLARE TEMP_RFSYSID INT DEFAULT 0;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

IF COALESCE(P_COMMON_SYS_ID, 0) = 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 125 THEN
SELECT COUNT(*) INTO TEMP_NUM FROM MDA_HEADER WHERE MDA_NO = P_COMMON_NO;
IF COALESCE(TEMP_NUM, 0) > 0 THEN
SELECT MDA_SYS_ID INTO TEMP_COMMON_SYS_ID FROM MDA_HEADER WHERE MDA_NO = P_COMMON_NO;
END IF;
SET TEMP_NUM = 0;
ELSE
SET TEMP_COMMON_SYS_ID = P_COMMON_SYS_ID;
END IF;

IF COALESCE(P_RFSYSID, 0) <= 0 AND (LENGTH(COALESCE(P_RFID_CODE, '')) > 0 OR LENGTH(COALESCE(P_RFID_SRNO, '')) > 0) THEN
	SELECT COUNT(*) INTO TEMP_NUM FROM RFID_MASTER WHERE STATUS IN ('Active', 'A') AND (RFIDCODE = COALESCE(P_RFID_CODE, RFIDCODE) OR RFIDSRNO = COALESCE(P_RFID_SRNO, RFIDCODE));
	IF COALESCE(TEMP_NUM, 0) > 0 THEN
		SELECT RFSYSID INTO TEMP_RFSYSID FROM RFID_MASTER WHERE STATUS IN ('Active', 'A') AND (RFIDCODE = COALESCE(P_RFID_CODE, RFIDCODE) OR RFIDSRNO = COALESCE(P_RFID_SRNO, RFIDCODE));
	END IF;
		SET TEMP_NUM = 0;
ELSE
	SET TEMP_RFSYSID = P_RFSYSID;
END IF;

SELECT COUNT(*) INTO TEMP_NUM FROM FG_GATE_IN_OUT WHERE DATE(GATE_IN_DT) = DATE(CURRENT_DATE) AND INWARD_SYS_ID = COALESCE(P_INWARD_SYS_ID, 0) AND MDA_SYS_ID = COALESCE(TEMP_COMMON_SYS_ID, 0) AND GATE_SYS_ID != COALESCE(P_ID, 0);

IF COALESCE(TEMP_NUM, 0) > 0 THEN
SET P_RESULT = 'E|Entered Gate In details already exist.|0';
ELSEIF COALESCE(TEMP_RFSYSID, 0) = 0 THEN
SET P_RESULT = 'E|RFID does not exist.|0';
ELSEIF COALESCE(TEMP_COMMON_SYS_ID, 0) = 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 125 THEN
SET P_RESULT = 'E|MDA No. does not exist.|0';
ELSEIF P_ID > 0 AND COALESCE(TEMP_COMMON_SYS_ID, 0) > 0 THEN
SET P_RESULT = 'S|Record updated successfully|';

ELSEIF COALESCE(TEMP_COMMON_SYS_ID, 0) > 0 THEN
IF COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 125 THEN
SELECT COALESCE(MAX(GATE_SYS_ID), 0) + 1 INTO TEMP_NUM FROM FG_GATE_IN_OUT;

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
IFNULL(TEMP_RFSYSID, 0), IFNULL(P_RFID_RECEIVE, 0), P_STATION_ID, P_PLANT_ID, P_USER_ID, NOW()
);

SET P_RESULT = 'S|Record saved successfully|';
END IF;

UPDATE RFID_MASTER SET STATUS = 'A' WHERE RFSYSID = TEMP_RFSYSID;
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_INWARD_GET(
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_LOV_GET(
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_MDA_GET(
IN `P_ID` INT,
IN `P_SearchTerm` VARCHAR(255),
IN `P_VEHICLE_NO` VARCHAR(255)
)
BEGIN

SELECT MDA_SYS_ID ID, MDA_NO, DI_NO, PLANT_CD, DATE_FORMAT(MDA_DT, '%d/%m/%Y') AS MDA_DT, X.TRANS_SYS_ID, TPTR_CD, TPTR_NAME, WH_CD, PARTY_NAME, DRIVER,
VEHICLE_NO, MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, OUT_TIME, X.PLANT_ID, X.CREATED_DATETIME, X.IS_POSTED,
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
SELECT DISTINCT Y.MDA_DTL_SYS_ID ID, Y.MDA_SYS_ID Mda_Id, Y.MDA_NO, Y.PROD_SNO, Y.MDA_DT, Y.PROD_SYS_ID, Y.SHIPMENT_NO, X.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, X.TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER
FROM MDA_HEADER X
LEFT JOIN MDA_DETAIL Y ON Y.MDA_SYS_ID = X.MDA_SYS_ID
WHERE 1 = CASE WHEN P_ID > 0 THEN CASE WHEN X.MDA_SYS_ID = P_ID THEN 1 ELSE 0 END ELSE 1 END
AND 1 = CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN CASE WHEN UPPER(VEHICLE_NO) = UPPER(P_VEHICLE_NO) THEN 1 ELSE 0 END ELSE 1 END;

-- Creating a temporary table for TBL_Load
DROP TEMPORARY TABLE IF EXISTS TBL_Load;

CREATE TEMPORARY TABLE TBL_Load AS
SELECT Mda_Id, SUM(Loaded_Shipper) AS Loaded_Shipper
FROM (
SELECT X.Mda_Id, X.MDA_NO, Z.Loaded_Shipper
FROM TBL_MAIN X
LEFT JOIN MDA_LOADING Z ON Z.MDA_SYS_ID = X.Mda_Id
) AS XZ
GROUP BY Mda_Id, MDA_NO, Loaded_Shipper;

-- Final SELECT query
SELECT ID, X.MDA_ID, X.MDA_NO, PROD_SNO, MDA_DT, X.TRANS_SYS_ID, TPTR_CD, TPTR_NAME, WH_CD, PARTY_NAME, DRIVER, X.PROD_SYS_ID, SKU_CODE, SKU_NAME, PRD_CD, PRD_DESC,
SHIPMENT_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, Z.Loaded_Shipper, CASE WHEN Z.Loaded_Shipper = X.GROSS_QTY THEN 1 ELSE 0 END AS Is_End_Loading, Y.SHIP_PER_PALLET, ROW_NUMBER() OVER (ORDER BY X.DIST DESC) AS MDA_ORDER
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_QR_CODE_CHECK(
IN P_GATE_IN_ID INT, IN P_MDA_ID INT, IN P_PRODUCT_ID INT, IN P_QR_CODE VARCHAR(255), 
IN IS_MANUAL_SCAN INT, IN P_PLANT_ID INT, IN P_USER_ID INT, IN P_ROLE_ID INT, 
IN P_MENU_ID INT, OUT P_RESULT VARCHAR(255)
)
BEGIN
DECLARE TEMP_NUM INT DEFAULT 0;
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
			VALUES (P_PLANT_ID,NULL,P_QR_Code,P_PRODUCT_ID,P_MDA_ID);

			-- Insert into reject list
			INSERT INTO QR_Code_RejectList (PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_SYS_ID, Reason) 
			VALUES (P_PLANT_ID,NULL,P_QR_Code,P_PRODUCT_ID,P_MDA_ID,P_RESULT);

			SET P_RESULT = CONCAT('E|', P_RESULT, '|0');
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

			SET P_RESULT = 'S|Valid QR Code|0';	
		END IF;

END IF;

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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_SCAN_CODE_HISTORY_GET(
IN P_ID INT
)
BEGIN


DROP TEMPORARY TABLE IF EXISTS TBL_MAIN;

CREATE TEMPORARY TABLE TBL_MAIN AS
SELECT PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, 'S' LOG_Type FROM QR_CODE_SUCCESSLIST X WHERE X.MDA_SYS_ID = P_ID
                       UNION ALL
                       SELECT PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, 'R' LOG_Type FROM QR_CODE_REJECTLIST X WHERE X.MDA_SYS_ID = P_ID;

SET @srno := 0;
SELECT (@srno := @srno + 1) AS SRNO, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, LOG_Type FROM TBL_MAIN;

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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_SplitString(
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_SYNC_BATCH_SAVE(
    IN P_ID INT,
    IN P_ServiceID INT,
    IN P_Token VARCHAR(255),
    IN P_PlantCd VARCHAR(255),
    IN P_Batch_no VARCHAR(255),
    IN P_Mfg_Date VARCHAR(255),
    IN P_Expiry_Date VARCHAR(255),
    IN P_TOTAL_SHIPPER_QTY INT,
    IN P_ManufacturedBy VARCHAR(255),
    IN P_MarketedBy VARCHAR(255),
    IN P_ShipperQRCode_Data TEXT,
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_SHIPPER_ID INT DEFAULT 0;
    DECLARE TEMP_SHIPPER_QRCODE_ID INT DEFAULT 0;
    DECLARE TEMP_BOTTLE_QRCODE_ID INT DEFAULT 0;
    DECLARE TEMP_PLANT_ID INT DEFAULT 0;
    DECLARE TEMP_PRODUCT_ID INT DEFAULT 0;
    DECLARE TEMP_CNT INT DEFAULT 0;

            DECLARE v_counter INT DEFAULT 1;
            DECLARE v_line VARCHAR(255);
            DECLARE v_shipper_qrcode TEXT;
            DECLARE v_action VARCHAR(50);
            DECLARE v_bottle_qrcode_list TEXT;
            DECLARE v_old_qrcode VARCHAR(255);
            
                    DECLARE v_bottle_counter INT DEFAULT 1;
                    DECLARE v_bottle_qrcode VARCHAR(255);
                    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|';
    END;

    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    IF LENGTH(IFNULL(P_ShipperQRCode_Data, '')) > 0 THEN
        IF LENGTH(IFNULL(P_PlantCd, '')) > 0 THEN
            SELECT PLANTID INTO TEMP_PLANT_ID FROM PLANT_MASTER WHERE PLANTCODE = P_PlantCd;
        END IF;

        IF IFNULL(TEMP_PLANT_ID, 0) <= 0 THEN
            SET TEMP_PLANT_ID = P_PLANT_ID;
        END IF;

        SELECT COUNT(*) INTO TEMP_CNT FROM SHIPPER_QRCODE_API_TEMP WHERE BATCH_NO = P_Batch_no AND PLANT_ID = TEMP_PLANT_ID AND SHIPPER_QRCODE_API_SYSID != IFNULL(P_ID, 0);

        IF IFNULL(P_ID, 0) <= 0 AND IFNULL(TEMP_CNT, 0) <= 0 THEN
            SELECT IFNULL(MAX(SHIPPER_QRCODE_API_SYSID), 0) + 1 INTO TEMP_SHIPPER_ID FROM SHIPPER_QRCODE_API_TEMP;

            INSERT INTO SHIPPER_QRCODE_API_TEMP (
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

            SET v_counter = 1;
            SET v_line = REGEXP_SUBSTR(P_ShipperQRCode_Data, '[^<#>]+', 1, v_counter);

            WHILE v_line IS NOT NULL DO
                SET v_shipper_qrcode = REGEXP_SUBSTR(v_line, '[^|]+', 1, 2);
                SET v_action = REGEXP_SUBSTR(v_line, '[^|]+', 1, 3);
                SET v_bottle_qrcode_list = REGEXP_SUBSTR(v_line, '[^|]+', 1, 5);
                SET v_old_qrcode = REGEXP_SUBSTR(v_line, '[^|]+', 1, 6);

				IF LENGTH(IFNULL(v_action, '')) > 0 AND LENGTH(IFNULL(v_shipper_qrcode, '')) > 0 THEN
                
					IF (TRIM(UPPER(v_action)) = 'DELETE') AND LENGTH(IFNULL(v_old_qrcode, '')) > 0 THEN
                    										
						SELECT COUNT(*) INTO TEMP_CNT FROM SHIPPER_QRCODE_TEMP WHERE SHIPPER_QRCODE = v_old_qrcode AND PLANT_ID = TEMP_PLANT_ID;

						IF IFNULL(TEMP_CNT, 0) = 0 THEN
                        						
							SELECT SHIPPER_QRCODE_SYSID INTO TEMP_CNT FROM SHIPPER_QRCODE_TEMP WHERE SHIPPER_QRCODE = v_old_qrcode AND PLANT_ID = TEMP_PLANT_ID;
									
								IF IFNULL(TEMP_CNT, 0) > 0 THEN
														
									DELETE FROM bottle_qrcode_temp WHERE SHIPPER_QRCODE_SYSID = TEMP_CNT;
				
									DELETE FROM SHIPPER_QRCODE_TEMP WHERE SHIPPER_QRCODE_SYSID = TEMP_CNT;
                                    
                                    COMMIT;
								END IF;
                        END IF;
						
                    
                    END IF;
                
					SELECT COUNT(*) INTO TEMP_CNT FROM SHIPPER_QRCODE_TEMP WHERE SHIPPER_QRCODE = v_shipper_qrcode AND ACTION = v_action AND PLANT_ID = TEMP_PLANT_ID;

					IF IFNULL(TEMP_CNT, 0) = 0 THEN
						SELECT IFNULL(MAX(SHIPPER_QRCODE_SYSID), 0) + 1 INTO TEMP_SHIPPER_QRCODE_ID FROM SHIPPER_QRCODE_TEMP;

						INSERT INTO SHIPPER_QRCODE_TEMP (
							SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE_API_SYSID, PALLET_QRCODE_API_SYSID, 
							PLANT_ID, EVENTTIME, SHIPPER_QRCODE, OLD_SHIPPER_QRCODE_SYSID, STATUS, 
							ACTION, TOTAL_BOTTLES_QTY, CREATED_BY, CREATED_DATETIME
						) VALUES (
							TEMP_SHIPPER_QRCODE_ID, TEMP_SHIPPER_ID, 0, TEMP_PLANT_ID, 
							NOW(), v_shipper_qrcode, 
							(SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE_TEMP WHERE SHIPPER_QRCODE = v_old_qrcode AND PLANT_ID = TEMP_PLANT_ID LIMIT 1), 
							'a', v_action, NULL, P_USER_ID, NOW()
						);
					END IF;

					IF LENGTH(IFNULL(v_bottle_qrcode_list, '')) > 0 THEN
						SET v_bottle_counter = 1;
						SET v_bottle_qrcode  = '';

						SET v_bottle_qrcode = REGEXP_SUBSTR(v_bottle_qrcode_list, '[^,]+', 1, v_bottle_counter);

						WHILE v_bottle_qrcode IS NOT NULL DO
							SELECT COUNT(*) INTO TEMP_CNT FROM BOTTLE_QRCODE_TEMP WHERE BOTTLE_QRCODE = v_bottle_qrcode AND PLANT_ID = TEMP_PLANT_ID;

							IF IFNULL(TEMP_CNT, 0) = 0 THEN
								SELECT IFNULL(MAX(BOTTLE_QRCODE_SYSID), 0) + 1 INTO TEMP_BOTTLE_QRCODE_ID FROM BOTTLE_QRCODE_TEMP;

								SELECT COUNT(*) INTO TEMP_CNT FROM PRODUCT_MASTER WHERE GTIN IN (
									SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(v_bottle_qrcode, ')', -1), '(', 1)
								);

								IF IFNULL(TEMP_CNT, 0) > 0 THEN
									SELECT PROD_SYS_ID INTO TEMP_PRODUCT_ID FROM PRODUCT_MASTER WHERE GTIN IN (
										SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(v_bottle_qrcode, ')', -1), '(', 1)
									) LIMIT 1;
								END IF;

								INSERT INTO BOTTLE_QRCODE_TEMP (
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

					COMMIT;
                    
				END IF;

                SET v_counter = v_counter + 1;
                SET v_line = REGEXP_SUBSTR(P_ShipperQRCode_Data, '[^<#>]+', 1, v_counter);
            END WHILE;

            SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_SHIPPER_ID);
        END IF;
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_SYNC_PRODUCT_SAVE(
    IN P_JSON_LIST TEXT, 
    IN P_PLANT_CODE VARCHAR(255), 
    IN P_PLANT_ID INT, 
    IN P_USER_ID INT, 
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_PLANT_ID INT DEFAULT 0; 
    DECLARE TEMP_PRODUCT_ID INT DEFAULT 0; 
    DECLARE TEMP_CNT INT DEFAULT 0; 
    DECLARE done INT DEFAULT 0;

    DECLARE prd_cd VARCHAR(255);
    DECLARE prd_desc VARCHAR(255);
    DECLARE prd_desc_h VARCHAR(255);
    DECLARE plant_cd VARCHAR(255);
    DECLARE print_order INT;
    DECLARE prd_desc_short VARCHAR(255);
    DECLARE extra1 VARCHAR(255);
    DECLARE extra2 VARCHAR(255);
    DECLARE extra3 VARCHAR(255);
    DECLARE prd_type VARCHAR(255);
    DECLARE sub_plant_cd VARCHAR(255);
    DECLARE prd_category VARCHAR(255);
    DECLARE active VARCHAR(1);
    DECLARE hsn_code VARCHAR(255);
    DECLARE uom VARCHAR(255);
    DECLARE conv_factor DECIMAL(10,2);
    DECLARE uom_evikas VARCHAR(255);
    DECLARE prd_cd_group_app VARCHAR(255);

    DECLARE cur CURSOR FOR 
        SELECT
            IF(COL_1 = '=', NULL, COL_1) AS prd_cd,
            IF(COL_2 = '=', NULL, COL_2) AS prd_desc,
            IF(COL_3 = '=', NULL, COL_3) AS prd_desc_h,
            IF(COL_4 = '=', NULL, COL_4) AS plant_cd,
            IF(COL_5 = '=', NULL, COL_5) AS print_order,
            IF(COL_6 = '=', NULL, COL_6) AS prd_desc_short,
            IF(COL_7 = '=', NULL, COL_7) AS extra1,
            IF(COL_8 = '=', NULL, COL_8) AS extra2,
            IF(COL_9 = '=', NULL, COL_9) AS extra3,
            IF(COL_10 = '=', NULL, COL_10) AS prd_type,
            IF(COL_11 = '=', NULL, COL_11) AS sub_plant_cd,
            IF(COL_12 = '=', NULL, COL_12) AS prd_category,
            IF(COL_13 = '=', NULL, COL_13) AS active,
            IF(COL_14 = '=', NULL, COL_14) AS hsn_code,
            IF(COL_15 = '=', NULL, COL_15) AS uom,
            IF(COL_16 = '=', NULL, COL_16) AS conv_factor,
            IF(COL_17 = '=', NULL, COL_17) AS uom_evikas,
            IF(COL_18 = '=', NULL, COL_18) AS prd_cd_group_app
        FROM (
            SELECT 
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 1) AS COL_1,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 2) AS COL_2,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 3) AS COL_3,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 4) AS COL_4,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 5) AS COL_5,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 6) AS COL_6,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 7) AS COL_7,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 8) AS COL_8,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 9) AS COL_9,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 10) AS COL_10,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 11) AS COL_11,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 12) AS COL_12,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 13) AS COL_13,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 14) AS COL_14,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 15) AS COL_15,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 16) AS COL_16,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 17) AS COL_17,
                SUBSTRING_INDEX(SUBSTRING_INDEX(P_JSON_LIST, '<#>', n.n), '|', 18) AS COL_18
            FROM
                (SELECT @row := @row + 1 as n FROM (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) t1,
                (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) t2,
                (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) t3,
                (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) t4,
                (SELECT @row := 0) r) n
            WHERE n.n <= (LENGTH(P_JSON_LIST) - LENGTH(REPLACE(P_JSON_LIST, '<#>', ''))) / LENGTH('<#>') + 1
        ) as J;
           
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|';
    END;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact system administrator|0';

    IF LENGTH(IFNULL(P_JSON_LIST, '')) > 0 THEN
        IF LENGTH(IFNULL(P_PLANT_CODE, '')) > 0 THEN
            SELECT PLANTID INTO TEMP_PLANT_ID FROM PLANT_MASTER WHERE PLANTCODE = P_PLANT_CODE;
        END IF;

        IF IFNULL(TEMP_PLANT_ID, 0) <= 0 THEN
            SET TEMP_PLANT_ID = P_PLANT_ID;
        END IF;

        OPEN cur;

        read_loop: LOOP
            FETCH cur INTO prd_cd, prd_desc, prd_desc_h, plant_cd, print_order, prd_desc_short, extra1, extra2, extra3, prd_type, sub_plant_cd, prd_category, active, hsn_code, uom, conv_factor, uom_evikas, prd_cd_group_app;
            IF done THEN
                LEAVE read_loop;
            END IF;

            BEGIN
                DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET TEMP_CNT = -1;

                SELECT COUNT(*) INTO TEMP_CNT FROM PRODUCT_MASTER WHERE PRD_CD = prd_cd AND PLANT_ID = TEMP_PLANT_ID;

                IF TEMP_CNT = -1 THEN
                    LEAVE read_loop;
                END IF;

                IF IFNULL(TEMP_CNT, 0) > 0 THEN
                    SET TEMP_CNT = 0;
                ELSE
                    SELECT IFNULL(MAX(PROD_SYS_ID), 0) + 1 INTO TEMP_PRODUCT_ID FROM PRODUCT_MASTER;

                    INSERT INTO PRODUCT_MASTER(PROD_SYS_ID, SKU_CODE, SKU_NAME, PRD_CD, PRD_DESC, PRD_DESC_H, PRD_DESC_SHORT, IS_POSTED,
                                               ISACTIVE, PLANT_ID, PLANT_CD, EXTRA1, EXTRA2, EXTRA3, PRD_TYPE, SUB_PLANT_CD, PRD_CATEGORY, ACTIVE,
                                               PRD_CD_GROUP_APP, HSN_CODE, UOM, CONV_FACTOR, PRINT_ORDER, UOM_EVIKAS, CREATED_DATETIME)
                    VALUES (TEMP_PRODUCT_ID, prd_cd, prd_desc, prd_cd, prd_desc, prd_desc_h, prd_desc_short, 0,
                            IF(IFNULL(active, '') = 'Y', 1, 0), TEMP_PLANT_ID, plant_cd,
                            extra1, extra2, extra3, prd_type, sub_plant_cd, prd_category, active,
                            prd_cd_group_app, CAST(hsn_code AS DECIMAL), uom, CAST(conv_factor AS DECIMAL), CAST(print_order AS DECIMAL),
                            uom_evikas, NOW());

                    COMMIT;
                END IF;
            END;
        END LOOP;

        CLOSE cur;

        SET P_RESULT = 'S|Record saved successfully|0';
    END IF;

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
