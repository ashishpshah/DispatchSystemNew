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
-- Table structure for table `menu_master_new`
--

DROP TABLE IF EXISTS menu_master_new;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE menu_master_new (
  ID double DEFAULT NULL,
  PARENT_ID double DEFAULT NULL,
  AREA varchar(500) DEFAULT NULL,
  CONTROLLER varchar(500) DEFAULT NULL,
  DISPLAY_NAME varchar(500) DEFAULT NULL,
  `URL` varchar(500) DEFAULT NULL,
  DISPLAYORDER double DEFAULT NULL,
  ISADMIN varchar(1) DEFAULT 'N',
  IS_ACTIVE varchar(1) DEFAULT 'N',
  CREATED_BY double DEFAULT NULL,
  CREATED_DATETIME datetime DEFAULT NULL,
  MODIFIED_BY double DEFAULT NULL,
  MODIFIED_DATETIME datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_master_new`
--

INSERT INTO menu_master_new VALUES (7,0,NULL,NULL,'Transaction',NULL,10,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (11,7,'Admin','Vendor','Vendor',NULL,14,'Y','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (18,0,NULL,NULL,'QR Codes',NULL,17,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (20,7,'Admin','VendorERP','Copy From ERP','Admin/VendorERP/CopyFromERP',17,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (1,0,NULL,NULL,'Master',NULL,1,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (2,1,'Admin','Plant','Plant',NULL,2,'Y','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (3,1,'Admin','Role','Role',NULL,3,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (4,1,'Admin','User','User',NULL,4,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (5,1,'Admin','UserAccess','User Access',NULL,4,'N','N',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (16,7,'Admin','VendorPo','Vendor PO',NULL,15,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (6,1,'Admin','Menu','Menu',NULL,3,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (8,1,'Admin','Country','Country',NULL,11,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (9,1,'Admin','State','State',NULL,12,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (10,1,'Admin','District','District',NULL,13,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (17,7,'Admin','VendorERP','Merge Vendor',NULL,16,'Y','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (12,1,'Admin','WorkStation','Work Station',NULL,15,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (14,1,'Admin','Designation','Designation',NULL,17,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (13,1,'Admin','WorkShift','Work Shift',NULL,16,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (15,1,'Admin','Product','Product',NULL,15,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (19,18,'Admin','QRGeneration','Generation',NULL,1,'N','Y',NULL,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (21,1,'Admin','LOV','LOV',NULL,18,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (23,18,'Admin','QRCode','Search Request',NULL,2,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (27,0,NULL,NULL,'Station1 Reports',NULL,17,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (28,27,'Admin','QRCodePrintReceipt','QR Code Print Receipt',NULL,1,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (29,27,'Admin','QRCodesViewSup','QR Codes View(SUP)',NULL,2,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (30,27,'Admin','QRCodesViewOP','QR Codes View(OP)',NULL,4,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (31,27,'Admin','BottleQRCodePrintCancel','Bottle QR Code Print Cancellation',NULL,5,'N','N',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (32,27,'Admin','VendorPoVsQrCodeGen','Vendor PO Vs QR Code Generation Request Summary',NULL,6,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (38,0,'Vendor','ChangePassword','Change Password',NULL,17,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (39,0,NULL,'Home','Sync Data','Home/SyncData',19,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (52,42,'Dispatch','CancleGateIn','Cancle Gate In',NULL,10,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (42,0,NULL,NULL,'Dispatch ',NULL,20,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (43,42,'Dispatch','RFID','RFID',NULL,1,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (24,18,'Admin','QRCode','Dispatch','Admin/QRCode/Dispatch',3,'N','N',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (41,1,'Admin','Transporter','Transporter',NULL,19,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (54,42,'Dispatch','TransportOfGoods','Transport Of Goods',NULL,12,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (35,33,'Vendor','QRCode','Dispatch','Vendor/Vender/Dispatch',2,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (33,0,'Vendor',NULL,'QR Codes',NULL,18,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (34,33,'Vendor','QRCode','Print','Vendor/Vender/Print',1,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (44,42,'Dispatch','GateIn','Gate In',NULL,2,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (45,42,'Dispatch','GateOut','Gate Out',NULL,3,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (46,42,'Dispatch','Load_MDA','Load MDA',NULL,4,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (47,42,'Dispatch','LoadBatch','Load Batch',NULL,5,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (48,42,'Dispatch','WeighmentInSlip','Weighment In Slip',NULL,6,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (49,42,'Dispatch','WeighmentOutSlip','Weighment Out Slip',NULL,7,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (50,42,'Dispatch','WeightIn','Weight In',NULL,8,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (51,42,'Dispatch','WeightOut','Weight Out',NULL,9,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (57,55,'Admin','DispatchSummary','Dispatch Summary',NULL,2,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (58,55,'Admin','PlantSummary','Plant Summary',NULL,3,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (59,55,'Admin','DispatchCountSummary','Dispatch Count Summary',NULL,4,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (60,55,'Admin','GateInCancel','Gate-In Cancel',NULL,5,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (61,55,'Admin','MDADispatchShippersList','MDA Dispatch Shippers List',NULL,6,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (62,55,'Admin','MDADispatchShippersRejectList','MDA Dispatch Shippers Rejection List',NULL,7,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (55,0,NULL,NULL,'Station 7&8 Reports',NULL,21,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (56,55,'Admin','MdaStatus','MDA Status',NULL,1,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (22,7,'Admin','ChangePassword','Change Password',NULL,17,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (26,18,'Admin','QRCode','Receipt','Admin/QRCode/Receipt',18,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (25,18,'Admin','QRCode','Print','Admin/QRCode/Print',17,'N','N',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (36,27,'Admin','QRCodesView','QR Codes View',NULL,3,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (37,0,'Vendor','Vender','Dashboard',NULL,16,'N','N',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (40,7,'MDA_Automation','Load_MDA','Load MDA',NULL,18,'N','Y',1,NULL,NULL,NULL);
INSERT INTO menu_master_new VALUES (53,42,'Dispatch','LostRFIDCard','Lost RFID Card',NULL,11,'N','Y',1,NULL,NULL,NULL);

--
-- Table structure for table `role_master_new`
--

DROP TABLE IF EXISTS role_master_new;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE role_master_new (
  ROLE_ID bigint NOT NULL,
  ROLE_NAME varchar(45) DEFAULT NULL,
  PLANT_ID bigint DEFAULT NULL,
  CREATED_BY bigint DEFAULT NULL,
  CREATED_DATETIME datetime DEFAULT NULL,
  IS_ACTIVE varchar(1) DEFAULT 'Y',
  IS_ADMIN varchar(1) DEFAULT 'N',
  MODIFIED_BY bigint DEFAULT NULL,
  MODIFIED_DATETIME datetime DEFAULT NULL,
  PRIMARY KEY (ROLE_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_master_new`
--

INSERT INTO role_master_new VALUES (1,'SuperAdmin',1,1,NULL,'Y','Y',NULL,NULL);
INSERT INTO role_master_new VALUES (2,'Admin',0,1,'2024-05-29 16:23:13','Y','Y',1,'2024-05-30 09:07:50');
INSERT INTO role_master_new VALUES (3,'Station 6',0,1,'2024-05-29 17:01:28','Y','N',1,'2024-05-30 09:07:57');
INSERT INTO role_master_new VALUES (4,'Station 7',0,1,'2024-05-29 17:02:24','Y','N',1,'2024-05-30 09:08:02');

--
-- Table structure for table `role_menu_new`
--

DROP TABLE IF EXISTS role_menu_new;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE role_menu_new (
  ROLE_ID double DEFAULT NULL,
  MENU_ID double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_menu_new`
--

INSERT INTO role_menu_new VALUES (2,0);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,2);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,3);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,4);
INSERT INTO role_menu_new VALUES (2,0);
INSERT INTO role_menu_new VALUES (2,7);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,8);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,9);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,10);
INSERT INTO role_menu_new VALUES (2,7);
INSERT INTO role_menu_new VALUES (2,11);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,12);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,13);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,14);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,15);
INSERT INTO role_menu_new VALUES (2,7);
INSERT INTO role_menu_new VALUES (2,16);
INSERT INTO role_menu_new VALUES (2,7);
INSERT INTO role_menu_new VALUES (2,17);
INSERT INTO role_menu_new VALUES (2,0);
INSERT INTO role_menu_new VALUES (2,18);
INSERT INTO role_menu_new VALUES (2,18);
INSERT INTO role_menu_new VALUES (2,19);
INSERT INTO role_menu_new VALUES (2,7);
INSERT INTO role_menu_new VALUES (2,20);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,21);
INSERT INTO role_menu_new VALUES (2,7);
INSERT INTO role_menu_new VALUES (2,22);
INSERT INTO role_menu_new VALUES (2,18);
INSERT INTO role_menu_new VALUES (2,23);
INSERT INTO role_menu_new VALUES (2,18);
INSERT INTO role_menu_new VALUES (2,26);
INSERT INTO role_menu_new VALUES (2,27);
INSERT INTO role_menu_new VALUES (2,28);
INSERT INTO role_menu_new VALUES (2,27);
INSERT INTO role_menu_new VALUES (2,29);
INSERT INTO role_menu_new VALUES (2,27);
INSERT INTO role_menu_new VALUES (2,30);
INSERT INTO role_menu_new VALUES (2,27);
INSERT INTO role_menu_new VALUES (2,32);
INSERT INTO role_menu_new VALUES (2,33);
INSERT INTO role_menu_new VALUES (2,34);
INSERT INTO role_menu_new VALUES (2,33);
INSERT INTO role_menu_new VALUES (2,35);
INSERT INTO role_menu_new VALUES (2,27);
INSERT INTO role_menu_new VALUES (2,36);
INSERT INTO role_menu_new VALUES (2,0);
INSERT INTO role_menu_new VALUES (2,38);
INSERT INTO role_menu_new VALUES (2,0);
INSERT INTO role_menu_new VALUES (2,39);
INSERT INTO role_menu_new VALUES (2,7);
INSERT INTO role_menu_new VALUES (2,40);
INSERT INTO role_menu_new VALUES (2,1);
INSERT INTO role_menu_new VALUES (2,41);
INSERT INTO role_menu_new VALUES (2,42);
INSERT INTO role_menu_new VALUES (2,43);
INSERT INTO role_menu_new VALUES (2,42);
INSERT INTO role_menu_new VALUES (2,44);
INSERT INTO role_menu_new VALUES (2,42);
INSERT INTO role_menu_new VALUES (2,45);
INSERT INTO role_menu_new VALUES (2,42);
INSERT INTO role_menu_new VALUES (2,46);
INSERT INTO role_menu_new VALUES (2,42);
INSERT INTO role_menu_new VALUES (2,47);
INSERT INTO role_menu_new VALUES (2,42);
INSERT INTO role_menu_new VALUES (2,48);
INSERT INTO role_menu_new VALUES (2,42);
INSERT INTO role_menu_new VALUES (2,49);
INSERT INTO role_menu_new VALUES (2,42);
INSERT INTO role_menu_new VALUES (2,50);
INSERT INTO role_menu_new VALUES (2,42);
INSERT INTO role_menu_new VALUES (2,51);
INSERT INTO role_menu_new VALUES (2,42);
INSERT INTO role_menu_new VALUES (2,52);
INSERT INTO role_menu_new VALUES (2,42);
INSERT INTO role_menu_new VALUES (2,53);
INSERT INTO role_menu_new VALUES (2,42);
INSERT INTO role_menu_new VALUES (2,54);
INSERT INTO role_menu_new VALUES (2,55);
INSERT INTO role_menu_new VALUES (2,56);
INSERT INTO role_menu_new VALUES (2,55);
INSERT INTO role_menu_new VALUES (2,57);
INSERT INTO role_menu_new VALUES (2,55);
INSERT INTO role_menu_new VALUES (2,58);
INSERT INTO role_menu_new VALUES (2,55);
INSERT INTO role_menu_new VALUES (2,59);
INSERT INTO role_menu_new VALUES (2,55);
INSERT INTO role_menu_new VALUES (2,60);
INSERT INTO role_menu_new VALUES (2,55);
INSERT INTO role_menu_new VALUES (2,61);
INSERT INTO role_menu_new VALUES (2,55);
INSERT INTO role_menu_new VALUES (2,62);
INSERT INTO role_menu_new VALUES (3,7);
INSERT INTO role_menu_new VALUES (3,40);
INSERT INTO role_menu_new VALUES (3,42);
INSERT INTO role_menu_new VALUES (3,43);
INSERT INTO role_menu_new VALUES (3,42);
INSERT INTO role_menu_new VALUES (3,44);
INSERT INTO role_menu_new VALUES (3,42);
INSERT INTO role_menu_new VALUES (3,45);
INSERT INTO role_menu_new VALUES (3,42);
INSERT INTO role_menu_new VALUES (3,47);
INSERT INTO role_menu_new VALUES (3,42);
INSERT INTO role_menu_new VALUES (3,48);
INSERT INTO role_menu_new VALUES (3,42);
INSERT INTO role_menu_new VALUES (3,49);
INSERT INTO role_menu_new VALUES (3,42);
INSERT INTO role_menu_new VALUES (3,50);
INSERT INTO role_menu_new VALUES (3,42);
INSERT INTO role_menu_new VALUES (3,51);
INSERT INTO role_menu_new VALUES (3,42);
INSERT INTO role_menu_new VALUES (3,52);
INSERT INTO role_menu_new VALUES (3,42);
INSERT INTO role_menu_new VALUES (3,53);
INSERT INTO role_menu_new VALUES (3,42);
INSERT INTO role_menu_new VALUES (3,54);
INSERT INTO role_menu_new VALUES (4,55);
INSERT INTO role_menu_new VALUES (4,56);
INSERT INTO role_menu_new VALUES (4,55);
INSERT INTO role_menu_new VALUES (4,57);
INSERT INTO role_menu_new VALUES (4,55);
INSERT INTO role_menu_new VALUES (4,58);
INSERT INTO role_menu_new VALUES (4,55);
INSERT INTO role_menu_new VALUES (4,59);
INSERT INTO role_menu_new VALUES (4,55);
INSERT INTO role_menu_new VALUES (4,60);
INSERT INTO role_menu_new VALUES (4,55);
INSERT INTO role_menu_new VALUES (4,61);
INSERT INTO role_menu_new VALUES (4,55);
INSERT INTO role_menu_new VALUES (4,62);

--
-- Table structure for table `user_master_new`
--

DROP TABLE IF EXISTS user_master_new;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE user_master_new (
  ID double NOT NULL,
  USER_NAME varchar(100) DEFAULT NULL,
  USER_PASSWORD varchar(100) DEFAULT NULL,
  FIRST_NAME varchar(45) DEFAULT NULL,
  MIDDLE_NAME varchar(45) DEFAULT NULL,
  LAST_NAME varchar(45) DEFAULT NULL,
  MOBILE_NO varchar(10) DEFAULT NULL,
  ALT_MOBILE_NO varchar(10) DEFAULT NULL,
  EMAIL_ID varchar(30) DEFAULT NULL,
  ALT_EMAIL_ID varchar(30) DEFAULT NULL,
  FULL_ADDRESS varchar(200) DEFAULT NULL,
  COUNTRY_ID bigint DEFAULT NULL,
  STATE_ID bigint DEFAULT NULL,
  DISTRICT_ID bigint DEFAULT NULL,
  CITY varchar(30) DEFAULT NULL,
  POSTAL_CODE varchar(8) DEFAULT NULL,
  EMP_CODE varchar(10) DEFAULT NULL,
  EMP_DESIGNATION_ID bigint DEFAULT NULL,
  EMP_WORK_SHIFT_ID bigint DEFAULT NULL,
  EMP_WORK_STATION_ID bigint DEFAULT NULL,
  IS_LOCK varchar(1) DEFAULT 'N',
  NOTE_FEEDBACK varchar(100) DEFAULT NULL,
  IS_ACTIVE varchar(1) DEFAULT 'N',
  CREATED_BY double DEFAULT NULL,
  CREATED_DATETIME datetime DEFAULT NULL,
  MODIFIED_BY double DEFAULT NULL,
  MODIFIED_DATETIME datetime DEFAULT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_master_new`
--

INSERT INTO user_master_new VALUES (1,'Admin','OxJcKnX/dBM=','Super',NULL,'Admin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'N',NULL,'Y',NULL,NULL,NULL,NULL);
INSERT INTO user_master_new VALUES (2,'Station 6 User','SM8c7ckHAFA=','NAZ',NULL,'NA','9999999999',NULL,'example@mail.com',NULL,'NA',0,0,0,NULL,'0','',0,0,0,'N','','Y',1,'2024-05-29 16:39:36',1,'2024-05-30 09:00:52');
INSERT INTO user_master_new VALUES (3,'Station 6 Admin ','OxJcKnX/dBM=','Admin',NULL,'NA','9999999999',NULL,'example@mail.com',NULL,'NA',0,0,0,NULL,'0','',0,0,0,'N','','Y',1,'2024-05-29 17:06:44',1,'2024-05-29 17:06:44');
INSERT INTO user_master_new VALUES (4,'Station 7 User','OxJcKnX/dBM=','User',NULL,'NA','9999999999',NULL,'example@mail.com',NULL,'NA',0,0,0,NULL,'0','',0,0,0,'N','','Y',1,'2024-05-29 17:07:32',1,'2024-05-29 17:07:32');

--
-- Table structure for table `user_role_new`
--

DROP TABLE IF EXISTS user_role_new;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE user_role_new (
  USER_ID double DEFAULT NULL,
  PLANT_ID double DEFAULT NULL,
  ROLE_ID double DEFAULT NULL,
  CREATED_BY double DEFAULT NULL,
  CREATED_DATETIME datetime DEFAULT NULL,
  MODIFIED_BY double DEFAULT NULL,
  MODIFIED_DATETIME datetime DEFAULT NULL,
  IS_DEFAULT varchar(1) DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role_new`
--

INSERT INTO user_role_new VALUES (1,4,1,1,NULL,NULL,NULL,'Y');
INSERT INTO user_role_new VALUES (3,4,2,1,'2024-05-29 17:06:44',NULL,NULL,'Y');
INSERT INTO user_role_new VALUES (4,4,4,1,'2024-05-29 17:07:32',NULL,NULL,'Y');
INSERT INTO user_role_new VALUES (2,4,3,1,'2024-05-30 09:00:52',NULL,NULL,'Y');



DELIMITER ;;
CREATE DEFINER=`iffco`@`%` PROCEDURE PC_LOGIN_AUTH(
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
CREATE DEFINER=`iffco`@`%` PROCEDURE PC_MENU_GET(
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
        UPDATE MENU_MASTER_NEW SET PARENT_ID = P_PARENT_ID, AREA = P_AREA, CONTROLLER = P_CONTROLLER, DISPLAY_NAME = P_NAME, URL = P_URL, DISPLAYORDER = TEMP_DISPLAYORDER, ISADMIN = P_ISADMIN, IS_ACTIVE = P_ISACTIVE, MODIFIED_BY = P_USER_ID, MODIFIED_DATETIME = NOW()
        WHERE ID = P_ID;
        
        SET P_RESULT := 'S|Record updated successfully|';
    ELSE
        SELECT COALESCE(MAX(ID), 0) + 1 INTO TEMP_NUM FROM MENU_MASTER_NEW;
        SELECT COALESCE(MAX(DISPLAYORDER), 0) + 1 INTO TEMP_DISPLAYORDER FROM MENU_MASTER_NEW WHERE PARENT_ID = P_PARENT_ID;
    
        INSERT INTO MENU_MASTER_NEW (ID, PARENT_ID, AREA, CONTROLLER, DISPLAY_NAME, URL, DISPLAYORDER, ISADMIN, IS_ACTIVE, CREATED_BY, CREATED_DATETIME, MODIFIED_BY, MODIFIED_DATETIME)
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
CREATE DEFINER=`iffco`@`%` PROCEDURE PC_PLANT_GET(
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
CREATE DEFINER=`iffco`@`%` PROCEDURE PC_ROLE_DELETE(
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
CREATE DEFINER=`iffco`@`%` PROCEDURE PC_ROLE_GET(
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
CREATE DEFINER=`iffco`@`%` PROCEDURE PC_ROLE_SAVE(
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
CREATE DEFINER=`iffco`@`%` PROCEDURE PC_USER_DELETE(
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
CREATE DEFINER=`iffco`@`%` PROCEDURE PC_USER_GET(
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
CREATE DEFINER=`iffco`@`%` PROCEDURE PC_USER_SAVE(
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
				SET v_counter = 1;
				SET v_plant_role  = '';

				SET v_plant_role = REGEXP_SUBSTR(P_PLANT_ROLE, '[^,]+', 1, v_counter);

				WHILE v_plant_role IS NOT NULL DO
                
					INSERT INTO USER_ROLE_NEW (USER_ID, PLANT_ID, ROLE_ID, CREATED_BY, CREATED_DATETIME)
					VALUES (P_ID, CAST(SUBSTRING_INDEX(v_plant_role, '|', 1) AS DECIMAL(10, 0)), CAST(SUBSTRING_INDEX(v_plant_role, '|', -1) AS DECIMAL(10, 0)), P_USER_ID, NOW());
                    
					SET v_counter = v_counter + 1;
					SET v_plant_role = REGEXP_SUBSTR(P_PLANT_ROLE, '[^,]+', 1, v_counter);
				END WHILE;
			END IF;
            
-- Set default plant role
UPDATE USER_ROLE_NEW
SET IS_DEFAULT = 'Y'
WHERE USER_ID = P_ID AND PLANT_ID = P_DEFAULT_PLANT;

SET P_RESULT = 'S|Record updated successfully|';
ELSE
-- Insert new user
SELECT IFNULL(MAX(ID), 0) + 1 INTO TEMP_NUM FROM USER_MASTER_NEW;

INSERT INTO USER_MASTER_NEW (ID, USER_NAME, USER_PASSWORD, FIRST_NAME, MIDDLE_NAME, LAST_NAME, MOBILE_NO, ALT_MOBILE_NO, EMAIL_ID, ALT_EMAIL_ID, FULL_ADDRESS, COUNTRY_ID, STATE_ID, DISTRICT_ID, CITY, POSTAL_CODE, EMP_CODE, EMP_DESIGNATION_ID, EMP_WORK_SHIFT_ID, EMP_WORK_STATION_ID, IS_LOCK, NOTE_FEEDBACK, IS_ACTIVE, CREATED_BY, CREATED_DATETIME, MODIFIED_BY, MODIFIED_DATETIME)
VALUES(TEMP_NUM, P_USER_NAME, P_USER_PASSWORD, P_FIRST_NAME, P_MIDDLE_NAME, P_LAST_NAME, P_MOBILE_NO, P_ALT_MOBILE_NO, P_EMAIL_ID, P_ALT_EMAIL_ID, P_FULL_ADDRESS, P_COUNTRY_ID, P_STATE_ID, P_DISTRICT_ID, P_CITY, P_POSTAL_CODE, P_EMP_CODE, P_EMP_DESIGNATION_ID, P_EMP_WORK_SHIFT_ID, P_EMP_WORK_STATION_ID, P_IS_LOCK, P_NOTE_FEEDBACK, 'Y', P_USER_ID, NOW(), P_USER_ID, NOW());


			IF LENGTH(IFNULL(P_PLANT_ROLE, '')) > 0 THEN
				SET v_counter = 1;
				SET v_plant_role  = '';

				SET v_plant_role = REGEXP_SUBSTR(P_PLANT_ROLE, '[^,]+', 1, v_counter);

				WHILE v_plant_role IS NOT NULL DO
                
					INSERT INTO USER_ROLE_NEW (USER_ID, PLANT_ID, ROLE_ID, CREATED_BY, CREATED_DATETIME)
					VALUES (TEMP_NUM, CAST(SUBSTRING_INDEX(v_plant_role, '|', 1) AS DECIMAL(10, 0)), CAST(SUBSTRING_INDEX(v_plant_role, '|', -1) AS DECIMAL(10, 0)), P_USER_ID, NOW());
                    
					SET v_counter = v_counter + 1;
					SET v_plant_role = REGEXP_SUBSTR(P_PLANT_ROLE, '[^,]+', 1, v_counter);
				END WHILE;
			END IF;
            

-- Set default plant role
UPDATE USER_ROLE_NEW
SET IS_DEFAULT = 'Y'
WHERE USER_ID = TEMP_NUM AND PLANT_ID = P_DEFAULT_PLANT;

SET P_RESULT = 'S|Record saved successfully|';
END IF;

END ;;
DELIMITER ;
