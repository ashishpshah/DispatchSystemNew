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
-- Dumping routines for database 'iffco'
--
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_DISPATCH_COUNT_SUMMARY_REPORT(
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_DISPATCH_SUMMARY_REPORT(
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_GATE_IN_CANCEL_GET(
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
            NULL AS TRANS_SYS_ID, 
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
        WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL
            AND (
                (1 = (CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN (CASE WHEN X.MDA_SYS_ID IN (SELECT MDA_SYS_ID FROM MDA_HEADER WHERE MDA_NO = P_VEHICLE_NO OR VEHICLE_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 1 END))
                OR 
                (1 = (CASE WHEN LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 1 END))
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_GATE_IN_CANCEL_REPORT(
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
                X.WEIGHT_OUT_DT, 
                X.GATE_OUT_DT, 
                X.CANCEL_GATE_REASON 
            FROM (
                SELECT 
                    X.GATE_SYS_ID, 
                    GATE_IN_DT, 
                    GATE_OUT_DT, 
                    INWARD_SYS_ID, 
                    X.MDA_SYS_ID COMMON_SYS_ID, 
                    TO_CHAR(XZ.MDA_NO) COMMON_NO,
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
                GATE_IN_DT, 
                GATE_OUT_DT, 
                INWARD_SYS_ID, 
                X.PO_SYS_ID COMMON_SYS_ID, 
                TO_CHAR(XZ.PO_NO) COMMON_NO,
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
                GATE_IN_DT, 
                GATE_OUT_DT, 
                INWARD_SYS_ID, 
                X.SO_SYS_ID COMMON_SYS_ID, 
                TO_CHAR(XZ.SO_NO) COMMON_NO,
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_GATE_IN_CANCEL_SAVE(
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
    IF P_ID > 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 125 THEN
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
  
        UPDATE RFID_MASTER SET STATUS = 'ACT' WHERE RFSYSID = TEMP_RFSYSID;

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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_GATE_OUT_SAVE(
    IN P_ID INT,
    IN P_GATE_OUT_NOTE VARCHAR(255),
    IN P_STATION_ID INT,
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_INWARD_SYS_ID INT DEFAULT 0;

    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact the system administrator|0';

    IF NVL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        SET P_RESULT := 'E|You are not authorized to perform this operation.|0';    
    ELSEIF P_ID > 0 THEN
        SELECT INWARD_SYS_ID INTO TEMP_INWARD_SYS_ID FROM FG_GATE_IN_OUT WHERE GATE_SYS_ID = P_ID AND NVL(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL;

        IF TEMP_INWARD_SYS_ID > 0 AND TEMP_INWARD_SYS_ID = 125 THEN
            UPDATE FG_GATE_IN_OUT 
            SET GATE_OUT_DT = CURRENT_TIMESTAMP(), IS_GOODS_TRANSFER = 1
            WHERE GATE_SYS_ID = P_ID AND NVL(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL;

            SET P_RESULT := 'S|Record saved successfully|';
        END IF;
    END IF;

    -- Exception handling
    IF TEMP_INWARD_SYS_ID = 0 THEN
        SET P_RESULT := 'E|No inward record found for the provided ID|0';
    ELSE
        SET P_RESULT := CONCAT('E|Opps!... Something went wrong. Please contact the system administrator|', TEMP_INWARD_SYS_ID);
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_MDA_ADD_QTY_SAVE(
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
SHIPMENT_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, Z.Loaded_Shipper, CASE WHEN Z.Loaded_Shipper = X.GROSS_QTY THEN 1 ELSE 0 END AS Is_End_Loading, Y.SHIP_PER_PALLET
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_MDA_STATUS_REPORT(
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_NEW_TRUCK_SAVE(
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

        IF COALESCE(P_ID, 0) > 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 125 THEN
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_OLD_TRUCK_SAVE(
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

        IF COALESCE(P_ID, 0) > 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 125 THEN
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_QR_CODE_GET(
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_RFID_DELETE(
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
/*!50003 DROP PROCEDURE IF EXISTS PC_RFID_LOST_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE PC_RFID_LOST_SAVE(
    IN P_ID INT,
    IN P_REF_SYS_ID INT,
    IN P_INWARD_SYS_ID INT,
    IN P_REF_SYS_ID_OLD INT,
    IN P_STATION_ID INT,
    IN P_REASON VARCHAR(255),
    IN P_REMARK VARCHAR(255),
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
    
    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact system administrator|1';

    IF NVL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        SET P_RESULT := 'E|You are not authorized to perform this operation.|0';
    ELSE
        IF TEMP_NUM = 0 THEN
            SELECT COALESCE(MAX(RFLOST_SYS_ID), 0) + 1 INTO TEMP_NUM FROM RFID_LOST_TEMP;

            INSERT INTO RFID_LOST_TEMP (RFLOST_SYS_ID, REF_SYS_ID, INWARD_SYS_ID, REF_SYS_ID_OLD, REASON, REMARK, RFID_LOST_DATE, STATION_ID, PLANT_ID, IS_ACTIVE, CREATED_BY_ID, CREATED_DATETIME)
            VALUES (TEMP_NUM, P_REF_SYS_ID, P_INWARD_SYS_ID, P_REF_SYS_ID_OLD, P_REASON, P_REMARK, NOW(), P_STATION_ID, P_PLANT_ID, P_ISACTIVE, P_USER_ID, NOW());

            UPDATE RFID_MASTER_TEMP SET STATUS = 'L' WHERE RFSYSID = P_REF_SYS_ID_OLD;
            UPDATE RFID_MASTER_TEMP SET STATUS = 'A' WHERE RFSYSID = P_REF_SYS_ID;

            IF P_ID > 0 AND P_INWARD_SYS_ID = 125 THEN
                UPDATE FG_GATE_IN_OUT SET RFSYSID = P_REF_SYS_ID WHERE GATE_SYS_ID = P_ID;
            ELSEIF P_ID > 0 AND P_INWARD_SYS_ID = 126 THEN
                UPDATE RM_GATE_IN_OUT SET RFSYSID = P_REF_SYS_ID WHERE GATE_SYS_ID = P_ID;
            ELSEIF P_ID > 0 AND P_INWARD_SYS_ID = 127 THEN
                UPDATE SP_GATE_IN_OUT SET RFSYSID = P_REF_SYS_ID WHERE GATE_SYS_ID = P_ID;
            END IF;

            SET P_RESULT := 'S|Record saved successfully|';
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_SO_SAVE(
    P_ID INT,
    P_VENDOR_ID INT,
    P_SITE_ID VARCHAR(255),
    P_SO_NO INT,
    P_SO_DATE VARCHAR(255),
    P_RIVISION VARCHAR(255),
    P_ORDER_TYPE VARCHAR(255),
    P_SO_RELEASE_DATE VARCHAR(255),
    P_SO_VALID_DATE VARCHAR(255),
    P_EMD_AMT INT,
    P_MSR_NO INT,
    P_CUST_NAME VARCHAR(255),
    P_ADDRESS VARCHAR(255),
    P_CITY VARCHAR(255),
    P_STATE VARCHAR(255),
    P_PANNO VARCHAR(255),
    P_GSTNNO VARCHAR(255),
    P_TERMS_PRICE INT,
    P_TERMS_PYMT_TERM VARCHAR(255),
    P_TERMS_LIFTING_PERIOD_DAYS INT,
    P_SO_REMARKS VARCHAR(255),
    P_STATUS_REMARKS VARCHAR(255),
    P_SO_DTLS VARCHAR(1000),
    P_ISACTIVE VARCHAR(1),
    P_PLANT_ID INT,
    P_USER_ID INT,
    P_ROLE_ID INT,
    P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE var_id_dtl INT;
    DECLARE var_line_no INT;
    DECLARE var_line_desc VARCHAR(255);
    DECLARE var_line_qty INT;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

 DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|';
    END;
    
    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact the system administrator|0';

    SELECT COUNT(*) INTO done FROM SO_HEADER X WHERE X.SO_NO = P_SO_NO AND X.SO_SYS_ID != P_ID;

    IF done = 0 THEN
        IF NVL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
            SET P_RESULT := 'E|You are not authorized to perform this operation.|0';    
        ELSEIF NVL(P_VENDOR_ID, 0) <= 0 THEN
            SET P_RESULT := 'E|Please select Vendor.|0';    
        ELSEIF P_SITE_ID IS NULL OR P_SITE_ID = '' THEN
            SET P_RESULT := 'E|Please select Vendor Site.|0';    
        ELSE
            SET done := LENGTH(P_SO_DTLS) = 0;
            
            WHILE NOT done DO
                SET var_id_dtl := SUBSTRING_INDEX(P_SO_DTLS, '<#>', 1);
                SET P_SO_DTLS := SUBSTRING(P_SO_DTLS, LENGTH(var_id_dtl) + 4);
                
                SET var_line_no := SUBSTRING_INDEX(P_SO_DTLS, '<#>', 1);
                SET P_SO_DTLS := SUBSTRING(P_SO_DTLS, LENGTH(var_line_no) + 4);
                
                SET var_line_desc := SUBSTRING_INDEX(P_SO_DTLS, '<#>', 1);
                SET P_SO_DTLS := SUBSTRING(P_SO_DTLS, LENGTH(var_line_desc) + 4);
                
                SET var_line_qty := SUBSTRING_INDEX(P_SO_DTLS, '<#>', 1);
                SET P_SO_DTLS := SUBSTRING(P_SO_DTLS, LENGTH(var_line_qty) + 4);
                
                IF var_id_dtl IS NOT NULL THEN
                    SELECT COUNT(*) INTO done FROM SO_DETAIL WHERE SO_DTL_SYS_ID = var_id_dtl AND SO_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;
                    IF done > 0 THEN
                        IF var_line_no <= 0 THEN
                            SELECT COALESCE(MAX(SLNO), 0) + 1 INTO var_line_no FROM SO_DETAIL WHERE SO_DTL_SYS_ID = var_id_dtl AND SO_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;
                        END IF;

                        UPDATE SO_DETAIL 
                        SET 
                            SLNO = var_line_no,
                            SCRAP_DESC = var_line_desc,
                            SO_QTY = var_line_qty
                        WHERE 
                            SO_DTL_SYS_ID = var_id_dtl AND SO_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;                                    
                    ELSE
                        SELECT COALESCE(MAX(SLNO), 0) + 1 INTO var_line_no FROM SO_DETAIL WHERE SO_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;
                        SELECT COALESCE(MAX(SO_DTL_SYS_ID), 0) + 1 INTO var_id_dtl FROM SO_DETAIL;
                        INSERT INTO SO_DETAIL (SO_DTL_SYS_ID, SO_SYS_ID, PLANT_ID, SLNO, SCRAP_DESC, SO_QTY)
                        VALUES (var_id_dtl, P_ID, P_PLANT_ID, var_line_no, var_line_desc, var_line_qty);
                    END IF;
                END IF;
            END WHILE;

            SET P_RESULT := 'S|Record updated successfully|' || P_ID;
        END IF;
    ELSE
        SET P_RESULT := 'E|Vendor SO is already exist.|' || P_ID;    
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_TRANSPORTER_GET(
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
        WHERE PLANT_ID = P_PLANT_ID AND X.TRANS_SYS_ID = P_ID AND X.IS_ACTIVE = CASE WHEN IFNULL(P_ISACTIVE, '') = '' THEN X.IS_ACTIVE ELSE P_ISACTIVE END;
    ELSE
        SELECT TRANS_SYS_ID AS ID, TPTR_NAME AS NAME, TPTR_CD, IS_ENTRY_MANUAL, PLANT_ID, CASE WHEN X.IS_ACTIVE = 'Y' THEN 1 ELSE 0 END AS IS_ACTIVE
        FROM TRANSPORTER_MASTER X
        WHERE PLANT_ID = P_PLANT_ID AND X.IS_ACTIVE = CASE WHEN IFNULL(P_ISACTIVE, '') = '' THEN X.IS_ACTIVE ELSE P_ISACTIVE END;
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_VENDOR_GET(
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

    IF IFNULL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) > 0 THEN
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
    END IF;

    #DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Error handling if required
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_WEIGHMENT_IN_GET(
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
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error
        ROLLBACK;
    END;
    
    START TRANSACTION;

    SELECT 
        ID, 
        DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT,
        DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT,
        INWARD_SYS_ID,
        (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE,
        COMMON_NO, COMMON_SYS_ID, TRANS_SYS_ID,
        (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) AS TRANSPORTER_NAME,
        TRUCK_NO, DRIVER_ID_TYPE,
        (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT,
        DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER, IS_UNLOAD_TRUCK,
        X.RFSYSID, XZ.RFIDSRNO, XZ.RFIDCODE,
        VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
        X.VENDOR_SYS_ID, VM.VENDOR_CODE, VM.ORGANIZATION_NAME AS VENDOR_NAME,
        X.CUST_CD, X.CUST_NAME, X.CUST_SITE_CD, X.SITE_NAME, X.STATION_ID, X.PLANT_ID, PM.PLANT_NAME, PM.PLANTCODE AS PLANT_CODE, X.IS_POSTED
    FROM (
        SELECT 
            GATE_SYS_ID AS ID, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, X.MDA_SYS_ID AS COMMON_SYS_ID,
            CAST(XZ.MDA_NO AS CHAR) AS COMMON_NO, NULL AS TRANS_SYS_ID, TRUCK_NO, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER, NULL AS IS_UNLOAD_TRUCK,
            RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
            NULL AS VENDOR_SYS_ID, XZ.WH_CD AS CUST_CD, XZ.PARTY_NAME AS CUST_NAME, NULL AS CUST_SITE_CD, NULL AS SITE_NAME, X.STATION_ID, X.PLANT_ID, X.IS_POSTED
        FROM FG_GATE_IN_OUT X
        LEFT JOIN MDA_HEADER XZ ON X.MDA_SYS_ID = XZ.MDA_SYS_ID
        WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL 
        AND (
        #1 = (CASE WHEN CHAR_LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN 
                        #(CASE WHEN MDA_SYS_ID IN (SELECT MDA_SYS_ID FROM MDA_HEADER WHERE MDA_NO = P_VEHICLE_NO OR VEHICLE_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END)
                    #ELSE 1 END) 
            #OR 
            1 = (CASE WHEN CHAR_LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN 
                        (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END)
                    ELSE 1 END)
        ) 
        #AND 0 = (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL X WHERE X.GATE_SYS_ID = GATE_SYS_ID)
        
        UNION ALL
        
        SELECT 
            GATE_SYS_ID AS ID, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, X.PO_SYS_ID AS COMMON_SYS_ID,
            CAST(XZ.PO_NO AS CHAR) AS COMMON_NO, X.TRANSPORTER_NAME, X.TRUCK_NO, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, NULL AS IS_GOODS_TRANSFER, IS_UNLOAD_TRUCK,
            RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, NULL AS GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
            XZ.VENDOR_SYS_ID, NULL AS CUST_CD, NULL AS CUST_NAME, NULL AS CUST_SITE_CD, NULL AS SITE_NAME, X.STATION_ID, X.PLANT_ID, X.IS_POSTED
        FROM RM_GATE_IN_OUT X
        LEFT JOIN PO_HEADER XZ ON X.PO_SYS_ID = XZ.PO_SYS_ID
        WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL 
        AND (
        #1 = (CASE WHEN CHAR_LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN 
                        #(CASE WHEN PO_SYS_ID IN (SELECT PO_SYS_ID FROM PO_HEADER WHERE PO_NO = P_VEHICLE_NO OR TRUCK_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END)
                    #ELSE 1 END) 
            #OR 
            1 = (CASE WHEN CHAR_LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN 
                        (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END)
                    ELSE 1 END)
        ) 
        #AND 0 = (SELECT COUNT(*) FROM RM_WEIGHMENT_DETAIL X WHERE X.GATE_SYS_ID = GATE_SYS_ID)
        
        UNION ALL
        
        SELECT 
            GATE_SYS_ID AS ID, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, X.SO_SYS_ID AS COMMON_SYS_ID,
            CAST(XZ.SO_NO AS CHAR) AS COMMON_NO, X.TRANS_SYS_ID, X.TRUCK_NO, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER, NULL AS IS_UNLOAD_TRUCK,
            RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
            XZ.VENSOR_SYS_ID AS VENDOR_SYS_ID, CAST(XZ.CUST_CD AS CHAR) AS CUST_CD, XZ.CUST_NAME, XZ.CUST_SITE_CD, XZ.SITE_NAME, X.STATION_ID, X.PLANT_ID, X.IS_POSTED
        FROM SP_GATE_IN_OUT X
        LEFT JOIN SO_HEADER XZ ON X.SO_SYS_ID = XZ.SO_SYS_ID
        WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL 
        AND (
        #1 = (CASE WHEN CHAR_LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN 
                        #(CASE WHEN SO_SYS_ID IN (SELECT SO_SYS_ID FROM SO_HEADER WHERE SO_NO = P_VEHICLE_NO OR TENDER_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END)
                    #ELSE 1 END) 
            #OR 
            1 = (CASE WHEN CHAR_LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN 
                        (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END)
                    ELSE 1 END)
        ) 
        #AND 0 = (SELECT COUNT(*) FROM SP_WEIGHMENT_DETAIL X WHERE X.GATE_SYS_ID = GATE_SYS_ID)
    ) X
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
    LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID;

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS PC_Weighment_IN_SAVE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE PC_Weighment_IN_SAVE(
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
        -- Handle the error
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator|', '|0');
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
        IF COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 125 THEN
            SELECT COUNT(*) INTO TEMP_NUM 
            FROM FG_GATE_IN_OUT 
            WHERE GATE_SYS_ID = P_ID 
                AND COALESCE(CANCEL_GATE_IN, 0) = 0 
                AND GATE_OUT_DT IS NULL 
                AND 0 = (SELECT COUNT(*) 
                         FROM FG_WEIGHMENT_DETAIL X 
                         WHERE X.GATE_SYS_ID = P_ID);
        END IF;

        IF COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 125 AND COALESCE(TEMP_NUM, 0) > 0 THEN
            -- Get the next WT_SYS_ID
            SELECT COALESCE(MAX(WT_SYS_ID), 0) + 1 INTO TEMP_NUM FROM FG_WEIGHMENT_DETAIL;

            -- Insert the record
            INSERT INTO FG_WEIGHMENT_DETAIL (
                WT_SYS_ID, GATE_SYS_ID, TARE_WT, TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME
            ) VALUES (
                TEMP_NUM, P_ID, P_TARE_WT, NOW(), 1, P_TARE_WT_NOTE, P_STATION_ID, P_PLANT_ID, P_USER_ID, NOW()
            );

            SET P_RESULT = 'S|Record saved successfully|';
        ELSE
            SET P_RESULT = 'E|Weighment Details already exist.|';
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_WEIGHMENT_IN_SLIP_GET(
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
    DECLARE done INT DEFAULT 0;
    DECLARE v_gate_sys_id INT;
    DECLARE v_common_sys_id INT;
    DECLARE v_common_no VARCHAR(255);
    #DECLARE cur_result CURSOR FOR
    
        SELECT X.WT_SYS_ID ID, X.TARE_WT, DATE_FORMAT(X.TARE_WT_DT, '%d/%m/%Y %H:%i') TARE_WT_DT, X.TARE_WT_MANUALLY, X.TARE_WT_NOTE,
               GATE_SYS_ID Gate_In_Id, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') GATE_OUT_DT,
               INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) INWARD_TYPE, COMMON_NO, COMMON_SYS_ID,
               TRANS_SYS_ID, (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) TRANSPORTER_NAME,
               TRUCK_NO, DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) DRIVER_ID_TYPE_TEXT,
               DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER, IS_UNLOAD_TRUCK,
               X.RFSYSID, XZ.RFIDSRNO, XZ.RFIDCODE,
               VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, NULL VERIFIED_OFFICER_NAME, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
               X.VENDOR_SYS_ID, VM.VENDOR_CODE, VM.ORGANIZATION_NAME VENDOR_NAME,
               X.CUST_CD, X.CUST_NAME, X.CUST_SITE_CD, X.SITE_NAME, X.STATION_ID, X.PLANT_ID, PM.PLANT_NAME, PM.PLANTCODE PLANT_CODE, X.IS_POSTED,
               X.WT_SYS_ID, X.TARE_WT, X.TARE_WT_DT, X.TARE_WT_MANUALLY, X.TARE_WT_NOTE, 
               (CASE WHEN GATE_SYS_ID_OLD > 0 THEN 'Weighment Slip - TRANSFER OF GOODS' ELSE 'Weighment Slip - Weigh In Print' END) REPORT_TITLE
        FROM (
            SELECT ZZ.WT_SYS_ID, ZZ.TARE_WT, ZZ.TARE_WT_DT, ZZ.TARE_WT_MANUALLY, ZZ.TARE_WT_NOTE,
                   X.GATE_SYS_ID, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, X.MDA_SYS_ID COMMON_SYS_ID,
                   CAST(XZ.MDA_NO AS CHAR) COMMON_NO, NULL TRANS_SYS_ID, TRUCK_NO, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER, NULL IS_UNLOAD_TRUCK,
                   RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
                   NULL VENDOR_SYS_ID, XZ.WH_CD CUST_CD, XZ.PARTY_NAME CUST_NAME, NULL CUST_SITE_CD, NULL SITE_NAME, X.STATION_ID, X.PLANT_ID, X.IS_POSTED
            FROM FG_GATE_IN_OUT X
            LEFT JOIN MDA_HEADER XZ ON X.MDA_SYS_ID = XZ.MDA_SYS_ID
            LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
            WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL
              AND (
              #1 = (CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN (CASE WHEN MDA_SYS_ID IN (SELECT MDA_SYS_ID FROM MDA_HEADER WHERE MDA_NO = P_VEHICLE_NO OR VEHICLE_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 0 END)
                   #OR 
                   1 = (CASE WHEN LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 0 END))
              AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL X WHERE ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND TARE_WT IS NOT NULL AND COALESCE(X.TARE_WT, 0) > 0)
            UNION ALL
            SELECT ZZ.WT_SYS_ID, ZZ.TARE_WT, ZZ.TARE_WT_DT, ZZ.TARE_WT_MANUALLY, ZZ.TARE_WT_NOTE,
                   X.GATE_SYS_ID, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, X.PO_SYS_ID COMMON_SYS_ID,
                   CAST(XZ.PO_NO AS CHAR) COMMON_NO, NULL TRANS_SYS_ID, X.TRUCK_NO, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, NULL IS_GOODS_TRANSFER, IS_UNLOAD_TRUCK,
                   RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, NULL GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
                   XZ.VENDOR_SYS_ID, NULL CUST_CD, NULL CUST_NAME, NULL CUST_SITE_CD, NULL SITE_NAME, X.STATION_ID, X.PLANT_ID, X.IS_POSTED
            FROM RM_GATE_IN_OUT X
            LEFT JOIN PO_HEADER XZ ON X.PO_SYS_ID = XZ.PO_SYS_ID
            LEFT JOIN RM_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
            WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL
              AND (
              #1 = (CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN (CASE WHEN PO_SYS_ID IN (SELECT PO_SYS_ID FROM PO_HEADER WHERE PO_NO = P_VEHICLE_NO OR TRUCK_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 0 END)
                   #OR 
                   1 = (CASE WHEN LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 0 END))
              AND 0 < (SELECT COUNT(*) FROM RM_WEIGHMENT_DETAIL X WHERE ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND TARE_WT IS NOT NULL AND COALESCE(X.TARE_WT, 0) > 0)
            UNION ALL
            SELECT ZZ.WT_SYS_ID, ZZ.TARE_WT, ZZ.TARE_WT_DT, ZZ.TARE_WT_MANUALLY, ZZ.TARE_WT_NOTE,
                   X.GATE_SYS_ID, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, X.SO_SYS_ID COMMON_SYS_ID,
                   CAST(XZ.SO_NO AS CHAR) COMMON_NO, X.TRANS_SYS_ID, X.TRUCK_NO, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER, NULL IS_UNLOAD_TRUCK,
                   RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
                   XZ.VENSOR_SYS_ID, CAST(XZ.CUST_CD AS CHAR) CUST_CD, XZ.CUST_NAME, XZ.CUST_SITE_CD, XZ.SITE_NAME, X.STATION_ID, X.PLANT_ID, X.IS_POSTED
            FROM SP_GATE_IN_OUT X
            LEFT JOIN SO_HEADER XZ ON X.SO_SYS_ID = XZ.SO_SYS_ID
            LEFT JOIN SP_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
            WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL
              AND (
              #1 = (CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN (CASE WHEN SO_SYS_ID IN (SELECT SO_SYS_ID FROM SO_HEADER WHERE SO_NO = P_VEHICLE_NO OR TENDER_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 0 END)
                   #OR 
                   1 = (CASE WHEN LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 0 END))
              AND 0 < (SELECT COUNT(*) FROM SP_WEIGHMENT_DETAIL X WHERE ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND TARE_WT IS NOT NULL AND COALESCE(X.TARE_WT, 0) > 0)
        ) X
        LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
        LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
        LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID;
    
    #DECLARE cur_dtls CURSOR FOR
    
        SELECT X.MDA_DTL_SYS_ID ID, COMMON_SYS_ID, COMMON_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i') MDA_DT, X.PROD_SYS_ID, PROD.SKU_CODE, PROD.SKU_NAME, PROD.PRD_CD, PROD.PRD_DESC, X.SHIPMENT_NO, X.BAG_NOS no_of_Box, X.NETT_QTY no_of_bottle, X.GROSS_QTY,
               INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) INWARD_TYPE,
               TRANS_SYS_ID, (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) TRANSPORTER_NAME,
               TRUCK_NO, DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) DRIVER_ID_TYPE_TEXT,
               DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER, IS_UNLOAD_TRUCK,
               X.RFSYSID, XZ.RFIDSRNO, XZ.RFIDCODE,
               VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, NULL VERIFIED_OFFICER_NAME, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
               X.VENDOR_SYS_ID, VM.VENDOR_CODE, VM.ORGANIZATION_NAME VENDOR_NAME,
               X.CUST_CD, X.CUST_NAME, X.CUST_SITE_CD, X.SITE_NAME, X.STATION_ID, X.PLANT_ID, PM.PLANT_NAME, PM.PLANTCODE PLANT_CODE, X.IS_POSTED
        FROM (
            SELECT ZZ.MDA_DTL_SYS_ID, ZZ.PROD_SNO, XZ.MDA_DT, ZZ.PROD_SYS_ID, ZZ.SHIPMENT_NO, ZZ.BAG_NOS, ZZ.NETT_QTY, ZZ.GROSS_QTY,
                   X.GATE_SYS_ID, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, X.MDA_SYS_ID COMMON_SYS_ID,
                   CAST(XZ.MDA_NO AS CHAR) COMMON_NO, NULL TRANS_SYS_ID, TRUCK_NO, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION, IS_GOODS_TRANSFER, NULL IS_UNLOAD_TRUCK,
                   RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, GATE_SYS_ID_OLD, CANCEL_GATE_IN, CANCEL_GATE_REASON,
                   NULL VENDOR_SYS_ID, XZ.WH_CD CUST_CD, XZ.PARTY_NAME CUST_NAME, NULL CUST_SITE_CD, NULL SITE_NAME, X.STATION_ID, X.PLANT_ID, X.IS_POSTED
            FROM FG_GATE_IN_OUT X
            LEFT JOIN MDA_HEADER XZ ON X.MDA_SYS_ID = XZ.MDA_SYS_ID
            LEFT JOIN MDA_DETAIL ZZ ON X.MDA_SYS_ID = ZZ.MDA_SYS_ID
            WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND GATE_IN_DT IS NOT NULL
              AND (
              #1 = (CASE WHEN LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 THEN (CASE WHEN MDA_SYS_ID IN (SELECT MDA_SYS_ID FROM MDA_HEADER WHERE MDA_NO = P_VEHICLE_NO OR VEHICLE_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 0 END)
                   #OR 
                   1 = (CASE WHEN LENGTH(COALESCE(P_RFID_NO, '')) > 0 THEN (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 0 END))
              AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL X WHERE 
              #Z.GATE_SYS_ID = X.GATE_SYS_ID AND 
              TARE_WT IS NOT NULL AND COALESCE(X.TARE_WT, 0) > 0)
        ) X
        LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
        LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
        LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID
        LEFT JOIN PRODUCT_MASTER PROD ON X.PROD_SYS_ID = PROD.PROD_SYS_ID;

    #OPEN cur_result;
    #OPEN cur_dtls;

    #DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    #REPEAT
        #FETCH cur_result INTO v_gate_sys_id, v_common_sys_id, v_common_no;
        -- Do something with the result here
    #UNTIL done END REPEAT;

    #CLOSE cur_result;
    #CLOSE cur_dtls;
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_WEIGHMENT_OUT_GET(
    IN P_ID INT,
    IN P_RFID_NO VARCHAR(255),
    IN P_VEHICLE_NO VARCHAR(255),
    IN P_ISACTIVE VARCHAR(10),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the exception
        ROLLBACK;
    END;
    
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
            NULL AS TRANS_SYS_ID, 
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
            SELECT * FROM FG_GATE_IN_OUT Z
            WHERE IFNULL(CANCEL_GATE_IN, 0) = 0 
            AND GATE_OUT_DT IS NULL  
            AND GATE_IN_DT IS NOT NULL 
            AND (
            #1 = (CASE WHEN LENGTH(IFNULL(P_VEHICLE_NO, '')) > 0 THEN 
                #(CASE WHEN MDA_SYS_ID IN (SELECT MDA_SYS_ID FROM MDA_HEADER WHERE MDA_NO = P_VEHICLE_NO OR VEHICLE_NO = P_VEHICLE_NO) THEN 1 ELSE 0 END) ELSE 1 END) 
                #OR 
                (1 = (CASE WHEN LENGTH(IFNULL(P_RFID_NO, '')) > 0 THEN 
                (CASE WHEN RFSYSID IN (SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO) THEN 1 ELSE 0 END) ELSE 1 END))
            ) 
            AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL X WHERE Z.GATE_SYS_ID = X.GATE_SYS_ID AND TARE_WT IS NOT NULL AND IFNULL(X.TARE_WT,0) > 0 AND GROSS_WT_DT IS NULL AND IFNULL(X.GROSS_WT,0) = 0)
        ) X
        LEFT JOIN MDA_HEADER XZ ON X.MDA_SYS_ID = XZ.MDA_SYS_ID
        LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID
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
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
    LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID;

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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_WEIGHMENT_OUT_SAVE(
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
    DECLARE TEMP_NUM INT;
    DECLARE TEMP_TARE_WT DECIMAL(10,2);
    DECLARE TEMP_INWARD_SYS_ID INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator1|1';
        ROLLBACK;
    END;

    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator0|0';

    -- Authorization check
    #IF IFNULL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT = 'E|You are not authorized to perform this operation.|0';
    #ELSE
    IF P_ID > 0 AND P_GATE_IN_ID > 0 THEN
        -- Fetch INWARD_SYS_ID
        SELECT INWARD_SYS_ID INTO TEMP_INWARD_SYS_ID
        FROM FG_GATE_IN_OUT
        WHERE GATE_SYS_ID = P_GATE_IN_ID AND IFNULL(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL;

        IF IFNULL(TEMP_INWARD_SYS_ID, 0) > 0 AND TEMP_INWARD_SYS_ID = 125 THEN
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

                SET P_RESULT = 'S|Record saved successfully|';
            END IF;
        END IF;
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
CREATE DEFINER=`admin`@`%` PROCEDURE PC_WEIGHMENT_OUT_SLIP_GET(
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
        X.TARE_WT_DT, 
        X.TARE_WT_MANUALLY, 
        X.TARE_WT_NOTE,
        GROSS_WT, 
        GROSS_WT_DT, 
        GROSS_WT_MANUALLY, 
        GROSS_WT_NOTE, 
        NET_WT, 
        OUT_OF_TOLERANCE_WT, 
        TOLERANCE_WT, 
        ALLOW_TOLERANCE_WT,
        (CASE WHEN GATE_SYS_ID_OLD > 0 THEN 'Weighment Slip - TRANSFER OF GOODS' ELSE 'Weighment Slip - Weigh Out Print' END) AS REPORT_TITLE
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
            NULL AS TRANS_SYS_ID, 
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
        WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 
            AND GATE_OUT_DT IS NULL  
            AND GATE_IN_DT IS NOT NULL 
            AND (
                LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 AND X.MDA_SYS_ID IN (
                    SELECT MDA_SYS_ID FROM MDA_HEADER WHERE MDA_NO = P_VEHICLE_NO OR VEHICLE_NO = P_VEHICLE_NO
                )
                OR LENGTH(COALESCE(P_RFID_NO, '')) > 0 AND X.RFSYSID IN (
                    SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO
                )
            ) 
            AND EXISTS (
                SELECT 1 FROM FG_WEIGHMENT_DETAIL WHERE X.GATE_SYS_ID = FG_WEIGHMENT_DETAIL.GATE_SYS_ID AND COALESCE(TARE_WT, 0) > 0 AND GROSS_WT_DT IS NOT NULL AND COALESCE(GROSS_WT, 0) > 0
            )
    ) X
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
    LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID;

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
        X.BAG_NOS AS no_of_Box, 
        X.NETT_QTY AS no_of_bottle, 
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
            NULL AS TRANS_SYS_ID, 
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
        LEFT JOIN MDA_DETAIL ZZ ON X.MDA_SYS_ID = ZZ.MDA_SYS_ID
        WHERE COALESCE(CANCEL_GATE_IN, 0) = 0 
            AND GATE_OUT_DT IS NULL  
            AND GATE_IN_DT IS NOT NULL 
            AND (
                LENGTH(COALESCE(P_VEHICLE_NO, '')) > 0 AND X.MDA_SYS_ID IN (
                    SELECT MDA_SYS_ID FROM MDA_HEADER WHERE MDA_NO = P_VEHICLE_NO OR VEHICLE_NO = P_VEHICLE_NO
                )
                OR LENGTH(COALESCE(P_RFID_NO, '')) > 0 AND X.RFSYSID IN (
                    SELECT RFSYSID FROM RFID_MASTER WHERE RFIDSRNO = P_RFID_NO OR RFIDCODE = P_RFID_NO
                )
            ) 
            AND EXISTS (
                SELECT 1 FROM FG_WEIGHMENT_DETAIL WHERE X.GATE_SYS_ID = FG_WEIGHMENT_DETAIL.GATE_SYS_ID AND COALESCE(TARE_WT, 0) > 0 AND GROSS_WT_DT IS NOT NULL AND COALESCE(GROSS_WT, 0) > 0
            )
    ) X
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
    LEFT JOIN VENDOR_MASTER VM ON X.VENDOR_SYS_ID = VM.VENDOR_SYS_ID
    LEFT JOIN PRODUCT_MASTER PROD ON X.PROD_SYS_ID = PROD.PROD_SYS_ID;

    -- Open the cursors
    #OPEN P_RESULT;
    #FETCH cur_result INTO P_RESULT;
    
    #OPEN P_DTLS;
    #FETCH cur_dtls INTO P_DTLS;

    #CLOSE cur_result;
    #CLOSE cur_dtls;
    
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
