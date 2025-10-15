-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
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
-- Table structure for table `bottle_qrcode`
--

-- DROP TABLE IF EXISTS `bottle_qrcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bottle_qrcode` (
  `bottle_qrcode_sysId` int NOT NULL AUTO_INCREMENT,
  `bottle_qrcode` varchar(50) DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `shipper_qrcode_sysId` int DEFAULT NULL,
  `plant_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_datetime` datetime DEFAULT NULL,
  `QR_REQUEST_ID` int DEFAULT NULL,
  `QR_REQUEST_FILE_NO` varchar(50) DEFAULT NULL,
  `Current_Holder_Type` varchar(1) DEFAULT NULL,
  `Current_Holder_SYS_ID` int DEFAULT NULL,
  `IS_SYNCED` int DEFAULT NULL,
  `IS_SYNCED_DATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`bottle_qrcode_sysId`),
  KEY `hashBottleQr` (`bottle_qrcode`),
  KEY `hashProductid` (`product_id`),
  KEY `ShipperSysID` (`shipper_qrcode_sysId`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=13172589 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countrymaster`
--

-- DROP TABLE IF EXISTS `countrymaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countrymaster` (
  `COUNTRY_ID` int NOT NULL AUTO_INCREMENT,
  `COUNTRY_NAME` varchar(45) DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `CREATED_BY` int DEFAULT NULL,
  `CREATED_DATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`COUNTRY_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `districtmaster`
--

-- DROP TABLE IF EXISTS `districtmaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `districtmaster` (
  `DISTRICT_ID` int NOT NULL AUTO_INCREMENT,
  `DISTRICT_NAME` varchar(45) DEFAULT NULL,
  `STATE_ID` int DEFAULT NULL,
  `COUNTRY_ID` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `CREATED_BY` int DEFAULT NULL,
  `CREATED_DATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`DISTRICT_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exp_fg_gate_in_out`
--

-- DROP TABLE IF EXISTS `exp_fg_gate_in_out`;
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
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exp_fg_weighment_detail`
--

-- DROP TABLE IF EXISTS `exp_fg_weighment_detail`;
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exp_invoice_dtls`
--

-- DROP TABLE IF EXISTS `exp_invoice_dtls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exp_invoice_dtls` (
  `Invoice_No` varchar(100) DEFAULT NULL,
  `Product_Desc` varchar(200) DEFAULT NULL,
  `HSN_Code` varchar(100) DEFAULT NULL,
  `Qty` int DEFAULT NULL,
  `Marks_No_Packing` varchar(500) DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `PLANT_ID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exp_invoice_master`
--

-- DROP TABLE IF EXISTS `exp_invoice_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exp_invoice_master` (
  `Invoice_No` varchar(100) DEFAULT NULL,
  `Invoice_Date` datetime DEFAULT NULL,
  `Order_Ref_No` varchar(100) DEFAULT NULL,
  `Order_Ref_Date` datetime DEFAULT NULL,
  `Performa_Invoice_No` varchar(100) DEFAULT NULL,
  `Performa_Invoice_Date` varchar(100) DEFAULT NULL,
  `Indent_No` varchar(100) DEFAULT NULL,
  `Plant_MDA_No` varchar(100) DEFAULT NULL,
  `Port_Loading` varchar(100) DEFAULT NULL,
  `Port_Discharge` varchar(100) DEFAULT NULL,
  `Carrier` varchar(100) DEFAULT NULL,
  `Sailing` varchar(100) DEFAULT NULL,
  `Country` varchar(100) DEFAULT NULL,
  `Incoterms2020` varchar(100) DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `PLANT_ID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exp_mda_pallate_loading`
--

-- DROP TABLE IF EXISTS `exp_mda_pallate_loading`;
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exp_mda_sequence`
--

-- DROP TABLE IF EXISTS `exp_mda_sequence`;
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
) ENGINE=MyISAM AUTO_INCREMENT=632 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fg_gate_in_out`
--

-- DROP TABLE IF EXISTS `fg_gate_in_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_gate_in_out` (
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
  `MDA_SYS_IDS` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`GATE_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=731 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fg_weighment_detail`
--

-- DROP TABLE IF EXISTS `fg_weighment_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_weighment_detail` (
  `WT_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_SYS_ID` int DEFAULT NULL,
  `GROSS_WT` double DEFAULT NULL,
  `GROSS_WT_DT` datetime DEFAULT NULL,
  `GROSS_WT_MANUALLY` tinyint(1) DEFAULT NULL,
  `GROSS_WT_NOTE` varchar(500) DEFAULT NULL,
  `TARE_WT` double DEFAULT NULL,
  `TARE_WT_DT` datetime DEFAULT NULL,
  `TARE_WT_MANUALLY` tinyint(1) DEFAULT NULL,
  `TARE_WT_NOTE` varchar(500) DEFAULT NULL,
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
) ENGINE=MyISAM AUTO_INCREMENT=551 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inward_master`
--

-- DROP TABLE IF EXISTS `inward_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inward_master` (
  `INWARD_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `INWARD_TYPE` varchar(20) NOT NULL,
  `IS_POSTED` tinyint(1) NOT NULL,
  `order_by` int DEFAULT '0',
  PRIMARY KEY (`INWARD_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_service`
--

-- DROP TABLE IF EXISTS `log_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_service` (
  `ID` bigint NOT NULL AUTO_INCREMENT,
  `MESSAGE` longtext NOT NULL,
  `CREATED_DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=80530 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lov_master`
--

-- DROP TABLE IF EXISTS `lov_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lov_master` (
  `LOV_COLUMN` varchar(30) NOT NULL,
  `LOV_CODE` varchar(20) NOT NULL,
  `LOV_DESC` varchar(100) DEFAULT NULL,
  `DISPLAY_SEQ_NO` int DEFAULT NULL,
  `CREATEDBY` int DEFAULT NULL,
  `CREATEDDATE` datetime DEFAULT NULL,
  `LASTMODIFIEDBY` int DEFAULT NULL,
  `LASTMODIFIEDDATE` datetime DEFAULT NULL,
  `ISACTIVE` char(1) DEFAULT 'Y',
  PRIMARY KEY (`LOV_COLUMN`,`LOV_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mda_add_qty_request`
--

-- DROP TABLE IF EXISTS `mda_add_qty_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mda_add_qty_request` (
  `MDA_ADD_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_SYS_ID` int DEFAULT NULL,
  `MDA_SYS_ID` int DEFAULT NULL,
  `PROD_SYS_ID` int DEFAULT NULL,
  `REQUIRED_SHIPPER_QTY` int DEFAULT NULL,
  `REASON` varchar(20) DEFAULT NULL,
  `REQUEST_STATUS` varchar(10) DEFAULT NULL,
  `RESPONSE_MSG` varchar(30) DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`MDA_ADD_SYS_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mda_detail`
--

-- DROP TABLE IF EXISTS `mda_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mda_detail` (
  `MDA_DTL_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `MDA_SYS_ID` int DEFAULT NULL,
  `MDA_NO` varchar(15) DEFAULT NULL,
  `PROD_SNO` int DEFAULT NULL,
  `MDA_DT` datetime DEFAULT NULL,
  `PROD_SYS_ID` int DEFAULT NULL,
  `SHIPMENT_NO` int DEFAULT NULL,
  `BAG_NOS` int DEFAULT NULL,
  `NETT_QTY` int DEFAULT NULL,
  `GROSS_QTY` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`MDA_DTL_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=1038 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mda_header`
--

-- DROP TABLE IF EXISTS `mda_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mda_header` (
  `MDA_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `MDA_NO` varchar(15) DEFAULT NULL,
  `DI_NO` varchar(15) DEFAULT NULL,
  `PLANT_CD` varchar(5) DEFAULT NULL,
  `MDA_DT` datetime DEFAULT NULL,
  `TRANS_SYS_ID` int DEFAULT NULL,
  `WH_CD` varchar(15) DEFAULT NULL,
  `PARTY_NAME` varchar(100) DEFAULT NULL,
  `DRIVER` varchar(100) DEFAULT NULL,
  `VEHICLE_NO` varchar(10) DEFAULT NULL,
  `MOBILE_NO` varchar(50) DEFAULT NULL,
  `DIST` int DEFAULT NULL,
  `BAG_NOS` int DEFAULT NULL,
  `NETT_QTY` int DEFAULT NULL,
  `GROSS_QTY` int DEFAULT NULL,
  `ECHIT_NO` varchar(50) DEFAULT NULL,
  `GST_NO` varchar(20) DEFAULT NULL,
  `OUT_TIME` datetime DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  `desp_place` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`MDA_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=1029 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mda_invoice_qr`
--

-- DROP TABLE IF EXISTS `mda_invoice_qr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mda_invoice_qr` (
  `MDAInvQr_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_SYS_ID` int DEFAULT NULL,
  `MDA_SYS_ID` int DEFAULT NULL,
  `MDA_NO` varchar(45) DEFAULT NULL,
  `INVOICEQrCODE` varchar(30) DEFAULT NULL,
  `BASE64InvQrCode` longtext,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  `IS_DISPATCHED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`MDAInvQr_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=738 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mda_loading`
--

-- DROP TABLE IF EXISTS `mda_loading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mda_loading` (
  `MDA_LOD_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_SYS_ID` int DEFAULT NULL,
  `MDA_SYS_ID` int DEFAULT NULL,
  `PROD_SYS_ID` int DEFAULT NULL,
  `REQUIRED_SHIPPER` int DEFAULT NULL,
  `LOADED_SHIPPER` int DEFAULT NULL,
  `SHIPPER_QR_CODE` varchar(50) DEFAULT NULL,
  `IS_MANUAL_SCAN` tinyint(1) DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  `ENTRY_TIME` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`MDA_LOD_SYS_ID`),
  KEY `validateship` (`SHIPPER_QR_CODE`,`PROD_SYS_ID`) USING BTREE,
  KEY `shipinsert` (`GATE_SYS_ID`,`MDA_SYS_ID`,`PROD_SYS_ID`,`SHIPPER_QR_CODE`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=518821 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mda_requisition_data`
--

-- DROP TABLE IF EXISTS `mda_requisition_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mda_requisition_data` (
  `MDA_REQ_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_SYS_ID` int DEFAULT NULL,
  `TRUCK_NO` varchar(15) DEFAULT NULL,
  `MDA_NO` varchar(45) DEFAULT NULL,
  `MDA_DATE` date DEFAULT NULL,
  `PROD_SYS_ID` int DEFAULT NULL,
  `SKU_CODE` varchar(45) DEFAULT NULL,
  `SKU_NAME` varchar(45) DEFAULT NULL,
  `BOTTLE_QTY` int DEFAULT NULL,
  `CARTON_QTY` int DEFAULT NULL,
  `LOADING_BAY` varchar(45) DEFAULT NULL,
  `LOADING_BAY_SYS_ID` int DEFAULT NULL,
  `SKU_ORDER` int DEFAULT NULL,
  `STATUS_CODE` varchar(45) DEFAULT NULL,
  `LOADING_STATUS` varchar(45) DEFAULT NULL,
  `LOADED_QTY` int DEFAULT NULL,
  `SHORT_QTY` int DEFAULT NULL,
  `ADDITIONAL_QTY` int DEFAULT NULL,
  `REASON` varchar(45) DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `LOADING_PROGRESS` varchar(45) DEFAULT NULL,
  `LOADED_ITEM` int DEFAULT '0',
  `API_RESULT` varchar(45) DEFAULT NULL,
  `API_REMARK` varchar(150) DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  `LOAD_IN_TIME` datetime DEFAULT NULL,
  `LOAD_OUT_TIME` datetime DEFAULT NULL,
  `MDA_SYS_ID` int DEFAULT NULL,
  PRIMARY KEY (`MDA_REQ_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=719 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mda_sequence`
--

-- DROP TABLE IF EXISTS `mda_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mda_sequence` (
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
) ENGINE=MyISAM AUTO_INCREMENT=757 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_master_new`
--

-- DROP TABLE IF EXISTS `menu_master_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_master_new` (
  `ID` double DEFAULT NULL,
  `PARENT_ID` double DEFAULT NULL,
  `AREA` varchar(500) DEFAULT NULL,
  `CONTROLLER` varchar(500) DEFAULT NULL,
  `DISPLAY_NAME` varchar(500) DEFAULT NULL,
  `URL` varchar(500) DEFAULT NULL,
  `DISPLAYORDER` double DEFAULT NULL,
  `ISADMIN` varchar(1) DEFAULT 'N',
  `IS_ACTIVE` varchar(1) DEFAULT 'N',
  `CREATED_BY` double DEFAULT NULL,
  `CREATED_DATETIME` datetime DEFAULT NULL,
  `MODIFIED_BY` double DEFAULT NULL,
  `MODIFIED_DATETIME` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `other_detail`
--

-- DROP TABLE IF EXISTS `other_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `other_detail` (
  `OTHER_DTL_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `OTHER_SYS_ID` int DEFAULT NULL,
  `SR_NO` int DEFAULT NULL,
  `MATERIAL` varchar(500) DEFAULT NULL,
  `MATERIAL_DESC` varchar(500) DEFAULT NULL,
  `UMO` varchar(50) DEFAULT NULL,
  `QTY` decimal(10,4) DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  PRIMARY KEY (`OTHER_DTL_SYS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `other_gate_in_out`
--

-- DROP TABLE IF EXISTS `other_gate_in_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `other_gate_in_out` (
  `GATE_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_IN_DT` datetime DEFAULT NULL,
  `GATE_OUT_DT` datetime DEFAULT NULL,
  `INWARD_SYS_ID` int DEFAULT NULL,
  `OTHER_SYS_ID` int DEFAULT NULL,
  `TRANS_SYS_ID` int DEFAULT NULL,
  `TRUCK_NO` varchar(10) DEFAULT NULL,
  `TRANSACTION_TYPE` varchar(45) DEFAULT NULL,
  `DRIVER_ID_TYPE` varchar(20) DEFAULT NULL,
  `DRIVER_ID_NUMBER` varchar(30) DEFAULT NULL,
  `DRIVER_NAME` varchar(30) DEFAULT NULL,
  `DRIVER_CONTACT` varchar(10) DEFAULT NULL,
  `DRIVER_CHANGED` tinyint(1) DEFAULT NULL,
  `DRIVER_NAME_NEW` varchar(30) DEFAULT NULL,
  `DRIVER_CONTACT_NEW` varchar(10) DEFAULT NULL,
  `TRUCK_VALIDATION` tinyint(1) DEFAULT NULL,
  `RFSYSID` int DEFAULT NULL,
  `VERIFIED_DOCUMENTS` tinyint(1) DEFAULT NULL,
  `RFID_RECEIVE` tinyint(1) DEFAULT NULL,
  `VERIFIED_OFFICER_ID` varchar(50) DEFAULT NULL,
  `CANCEL_GATE_IN` tinyint(1) DEFAULT NULL,
  `CANCEL_GATE_REASON` varchar(50) DEFAULT NULL,
  `IS_UNLOAD_TRUCK` tinyint(1) DEFAULT NULL,
  `STATION_ID` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`GATE_SYS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `other_header`
--

-- DROP TABLE IF EXISTS `other_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `other_header` (
  `OTHER_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `ORDER_NO` varchar(15) DEFAULT NULL,
  `ORDER_DATE` datetime DEFAULT NULL,
  `COST_CENTER` int DEFAULT NULL,
  `DESCCRIPTION` varchar(1000) DEFAULT NULL,
  `TRANS_SYS_ID` int DEFAULT NULL,
  `TRUCK_NO` varchar(10) DEFAULT NULL,
  `IS_PO_MANUAL` tinyint(1) DEFAULT NULL,
  `STATION_ID` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`OTHER_SYS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `other_weighment_detail`
--

-- DROP TABLE IF EXISTS `other_weighment_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `other_weighment_detail` (
  `WT_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_SYS_ID` int DEFAULT NULL,
  `WeighIn_WT` double DEFAULT NULL,
  `WeighIn_WT_DT` datetime DEFAULT NULL,
  `WeighIn_WT_NOTE` varchar(50) DEFAULT NULL,
  `WeighOut_WT` double DEFAULT NULL,
  `WeighOut_WT_DT` datetime DEFAULT NULL,
  `WeighOut_WT_NOTE` varchar(50) DEFAULT NULL,
  `NET_WT` double DEFAULT NULL,
  `STATION_ID` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`WT_SYS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pallate_master`
--

-- DROP TABLE IF EXISTS `pallate_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pallate_master` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `serial_no` varchar(45) NOT NULL,
  `SSCC` varchar(45) NOT NULL,
  `Pallate_No` varchar(45) NOT NULL,
  `Pallate_Type` varchar(45) NOT NULL,
  `Shipper_Qty` int DEFAULT NULL,
  `Dispatch_Mode` varchar(45) DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `PLANT_ID` int DEFAULT NULL,
  `DI_No` varchar(100) DEFAULT NULL,
  `CREATED_BY` int DEFAULT NULL,
  PRIMARY KEY (`Id`,`serial_no`,`SSCC`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `pallate_master_BEFORE_INSERT` BEFORE INSERT ON `pallate_master` FOR EACH ROW BEGIN
	DECLARE max_serial DECIMAL;
    DECLARE AI VARCHAR(2);
    DECLARE ExtensionDigit VARCHAR(1);
    DECLARE CompanyPrefix VARCHAR(9);
    DECLARE FinalSerialReference VARCHAR(255);
    DECLARE CheckDigit_ INT;
    DECLARE serial_no_ DOUBLE;
    DECLARE serial_len INT;
    DECLARE MaxNumber INT;
    
    SET AI = '00';
	SET ExtensionDigit = '0';
	SET CompanyPrefix = '8905204';
	SET CheckDigit_ = 0;
	SET serial_no_ = 0.0;
	SET serial_len = 17 - 1 - CHAR_LENGTH(CompanyPrefix);
	SET MaxNumber = POWER(10, serial_len) - 1;

	SELECT SUBSTRING_INDEX(IFNULL(serial_no, '0.0'), '.', 1) , IF(LOCATE('.', IFNULL(serial_no, '0.0')) = 0, 0, SUBSTRING_INDEX(IFNULL(serial_no, '0.0'), '.', -1)) INTO ExtensionDigit, serial_no_
	FROM (SELECT MAX(CAST(IFNULL(serial_no, '0.0') AS DOUBLE)) serial_no FROM pallate_master WHERE LOCATE(CompanyPrefix, SSCC) > 0) Z;

	SET ExtensionDigit = IF(serial_no_ + 1 <= MaxNumber, ExtensionDigit, ExtensionDigit + 1);
	SET serial_no_ = IF(serial_no_ + 1 <= MaxNumber, serial_no_ + 1, 1);
	SET FinalSerialReference = CONCAT(ExtensionDigit, CompanyPrefix, LPAD(1, serial_len, '0'));

	-- SELECT MaxNumber, LPAD(serial_no_, serial_len, '0')serial_no, CAST(CONCAT(ExtensionDigit, '.', LPAD(serial_no_, serial_len, '0')) AS DOUBLE) serial_no_, ExtensionDigit, FinalSerialReference;

	WITH RECURSIVE SerialData AS (SELECT CONCAT(ExtensionDigit, CompanyPrefix, LPAD(serial_no_, serial_len, '0')) AS FinalSerialReference)
	, Numbers AS (
		SELECT 1 AS n, FinalSerialReference
		FROM SerialData
		UNION ALL
		SELECT n + 1, FinalSerialReference
		FROM Numbers
		WHERE n < CHAR_LENGTH(FinalSerialReference) )
	, Check_Digit AS (SELECT FinalSerialReference, (CEIL(sum_digit / 10) * 10) - sum_digit AS CheckDigit 
	FROM (SELECT FinalSerialReference,SUM(IF(index_n % 2 != 0, digit * 3, digit))sum_digit 
	FROM (SELECT FinalSerialReference, SUBSTRING(FinalSerialReference, n, 1) AS digit, n AS index_n FROM Numbers ORDER BY FinalSerialReference, n) X
	GROUP BY X.FinalSerialReference) Z GROUP BY Z.FinalSerialReference, Z.sum_digit)
	SELECT CheckDigit INTO CheckDigit_ FROM Check_Digit;
    
    SET NEW.SSCC = CONCAT(AI, CONCAT(ExtensionDigit, CompanyPrefix, LPAD(serial_no_, serial_len, '0')), CheckDigit_);    
    SET NEW.serial_no = CONCAT(ExtensionDigit, '.', LPAD(serial_no_, serial_len, '0'));
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pallate_shipper`
--

-- DROP TABLE IF EXISTS `pallate_shipper`;
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
  `PLANT_ID` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pallet_qrcode_api`
--

-- DROP TABLE IF EXISTS `pallet_qrcode_api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pallet_qrcode_api` (
  `pallet_qrcode_api_sysId` int NOT NULL AUTO_INCREMENT,
  `pallet_qrcode` varchar(45) DEFAULT NULL,
  `total_shipper_qty` int DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `plant_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_datetime` datetime DEFAULT NULL,
  `palletization_datetime` datetime DEFAULT NULL,
  `palletization_mode` varchar(10) DEFAULT NULL,
  `palletization_station` varchar(20) DEFAULT NULL,
  `Current_Holder_Type` varchar(1) DEFAULT NULL,
  `Current_Holder_SYS_ID` int DEFAULT NULL,
  `PalletID` varchar(45) DEFAULT NULL,
  `IS_SYNCED` int DEFAULT NULL,
  `IS_SYNCED_DATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`pallet_qrcode_api_sysId`),
  UNIQUE KEY `PalletID_UNIQUE` (`PalletID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plant_master`
--

-- DROP TABLE IF EXISTS `plant_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plant_master` (
  `PlantID` int NOT NULL,
  `PlantCode` varchar(45) DEFAULT NULL,
  `PlantAddress` varchar(150) DEFAULT NULL,
  `Plant_Name` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`PlantID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `po_detail`
--

-- DROP TABLE IF EXISTS `po_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `po_detail` (
  `PO_DTL_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `PO_SYS_ID` int DEFAULT NULL,
  `PO_LINE_NO` int DEFAULT NULL,
  `LINE_DESC` varchar(500) DEFAULT NULL,
  `UMO` varchar(50) DEFAULT NULL,
  `LINE_QTY` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `RECEIVE_QTY` decimal(10,0) DEFAULT NULL,
  `RECEIVE_UOM` varchar(45) DEFAULT NULL,
  `SHORT_QTY` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`PO_DTL_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `po_header`
--

-- DROP TABLE IF EXISTS `po_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `po_header` (
  `PO_SYS_ID` int NOT NULL,
  `PO_NO` varchar(15) DEFAULT NULL,
  `PO_DATE` datetime DEFAULT NULL,
  `VENDOR_SYS_ID` int DEFAULT NULL,
  `COST_CENTER` int DEFAULT NULL,
  `PO_DESCCRIPTION` varchar(1000) DEFAULT NULL,
  `TRANS_SYS_ID` int DEFAULT NULL,
  `TRUCK_NO` varchar(10) DEFAULT NULL,
  `IS_PO_MANUAL` tinyint(1) DEFAULT NULL,
  `STATION_ID` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`PO_SYS_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_master`
--

-- DROP TABLE IF EXISTS `product_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_master` (
  `PROD_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `SKU_CODE` varchar(5) DEFAULT NULL,
  `SKU_NAME` varchar(200) DEFAULT NULL,
  `PRD_CD` varchar(5) DEFAULT NULL,
  `PRD_DESC` varchar(200) DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  `PRD_WT_FILL` double DEFAULT NULL,
  `SHIP_WT_FILL` double DEFAULT NULL,
  `PROD_PER_SHIPPER` int DEFAULT NULL,
  `TOLERANCE_PER` double DEFAULT NULL,
  `PAL_WT_FILL` double DEFAULT NULL,
  `SHIP_PER_PALLET` int DEFAULT NULL,
  `NOTE` varchar(250) DEFAULT NULL,
  `ISACTIVE` tinyint(1) DEFAULT NULL,
  `prd_desc_h` varchar(45) DEFAULT NULL,
  `plant_cd` varchar(5) DEFAULT NULL,
  `print_order` int DEFAULT NULL,
  `prd_desc_short` varchar(45) DEFAULT NULL,
  `extra1` varchar(45) DEFAULT NULL,
  `extra2` varchar(45) DEFAULT NULL,
  `extra3` varchar(45) DEFAULT NULL,
  `prd_type` varchar(5) DEFAULT NULL,
  `sub_plant_cd` varchar(5) DEFAULT NULL,
  `prd_category` varchar(45) DEFAULT NULL,
  `active` varchar(1) DEFAULT NULL,
  `hsn_code` int DEFAULT NULL,
  `prd_cd_group_app` varchar(5) DEFAULT NULL,
  `uom` varchar(5) DEFAULT NULL,
  `conv_factor` double DEFAULT NULL,
  `uom_evikas` varchar(5) DEFAULT NULL,
  `GTIN` varchar(150) DEFAULT NULL,
  `BPEX` varchar(45) DEFAULT NULL,
  `VALIDITY_MONTH` int DEFAULT '24',
  PRIMARY KEY (`PROD_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qr_code_rejectlist`
--

-- DROP TABLE IF EXISTS `qr_code_rejectlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qr_code_rejectlist` (
  `PLANT_ID` int DEFAULT NULL,
  `BELT_NO` int DEFAULT NULL,
  `QRCODE` varchar(50) DEFAULT NULL,
  `Product_SYS_ID` int DEFAULT NULL,
  `MDA_NO` varchar(45) DEFAULT NULL,
  `REJECT_REASON` varchar(100) DEFAULT NULL,
  `RID` int NOT NULL AUTO_INCREMENT,
  `ENTRY_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `MDA_SYS_ID` int DEFAULT NULL,
  PRIMARY KEY (`RID`),
  KEY `getrejlist` (`PLANT_ID`,`BELT_NO`,`Product_SYS_ID`,`MDA_NO`),
  KEY `getrejdata` (`PLANT_ID`,`BELT_NO`,`MDA_NO`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=5761 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qr_code_rejectlist_log`
--

-- DROP TABLE IF EXISTS `qr_code_rejectlist_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qr_code_rejectlist_log` (
  `PLANT_ID` int DEFAULT NULL,
  `BELT_NO` int DEFAULT NULL,
  `QRCODE` varchar(50) DEFAULT NULL,
  `Product_SYS_ID` int DEFAULT NULL,
  `MDA_NO` varchar(45) DEFAULT NULL,
  `REJECT_REASON` varchar(100) DEFAULT NULL,
  `IS_POSTED` int DEFAULT NULL,
  `reg_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`reg_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2419 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qr_code_successlist`
--

-- DROP TABLE IF EXISTS `qr_code_successlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qr_code_successlist` (
  `PLANT_ID` int DEFAULT NULL,
  `BELT_NO` int DEFAULT NULL,
  `QRCODE` varchar(50) DEFAULT NULL,
  `Product_SYS_ID` int DEFAULT NULL,
  `MDA_NO` varchar(45) DEFAULT NULL,
  `SID` int NOT NULL AUTO_INCREMENT,
  `ENTRY_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `MDA_SYS_ID` int DEFAULT NULL,
  PRIMARY KEY (`SID`),
  UNIQUE KEY `uniqidx` (`BELT_NO`,`MDA_NO`,`QRCODE`) USING BTREE,
  KEY `getdata` (`PLANT_ID`,`BELT_NO`,`Product_SYS_ID`,`MDA_NO`),
  KEY `getsucdata` (`PLANT_ID`,`BELT_NO`,`MDA_NO`) USING BTREE,
  KEY `validateshipqr` (`QRCODE`,`BELT_NO`,`MDA_NO`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=460564 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qr_code_successlist_log`
--

-- DROP TABLE IF EXISTS `qr_code_successlist_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qr_code_successlist_log` (
  `PLANT_ID` int DEFAULT NULL,
  `BELT_NO` int DEFAULT NULL,
  `QRCODE` varchar(50) DEFAULT NULL,
  `Product_SYS_ID` int DEFAULT NULL,
  `MDA_NO` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qr_codes_cloud`
--

-- DROP TABLE IF EXISTS `qr_codes_cloud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qr_codes_cloud` (
  `REQUEST_NO` varchar(1045) DEFAULT NULL,
  `SERIAL_NO` varchar(1045) DEFAULT NULL,
  KEY `hashQrcode` (`SERIAL_NO`(50))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qrcode_app_identifier`
--

-- DROP TABLE IF EXISTS `qrcode_app_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrcode_app_identifier` (
  `APID1_Desc` varchar(50) DEFAULT NULL,
  `APID1_Val` varchar(50) DEFAULT NULL,
  `APID2_Desc` varchar(50) DEFAULT NULL,
  `APID2_Val` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rfid_master`
--

-- DROP TABLE IF EXISTS `rfid_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rfid_master` (
  `RFSYSID` int NOT NULL AUTO_INCREMENT,
  `RFIDSRNO` varchar(30) DEFAULT NULL,
  `RFIDCODE` varchar(49) DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `REASONFOREDIT` varchar(100) DEFAULT NULL,
  `STATION_ID` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`RFSYSID`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rm_gate_in_out`
--

-- DROP TABLE IF EXISTS `rm_gate_in_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rm_gate_in_out` (
  `GATE_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_IN_DT` datetime DEFAULT NULL,
  `GATE_OUT_DT` datetime DEFAULT NULL,
  `INWARD_SYS_ID` int DEFAULT NULL,
  `PO_SYS_ID` int DEFAULT NULL,
  `TRANSPORTER_NAME` varchar(50) DEFAULT NULL,
  `TRUCK_NO` varchar(10) DEFAULT NULL,
  `DRIVER_ID_TYPE` varchar(20) DEFAULT NULL,
  `DRIVER_ID_NUMBER` varchar(30) DEFAULT NULL,
  `DRIVER_NAME` varchar(30) DEFAULT NULL,
  `DRIVER_CONTACT` varchar(10) DEFAULT NULL,
  `DRIVER_CHANGED` tinyint(1) DEFAULT NULL,
  `DRIVER_NAME_NEW` varchar(30) DEFAULT NULL,
  `DRIVER_CONTACT_NEW` varchar(10) DEFAULT NULL,
  `TRUCK_VALIDATION` tinyint(1) DEFAULT NULL,
  `RFSYSID` int DEFAULT NULL,
  `VERIFIED_DOCUMENTS` tinyint(1) DEFAULT NULL,
  `RFID_RECEIVE` tinyint(1) DEFAULT NULL,
  `VERIFIED_OFFICER_ID` varchar(50) DEFAULT NULL,
  `CANCEL_GATE_IN` tinyint(1) DEFAULT NULL,
  `CANCEL_GATE_REASON` varchar(50) DEFAULT NULL,
  `IS_UNLOAD_TRUCK` tinyint(1) DEFAULT NULL,
  `STATION_ID` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`GATE_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rm_weighment_detail`
--

-- DROP TABLE IF EXISTS `rm_weighment_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rm_weighment_detail` (
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
  `STATION_ID` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`WT_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_master`
--

-- DROP TABLE IF EXISTS `role_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_master` (
  `ROLE_ID` int NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` varchar(45) DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `CREATED_BY` int DEFAULT NULL,
  `CREATED_DATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=231 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_master_new`
--

-- DROP TABLE IF EXISTS `role_master_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_master_new` (
  `ROLE_ID` bigint NOT NULL,
  `ROLE_NAME` varchar(45) DEFAULT NULL,
  `PLANT_ID` bigint DEFAULT NULL,
  `CREATED_BY` bigint DEFAULT NULL,
  `CREATED_DATETIME` datetime DEFAULT NULL,
  `IS_ACTIVE` varchar(1) DEFAULT 'Y',
  `IS_ADMIN` varchar(1) DEFAULT 'N',
  `MODIFIED_BY` bigint DEFAULT NULL,
  `MODIFIED_DATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_menu_new`
--

-- DROP TABLE IF EXISTS `role_menu_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_menu_new` (
  `ROLE_ID` double DEFAULT NULL,
  `MENU_ID` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipper_qr_code_file_upload_status`
--

-- DROP TABLE IF EXISTS `shipper_qr_code_file_upload_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipper_qr_code_file_upload_status` (
  `FILEUPLOADNAME` varchar(1000) NOT NULL,
  `STARTDATE` datetime NOT NULL,
  `ENDDATE` datetime DEFAULT NULL,
  `QRCODECOUNT` int DEFAULT NULL,
  `FILESTATUS` varchar(45) DEFAULT NULL,
  `REMARK` longtext NOT NULL,
  `is_rework` varchar(1) DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipper_qrcode`
--

-- DROP TABLE IF EXISTS `shipper_qrcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipper_qrcode` (
  `shipper_qrcode_sysId` int NOT NULL AUTO_INCREMENT,
  `shipper_qrcode` varchar(50) DEFAULT NULL,
  `total_bottles_qty` int DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `old_shipper_qrcode_sysId` int DEFAULT NULL,
  `shipper_qrcode_api_sysId` int DEFAULT NULL,
  `pallet_qrcode_api_sysId` int DEFAULT NULL,
  `plant_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_datetime` datetime DEFAULT NULL,
  `Current_Holder_Type` varchar(1) DEFAULT NULL,
  `Current_Holder_SYS_ID` int DEFAULT NULL,
  `IS_SYNCED` int DEFAULT NULL,
  `IS_SYNCED_DATETIME` datetime DEFAULT NULL,
  `EventTime` datetime DEFAULT NULL,
  PRIMARY KEY (`shipper_qrcode_sysId`),
  KEY `hashShipperQr` (`shipper_qrcode`),
  KEY `ShipperAndAPISysId` (`shipper_qrcode`,`shipper_qrcode_api_sysId`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=558204 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipper_qrcode_api`
--

-- DROP TABLE IF EXISTS `shipper_qrcode_api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipper_qrcode_api` (
  `shipper_qrcode_api_sysId` int NOT NULL AUTO_INCREMENT,
  `batch_no` varchar(20) DEFAULT NULL,
  `mfg_date` datetime DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `eventtime` datetime DEFAULT NULL,
  `plant_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_datetime` datetime DEFAULT NULL,
  `response_status` varchar(45) DEFAULT NULL,
  `total_shipper_qty` int DEFAULT NULL,
  `Current_Holder_Type` varchar(1) DEFAULT NULL,
  `Current_Holder_SYS_ID` int DEFAULT NULL,
  `IS_SYNCED` int DEFAULT NULL,
  `IS_SYNCED_DATETIME` datetime DEFAULT NULL,
  `ManufacturedBy` varchar(100) DEFAULT NULL,
  `MarketedBy` varchar(100) DEFAULT NULL,
  `Product_Code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`shipper_qrcode_api_sysId`)
) ENGINE=MyISAM AUTO_INCREMENT=444 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipper_qrcode_rework`
--

-- DROP TABLE IF EXISTS `shipper_qrcode_rework`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipper_qrcode_rework` (
  `REWORK_ID` int DEFAULT NULL,
  `shipper_qrcode_sysId` int DEFAULT NULL,
  `shipper_qrcode` varchar(50) DEFAULT NULL,
  `total_bottles_qty` int DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `old_shipper_qrcode_sysId` int DEFAULT NULL,
  `shipper_qrcode_api_sysId` int DEFAULT NULL,
  `pallet_qrcode_api_sysId` int DEFAULT NULL,
  `plant_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_datetime` datetime DEFAULT NULL,
  `Current_Holder_Type` varchar(1) DEFAULT NULL,
  `Current_Holder_SYS_ID` int DEFAULT NULL,
  `IS_SYNCED` int DEFAULT '0',
  `IS_SYNCED_DATETIME` datetime DEFAULT NULL,
  `EventTime` datetime DEFAULT NULL,
  `CREATED_TIMESTAMP` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IS_POSTED` int DEFAULT '0',
  `sh_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sh_id`),
  KEY `hashShipperQr` (`shipper_qrcode`),
  KEY `ShipperCodeApi` (`shipper_qrcode_api_sysId`,`REWORK_ID`,`shipper_qrcode`) USING BTREE,
  KEY `ShipperAndAPISysId` (`shipper_qrcode`,`shipper_qrcode_api_sysId`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `so_detail`
--

-- DROP TABLE IF EXISTS `so_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `so_detail` (
  `SO_DTL_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `SO_SYS_ID` int DEFAULT NULL,
  `UNIT_CODE` int DEFAULT NULL,
  `SO_NO` int DEFAULT NULL,
  `SLNO` int DEFAULT NULL,
  `SCRAP_CD` int DEFAULT NULL,
  `SCRAP_DESC` varchar(500) DEFAULT NULL,
  `UOM` varchar(10) DEFAULT NULL,
  `ERP_UOM_CD` int DEFAULT NULL,
  `SO_QTY` int DEFAULT NULL,
  `BASIC_AMT` double DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `LOADING_QTY` int DEFAULT NULL,
  `LOADING_UOM` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`SO_DTL_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `so_header`
--

-- DROP TABLE IF EXISTS `so_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `so_header` (
  `SO_SYS_ID` int NOT NULL,
  `UNIT_CODE` int DEFAULT NULL,
  `SO_NO` int DEFAULT NULL,
  `SO_DATE` datetime DEFAULT NULL,
  `SO_RELEASE_DATE` datetime DEFAULT NULL,
  `SO_VALID_DATE` datetime DEFAULT NULL,
  `SEQUENCE_NO` int DEFAULT NULL,
  `TENDER_NO` int DEFAULT NULL,
  `TENDER_DATE` datetime DEFAULT NULL,
  `VENSOR_SYS_ID` int DEFAULT NULL,
  `CUST_CD` int DEFAULT NULL,
  `CUST_NAME` varchar(30) DEFAULT NULL,
  `CUST_SITE_CD` int DEFAULT NULL,
  `SITE_NAME` varchar(50) DEFAULT NULL,
  `ADD1` varchar(500) DEFAULT NULL,
  `ADD2` varchar(500) DEFAULT NULL,
  `ADD3` varchar(500) DEFAULT NULL,
  `CITY` varchar(20) DEFAULT NULL,
  `PIN` int DEFAULT NULL,
  `STATE` varchar(15) DEFAULT NULL,
  `STATE_CD` varchar(10) DEFAULT NULL,
  `GSTN_NO` varchar(20) DEFAULT NULL,
  `PAN_NO` varchar(10) DEFAULT NULL,
  `CUST_NON_GST` int DEFAULT NULL,
  `TEL_NO` varchar(10) DEFAULT NULL,
  `SO_REMARKS` varchar(1000) DEFAULT NULL,
  `STATUS` varchar(1000) DEFAULT NULL,
  `STATUS_DATE` datetime DEFAULT NULL,
  `STATUS_REMARKS` varchar(1000) DEFAULT NULL,
  `EMD_AMT` double DEFAULT NULL,
  `TERMS_PRICE` varchar(500) DEFAULT NULL,
  `TERMS_PYMT_TERM` varchar(1000) DEFAULT NULL,
  `TERMS_LIFTING_PERIOD_DAYS` int DEFAULT NULL,
  `TENDER_TYPE` varchar(20) DEFAULT NULL,
  `AMEND_NO` int DEFAULT NULL,
  `AMEND_RELEASE_DATE` datetime DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `RIVISION` varchar(50) DEFAULT NULL,
  `TRUCK_NO` varchar(10) DEFAULT NULL,
  `TRANSPORTER_NAME` varchar(50) DEFAULT NULL,
  `LOADING_GATE` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`SO_SYS_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_gate_in_out`
--

-- DROP TABLE IF EXISTS `sp_gate_in_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sp_gate_in_out` (
  `GATE_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `GATE_IN_DT` datetime DEFAULT NULL,
  `GATE_OUT_DT` datetime DEFAULT NULL,
  `INWARD_SYS_ID` int DEFAULT NULL,
  `SO_SYS_ID` int DEFAULT NULL,
  `TRANS_SYS_ID` int DEFAULT NULL,
  `TRANSPORTER_NAME` varchar(50) DEFAULT NULL,
  `TRUCK_NO` varchar(10) DEFAULT NULL,
  `DRIVER_ID_TYPE` varchar(20) DEFAULT NULL,
  `DRIVER_ID_NUMBER` varchar(30) DEFAULT NULL,
  `DRIVER_NAME` varchar(30) DEFAULT NULL,
  `DRIVER_CONTACT` varchar(10) DEFAULT NULL,
  `DRIVER_CHANGED` tinyint(1) DEFAULT NULL,
  `DRIVER_NAME_NEW` varchar(30) DEFAULT NULL,
  `DRIVER_CONTACT_NEW` varchar(10) DEFAULT NULL,
  `TRUCK_VALIDATION` tinyint(1) DEFAULT NULL,
  `RFSYSID` int DEFAULT NULL,
  `VERIFIED_DOCUMENTS` tinyint(1) DEFAULT NULL,
  `RFID_RECEIVE` tinyint(1) DEFAULT NULL,
  `VERIFIED_OFFICER_ID` varchar(50) DEFAULT NULL,
  `CANCEL_GATE_IN` tinyint(1) DEFAULT NULL,
  `CANCEL_GATE_REASON` varchar(50) DEFAULT NULL,
  `GATE_SYS_ID_OLD` int DEFAULT NULL,
  `IS_GOODS_TRANSFER` tinyint(1) DEFAULT NULL,
  `STATION_ID` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_BY_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`GATE_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_weighment_detail`
--

-- DROP TABLE IF EXISTS `sp_weighment_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sp_weighment_detail` (
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
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statemaster`
--

-- DROP TABLE IF EXISTS `statemaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statemaster` (
  `STATE_ID` int NOT NULL,
  `STATE_NAME` varchar(45) DEFAULT NULL,
  `COUNTRY_ID` int DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `CREATED_BY` int DEFAULT NULL,
  `CREATED_DATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`STATE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transporter_master`
--

-- DROP TABLE IF EXISTS `transporter_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transporter_master` (
  `TRANS_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `tptr_cd` varchar(50) DEFAULT NULL,
  `tptr_name` varchar(50) DEFAULT NULL,
  `IS_ENTRY_MANUAL` tinyint(1) DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`TRANS_SYS_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_master_new`
--

-- DROP TABLE IF EXISTS `user_master_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_master_new` (
  `ID` double NOT NULL,
  `USER_NAME` varchar(100) DEFAULT NULL,
  `USER_PASSWORD` varchar(100) DEFAULT NULL,
  `FIRST_NAME` varchar(45) DEFAULT NULL,
  `MIDDLE_NAME` varchar(45) DEFAULT NULL,
  `LAST_NAME` varchar(45) DEFAULT NULL,
  `MOBILE_NO` varchar(10) DEFAULT NULL,
  `ALT_MOBILE_NO` varchar(10) DEFAULT NULL,
  `EMAIL_ID` varchar(30) DEFAULT NULL,
  `ALT_EMAIL_ID` varchar(30) DEFAULT NULL,
  `FULL_ADDRESS` varchar(200) DEFAULT NULL,
  `COUNTRY_ID` bigint DEFAULT NULL,
  `STATE_ID` bigint DEFAULT NULL,
  `DISTRICT_ID` bigint DEFAULT NULL,
  `CITY` varchar(30) DEFAULT NULL,
  `POSTAL_CODE` varchar(8) DEFAULT NULL,
  `EMP_CODE` varchar(10) DEFAULT NULL,
  `EMP_DESIGNATION_ID` bigint DEFAULT NULL,
  `EMP_WORK_SHIFT_ID` bigint DEFAULT NULL,
  `EMP_WORK_STATION_ID` bigint DEFAULT NULL,
  `IS_LOCK` varchar(1) DEFAULT 'N',
  `NOTE_FEEDBACK` varchar(100) DEFAULT NULL,
  `IS_ACTIVE` varchar(1) DEFAULT 'N',
  `CREATED_BY` double DEFAULT NULL,
  `CREATED_DATETIME` datetime DEFAULT NULL,
  `MODIFIED_BY` double DEFAULT NULL,
  `MODIFIED_DATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_role_new`
--

-- DROP TABLE IF EXISTS `user_role_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role_new` (
  `USER_ID` double DEFAULT NULL,
  `PLANT_ID` double DEFAULT NULL,
  `ROLE_ID` double DEFAULT NULL,
  `CREATED_BY` double DEFAULT NULL,
  `CREATED_DATETIME` datetime DEFAULT NULL,
  `MODIFIED_BY` double DEFAULT NULL,
  `MODIFIED_DATETIME` datetime DEFAULT NULL,
  `IS_DEFAULT` varchar(1) DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vendor_master`
--

-- DROP TABLE IF EXISTS `vendor_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor_master` (
  `PLANT_ID` int NOT NULL,
  `VENDOR_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `VENDOR_CODE` int DEFAULT NULL,
  `ORGANIZATION_NAME` varchar(150) DEFAULT NULL,
  `VENDOR_SITE` varchar(50) DEFAULT NULL,
  `FIRST_NAME` varchar(20) DEFAULT NULL,
  `MIDDLE_NAME` varchar(20) DEFAULT NULL,
  `LAST_NAME` varchar(20) DEFAULT NULL,
  `PRIMARY_MOBILE` varchar(10) DEFAULT NULL,
  `ALTERNATIVE_MOBILE` varchar(10) DEFAULT NULL,
  `PRIMARY_EMAIL` varchar(45) DEFAULT NULL,
  `ALTERNATIVE_EMAIL` varchar(45) DEFAULT NULL,
  `PHONE_NUMBER` varchar(15) DEFAULT NULL,
  `COUNTRY_ID` int DEFAULT NULL,
  `STATE_ID` int DEFAULT NULL,
  `DISTRICT_ID` int DEFAULT NULL,
  `CITY` varchar(100) DEFAULT NULL,
  `ADDRESS` varchar(100) DEFAULT NULL,
  `IS_SYSTEM_USER` tinyint DEFAULT NULL,
  `PASSWORD` varchar(100) DEFAULT NULL,
  `ACTIVE` tinyint DEFAULT NULL,
  `USER_LOCK` tinyint DEFAULT NULL,
  `Created_DateTime` datetime DEFAULT NULL,
  `IS_POSTED` tinyint(1) DEFAULT NULL,
  `VENDOR_TYPE` varchar(1) DEFAULT NULL,
  `VENDOR_CODE_TEMP` int DEFAULT NULL,
  `PRINT_LABEL_QTY` int DEFAULT NULL,
  `ROLE_ID` int DEFAULT NULL,
  PRIMARY KEY (`VENDOR_SYS_ID`,`PLANT_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `vw_exp_get_gate_in_mda_id`
--

-- DROP TABLE IF EXISTS `vw_exp_get_gate_in_mda_id`;
/*!50001 DROP VIEW IF EXISTS `vw_exp_get_gate_in_mda_id`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_exp_get_gate_in_mda_id` AS SELECT 
 1 AS `PLANT_ID`,
 1 AS `GATE_SYS_ID`,
 1 AS `VEHICLE_NO`,
 1 AS `MDA_SYS_ID`,
 1 AS `MDA_NO`,
 1 AS `MDA_DT`,
 1 AS `GATE_IN_DT`,
 1 AS `GATE_OUT_DT`,
 1 AS `OUT_TIME`,
 1 AS `CANCEL_GATE_IN`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_get_gate_in_mda_id`
--

-- DROP TABLE IF EXISTS `vw_get_gate_in_mda_id`;
/*!50001 DROP VIEW IF EXISTS `vw_get_gate_in_mda_id`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_get_gate_in_mda_id` AS SELECT 
 1 AS `PLANT_ID`,
 1 AS `GATE_SYS_ID`,
 1 AS `VEHICLE_NO`,
 1 AS `MDA_SYS_ID`,
 1 AS `MDA_NO`,
 1 AS `MDA_DT`,
 1 AS `GATE_IN_DT`,
 1 AS `GATE_OUT_DT`,
 1 AS `OUT_TIME`,
 1 AS `CANCEL_GATE_IN`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_get_gate_in_mda_no_gate_out`
--

-- DROP TABLE IF EXISTS `vw_get_gate_in_mda_no_gate_out`;
/*!50001 DROP VIEW IF EXISTS `vw_get_gate_in_mda_no_gate_out`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_get_gate_in_mda_no_gate_out` AS SELECT 
 1 AS `PLANT_ID`,
 1 AS `GATE_SYS_ID`,
 1 AS `VEHICLE_NO`,
 1 AS `MDA_SYS_ID`,
 1 AS `MDA_NO`,
 1 AS `MDA_DT`,
 1 AS `GATE_IN_DT`,
 1 AS `GATE_OUT_DT`,
 1 AS `OUT_TIME`,
 1 AS `CANCEL_GATE_IN`,
 1 AS `BAG_NOS`,
 1 AS `Required_Shipper`,
 1 AS `WEIGHIN_WT`,
 1 AS `WEIGHIN_WT_NOTE`,
 1 AS `WEIGHIN_WT_DT`,
 1 AS `WEIGHOUT_WT`,
 1 AS `WEIGHOUT_WT_NOTE`,
 1 AS `WEIGHOUT_WT_DT`,
 1 AS `NET_WT`,
 1 AS `TOLERANCE_WT`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_mda_fg_gate_dtls`
--

-- DROP TABLE IF EXISTS `vw_mda_fg_gate_dtls`;
/*!50001 DROP VIEW IF EXISTS `vw_mda_fg_gate_dtls`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_mda_fg_gate_dtls` AS SELECT 
 1 AS `PLANT_ID`,
 1 AS `GATE_SYS_ID`,
 1 AS `MDA_SYS_ID`,
 1 AS `MDA_NO`,
 1 AS `VEHICLE_NO`,
 1 AS `GATE_IN_DT`,
 1 AS `GATE_OUT_DT`,
 1 AS `MDA_DT`,
 1 AS `GROSS_WT`,
 1 AS `NET_WT`,
 1 AS `BAG_NOS`,
 1 AS `PROD_SYS_ID`,
 1 AS `PRD_CD`,
 1 AS `PRD_DESC`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `work_shift_master`
--

-- DROP TABLE IF EXISTS `work_shift_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_shift_master` (
  `SHIFT_SYS_ID` int NOT NULL AUTO_INCREMENT,
  `SHIFT_NAME` varchar(45) DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `CREATED_BY` int DEFAULT NULL,
  `CREATED_DATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`SHIFT_SYS_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `work_station_master`
--

-- DROP TABLE IF EXISTS `work_station_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_station_master` (
  `WS_SYS_ID` int NOT NULL,
  `WS_NAME` varchar(45) DEFAULT NULL,
  `PLANT_ID` int DEFAULT NULL,
  `CREATED_BY` int DEFAULT NULL,
  `CREATED_DATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`WS_SYS_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'iffco'
--

--
-- Dumping routines for database 'iffco'
--
/*!50003 DROP FUNCTION IF EXISTS `FN_COMMON_MDA_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  FUNCTION `FN_COMMON_MDA_ID`(
    P_PLANT_ID INT,
    P_GATE_SYS_ID INT,
    P_MDA_SYS_ID INT) RETURNS longtext CHARSET utf8mb4
    NO SQL
    DETERMINISTIC
BEGIN
DECLARE result LONGTEXT;

	WITH TBL_GM AS (SELECT Z.PLANT_ID, X.GATE_SYS_ID, Z.MDA_SYS_ID, MDA_NO, VEHICLE_NO, MDA_DT, OUT_TIME
		FROM mda_header Z
		LEFT JOIN fg_gate_in_out X ON X.PLANT_ID = Z.PLANT_ID AND X.MDA_SYS_ID = Z.MDA_SYS_ID
		WHERE Z.PLANT_ID = P_PLANT_ID AND (VEHICLE_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y')) IN (
			SELECT VEHICLE_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y')MDA_DT FROM mda_header X 
			WHERE VEHICLE_NO IN (SELECT DISTINCT VEHICLE_NO FROM mda_header WHERE MDA_SYS_ID = IFNULL(P_MDA_SYS_ID,0) 
									UNION SELECT DISTINCT TRUCK_NO VEHICLE_NO FROM fg_gate_in_out WHERE GATE_SYS_ID = IFNULL(P_GATE_SYS_ID, 0) 
								) GROUP BY VEHICLE_NO, MDA_DT )
		GROUP BY Z.PLANT_ID, X.GATE_SYS_ID, Z.MDA_SYS_ID, MDA_NO, VEHICLE_NO, MDA_DT, OUT_TIME
	)
SELECT GROUP_CONCAT(combined_column SEPARATOR '#') INTO result
	FROM (SELECT MDA_SYS_ID AS combined_column
FROM (SELECT GM.PLANT_ID, IFNULL(GM.GATE_SYS_ID, (SELECT GMZ.GATE_SYS_ID FROM TBL_GM GMZ 
	WHERE IFNULL(GMZ.GATE_SYS_ID, 0) > 0 AND DATE_FORMAT(GMZ.MDA_DT, '%d/%m/%Y') = DATE_FORMAT(GM.MDA_DT, '%d/%m/%Y') LIMIT 1))GATE_SYS_ID
	, GM.MDA_SYS_ID, GM.MDA_NO, GM.VEHICLE_NO, GM.MDA_DT, IFNULL(GM.OUT_TIME, '') AS OUT_TIME
	FROM TBL_GM GM
    WHERE IFNULL(GM.OUT_TIME, '') = ''
) X) X LIMIT 1;

RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_GATE_IN_OUT_MDA_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  FUNCTION `FN_GATE_IN_OUT_MDA_GET`(
    P_PLANT_ID INT,
    P_GATE_SYS_ID INT,
    P_MDA_SYS_ID INT,
    P_SEARCH_TERM VARCHAR(255)) RETURNS longtext CHARSET utf8mb4
    NO SQL
    DETERMINISTIC
BEGIN
DECLARE result LONGTEXT;

	WITH TBL_GM AS (SELECT Z.PLANT_ID, X.GATE_SYS_ID, Z.MDA_SYS_ID, MDA_NO, VEHICLE_NO, MDA_DT, OUT_TIME
		FROM mda_header Z
		LEFT JOIN fg_gate_in_out X ON X.PLANT_ID = Z.PLANT_ID AND X.MDA_SYS_ID = Z.MDA_SYS_ID AND COALESCE(X.CANCEL_GATE_IN, 0) = 0  
		WHERE Z.PLANT_ID = P_PLANT_ID AND (VEHICLE_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y')) IN (
			SELECT VEHICLE_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y')MDA_DT FROM mda_header X 
			WHERE VEHICLE_NO IN (SELECT DISTINCT VEHICLE_NO FROM mda_header WHERE MDA_SYS_ID = IFNULL(P_MDA_SYS_ID,0) OR MDA_NO = P_SEARCH_TERM
									UNION SELECT DISTINCT TRUCK_NO VEHICLE_NO FROM fg_gate_in_out WHERE (GATE_SYS_ID = IFNULL(P_GATE_SYS_ID, 0) OR TRUCK_NO = P_SEARCH_TERM)
								) GROUP BY VEHICLE_NO, MDA_DT )
		AND 0 < (select COUNT(*) FROM mda_detail MD WHERE MD.MDA_SYS_ID = Z.MDA_SYS_ID AND MD.PROD_SYS_ID IN (31,35,55,56))
        -- AND COALESCE(X.CANCEL_GATE_IN, 0) = 0  
		GROUP BY Z.PLANT_ID, X.GATE_SYS_ID, Z.MDA_SYS_ID, MDA_NO, VEHICLE_NO, MDA_DT, OUT_TIME
	)
SELECT GROUP_CONCAT(combined_column SEPARATOR '#') INTO result
	FROM (SELECT CONCAT(PLANT_ID, ',', GATE_SYS_ID, ',', MDA_SYS_ID, ',', MDA_NO, ',', VEHICLE_NO, ',', DATE_FORMAT(MDA_DT, '%d/%m/%Y')
    , ',', IF(OUT_TIME = '' OR OUT_TIME = NULL, '', DATE_FORMAT(OUT_TIME, '%d/%m/%Y'))) AS combined_column
FROM (SELECT GM.PLANT_ID, IFNULL(GM.GATE_SYS_ID, (SELECT GMZ.GATE_SYS_ID FROM TBL_GM GMZ 
	WHERE IFNULL(GMZ.GATE_SYS_ID, 0) > 0 AND DATE_FORMAT(GMZ.MDA_DT, '%d/%m/%Y') = DATE_FORMAT(GM.MDA_DT, '%d/%m/%Y') LIMIT 1))GATE_SYS_ID
	, GM.MDA_SYS_ID, GM.MDA_NO, GM.VEHICLE_NO, GM.MDA_DT, IFNULL(GM.OUT_TIME, '') AS OUT_TIME
	FROM TBL_GM GM
) X) X LIMIT 1;

RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_BATCH_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_BATCH_GET`(
IN `P_ID` INT,
IN `P_ISACTIVE` VARCHAR(255),
IN `P_PLANT_ID` INT,
IN `P_USER_ID` INT,
IN `P_ROLE_ID` INT,
IN `P_MENU_ID` INT
)
BEGIN

		IF P_ID < 0 THEN
            
            -- SELECT (IFNULL(MAX(Serial_No), 0) + 1)Max_Serial_No FROM iffco.batch_master;
			SELECT (COUNT(*) + 1) Max_Serial_No FROM iffco.shipper_qrcode_api WHERE date_format(mfg_date, 'YY') = date_format(NOW(), 'YY');

			SELECT APID1_Desc, APID1_Val, APID2_Desc, APID2_Val  FROM iffco.qrcode_app_identifier;
            
        ELSEIF P_ID > 0 THEN
            
            SELECT Serial_No, Batch_No, Mfg_Date, Plant_Code, Product_Code, Current_Year, Julian_Day
            FROM BATCH_MASTER X
            WHERE X.Serial_No = P_ID;

        ELSE
        
            SELECT Serial_No, Batch_No, Mfg_Date, Plant_Code, Product_Code, Current_Year, Julian_Day
            FROM BATCH_MASTER X;

        END IF;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_CHANGEPASSWORD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_CHANGEPASSWORD`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_COUNTRY_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_COUNTRY_GET`(IN P_ID          INT,
                                  IN P_ISACTIVE    VARCHAR(255),
                                  IN P_PLANT_ID    INT,
                                  IN P_USER_ID     INT,
                                  IN P_ROLE_ID     INT,
                                  IN P_MENU_ID     INT)
BEGIN
IF P_ID > 0 THEN
      
            SELECT X.COUNTRY_ID ID,
                   NULL CODE,
                   X.COUNTRY_NAME NAME,
                   PLANT_ID,
                   CREATED_BY,
                   CREATED_DATETIME,
                   1 ISACTIVE
              FROM countrymaster X
             WHERE X.COUNTRY_ID = P_ID;
      ELSE
      
            SELECT X.COUNTRY_ID ID,
                   NULL CODE,
                   X.COUNTRY_NAME NAME,
                   PLANT_ID,
                   CREATED_BY,
                   CREATED_DATETIME,
                   1 ISACTIVE
              FROM countrymaster X;
      END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_COUNTRY_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_COUNTRY_SAVE`(IN P_ID          INT,
                                  IN P_CODE    VARCHAR(255),
                                  IN P_NAME    VARCHAR(255),
                                  IN P_ISACTIVE    VARCHAR(255),
                                  IN P_PLANT_ID    INT,
                                  IN P_USER_ID     INT,
                                  IN P_ROLE_ID     INT,
                                  IN P_MENU_ID     INT,
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
		
        SELECT COUNT(*) INTO TEMP_NUM FROM countrymaster X WHERE X.COUNTRY_NAME = P_NAME AND X.COUNTRY_ID != P_ID;
        
        IF TEMP_NUM > 0 THEN
			SET P_RESULT = 'E|Country name already exists.|0';    
		ELSEIF P_ID > 0 THEN

			UPDATE countrymaster SET COUNTRY_NAME = P_NAME
			WHERE COUNTRY_ID = P_ID;

			SET P_RESULT = 'S|Record updated successfully|';

		ELSE

			INSERT INTO countrymaster (COUNTRY_NAME, PLANT_ID, CREATED_BY, CREATED_DATETIME)
			VALUES(P_NAME, P_PLANT_ID, P_USER_ID, NOW());

			SET P_RESULT = 'S|Record saved successfully|';
		END IF;
        
	COMMIT;
  

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_DISPATCH_COUNT_SUMMARY_REPORT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_DISPATCH_COUNT_SUMMARY_REPORT`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_DISPATCH_SUMMARY_REPORT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_DISPATCH_SUMMARY_REPORT`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_DISTRICT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_DISTRICT_GET`(IN P_ID          INT, IN P_COUNTRY_ID          INT, IN P_STATE_ID          INT,
                                  IN P_ISACTIVE    VARCHAR(255),
                                  IN P_PLANT_ID    INT,
                                  IN P_USER_ID     INT,
                                  IN P_ROLE_ID     INT,
                                  IN P_MENU_ID     INT)
BEGIN
IF P_ID > 0 THEN
      
            SELECT X.DISTRICT_ID ID,
                   NULL CODE,
                   X.DISTRICT_NAME NAME,
					COUNTRY_ID,
                   (SELECT COUNTRY_NAME
                      FROM countrymaster
                     WHERE X.COUNTRY_ID = COUNTRY_ID)
                      COUNTRY_NAME,
                   STATE_ID,
                   (SELECT STATE_NAME
                      FROM statemaster
                     WHERE X.COUNTRY_ID = COUNTRY_ID)
                      STATE_NAME,
                   PLANT_ID,
                   CREATED_BY,
                   CREATED_DATETIME,
                   1 ISACTIVE
              FROM districtmaster X
             WHERE X.COUNTRY_ID = P_ID;
      ELSE
      
            SELECT X.DISTRICT_ID ID,
                   NULL CODE,
                   X.DISTRICT_NAME NAME,
					COUNTRY_ID,
                   (SELECT COUNTRY_NAME
                      FROM countrymaster
                     WHERE X.COUNTRY_ID = COUNTRY_ID)
                      COUNTRY_NAME,
                   STATE_ID,
                   (SELECT STATE_NAME
                      FROM statemaster
                     WHERE X.COUNTRY_ID = COUNTRY_ID)
                      STATE_NAME,
                   PLANT_ID,
                   CREATED_BY,
                   CREATED_DATETIME,
                   1 ISACTIVE
              FROM districtmaster X;
      END IF;
END ;;
DELIMITER ;
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
CREATE  PROCEDURE `PC_EXP_GATE_IN_CANCEL_GET`(
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
CREATE  PROCEDURE `PC_EXP_GATE_IN_CANCEL_SAVE`(
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
CREATE  PROCEDURE `PC_EXP_GATE_IN_MDA_LIST`(IN P_SEARCHTERM VARCHAR(255), IN P_PLANT_ID INT)
BEGIN


            UPDATE RFID_MASTER SET STATUS = 'Active' 
			WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM fg_gate_in_out X WHERE GATE_OUT_DT IS NULL 
									UNION
									SELECT DISTINCT RFSYSID FROM exp_fg_gate_in_out X WHERE GATE_OUT_DT IS NULL);
            
            
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
    FROM (SELECT MH.PLANT_ID, MH.MDA_SYS_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, SUM(GIO.EXPECTED_QTY) Expected_Shipper
		, (SELECT COUNT(*) FROM exp_mda_pallate_loading eml WHERE eml.PLANT_ID = MH.PLANT_ID AND eml.MDA_SYS_ID = MH.MDA_SYS_ID AND eml.GATE_SYS_ID = GIO.GATE_SYS_ID) Loaded_Shipper 
		FROM TBL_RESULT MH
		LEFT JOIN exp_fg_gate_in_out GIO ON GIO.PLANT_ID = MH.PLANT_ID AND GIO.MDA_SYS_ID = MH.MDA_SYS_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
		GROUP BY MH.PLANT_ID, MH.MDA_SYS_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO, GATE_IN_DT, GATE_OUT_DT
	) X GROUP BY X.PLANT_ID, X.MDA_SYS_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY MH.MDA_DT DESC, MH.MDA_NO DESC, MH.VEHICLE_NO ASC)) AS SR_NO
,MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.VEHICLE_NO, NULL VEHICLE_SHIPPERS
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
CREATE  PROCEDURE `PC_EXP_GATE_IN_SAVE`(
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
DECLARE Remaining_Shipper INT DEFAULT 0;
      
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

IF IFNULL(TEMP_NUM, 0) <= 0 THEN
	SELECT COUNT(*) INTO TEMP_NUM FROM EXP_FG_GATE_IN_OUT WHERE TRUCK_NO = IFNULL(P_TRUCK_NO, '') AND GATE_OUT_DT IS NULL AND COALESCE(CANCEL_GATE_IN, 0) = 0;
END IF;

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

	SELECT SUM(IFNULL(GIO.EXPECTED_QTY, 0)) INTO Loaded_Shipper
				FROM mda_header MH
				LEFT JOIN exp_fg_gate_in_out GIO ON GIO.PLANT_ID = MH.PLANT_ID AND GIO.MDA_SYS_ID = MH.MDA_SYS_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
				WHERE MH.MDA_NO = P_MDA_NO AND MH.MDA_SYS_ID = P_MDA_SYS_ID 
				GROUP BY MH.PLANT_ID, MH.MDA_SYS_ID;

	SELECT CAST((SUM(IFNULL(MD.BAG_NOS, 0)) / 24) as UNSIGNED) INTO Required_Shipper
	FROM mda_header MH
	INNER JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
	WHERE MH.MDA_NO = P_MDA_NO AND MH.MDA_SYS_ID = P_MDA_SYS_ID 
    AND MH.OUT_TIME IS NULL;

	SET Remaining_Shipper = (IFNULL(Required_Shipper, 0) - IFNULL(Loaded_Shipper, 0));

	-- SET P_RESULT = CONCAT('E','|','You entered expected qty is wrong. Remaining Qty is ',IFNULL(Remaining_Shipper, 0),'|','0');
    
	IF IFNULL(Remaining_Shipper, 0) = 0 THEN
		SET P_RESULT = 'E|Selected MDA Loading Completed.|0';
	ELSEIF IFNULL(Remaining_Shipper, 0) < IFNULL(P_EXPECTED_QTY, 0) THEN
		-- SET Loaded_Shipper = (IFNULL(Required_Shipper, 0) - IFNULL(Loaded_Shipper, 0));
		SET P_RESULT = CONCAT('E','|','You entered expected qty is wrong. Remaining Qty is ',IFNULL(Remaining_Shipper, 0),'|','0');
	ELSE

		IF TRIM(IFNULL(P_TRANSPORTER_CODE, '')) != '' THEN	
			SELECT TRANS_SYS_ID INTO TEMP_TRANS_SYS_ID FROM transporter_master X WHERE X.tptr_cd = TRIM(P_TRANSPORTER_CODE);	
		ELSE
			SELECT TRANS_SYS_ID INTO TEMP_TRANS_SYS_ID FROM mda_header WHERE MDA_NO = IFNULL(P_MDA_NO, '') AND MDA_SYS_ID = P_MDA_SYS_ID;
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
CREATE  PROCEDURE `PC_EXP_GATE_OUT_GET`(
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
CREATE  PROCEDURE `PC_EXP_GATE_OUT_SAVE`(
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
			WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM fg_gate_in_out X WHERE GATE_OUT_DT IS NULL 
									UNION
									SELECT DISTINCT RFSYSID FROM exp_fg_gate_in_out X WHERE GATE_OUT_DT IS NULL);
            
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
				
				COMMIT;
				
				SET P_RESULT := CONCAT( 'S|Record saved successfully', '|0' );
			END IF;
        ELSE
			  
			SET P_RESULT = CONCAT('E|Gate Out Details is already saved. Gate Out Date Time : ', IFNULL(TEMP_GATE_OUT_DT, ''), '|0');
            
        END IF;
        
    END IF;

            UPDATE RFID_MASTER SET STATUS = 'Active' 
			WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM fg_gate_in_out X WHERE GATE_OUT_DT IS NULL 
									UNION
									SELECT DISTINCT RFSYSID FROM exp_fg_gate_in_out X WHERE GATE_OUT_DT IS NULL);
            
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_INVOICE_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_EXP_INVOICE_GET`()
BEGIN
	SELECT X.Invoice_No, DATE_FORMAT(Invoice_Date, '%d/%m/%Y') AS Invoice_Date, Order_Ref_No, DATE_FORMAT(Order_Ref_Date, '%d/%m/%Y') AS Order_Ref_Date
    , Performa_Invoice_No, DATE_FORMAT(Performa_Invoice_Date, '%d/%m/%Y') AS Performa_Invoice_Date, Indent_No, Plant_MDA_No
    , Port_Loading, Port_Discharge, Carrier, Sailing, Country, Incoterms2020, Marks_No_Packing
    -- , Product_Desc, HSN_Code, Qty
    , GROUP_CONCAT(CONCAT(Z.Product_Desc, ' (', Z.Qty, ')')  SEPARATOR ', ') AS Product_Desc
    , GROUP_CONCAT(Z.HSN_Code SEPARATOR ', ') AS HSN_Code
    , SUM(Z.Qty) AS Qty
    FROM exp_invoice_master X
    INNER JOIN exp_invoice_dtls Z ON Z.Invoice_No = X.Invoice_No
    GROUP BY X.Invoice_No, Invoice_Date, Order_Ref_No, Order_Ref_Date
    , Performa_Invoice_No, Performa_Invoice_Date, Indent_No, Plant_MDA_No
    , Port_Loading, Port_Discharge, Carrier, Sailing, Country, Incoterms2020, Marks_No_Packing;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_EXP_INVOICE_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_EXP_INVOICE_SAVE`(
  IN P_Invoice_No varchar(100) 
, IN P_Invoice_Date varchar(100) 
, IN P_Order_Ref_No varchar(100) 
, IN P_Order_Ref_Date varchar(100) 
, IN P_Performa_Invoice_No varchar(100) 
, IN P_Performa_Invoice_Date varchar(100) 
, IN P_Indent_No varchar(100) 
, IN P_Plant_MDA_No varchar(100) 
, IN P_Port_Loading varchar(100) 
, IN P_Port_Discharge varchar(100) 
, IN P_Carrier varchar(100) 
, IN P_Sailing varchar(100) 
, IN P_Country varchar(100) 
, IN P_Incoterms2020 varchar(100) 
, IN P_Marks_No_Packing varchar(16300) 
, IN P_Product_Desc varchar(200) 
, IN P_HSN_Code varchar(100) 
, IN P_Qty int,
IN P_PLANT_ID    INT,
IN P_USER_ID INT,
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
		
        SELECT COUNT(*) INTO TEMP_NUM FROM exp_invoice_master X WHERE X.Invoice_No = P_Invoice_No AND PLANT_ID = P_PLANT_ID;
        
        IF IFNULL(TEMP_NUM, 0) > 0 THEN
        
			UPDATE `iffco`.`exp_invoice_master`
			SET
			`Invoice_No` = P_Invoice_No,
			`Invoice_Date` = STR_TO_DATE(REPLACE(P_Invoice_Date, '-', '/'), '%d/%m/%Y'),
			`Order_Ref_No` = P_Order_Ref_No,
			`Order_Ref_Date` =  STR_TO_DATE(REPLACE(P_Order_Ref_Date, '-', '/'), '%d/%m/%Y'),
			`Performa_Invoice_No` = P_Performa_Invoice_No,
			`Performa_Invoice_Date` = P_Performa_Invoice_Date,
			`Indent_No` = P_Indent_No,
			`Plant_MDA_No` = P_Plant_MDA_No,
			`Port_Loading` = P_Port_Loading,
			`Port_Discharge` = P_Port_Discharge,
			`Carrier` = P_Carrier,
			`Sailing` = P_Sailing,
			`Country` = P_Country,
			`Incoterms2020` = P_Incoterms2020
			WHERE Invoice_No = P_Invoice_No AND PLANT_ID = P_PLANT_ID;
		ELSE
        
			INSERT INTO exp_invoice_master (Invoice_No, Invoice_Date, Order_Ref_No, Order_Ref_Date, Performa_Invoice_No, Performa_Invoice_Date, Indent_No, Plant_MDA_No, Port_Loading, Port_Discharge, Carrier, Sailing, Country, Incoterms2020, Created_BY_ID, PLANT_ID)
			VALUES(P_Invoice_No, STR_TO_DATE(REPLACE(P_Invoice_Date, '-', '/'), '%d/%m/%Y'), P_Order_Ref_No, STR_TO_DATE(REPLACE(P_Order_Ref_Date, '-', '/'), '%d/%m/%Y'), P_Performa_Invoice_No, STR_TO_DATE(REPLACE(P_Performa_Invoice_Date, '-', '/'), '%d/%m/%Y'), P_Indent_No, P_Plant_MDA_No, P_Port_Loading, P_Port_Discharge, P_Carrier, P_Sailing, P_Country, P_Incoterms2020, P_USER_ID, P_PLANT_ID);

		END IF;
                
		
        SELECT COUNT(*) INTO TEMP_NUM FROM exp_invoice_dtls X WHERE X.Invoice_No = P_Invoice_No AND Product_Desc = P_Product_Desc AND PLANT_ID = P_PLANT_ID;
        
        IF IFNULL(TEMP_NUM, 0) > 0 THEN
        
			UPDATE `iffco`.`exp_invoice_dtls`
			SET
			`Marks_No_Packing` = P_Marks_No_Packing,
			`HSN_Code` = P_HSN_Code,
			`Qty` = P_Qty
			WHERE Invoice_No = P_Invoice_No AND Product_Desc = P_Product_Desc AND PLANT_ID = P_PLANT_ID;
		ELSE
        
			INSERT INTO exp_invoice_dtls (Invoice_No, Marks_No_Packing, Product_Desc, HSN_Code, Qty, Created_BY_ID, PLANT_ID)
			VALUES(P_Invoice_No, P_Marks_No_Packing, P_Product_Desc, P_HSN_Code, P_Qty, P_USER_ID, P_PLANT_ID);

		END IF;
                
			SET P_RESULT = 'S|Record saved successfully|';
        
	COMMIT;
  

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
CREATE  PROCEDURE `PC_EXP_MDA_PALLATE_GET`(IN P_Gate_In_Id INT, IN P_MDA_Id INT, IN P_DI_No VARCHAR(255), IN P_PLANT_ID INT)
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
	, MDA_LOD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, X.DI_NO, PROD_SYS_ID, Pallate_Id, X.PALLATE_NO, SSCC, Pallate_Type, Shipper_Qty, (Shipper_Qty * 24) Bottle_Qty, Dispatch_Mode
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
CREATE  PROCEDURE `PC_EXP_REPORT_GATE_IN_OUT`(
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
                    AND IF(IFNULL(TRIM(P_SEARCHTERM),'') = '', TRUE, TRUCK_NO = TRIM(P_SEARCHTERM)) 
					AND (CASE WHEN IFNULL(TRIM(P_FROMDATE),'') != '' THEN GATE_IN_DT >= STR_TO_DATE(P_FROMDATE, '%d/%m/%Y') 
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
CREATE  PROCEDURE `PC_EXP_WEIGHMENT_IN_GET`(
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
CREATE  PROCEDURE `PC_EXP_WEIGHMENT_IN_SAVE`(
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
CREATE  PROCEDURE `PC_EXP_WEIGHMENT_IN_SLIP`(
    IN P_GATE_SYS_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
)
BEGIN
		SELECT PlantID PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Weighment Slip - Weigh In (Export)' REPORT_TITLE
		FROM PLANT_MASTER WHERE PlantID = P_PLANT_ID;
		
WITH TBL_GATE_IN_MDA AS (SELECT X.PLANT_ID, X.GATE_SYS_ID, X.TRUCK_NO VEHICLE_NO, X.MDA_SYS_ID, Z.MDA_NO, Z.DI_NO, NULL Dest_Country, NULL Dispatch_Mode
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
, TBL_GATE_IN AS (SELECT X.PLANT_ID, GATE_SYS_ID, VEHICLE_NO, X.MDA_SYS_ID, X.MDA_NO, GATE_IN_DT, GATE_OUT_DT
				, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME
                , DIST, DESP_PLACE, RFSYSID, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
                , ZZ.BAG_NOS, Expected_Shipper, ZZ.PROD_SYS_ID
		FROM TBL_GATE_IN_MDA X
		LEFT JOIN mda_detail ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.MDA_SYS_ID = X.MDA_SYS_ID
)
, TBL_Loaded AS (SELECT X.PLANT_ID, X.MDA_SYS_ID, X.GATE_SYS_ID, Expected_Shipper
		, COUNT(XZ.MDA_LOD_SYS_ID) Loaded_Pallate
		, IFNULL(SUM((SELECT Shipper_Qty FROM pallate_master Y WHERE Y.Id = XZ.Pallate_Id AND Y.DI_No = XZ.DI_No)), 0) Loaded_Shipper
		FROM TBL_GATE_IN X
		LEFT JOIN exp_mda_pallate_loading XZ ON XZ.MDA_SYS_ID = X.MDA_SYS_ID AND XZ.GATE_SYS_ID = X.GATE_SYS_ID
		GROUP BY X.PLANT_ID, X.MDA_SYS_ID, X.GATE_SYS_ID, Expected_Shipper
)
, TBL_RESULT AS (
SELECT X.PLANT_ID, X.GATE_SYS_ID, X.VEHICLE_NO, X.MDA_SYS_ID, X.MDA_NO, GATE_IN_DT, GATE_OUT_DT
				, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME
                , DIST, DESP_PLACE, RFSYSID, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
                , DI_NO, Dest_Country, Dispatch_Mode
                , ZZ.PROD_SYS_ID, ZZ.BAG_NOS, ZX.Expected_Shipper, ZX.Loaded_Pallate, ZX.Loaded_Shipper
		FROM TBL_GATE_IN_MDA X
		LEFT JOIN mda_detail ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.MDA_SYS_ID = X.MDA_SYS_ID
		LEFT JOIN TBL_Loaded ZX ON ZX.PLANT_ID = X.PLANT_ID AND ZX.MDA_SYS_ID = X.MDA_SYS_ID AND ZX.GATE_SYS_ID = X.GATE_SYS_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY GATE_IN_DT DESC, GATE_SYS_ID DESC)) AS SR_NO
, X.PLANT_ID, X.GATE_SYS_ID, MDA_SYS_ID, VEHICLE_NO, MDA_NO, X.BAG_NOS, CAST((SUM(IFNULL(X.BAG_NOS, 0)) / 24) as UNSIGNED) Required_Shipper, Expected_Shipper, Loaded_Shipper
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
    , DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
	, X.PLANT_CD, WH_CD, PARTY_NAME, DIST, DESP_PLACE, RM.RFSYSID, RM.RFIDSRNO
    , DI_NO, Dest_Country, Dispatch_Mode
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
GROUP BY X.PLANT_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, VEHICLE_NO, MDA_NO, DI_NO, Dest_Country, Dispatch_Mode, Expected_Shipper, Loaded_Shipper, GATE_IN_DT, GATE_OUT_DT, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
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
CREATE  PROCEDURE `PC_EXP_WEIGHMENT_OUT_GET`(
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
CREATE  PROCEDURE `PC_EXP_WEIGHMENT_OUT_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_IN_CANCEL_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_IN_CANCEL_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_INWARD_SYS_ID INT,
    IN P_PLANT_ID INT
)
BEGIN

IF IFNULL(P_INWARD_SYS_ID, 0) = 1 THEN

		WITH TBL_RESULT AS (SELECT PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO
			, GROUP_CONCAT(DISTINCT MDA_NO ORDER BY MDA_SYS_ID SEPARATOR ',') AS MDA_NO
			, GROUP_CONCAT(DISTINCT DATE_FORMAT(MDA_DT, '%d/%m/%Y') ORDER BY MDA_SYS_ID SEPARATOR ',') AS MDA_DT
			, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
			, GROUP_CONCAT(DISTINCT PLANT_CD ORDER BY PLANT_CD SEPARATOR ',') AS PLANT_CD 
			, GROUP_CONCAT(DISTINCT TRANS_SYS_ID ORDER BY TRANS_SYS_ID SEPARATOR ',') AS TRANS_SYS_IDS
			, GROUP_CONCAT(DISTINCT PROD_SYS_ID ORDER BY PROD_SYS_ID SEPARATOR ',') AS PROD_SYS_IDS
			, GROUP_CONCAT(DISTINCT WH_CD ORDER BY WH_CD SEPARATOR ',') AS WH_CD 
			, GROUP_CONCAT(DISTINCT PARTY_NAME ORDER BY PARTY_NAME SEPARATOR ',') AS PARTY_NAME 
			, VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID
			FROM (SELECT GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO
				, GIO.GATE_IN_DT, GIO.GATE_OUT_DT, GIO.INWARD_SYS_ID, GIO.DRIVER_ID_TYPE, GIO.DRIVER_ID_NUMBER, IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_NAME_NEW, GIO.DRIVER_NAME) AS DRIVER_NAME,  IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_CONTACT_NEW, GIO.DRIVER_CONTACT) AS DRIVER_CONTACT, GIO.DRIVER_CHANGED
				, GIO.MDA_SYS_IDS AS MDA_SYS_IDS, MH.MDA_SYS_ID, MH.MDA_NO, MH.MDA_DT
				, MH.PLANT_CD, MH.TRANS_SYS_ID, MD.PROD_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
				, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID
				FROM fg_gate_in_out GIO
				INNER JOIN mda_header MH ON GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0
				LEFT JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
				WHERE MH.PLANT_ID = P_PLANT_ID AND GIO.GATE_OUT_DT IS NULL AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
				AND MH.OUT_TIME IS NULL -- AND MD.PROD_SYS_ID IN (35,55,56)
				AND IF(TRIM(IFNULL(P_SEARCHTERM,'')) = '', TRUE, 
						(GIO.TRUCK_NO = TRIM(IFNULL(P_SEARCHTERM,''))
							OR 0 < (SELECT COUNT(*) FROM mda_header MHZ WHERE GIO.PLANT_ID = MHZ.PLANT_ID AND MHZ.MDA_NO = TRIM(IFNULL(P_SEARCHTERM,'')) AND FIND_IN_SET(MHZ.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0 AND MHZ.OUT_TIME IS NULL)
							OR GIO.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = TRIM(IFNULL(P_SEARCHTERM,'')) OR ZX.RFIDCODE = TRIM(IFNULL(P_SEARCHTERM,''))))
						)
					)
				ORDER BY MH.PLANT_ID, GIO.GATE_IN_DT DESC
			) X
			GROUP BY PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
		)
		SELECT (ROW_NUMBER() OVER (ORDER BY GIO.PLANT_ID, GATE_SYS_ID DESC)) AS SR_NO
		, GIO.PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, MDA_NO COMMON_NO, MDA_DT
			, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
			, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
			, INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = GIO.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE
			, DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = GIO.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
			, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
		, GIO.PLANT_CD, TRANS_SYS_IDS, PROD_SYS_IDS, WH_CD, PARTY_NAME
		, GROUP_CONCAT(DISTINCT PM.PROD_SYS_ID ORDER BY PM.PROD_SYS_ID SEPARATOR ',') AS PROD_SYS_IDS
		, GROUP_CONCAT(DISTINCT PM.PRD_CD ORDER BY PM.PRD_CD SEPARATOR ',') AS PROD_CD
		, GROUP_CONCAT(DISTINCT PM.PRD_DESC ORDER BY PM.PRD_DESC SEPARATOR ',') AS PROD_NAME
		, GROUP_CONCAT(DISTINCT TM.TRANS_SYS_ID ORDER BY TM.TRANS_SYS_ID SEPARATOR ',') AS TRANS_SYS_IDS
		, GROUP_CONCAT(DISTINCT TM.TPTR_CD ORDER BY TM.TPTR_CD SEPARATOR ',') AS TRANS_CD
		, GROUP_CONCAT(DISTINCT TM.TPTR_NAME ORDER BY TM.TPTR_NAME SEPARATOR ',') AS TRANS_NAME
		, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME
		FROM TBL_RESULT GIO
		LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = GIO.PLANT_ID AND FIND_IN_SET(TM.TRANS_SYS_ID, GIO.TRANS_SYS_IDS) > 0
		LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = GIO.PLANT_ID AND FIND_IN_SET(PM.PROD_SYS_ID, GIO.PROD_SYS_IDS) > 0
		GROUP BY GIO.PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, MDA_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
		ORDER BY PLANT_ID, GATE_SYS_ID DESC;

ELSEIF IFNULL(P_INWARD_SYS_ID, 0) = 4 THEN

	WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.OTHER_SYS_ID, Y.ORDER_NO, Y.TRUCK_NO, Y.ORDER_DATE, Y.TRANS_SYS_ID, X.TRANSACTION_TYPE,
        INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID
				FROM other_gate_in_out X, 
				(SELECT Z.* FROM other_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID 
					AND ((Z.TRUCK_NO = P_SEARCHTERM
							OR Z.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_header XZ WHERE XZ.TRUCK_NO = P_SEARCHTERM OR XZ.OTHER_SYS_ID = IFNULL(P_ID,0)) 
							OR Z.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,''))) AND XZ.INWARD_SYS_ID = 4)
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0)
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.TRUCK_NO 
                AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL AND COALESCE(X.CANCEL_GATE_IN, 0) = 0
				AND 0 < (SELECT COUNT(*) FROM other_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID )
	)
	SELECT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, X.OTHER_SYS_ID COMMON_SYS_ID, X.ORDER_NO COMMON_NO, X.TRUCK_NO VEHICLE_NO
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(ORDER_DATE, '%d/%m/%Y %H:%i') AS MDA_DT
	, X.INWARD_SYS_ID, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
	, X.TRANS_SYS_ID, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANS_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.WEIGHIN_WT, DATE_FORMAT(ZZ.WEIGHIN_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT, ZZ.WEIGHIN_WT_NOTE
	, ZZ.WEIGHOUT_WT, DATE_FORMAT(ZZ.WEIGHOUT_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHOUT_WT_DT, ZZ.WEIGHOUT_WT_NOTE
    , X.PLANT_ID, PM.PLANT_NAME, PM.PLANTCODE AS PLANT_CODE, X.TRANSACTION_TYPE
    , X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME
	FROM TBL_MAIN X 
	LEFT JOIN other_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.PLANT_ID = X.PLANT_ID
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
	ORDER BY X.GATE_IN_DT DESC, X.ORDER_DATE DESC;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_IN_CANCEL_REPORT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_IN_CANCEL_REPORT`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_IN_CANCEL_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_IN_CANCEL_SAVE`(
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
    DECLARE TEMP_COUNT_LOAD INT;
    DECLARE TEMP_RFSYSID INT;
    
    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact the system administrator|0';

    #IF COALESCE(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT := 'E|You are not authorized to perform this operation.|0';    
    #ELSE
    IF P_ID > 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 1 THEN
		
        select COUNT(ML.MDA_LOD_SYS_ID) INTO TEMP_COUNT_LOAD
		from fg_gate_in_out gio 
		join mda_header mh on gio.PLANT_ID = mh.PLANT_ID and find_in_set(mh.MDA_SYS_ID,gio.MDA_SYS_IDS) > 0 
		left join mda_detail md on md.PLANT_ID = mh.PLANT_ID and md.MDA_SYS_ID = mh.MDA_SYS_ID 
		left join MDA_LOADING ML on ML.GATE_SYS_ID = gio.GATE_SYS_ID
		WHERE gio.GATE_SYS_ID = COALESCE(P_ID, 0) AND IFNULL(CANCEL_GATE_IN, 0) = 0
		order by gio.PLANT_ID,gio.GATE_IN_DT desc,gio.GATE_OUT_DT desc,mh.MDA_NO desc;
    
    IF IFNULL(TEMP_COUNT_LOAD, 0) > 0 THEN
    
        SET P_RESULT := 'E|Loading has started, so unable to cancel the truck.|';
        
    ELSE
    
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
    
    ELSEIF P_ID > 0 AND COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 4 THEN
        SELECT COUNT(*) INTO TEMP_NUM FROM OTHER_GATE_IN_OUT X WHERE X.GATE_SYS_ID = COALESCE(P_ID, 0);

        IF COALESCE(TEMP_NUM, 0) > 0 THEN
            SELECT RFSYSID INTO TEMP_RFSYSID FROM OTHER_GATE_IN_OUT X WHERE X.GATE_SYS_ID = COALESCE(P_ID, 0);
        
            SELECT COUNT(*) INTO TEMP_NUM FROM RFID_MASTER WHERE RFSYSID = TEMP_RFSYSID;
        
            IF COALESCE(TEMP_NUM, 0) > 0 THEN
                SELECT RFSYSID INTO TEMP_RFSYSID FROM RFID_MASTER WHERE RFSYSID = TEMP_RFSYSID;
            ELSE
                SET TEMP_RFSYSID := 0;
            END IF;
        ELSE
            SET TEMP_RFSYSID := 0;
        END IF;

        UPDATE OTHER_GATE_IN_OUT 
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_IN_MDA_LIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_IN_MDA_LIST`(IN P_SEARCHTERM VARCHAR(255),IN P_PLANT_ID INT)
BEGIN

            UPDATE RFID_MASTER SET STATUS = 'Active' 
			WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM fg_gate_in_out X WHERE GATE_OUT_DT IS NULL 
									UNION
									SELECT DISTINCT RFSYSID FROM exp_fg_gate_in_out X WHERE GATE_OUT_DT IS NULL);
            
WITH TBL_MH AS (SELECT MH.VEHICLE_NO, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')MDA_DT 
	FROM mda_header MH 
	WHERE MH.PLANT_ID = P_PLANT_ID AND MH.OUT_TIME IS NULL 
	AND ((MH.MDA_NO = P_SEARCHTERM OR MH.VEHICLE_NO = P_SEARCHTERM) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '', 1, 0))
	GROUP BY MH.VEHICLE_NO, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')
)
, TBL_RESULT AS (SELECT MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.VEHICLE_NO, MH.MDA_DT, MH.OUT_TIME, MH.PLANT_CD, MH.TRANS_SYS_ID, MD.PROD_SYS_ID
    , MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
	FROM mda_header MH
	LEFT JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
	WHERE MH.PLANT_ID = P_PLANT_ID AND (MH.VEHICLE_NO, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')) IN (SELECT VEHICLE_NO, MDA_DT FROM TBL_MH)
	AND MH.OUT_TIME IS NULL -- AND MD.PROD_SYS_ID IN (35,55,56)
    AND 0 = (select COUNT(*) FROM fg_gate_in_out GIO WHERE GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0 AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0)
    AND 0 = (select COUNT(*) FROM exp_fg_gate_in_out GIO WHERE GIO.PLANT_ID = MH.PLANT_ID AND MH.MDA_SYS_ID =  GIO.MDA_SYS_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0)
    GROUP BY MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.VEHICLE_NO, MH.MDA_DT, MH.OUT_TIME, MH.PLANT_CD, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE, MD.PROD_SYS_ID
	ORDER BY MH.PLANT_ID, MH.MDA_SYS_ID DESC, MH.MDA_DT DESC, MD.PROD_SYS_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY MH.PLANT_ID, MH.MDA_DT DESC, MH.MDA_NO DESC, MH.VEHICLE_NO)) AS SR_NO
,MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.VEHICLE_NO
, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y') AS MDA_DT, DATE_FORMAT(MH.OUT_TIME, '%d/%m/%Y %H:%i') AS OUT_TIME, MH.PLANT_CD
, MH.PROD_SYS_ID, PM.PRD_CD AS PROD_CD, PM.PRD_DESC AS PROD_NAME
, MH.TRANS_SYS_ID, TM.tptr_cd AS TRANS_CD, TM.TPTR_NAME AS TRANS_NAME
, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
, (ROW_NUMBER() OVER (PARTITION BY MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.VEHICLE_NO, MH.MDA_DT ORDER BY MH.DIST DESC)) AS MDA_ORDER
FROM TBL_RESULT MH
LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = MH.PLANT_ID AND TM.TRANS_SYS_ID = MH.TRANS_SYS_ID
LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = MH.PLANT_ID AND PM.PROD_SYS_ID = MH.PROD_SYS_ID
-- WHERE 0 = (SELECT COUNT(*) FROM MDA_LOADING ML WHERE ML.PLANT_ID = MH.PLANT_ID AND ML.MDA_SYS_ID = MH.MDA_SYS_ID )
ORDER BY MH.PLANT_ID, MH.MDA_DT DESC, MH.MDA_NO DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_IN_OTHER_LIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_IN_OTHER_LIST`(IN P_SearchTerm VARCHAR(255),IN P_PLANT_ID INT)
BEGIN

SELECT (ROW_NUMBER() OVER (PARTITION BY X.ORDER_DATE, X.TRUCK_NO ORDER BY X.ORDER_DATE DESC, X.OTHER_SYS_ID ASC)) AS SR_NO
, X.OTHER_SYS_ID ID, X.ORDER_NO, DATE_FORMAT(X.ORDER_DATE, '%d/%m/%Y') AS ORDER_DATE, X.COST_CENTER, X.DESCCRIPTION, X.TRUCK_NO, X.TRANS_SYS_ID
, TPTR_CD WH_CD, TPTR_NAME PARTY_NAME, X.IS_PO_MANUAL
FROM other_header X 
LEFT JOIN TRANSPORTER_MASTER TR ON X.TRANS_SYS_ID = TR.TRANS_SYS_ID 
WHERE X.PLANT_ID = P_PLANT_ID AND X.OTHER_SYS_ID NOT IN (SELECT DISTINCT Z.OTHER_SYS_ID FROM other_gate_in_out Z)
AND 1 = CASE WHEN LENGTH(COALESCE(P_SearchTerm, '')) > 0 THEN CASE WHEN UPPER(TRUCK_NO) LIKE CONCAT('%', UPPER(P_SearchTerm), '%') THEN 1 ELSE 0 END ELSE 1 END
ORDER BY X.ORDER_DATE DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_IN_OTHER_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_IN_OTHER_SAVE`(
IN `P_ID` INT,
IN `P_INWARD_SYS_ID` INT,
IN `P_COMMON_SYS_ID` INT,
IN `P_COMMON_NO` VARCHAR(255),
IN `P_TRUCK_NO` VARCHAR(255),
IN `P_TRANSACTION_TYPE` VARCHAR(255),
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
DECLARE TEMP_TRANS_SYS_ID INT DEFAULT 0;
DECLARE TEMP_RFSYSID INT DEFAULT 0;
DECLARE TEMP_MDA_DT VARCHAR(255);
      
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

IF IFNULL(P_COMMON_SYS_ID, 0) = 0 AND IFNULL(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 4 THEN
	SELECT COUNT(*) INTO TEMP_NUM FROM other_header WHERE ORDER_NO = P_COMMON_NO;
		IF IFNULL(TEMP_NUM, 0) > 0 THEN
			SELECT OTHER_SYS_ID, TRANS_SYS_ID INTO TEMP_COMMON_SYS_ID, TEMP_TRANS_SYS_ID FROM other_header WHERE ORDER_NO = P_COMMON_NO LIMIT 1;
		ELSE
			SET TEMP_COMMON_SYS_ID = 0;   
			SET TEMP_TRANS_SYS_ID = 0;        
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

SELECT COUNT(*) INTO TEMP_NUM FROM other_gate_in_out WHERE /*DATE(GATE_IN_DT) = DATE(CURRENT_DATE) AND*/ INWARD_SYS_ID = IFNULL(P_INWARD_SYS_ID, 0) 
		AND OTHER_SYS_ID = IFNULL(TEMP_COMMON_SYS_ID, 0) AND GATE_SYS_ID != IFNULL(P_ID, 0);

IF IFNULL(TEMP_NUM, 0) > 0 THEN
	SET P_RESULT = 'E|Entered Gate In details already exist.|0';
ELSEIF IFNULL(TEMP_RFSYSID, 0) = 0 THEN
	SET P_RESULT = 'E|RFID does not exist or already assigned.|0';
ELSEIF IFNULL(TEMP_COMMON_SYS_ID, 0) = 0 AND IFNULL(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 4 THEN
	SET P_RESULT = 'E|Order No. does not exist.|0';
ELSEIF P_ID > 0 AND IFNULL(TEMP_COMMON_SYS_ID, 0) > 0 THEN
	SET P_RESULT = 'S|Record updated successfully|';

ELSEIF IFNULL(TEMP_COMMON_SYS_ID, 0) > 0 THEN
	IF IFNULL(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 4 THEN
		
		INSERT INTO other_gate_in_out (
        GATE_IN_DT, INWARD_SYS_ID, OTHER_SYS_ID, TRUCK_NO, TRANS_SYS_ID, TRANSACTION_TYPE,
		DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, 
		DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION,
		RFSYSID, RFID_RECEIVE, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME
		)
		VALUES (NOW(), P_INWARD_SYS_ID, TEMP_COMMON_SYS_ID, P_TRUCK_NO, TEMP_TRANS_SYS_ID, P_TRANSACTION_TYPE,
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_IN_OUT_REPORT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_IN_OUT_REPORT_GET`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_IN_PO_LIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_IN_PO_LIST`(IN `P_SearchTerm` VARCHAR(255),IN P_PLANT_ID INT)
BEGIN

SELECT PO.PO_SYS_ID, PO_NO, RM.GATE_SYS_ID, PO_DATE, PO.VENDOR_SYS_ID, VM.ORGANIZATION_NAME, VM.VENDOR_SITE, COST_CENTER, PO_DESCCRIPTION, PO.TRANS_SYS_ID, TR.TPTR_CD, TR.TPTR_NAME, PO.TRUCK_NO, IS_PO_MANUAL, RF.RFIDSRNO
, PO.STATION_ID, PO.PLANT_ID, (SELECT PLANTCODE FROM PLANT_MASTER PM WHERE PO.PLANT_ID = PM.PLANTID) PLANT_CD, PO.CREATED_BY_ID, PO.CREATED_DATETIME
, PO.IS_POSTED FROM PO_HEADER PO
LEFT JOIN TRANSPORTER_MASTER TR ON PO.TRANS_SYS_ID = TR.TRANS_SYS_ID
LEFT JOIN RM_GATE_IN_OUT RM ON RM.PO_SYS_ID = PO.PO_SYS_ID
LEFT JOIN RFID_MASTER RF ON RM.RFSYSID = RF.RFSYSID
LEFT JOIN vendor_master VM ON VM.VENDOR_SYS_ID = PO.VENDOR_SYS_ID
WHERE PO.PLANT_ID = P_PLANT_ID 
AND PO.PO_SYS_ID NOT IN (SELECT PO_SYS_ID FROM RM_GATE_IN_OUT)
AND 1 = CASE WHEN LENGTH(COALESCE(P_SEARCHTERM, '')) > 0 THEN CASE WHEN UPPER(PO.TRUCK_NO) LIKE CONCAT('%', UPPER(P_SEARCHTERM), '%')  OR  UPPER(PO.PO_NO) LIKE CONCAT('%', UPPER(P_SEARCHTERM), '%')  THEN 1 ELSE 0 END ELSE 1 END
ORDER BY CREATED_DATETIME DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_IN_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_IN_SAVE`(
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
DECLARE TEMP_MDA_DT VARCHAR(255);
      
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

		SELECT DATE_FORMAT(MH.MDA_DT, '%d/%m/%y') INTO TEMP_MDA_DT FROM mda_header MH WHERE MH.MDA_SYS_ID = TEMP_COMMON_SYS_ID;

		INSERT INTO mda_sequence (PLANT_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_Sequence_No, MDA_STATUS, MDA_REASON, MDA_REMARK, MDA_STATUS_DATETIME
										, Created_BY_ID, Created_DateTime, IS_POSTED)
		SELECT P_PLANT_ID, TEMP_NUM, MH.MDA_SYS_ID, (ROW_NUMBER() OVER (ORDER BY MH.DIST DESC)), NULL, NULL, NULL, NOW(), P_USER_ID, NOW(), 0 
        FROM mda_header MH WHERE MH.VEHICLE_NO = P_TRUCK_NO AND DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y') = (SELECT DATE_FORMAT(MHX.MDA_DT, '%d/%m/%Y') FROM mda_header MHX WHERE MHX.MDA_SYS_ID = TEMP_COMMON_SYS_ID);
        #AND (DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y') = TEMP_MDA_DT OR DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y') = DATE_FORMAT((STR_TO_DATE(TEMP_MDA_DT, '%d/%m/%Y') - INTERVAL 1 DAY), '%d/%m/%Y'));

		SET P_RESULT = 'S|Record saved successfully|';
	END IF;
    
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_IN_SAVE_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_IN_SAVE_NEW`(
IN `P_ID` INT,
IN `P_INWARD_SYS_ID` INT,
IN `P_COMMON_SYS_ID` INT,
IN `P_COMMON_SYS_ID_MULTI` VARCHAR(255),
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
DECLARE TEMP_COMMON_SYS_ID INT DEFAULT 0;
DECLARE TEMP_NUM INT DEFAULT 0;
DECLARE TEMP_NUM_MDA INT DEFAULT 0;
DECLARE TEMP_RFSYSID INT DEFAULT 0;
DECLARE TEMP_COMMON_SYS_ID_MULTI VARCHAR(255);
      
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

IF TRIM(IFNULL(P_COMMON_SYS_ID_MULTI, '')) = '' THEN	
	SET TEMP_COMMON_SYS_ID_MULTI = CONCAT('',P_COMMON_SYS_ID);
ELSE
	SET TEMP_COMMON_SYS_ID_MULTI = TRIM(REPLACE(REPLACE(IFNULL(P_COMMON_SYS_ID_MULTI, ''), ' ', ''), '|', ','));
END IF;

IF INSTR(TEMP_COMMON_SYS_ID_MULTI, ',') > 0 THEN 
	SET TEMP_COMMON_SYS_ID = CAST(SUBSTRING_INDEX(TEMP_COMMON_SYS_ID_MULTI, ',', 1) AS UNSIGNED);
ELSE
	SET TEMP_COMMON_SYS_ID = CAST(TEMP_COMMON_SYS_ID_MULTI AS UNSIGNED);
END IF;

SELECT COUNT(*) INTO TEMP_NUM FROM FG_GATE_IN_OUT WHERE TRUCK_NO = IFNULL(P_TRUCK_NO, '') AND GATE_OUT_DT IS NULL AND COALESCE(CANCEL_GATE_IN, 0) = 0;

IF IFNULL(TEMP_NUM, 0) <= 0 THEN
	SELECT COUNT(*) INTO TEMP_NUM FROM FG_GATE_IN_OUT WHERE TRUCK_NO = IFNULL(P_TRUCK_NO, '') 
			AND FIND_IN_SET(MDA_SYS_ID, TEMP_COMMON_SYS_ID_MULTI) > 0 AND MDA_SYS_ID = TEMP_COMMON_SYS_ID AND GATE_SYS_ID != IFNULL(P_ID, 0)AND COALESCE(CANCEL_GATE_IN, 0) = 0 ;
END IF;

SELECT COUNT(*) INTO TEMP_NUM_MDA FROM mda_header WHERE VEHICLE_NO = IFNULL(P_TRUCK_NO, '') AND FIND_IN_SET(MDA_SYS_ID, TEMP_COMMON_SYS_ID_MULTI) > 0;

IF IFNULL(TEMP_NUM, 0) > 0 THEN
	SET P_RESULT = 'E|Entered Gate In details already exist.|0';
ELSEIF IFNULL(TEMP_RFSYSID, 0) = 0 THEN
	SET P_RESULT = 'E|RFID does not exist or already assigned.|0';
ELSEIF IFNULL(TEMP_NUM_MDA, 0) = 0 THEN
	SET P_RESULT = 'E|MDA does not exist.|0';
    
ELSE

	IF IFNULL(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 1 THEN
		#SELECT IFNULL(MAX(GATE_SYS_ID), 0) + 1 INTO TEMP_NUM FROM FG_GATE_IN_OUT;
        WITH TBL_AI AS (SELECT `AUTO_INCREMENT` ID FROM  INFORMATION_SCHEMA.TABLES 
		WHERE LOWER(TABLE_SCHEMA) = 'iffco' AND LOWER(TABLE_NAME) = 'fg_gate_in_out')
		, TBL_T AS (SELECT IFNULL(MAX(GATE_SYS_ID), 0) + 1 ID FROM fg_gate_in_out) 
		SELECT IF(X.ID > Z.ID, X.ID, Z.ID) + 1 INTO TEMP_NUM FROM TBL_AI X, TBL_T Z;


		INSERT INTO FG_GATE_IN_OUT (
		GATE_SYS_ID, GATE_IN_DT, INWARD_SYS_ID, MDA_SYS_ID, MDA_SYS_IDS, TRUCK_NO, 
		DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, 
		DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION,
		RFSYSID, RFID_RECEIVE, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME
		)
		VALUES (
		TEMP_NUM, NOW(), P_INWARD_SYS_ID, TEMP_COMMON_SYS_ID, TEMP_COMMON_SYS_ID_MULTI, P_TRUCK_NO, 
		P_DRIVER_ID_TYPE, P_DRIVER_ID_NUMBER, P_DRIVER_NAME, P_DRIVER_CONTACT, 
		IFNULL(P_DRIVER_CHANGED, 0), P_DRIVER_NAME_NEW, P_DRIVER_CONTACT_NEW, IFNULL(P_TRUCK_VALIDATION, 0),
		IFNULL(TEMP_RFSYSID, 0), IFNULL(P_RFID_RECEIVE, 0), TEMP_STATION_ID, P_PLANT_ID, P_USER_ID, NOW()
		);

		UPDATE RFID_MASTER SET STATUS = 'Assigned' WHERE RFSYSID = TEMP_RFSYSID;

		INSERT INTO mda_sequence (PLANT_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_Sequence_No, MDA_STATUS, MDA_REASON, MDA_REMARK, MDA_STATUS_DATETIME
										, Created_BY_ID, Created_DateTime, IS_POSTED)
		SELECT P_PLANT_ID, TEMP_NUM, MH.MDA_SYS_ID, (ROW_NUMBER() OVER (ORDER BY MH.DIST DESC)), NULL, NULL, NULL, NOW(), P_USER_ID, NOW(), 0 
        FROM mda_header MH WHERE MH.VEHICLE_NO = P_TRUCK_NO AND FIND_IN_SET(MH.MDA_SYS_ID, TEMP_COMMON_SYS_ID_MULTI) > 0;
	
		SET P_RESULT = 'S|Record saved successfully|0';
	END IF;
    
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_IN_SO_LIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_IN_SO_LIST`(IN `P_SearchTerm` VARCHAR(255),IN P_PLANT_ID INT)
BEGIN

SELECT SO.SO_SYS_ID, UNIT_CODE, SP.GATE_SYS_ID, SO_NO, SO_DATE, SO_RELEASE_DATE, SO.TRUCK_NO, SO.TRANSPORTER_NAME, SO.LOADING_GATE, SP.DRIVER_NAME, SP.DRIVER_CONTACT, SP.DRIVER_ID_TYPE, SP.DRIVER_ID_NUMBER, SO_VALID_DATE, SEQUENCE_NO, TENDER_NO, TENDER_DATE, SO.VENSOR_SYS_ID, CUST_CD, RF.RFIDSRNO
 , CUST_NAME, CUST_SITE_CD, SITE_NAME, ADD1, ADD2, ADD3, CITY, PIN, STATE, STATE_CD, GSTN_NO, PAN_NO, CUST_NON_GST, TEL_NO
 , SO_REMARKS, SO.STATUS, STATUS_DATE, STATUS_REMARKS, TERMS_PYMT_TERM, TERMS_LIFTING_PERIOD_DAYS, TENDER_TYPE, AMEND_NO
 , AMEND_RELEASE_DATE, SO.CREATED_DATETIME, SO.IS_POSTED, SO.PLANT_ID, RIVISION FROM SO_HEADER SO 
LEFT JOIN SP_GATE_IN_OUT SP ON SP.SO_SYS_ID = SO.SO_SYS_ID
LEFT JOIN RFID_MASTER RF ON SP.RFSYSID = RF.RFSYSID
    WHERE SO.PLANT_ID = P_PLANT_ID 
    AND SO.SO_SYS_ID NOT IN (SELECT SO_SYS_ID FROM SP_GATE_IN_OUT)
    AND 1 = CASE WHEN LENGTH(COALESCE(P_SEARCHTERM, '')) > 0 THEN CASE WHEN UPPER(SP.TRUCK_NO) LIKE UPPER(P_SEARCHTERM)  OR  UPPER(SO.SO_NO) = UPPER(P_SEARCHTERM)  THEN 1 ELSE 0 END ELSE 1 END
    ORDER BY CREATED_DATETIME DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_OUT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_OUT_GET`(
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
    
    
    
    
    WITH TBL_RESULT AS (SELECT PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO
	, GROUP_CONCAT(DISTINCT MDA_NO ORDER BY MDA_SYS_ID SEPARATOR ',') AS MDA_NO
	, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
	, GROUP_CONCAT(DISTINCT PLANT_CD ORDER BY PLANT_CD SEPARATOR ',') AS PLANT_CD 
	, GROUP_CONCAT(DISTINCT TRANS_SYS_ID ORDER BY TRANS_SYS_ID SEPARATOR ',') AS TRANS_SYS_IDS
	, GROUP_CONCAT(DISTINCT PROD_SYS_ID ORDER BY PROD_SYS_ID SEPARATOR ',') AS PROD_SYS_IDS
	, GROUP_CONCAT(DISTINCT WH_CD ORDER BY WH_CD SEPARATOR ',') AS WH_CD 
	, GROUP_CONCAT(DISTINCT PARTY_NAME ORDER BY PARTY_NAME SEPARATOR ',') AS PARTY_NAME 
    , VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID
	FROM (SELECT GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO
		, GIO.GATE_IN_DT, GIO.GATE_OUT_DT, GIO.INWARD_SYS_ID, GIO.DRIVER_ID_TYPE, GIO.DRIVER_ID_NUMBER, IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_NAME_NEW, GIO.DRIVER_NAME) AS DRIVER_NAME,  IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_CONTACT_NEW, GIO.DRIVER_CONTACT) AS DRIVER_CONTACT, GIO.DRIVER_CHANGED
		, GIO.MDA_SYS_IDS AS MDA_SYS_IDS, MH.MDA_SYS_ID, MH.MDA_NO
		, MH.PLANT_CD, MH.TRANS_SYS_ID, MD.PROD_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
        , GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID
		FROM fg_gate_in_out GIO
		INNER JOIN mda_header MH ON GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0
		LEFT JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
		WHERE MH.PLANT_ID = P_PLANT_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
		AND GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL
        AND IF(IFNULL(P_SEARCHTERM,'') = '', TRUE, 
				(GIO.TRUCK_NO = P_SEARCHTERM
					OR 0 < (SELECT COUNT(*) FROM mda_header MHZ WHERE GIO.PLANT_ID = MHZ.PLANT_ID AND MHZ.MDA_NO = P_SEARCHTERM AND FIND_IN_SET(MHZ.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0 AND MHZ.OUT_TIME IS NULL)
					OR GIO.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,'')))
                )
			)
		AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = GIO.GATE_SYS_ID 
								AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0 AND XZ.GROSS_WT_DT IS NOT NULL)
		ORDER BY MH.PLANT_ID, GIO.GATE_IN_DT DESC
	) X
	GROUP BY PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY GIO.PLANT_ID, GATE_IN_DT DESC, GIO.GATE_SYS_ID, VEHICLE_NO)) AS SR_NO
, GIO.PLANT_ID, GIO.GATE_SYS_ID ID, ZZ.WT_SYS_ID, MDA_SYS_IDS, VEHICLE_NO Truck_No, MDA_NO COMMON_NO, NULL COMMON_SYS_ID
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
    , DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
	, INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = GIO.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE
    , DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = GIO.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
    , DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, GIO.PLANT_CD PLANT_CODE, TRANS_SYS_IDS, PROD_SYS_IDS, WH_CD, PARTY_NAME
, GROUP_CONCAT(DISTINCT PM.PROD_SYS_ID ORDER BY PM.PROD_SYS_ID SEPARATOR ',') AS PROD_SYS_IDS
, GROUP_CONCAT(DISTINCT PM.PRD_CD ORDER BY PM.PRD_CD SEPARATOR ',') AS PROD_CD
, GROUP_CONCAT(DISTINCT PM.PRD_DESC ORDER BY PM.PRD_DESC SEPARATOR ',') AS PROD_NAME
, GROUP_CONCAT(DISTINCT TM.TRANS_SYS_ID ORDER BY TM.TRANS_SYS_ID SEPARATOR ',') AS TRANS_SYS_IDS
, GROUP_CONCAT(DISTINCT TM.TPTR_CD ORDER BY TM.TPTR_CD SEPARATOR ',') AS TRANS_CD
, GROUP_CONCAT(DISTINCT TM.TPTR_NAME ORDER BY TM.TPTR_NAME SEPARATOR ',') AS TRANSPORTER_NAME
, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME, NULL TRANSACTION_TYPE
		, ZZ.WT_SYS_ID, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.TARE_WT_MANUALLY, ZZ.TARE_WT_NOTE
		, ZZ.GROSS_WT, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, ZZ.GROSS_WT_MANUALLY, ZZ.GROSS_WT_NOTE, ZZ.NET_WT
FROM TBL_RESULT GIO
INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.PLANT_ID = GIO.PLANT_ID AND ZZ.GATE_SYS_ID = GIO.GATE_SYS_ID
LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = GIO.PLANT_ID AND FIND_IN_SET(TM.TRANS_SYS_ID, GIO.TRANS_SYS_IDS) > 0
LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = GIO.PLANT_ID AND FIND_IN_SET(PM.PROD_SYS_ID, GIO.PROD_SYS_IDS) > 0
GROUP BY GIO.PLANT_ID, GIO.GATE_SYS_ID, ZZ.WT_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, MDA_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
		, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, ZZ.TARE_WT_DT, ZZ.TARE_WT_MANUALLY, ZZ.TARE_WT_NOTE, ZZ.GROSS_WT, ZZ.GROSS_WT_DT, ZZ.GROSS_WT_MANUALLY, ZZ.GROSS_WT_NOTE, ZZ.NET_WT
ORDER BY PLANT_ID, GATE_IN_DT DESC, GIO.GATE_SYS_ID, VEHICLE_NO;
    
 /*   
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
							OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,'')) ) AND XZ.INWARD_SYS_ID IN (125, 1))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND P_ID = 0, 1, 0)
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.VEHICLE_NO AND 1 = (CASE WHEN IFNULL(P_SEARCHTERM,'') = '' OR X.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,''))) 
																									THEN (CASE WHEN COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL THEN 1 ELSE 0 END ) ELSE 1 END ) 
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
WHERE X.INWARD_SYS_ID IN (125, 1) AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.OUT_TIME IS NULL
AND ZZ.TARE_WT IS NOT NULL AND COALESCE(ZZ.TARE_WT,0) > 0 AND ZZ.GROSS_WT_DT IS NOT NULL AND COALESCE(ZZ.GROSS_WT,0) > 0;
*/

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_OUT_GET_OTHER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_OUT_GET_OTHER`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.OTHER_SYS_ID, Y.ORDER_NO, Y.TRUCK_NO, Y.ORDER_DATE, Y.TRANS_SYS_ID, X.TRANSACTION_TYPE,
        INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID
				FROM other_gate_in_out X, 
				(SELECT Z.* FROM other_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID 
					AND ((Z.TRUCK_NO = P_SEARCHTERM
							OR Z.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_header XZ WHERE XZ.TRUCK_NO = P_SEARCHTERM OR XZ.OTHER_SYS_ID = IFNULL(P_ID,0)) 
							OR Z.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,''))) AND XZ.INWARD_SYS_ID = 4)
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0)
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.TRUCK_NO AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM other_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.WEIGHIN_WT_DT IS NOT NULL AND IFNULL(XZ.WEIGHIN_WT,0) > 0 AND XZ.WEIGHOUT_WT_DT IS NOT NULL AND IFNULL(XZ.WEIGHOUT_WT,0) > 0)
	)
	SELECT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID ID, X.OTHER_SYS_ID COMMON_SYS_ID, X.ORDER_NO COMMON_NO, X.TRUCK_NO
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(ORDER_DATE, '%d/%m/%Y %H:%i') AS ORDER_DATE
	, X.INWARD_SYS_ID, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
	, X.TRANS_SYS_ID, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.WEIGHIN_WT, DATE_FORMAT(ZZ.WEIGHIN_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT, ZZ.WEIGHIN_WT_NOTE
	, ZZ.WEIGHOUT_WT, DATE_FORMAT(ZZ.WEIGHOUT_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHOUT_WT_DT, ZZ.WEIGHOUT_WT_NOTE
    , X.PLANT_ID, PM.PLANT_NAME, PM.PLANTCODE AS PLANT_CODE, X.TRANSACTION_TYPE
    , X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME
	FROM TBL_MAIN X 
	LEFT JOIN other_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.PLANT_ID = X.PLANT_ID
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
	-- WHERE IFNULL(ZZ.WEIGHIN_WT,0) > 0 AND ZZ.WEIGHIN_WT_DT IS NOT NULL AND IFNULL(ZZ.WEIGHOUT_WT,0) > 0 AND ZZ.WEIGHOUT_WT_DT IS NOT NULL
	ORDER BY X.GATE_IN_DT DESC, X.ORDER_DATE DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_OUT_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_OUT_SAVE`(
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
        
            UPDATE RFID_MASTER SET STATUS = 'Active' 
			WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM fg_gate_in_out X WHERE GATE_OUT_DT IS NULL 
									UNION
									SELECT DISTINCT RFSYSID FROM exp_fg_gate_in_out X WHERE GATE_OUT_DT IS NULL);
            
    END;

	SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
		
    #IF NVL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT := 'E|You are not authorized to perform this operation.|0';    
    #ELSE
    IF P_ID > 0 THEN

        
        SELECT X.RFSYSID, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_RFID, TEMP_GATE_OUT_DT FROM fg_gate_in_out X WHERE X.GATE_SYS_ID = P_ID AND X.MDA_SYS_ID = P_MDA_SYS_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NULL THEN
        
            UPDATE FG_GATE_IN_OUT 
            SET GATE_OUT_DT = CURRENT_TIMESTAMP(), IS_GOODS_TRANSFER = 1
            WHERE GATE_SYS_ID = P_ID AND COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND STATION_ID = TEMP_STATION_ID AND PLANT_ID = P_PLANT_ID;
			
            #UPDATE mda_header SET OUT_TIME = NOW() WHERE MDA_SYS_ID = P_MDA_SYS_ID AND PLANT_ID = P_PLANT_ID;

            UPDATE mda_header MH_U
			INNER JOIN fg_gate_in_out GIO ON MH_U.PLANT_ID = GIO.PLANT_ID AND GIO.TRUCK_NO = MH_U.VEHICLE_NO
			INNER JOIN mda_header MH ON MH.PLANT_ID = GIO.PLANT_ID AND GIO.TRUCK_NO = MH.VEHICLE_NO
			SET MH_U.OUT_TIME = NOW()
			WHERE GIO.PLANT_ID = P_PLANT_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0 AND GIO.GATE_IN_DT IS NOT NULL AND GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL AND MH_U.OUT_TIME IS NULL
			AND GIO.GATE_SYS_ID = P_ID AND MH_U.PLANT_ID = MH.PLANT_ID AND MH.MDA_SYS_ID = MH_U.MDA_SYS_ID;

			SELECT MDA_NO INTO TEMP_MDA_NO FROM mda_header Z WHERE MDA_SYS_ID = P_MDA_SYS_ID AND PLANT_ID = P_PLANT_ID LIMIT 1;
            
			SELECT COALESCE(MAX(MDAInvQr_SYS_ID), 0) + 1 INTO TEMP_NUM FROM mda_invoice_qr;
            
			INSERT INTO mda_invoice_qr (MDAInvQr_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, INVOICEQrCODE, BASE64InvQrCode, Created_BY_ID, Created_DateTime, PLANT_ID, IS_POSTED, IS_DISPATCHED)
			VALUES(TEMP_NUM, P_ID, P_MDA_SYS_ID,TEMP_MDA_NO,P_INVOICE_QR_CODE,P_BASE64_INVOICE_QR_CODE, P_USER_ID, NOW(), P_PLANT_ID, 0,1);
            
            COMMIT;
            
            #UPDATE RFID_MASTER SET STATUS = 'Active' WHERE RFSYSID = TEMP_RFID AND PLANT_ID = P_PLANT_ID;
            
            /*UPDATE RFID_MASTER SET STATUS = 'Active' 
            WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM fg_gate_in_out X
								INNER JOIN mda_header Y ON Y.PLANT_ID = X.PLANT_ID AND Y.MDA_SYS_ID = X.MDA_SYS_ID
								WHERE GATE_OUT_DT IS NULL AND OUT_TIME IS NULL AND DATE_FORMAT(X.GATE_IN_DT, '%Y') = '2024'
								ORDER BY 1 DESC) 
			AND PLANT_ID = P_PLANT_ID;*/
            
            WITH TBL_MDA AS (SELECT Z.PLANT_ID, Z.GATE_SYS_ID, MD.MDA_SYS_ID, MD.PROD_SYS_ID, Z.VEHICLE_NO, Z.MDA_NO, PM.PRD_CD AS PRODUCT_CODE, PM.PRD_DESC AS PRODUCT_DESC
					, CAST((MD.BAG_NOS / 24) AS unsigned) Required_Shipper
					FROM (SELECT GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO, MH.MDA_SYS_ID, MH.MDA_NO
						FROM fg_gate_in_out GIO
						INNER JOIN mda_header MH ON GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0
						WHERE COALESCE(GIO.CANCEL_GATE_IN, 0) = 0 AND GIO.GATE_SYS_ID = P_ID 
					) Z
					INNER JOIN mda_detail MD ON MD.PLANT_ID = Z.PLANT_ID AND MD.MDA_SYS_ID = Z.MDA_SYS_ID
					LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = Z.PLANT_ID AND PM.PROD_SYS_ID = MD.PROD_SYS_ID
					WHERE INSTR(PM.PRD_DESC, 'IPL') > 0
			)
			, TBL_MDA_LOAD AS (SELECT PLANT_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, PRODUCT_CODE, SHIPPER_QR_CODE 
					FROM MDA_LOADING ML 
					WHERE EXISTS (SELECT 1 FROM TBL_MDA Z WHERE ML.MDA_SYS_ID = Z.MDA_SYS_ID AND ML.GATE_SYS_ID = Z.GATE_SYS_ID) 
					GROUP BY PLANT_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, PRODUCT_CODE, SHIPPER_QR_CODE
			)
			, TBL_SHIPPER AS (
			SELECT ML.PLANT_ID, ML.GATE_SYS_ID, ML.MDA_SYS_ID, ML.PROD_SYS_ID, ML.PRODUCT_CODE, SQA.shipper_qrcode_api_sysId, SQA.BATCH_NO, SQA.MarketedBy
			FROM TBL_MDA_LOAD ML
			LEFT JOIN SHIPPER_QRCODE SQ ON SQ.PLANT_ID = ML.PLANT_ID AND SQ.SHIPPER_QRCODE = ML.SHIPPER_QR_CODE
			LEFT JOIN SHIPPER_QRCODE_API SQA ON SQA.PLANT_ID = ML.PLANT_ID AND SQA.SHIPPER_QRCODE_API_SYSID = SQ.SHIPPER_QRCODE_API_SYSID
			GROUP BY ML.PLANT_ID, ML.GATE_SYS_ID, ML.MDA_SYS_ID, ML.PROD_SYS_ID, ML.PRODUCT_CODE, SQA.shipper_qrcode_api_sysId, SQA.BATCH_NO, SQA.MarketedBy
			)
			UPDATE SHIPPER_QRCODE_API SQA
			JOIN TBL_SHIPPER TS ON TS.shipper_qrcode_api_sysId = SQA.shipper_qrcode_api_sysId AND TS.BATCH_NO = SQA.BATCH_NO
			SET SQA.MarketedBy = 'IPL', SQA.Product_Code = PRODUCT_CODE;
						
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

            UPDATE RFID_MASTER SET STATUS = 'Active' 
			WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM fg_gate_in_out X WHERE GATE_OUT_DT IS NULL 
									UNION
									SELECT DISTINCT RFSYSID FROM exp_fg_gate_in_out X WHERE GATE_OUT_DT IS NULL);
            
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_OUT_SAVE_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_OUT_SAVE_NEW`(
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
    DECLARE TEMP_CURRENT_DATETIME datetime;
    DECLARE TEMP_Combined_Info VARCHAR(2550) DEFAULT NULL;
    
    DECLARE TEMP_MDA_ID VARCHAR(255);
    DECLARE TEMP_MDA_NO VARCHAR(255);
    DECLARE TEMP_GATE_OUT_DT VARCHAR(255) DEFAULT NULL;
    DECLARE TEMP_INVOICE_QR_CODE VARCHAR(255) DEFAULT NULL;
      
            DECLARE v_CNT BIGINT DEFAULT 0;
            DECLARE v_counter BIGINT DEFAULT 1;
            DECLARE v_line_invoice_no LONGTEXT;
            DECLARE v_line_invoice_qr_base64 LONGTEXT;
            DECLARE v_invoice_no LONGTEXT;
            DECLARE v_invoice_qr_base64 LONGTEXT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
    
            UPDATE RFID_MASTER SET STATUS = 'Active' 
            WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM fg_gate_in_out X
								INNER JOIN mda_header Y ON Y.PLANT_ID = X.PLANT_ID AND Y.MDA_SYS_ID = X.MDA_SYS_ID
								WHERE GATE_OUT_DT IS NULL AND OUT_TIME IS NULL AND DATE_FORMAT(X.GATE_IN_DT, '%Y') = '2024'
                                -- UNION 
                                -- SELECT DISTINCT RFSYSID FROM other_gate_in_out X WHERE GATE_OUT_DT IS NULL ORDER BY 1 DESC
                                );
            
            
        SELECT DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_GATE_OUT_DT 
        FROM fg_gate_in_out X 
        WHERE X.GATE_SYS_ID = P_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NULL THEN
			
            SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
            
        ELSE
			
            SELECT GROUP_CONCAT(CONCAT('MDA No. : ', MDA_NO, ', Invoice No. : ', INVOICEQrCODE) SEPARATOR '; ') 
					INTO TEMP_Combined_Info 
            FROM mda_invoice_qr WHERE GATE_SYS_ID = P_ID;
            
			SET P_RESULT = CONCAT(
				'E|Gate Out Details is already saved. Gate Out Date Time : ', 
				IFNULL(TEMP_GATE_OUT_DT, ''), 
				IF(TEMP_Combined_Info IS NOT NULL, CONCAT('. ', TEMP_Combined_Info), ''), 
				'|0'
			);
            
        END IF;
        
    END;

	SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
		
    #IF NVL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT := 'E|You are not authorized to perform this operation.|0';    
    #ELSE
    IF P_ID > 0 THEN
		
        SET TEMP_CURRENT_DATETIME = NOW();
        
        SELECT DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_GATE_OUT_DT 
        FROM fg_gate_in_out X 
        WHERE X.GATE_SYS_ID = P_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NULL THEN
        
            #UPDATE mda_header SET OUT_TIME = NOW() WHERE MDA_SYS_ID = P_MDA_SYS_ID AND PLANT_ID = P_PLANT_ID;

			SET v_counter = 1;
			SET v_line_invoice_no = REGEXP_SUBSTR(P_INVOICE_QR_CODE, '[^,]+', 1, v_counter);
			SET v_line_invoice_qr_base64 = REGEXP_SUBSTR(P_BASE64_INVOICE_QR_CODE, '[^,]+', 1, v_counter);
			
			WHILE v_line_invoice_no IS NOT NULL AND v_line_invoice_qr_base64 IS NOT NULL DO
			
				SET v_CNT = 1;
				SET TEMP_MDA_ID = REGEXP_SUBSTR(v_line_invoice_no, '[^|]+', 1, v_CNT);
				SET v_CNT = v_CNT + 1;
				SET v_invoice_no = REGEXP_SUBSTR(v_line_invoice_no, '[^|]+', 1, v_CNT);
				SET v_invoice_qr_base64 = REGEXP_SUBSTR(v_line_invoice_qr_base64, '[^|]+', 1, v_CNT);
						
				SELECT COUNT(*) INTO TEMP_NUM FROM mda_invoice_qr WHERE GATE_SYS_ID = P_ID AND MDA_SYS_ID = CAST(TEMP_MDA_ID AS UNSIGNED);
                        
				IF IFNULL(TEMP_NUM, 0) = 0 AND TEMP_MDA_ID IS NOT NULL AND v_invoice_no IS NOT NULL AND v_invoice_qr_base64 IS NOT NULL THEN		
							   
					SELECT MDA_NO INTO TEMP_MDA_NO FROM mda_header Z WHERE MDA_SYS_ID = CAST(TEMP_MDA_ID AS UNSIGNED) AND PLANT_ID = P_PLANT_ID LIMIT 1;
					
					SELECT COALESCE(MAX(MDAInvQr_SYS_ID), 0) + 1 INTO TEMP_NUM FROM mda_invoice_qr;
					
					INSERT INTO mda_invoice_qr (MDAInvQr_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, INVOICEQrCODE, BASE64InvQrCode, Created_BY_ID, Created_DateTime, PLANT_ID, IS_POSTED, IS_DISPATCHED)
					VALUES(TEMP_NUM, P_ID, CAST(TEMP_MDA_ID AS UNSIGNED),TEMP_MDA_NO,v_invoice_no,v_invoice_qr_base64, P_USER_ID, TEMP_CURRENT_DATETIME, P_PLANT_ID, 0,1);
					
					COMMIT;
					
				END IF;
				                 
				SET v_counter = v_counter + 1;
				SET v_line_invoice_no = REGEXP_SUBSTR(P_INVOICE_QR_CODE, '[^,]+', 1, v_counter);
				SET v_line_invoice_qr_base64 = REGEXP_SUBSTR(P_BASE64_INVOICE_QR_CODE, '[^,]+', 1, v_counter);
				
			END WHILE;
                        
			UPDATE mda_requisition_data SET LOADING_PROGRESS = 'Completed', LOAD_OUT_TIME = TEMP_CURRENT_DATETIME
            WHERE PLANT_ID = P_PLANT_ID AND GATE_SYS_ID = P_ID;
                                    
            UPDATE mda_header MH
            INNER JOIN vw_get_gate_in_mda_id VW ON MH.MDA_SYS_ID = VW.MDA_SYS_ID AND VW.GATE_SYS_ID = P_ID
			SET MH.OUT_TIME = TEMP_CURRENT_DATETIME
			WHERE MH.PLANT_ID = P_PLANT_ID AND MH.OUT_TIME IS NULL;
            
            UPDATE FG_GATE_IN_OUT 
            SET GATE_OUT_DT = TEMP_CURRENT_DATETIME, IS_GOODS_TRANSFER = 1
            WHERE GATE_SYS_ID = P_ID AND COALESCE(CANCEL_GATE_IN, 0) = 0 
            AND GATE_OUT_DT IS NULL AND PLANT_ID = P_PLANT_ID;
            
            UPDATE RFID_MASTER SET STATUS = 'Active' 
            WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM fg_gate_in_out X
								INNER JOIN mda_header Y ON Y.PLANT_ID = X.PLANT_ID AND Y.MDA_SYS_ID = X.MDA_SYS_ID
								WHERE GATE_OUT_DT IS NULL AND OUT_TIME IS NULL AND DATE_FORMAT(X.GATE_IN_DT, '%Y') = '2024'
                                -- UNION 
                                -- SELECT DISTINCT RFSYSID FROM other_gate_in_out X WHERE GATE_OUT_DT IS NULL ORDER BY 1 DESC
                                );
            
            COMMIT;
            
            SELECT GROUP_CONCAT(CONCAT('MDA No. : ', MDA_NO, ', Invoice No. : ', INVOICEQrCODE) SEPARATOR '; ') 
					INTO TEMP_Combined_Info 
            FROM mda_invoice_qr WHERE GATE_SYS_ID = P_ID;
            
            SET P_RESULT := CONCAT(
				'S|Record saved successfully', 
				IF(TEMP_Combined_Info IS NOT NULL AND TEMP_Combined_Info != '', 
				   CONCAT('. ', TEMP_Combined_Info), 
				   ''), 
				'|0'
			);
        ELSE
			  
            SELECT GROUP_CONCAT(CONCAT('MDA No. : ', MDA_NO, ', Invoice No. : ', INVOICEQrCODE) SEPARATOR '; ') 
					INTO TEMP_Combined_Info 
            FROM mda_invoice_qr WHERE GATE_SYS_ID = P_ID;
            
			SET P_RESULT = CONCAT(
				'E|Gate Out Details is already saved. Gate Out Date Time : ', 
				IFNULL(TEMP_GATE_OUT_DT, ''), 
				IF(TEMP_Combined_Info IS NOT NULL, CONCAT('. ', TEMP_Combined_Info), ''), 
				'|0'
			);
            
        END IF;
        
    END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_GATE_OUT_SAVE_OTHER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_GATE_OUT_SAVE_OTHER`(
    IN P_ID INT,
    IN P_COMMON_SYS_ID INT,
    IN P_GATE_OUT_NOTE VARCHAR(255),
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
    DECLARE TEMP_INWARD_SYS_ID INT DEFAULT 4;
    
    DECLARE TEMP_GATE_OUT_DT VARCHAR(255) DEFAULT NULL;
    DECLARE TEMP_INVOICE_QR_CODE VARCHAR(255) DEFAULT NULL;
      
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
    
            UPDATE RFID_MASTER SET STATUS = 'Active' 
            WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM fg_gate_in_out X
								INNER JOIN mda_header Y ON Y.PLANT_ID = X.PLANT_ID AND Y.MDA_SYS_ID = X.MDA_SYS_ID
								WHERE GATE_OUT_DT IS NULL AND OUT_TIME IS NULL
                                UNION 
                                SELECT DISTINCT RFSYSID FROM other_gate_in_out X WHERE GATE_OUT_DT IS NULL ORDER BY 1 DESC) 
			AND PLANT_ID = P_PLANT_ID;
            
            
        SELECT DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_GATE_OUT_DT 
        FROM other_gate_in_out X 
        WHERE X.GATE_SYS_ID = P_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NULL THEN
			
            SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
            
        ELSE
			
			SET P_RESULT = CONCAT('E|Gate Out Details is already saved. Gate Out Date Time : ', IFNULL(TEMP_GATE_OUT_DT,''), '|0');
            
        END IF;
        
    END;

	SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
		
    IF P_ID > 0 THEN
		
        SELECT DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_GATE_OUT_DT 
        FROM other_gate_in_out X 
        WHERE X.GATE_SYS_ID = P_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NULL THEN
        
            UPDATE other_gate_in_out 
            SET GATE_OUT_DT = CURRENT_TIMESTAMP()
            WHERE GATE_SYS_ID = P_ID AND COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND PLANT_ID = P_PLANT_ID;
            
            UPDATE RFID_MASTER SET STATUS = 'Active' 
            WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM fg_gate_in_out X
								INNER JOIN mda_header Y ON Y.PLANT_ID = X.PLANT_ID AND Y.MDA_SYS_ID = X.MDA_SYS_ID
								WHERE GATE_OUT_DT IS NULL AND OUT_TIME IS NULL 
                                UNION 
                                SELECT DISTINCT RFSYSID FROM other_gate_in_out X WHERE GATE_OUT_DT IS NULL ORDER BY 1 DESC) 
			AND PLANT_ID = P_PLANT_ID;
            
            COMMIT;
            
            SET P_RESULT := 'S|Record saved successfully|0';
        ELSE
			  
			SET P_RESULT = CONCAT('E|Gate Out Details is already saved. Gate Out Date Time : ', IFNULL(TEMP_GATE_OUT_DT,''), '|0');
            
        END IF;
        
    END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_INVOICE_QR_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_INVOICE_QR_SAVE`(
	IN P_GATE_IN_OUT_ID INT,
    IN P_MDA_SYS_ID INT,
    IN P_INVOICE_QR_CODE VARCHAR(255),
    IN P_BASE64_INVOICE_QR_CODE LONGTEXT,
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    OUT P_RESULT VARCHAR(255))
BEGIN

	DECLARE TEMP_STATION_ID INT DEFAULT 7;
	DECLARE TEMP_NUM INT DEFAULT 0;
    DECLARE TEMP_INWARD_SYS_ID INT DEFAULT 1;
    
    DECLARE TEMP_MDA_ID VARCHAR(255);
    DECLARE TEMP_MDA_NO VARCHAR(255);
    DECLARE TEMP_GATE_OUT_DT VARCHAR(255) DEFAULT NULL;
    DECLARE TEMP_INVOICE_QR_CODE VARCHAR(255) DEFAULT NULL;
      
            DECLARE v_CNT BIGINT DEFAULT 0;
            DECLARE v_counter BIGINT DEFAULT 1;
            DECLARE v_line_invoice_no LONGTEXT;
            DECLARE v_line_invoice_qr_base64 LONGTEXT;
            DECLARE v_invoice_no LONGTEXT;
            DECLARE v_invoice_qr_base64 LONGTEXT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
        
            UPDATE RFID_MASTER SET STATUS = 'Active' 
            WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM fg_gate_in_out X
								INNER JOIN mda_header Y ON Y.PLANT_ID = X.PLANT_ID AND Y.MDA_SYS_ID = X.MDA_SYS_ID
								WHERE GATE_OUT_DT IS NULL AND OUT_TIME IS NULL AND DATE_FORMAT(X.GATE_IN_DT, '%Y') = '2024'
                                -- UNION 
                                -- SELECT DISTINCT RFSYSID FROM other_gate_in_out X WHERE GATE_OUT_DT IS NULL ORDER BY 1 DESC
                                ) 
			AND PLANT_ID = P_PLANT_ID;
                        
            SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
                    
    END;

	SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
		
    #IF NVL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT := 'E|You are not authorized to perform this operation.|0';    
    #ELSE
    IF P_GATE_IN_OUT_ID > 0 THEN
		
        SELECT DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_GATE_OUT_DT 
        FROM fg_gate_in_out X 
        WHERE X.GATE_SYS_ID = P_GATE_IN_OUT_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NOT NULL THEN
        
			SET v_counter = 1;
			SET v_line_invoice_no = REGEXP_SUBSTR(P_INVOICE_QR_CODE, '[^,]+', 1, v_counter);
			SET v_line_invoice_qr_base64 = REGEXP_SUBSTR(P_BASE64_INVOICE_QR_CODE, '[^,]+', 1, v_counter);
			
			WHILE v_line_invoice_no IS NOT NULL AND v_line_invoice_qr_base64 IS NOT NULL DO
			
				SET v_CNT = 1;
				SET TEMP_MDA_ID = REGEXP_SUBSTR(v_line_invoice_no, '[^|]+', 1, v_CNT);
				SET v_CNT = v_CNT + 1;
				SET v_invoice_no = REGEXP_SUBSTR(v_line_invoice_no, '[^|]+', 1, v_CNT);
				SET v_invoice_qr_base64 = REGEXP_SUBSTR(v_line_invoice_qr_base64, '[^|]+', 1, v_CNT);
														
				SELECT COUNT(*) INTO TEMP_NUM 
				FROM mda_invoice_qr X 
				WHERE X.GATE_SYS_ID = P_GATE_IN_OUT_ID AND X.MDA_SYS_ID = CAST(TEMP_MDA_ID AS UNSIGNED) 
				AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
				   
				IF IFNULL(TEMP_NUM, 0) = 0 AND TEMP_MDA_ID IS NOT NULL AND v_invoice_no IS NOT NULL AND v_invoice_qr_base64 IS NOT NULL THEN		
							   
					SELECT MDA_NO INTO TEMP_MDA_NO FROM mda_header Z WHERE MDA_SYS_ID = CAST(TEMP_MDA_ID AS UNSIGNED) AND PLANT_ID = P_PLANT_ID LIMIT 1;
					
					SELECT COALESCE(MAX(MDAInvQr_SYS_ID), 0) + 1 INTO TEMP_NUM FROM mda_invoice_qr;
					
					INSERT INTO mda_invoice_qr (MDAInvQr_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, INVOICEQrCODE, BASE64InvQrCode, Created_BY_ID, Created_DateTime, PLANT_ID, IS_POSTED, IS_DISPATCHED)
					VALUES(TEMP_NUM, P_GATE_IN_OUT_ID, CAST(TEMP_MDA_ID AS UNSIGNED),TEMP_MDA_NO,v_invoice_no,v_invoice_qr_base64, P_USER_ID, NOW(), P_PLANT_ID, 0,1);
					
					COMMIT;
					
				END IF;
				                 
				SET v_counter = v_counter + 1;
				SET v_line_invoice_no = REGEXP_SUBSTR(P_INVOICE_QR_CODE, '[^,]+', 1, v_counter);
				SET v_line_invoice_qr_base64 = REGEXP_SUBSTR(P_BASE64_INVOICE_QR_CODE, '[^,]+', 1, v_counter);
				
			END WHILE;
            
            SET P_RESULT := 'S|Record saved successfully|0';
        
        END IF;
        
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_INWARD_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_INWARD_GET`(
IN P_ID INT,
IN P_ISACTIVE VARCHAR(255),
IN P_PLANT_ID INT,
IN P_USER_ID INT,
IN P_ROLE_ID INT,
IN P_MENU_ID INT
)
BEGIN

IF P_ID > 0 THEN
SELECT INWARD_SYS_ID AS ID, INWARD_TYPE, order_by
FROM INWARD_MASTER
WHERE INWARD_SYS_ID = P_ID;
ELSE
SELECT INWARD_SYS_ID AS ID, INWARD_TYPE, order_by
FROM INWARD_MASTER
ORDER BY order_by;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_LOAD_MDA_GET_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_LOAD_MDA_GET_NEW`(IN P_GATE_SYS_ID INT, IN P_MDA_SYS_ID INT, IN P_SEARCHTERM VARCHAR(255), IN P_PLANT_ID INT)
BEGIN

SET @rownum := 0;

IF IFNULL(P_GATE_SYS_ID,0) = 0 AND IFNULL(P_MDA_SYS_ID, 0) = 0 AND IFNULL(P_SEARCHTERM, '') = '' THEN

WITH TBL_RESULT AS (SELECT PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO
	, GROUP_CONCAT(DISTINCT MDA_NO ORDER BY MDA_SYS_ID SEPARATOR ',') AS MDA_NO
	, GROUP_CONCAT(DISTINCT DATE_FORMAT(MDA_DT, '%d/%m/%Y') ORDER BY MDA_SYS_ID SEPARATOR ',') AS MDA_DT
	, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
	, GROUP_CONCAT(DISTINCT PLANT_CD ORDER BY PLANT_CD SEPARATOR ',') AS PLANT_CD 
	, GROUP_CONCAT(DISTINCT TRANS_SYS_ID ORDER BY TRANS_SYS_ID SEPARATOR ',') AS TRANS_SYS_IDS
	, GROUP_CONCAT(DISTINCT PROD_SYS_ID ORDER BY PROD_SYS_ID SEPARATOR ',') AS PROD_SYS_IDS
	, GROUP_CONCAT(DISTINCT WH_CD ORDER BY WH_CD SEPARATOR ',') AS WH_CD 
	, GROUP_CONCAT(DISTINCT PARTY_NAME ORDER BY PARTY_NAME SEPARATOR ',') AS PARTY_NAME 
    , VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID
	FROM (SELECT GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO
		, GIO.GATE_IN_DT, GIO.GATE_OUT_DT, GIO.INWARD_SYS_ID, GIO.DRIVER_ID_TYPE, GIO.DRIVER_ID_NUMBER, IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_NAME_NEW, GIO.DRIVER_NAME) AS DRIVER_NAME,  IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_CONTACT_NEW, GIO.DRIVER_CONTACT) AS DRIVER_CONTACT, GIO.DRIVER_CHANGED
		, GIO.MDA_SYS_IDS AS MDA_SYS_IDS, MH.MDA_SYS_ID, MH.MDA_NO, MH.MDA_DT
		, MH.PLANT_CD, MH.TRANS_SYS_ID, MD.PROD_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
        , GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID
		FROM fg_gate_in_out GIO
		INNER JOIN mda_header MH ON GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0
		LEFT JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
		WHERE MH.PLANT_ID = P_PLANT_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
		AND GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL
		AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = GIO.GATE_SYS_ID AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) = 0 AND XZ.GROSS_WT_DT IS NULL)
		ORDER BY MH.PLANT_ID, GIO.GATE_IN_DT DESC
	) X
	GROUP BY PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY GIO.PLANT_ID, GATE_IN_DT DESC, GIO.GATE_SYS_ID, VEHICLE_NO)) AS SR_NO
, GIO.PLANT_ID, GIO.GATE_SYS_ID, ZZ.WT_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, MDA_NO, NULL MDA_SYS_ID, MDA_DT, NULL DIST
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
    , DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
	, INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = GIO.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE
    , DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = GIO.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
    , DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, GIO.PLANT_CD, TRANS_SYS_IDS, PROD_SYS_IDS, WH_CD, PARTY_NAME
, GROUP_CONCAT(DISTINCT PM.PROD_SYS_ID ORDER BY PM.PROD_SYS_ID SEPARATOR ',') AS PROD_SYS_IDS
, GROUP_CONCAT(DISTINCT PM.PRD_CD ORDER BY PM.PRD_CD SEPARATOR ',') AS PROD_CD
, GROUP_CONCAT(DISTINCT PM.PRD_DESC ORDER BY PM.PRD_DESC SEPARATOR ',') AS PROD_NAME
, GROUP_CONCAT(DISTINCT TM.TRANS_SYS_ID ORDER BY TM.TRANS_SYS_ID SEPARATOR ',') AS TRANS_SYS_IDS
, GROUP_CONCAT(DISTINCT TM.TPTR_CD ORDER BY TM.TPTR_CD SEPARATOR ',') AS tptr_cd
, GROUP_CONCAT(DISTINCT TM.TPTR_NAME ORDER BY TM.TPTR_NAME SEPARATOR ',') AS tptr_name
, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME
, ZZ.TARE_WT WEIGHIN_WT, ZZ.TARE_WT_NOTE WEIGHIN_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT, NULL TRANSACTION_TYPE
FROM TBL_RESULT GIO
INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.PLANT_ID = GIO.PLANT_ID AND ZZ.GATE_SYS_ID = GIO.GATE_SYS_ID
LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = GIO.PLANT_ID AND FIND_IN_SET(TM.TRANS_SYS_ID, GIO.TRANS_SYS_IDS) > 0
LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = GIO.PLANT_ID AND FIND_IN_SET(PM.PROD_SYS_ID, GIO.PROD_SYS_IDS) > 0
GROUP BY GIO.PLANT_ID, GATE_SYS_ID, ZZ.WT_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, MDA_NO, MDA_DT, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
		, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, ZZ.TARE_WT_DT
ORDER BY PLANT_ID, GATE_IN_DT DESC, GATE_SYS_ID, VEHICLE_NO;


ELSEIF IFNULL(P_GATE_SYS_ID,0) > 0 THEN

	WITH TBL_RESULT AS (SELECT X.PLANT_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, VEHICLE_NO, X.MDA_NO, X.MDA_DT
			, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
			, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID, RFSYSID, DIST, DESP_PLACE
			, PROD_SYS_ID, PROD_SNO, BAG_NOS, CAST((BAG_NOS / 24) AS unsigned) Required_Shipper
			, (SELECT COUNT(*) FROM MDA_LOADING ML WHERE ML.MDA_SYS_ID = X.MDA_SYS_ID AND ML.PROD_SYS_ID = X.PROD_SYS_ID) Loaded_Shipper, NULL Qty
			, (SELECT COUNT(*) FROM QR_CODE_REJECTLIST XZ WHERE XZ.PLANT_ID = X.PLANT_ID AND XZ.MDA_SYS_ID = X.MDA_SYS_ID AND XZ.PRODUCT_SYS_ID = X.PROD_SYS_ID) REJECT_SHIPPER
			FROM (
				SELECT Z.PLANT_ID, Z.GATE_SYS_ID, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID
				, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
				, MDA_SYS_IDS, MD.MDA_SYS_ID, Z.MDA_NO, Z.MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, MOBILE_NO, DIST, DESP_PLACE, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID, RFSYSID
				, MD.PROD_SYS_ID, MD.PROD_SNO, MD.BAG_NOS
				FROM (SELECT GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO
					, GIO.GATE_IN_DT, GIO.GATE_OUT_DT, GIO.INWARD_SYS_ID, GIO.DRIVER_ID_TYPE, GIO.DRIVER_ID_NUMBER, IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_NAME_NEW, GIO.DRIVER_NAME) AS DRIVER_NAME,  IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_CONTACT_NEW, GIO.DRIVER_CONTACT) AS DRIVER_CONTACT, GIO.DRIVER_CHANGED
					, GIO.MDA_SYS_IDS AS MDA_SYS_IDS, MH.MDA_SYS_ID, MH.MDA_NO, MH.MDA_DT
					, MH.PLANT_CD, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
					, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, GIO.RFSYSID
					FROM fg_gate_in_out GIO
					INNER JOIN mda_header MH ON GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0
					WHERE MH.PLANT_ID = P_PLANT_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0 AND GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL
					AND GIO.GATE_SYS_ID = IFNULL(P_GATE_SYS_ID,0)
                    AND IF(IFNULL(P_MDA_SYS_ID,0)= 0, TRUE, MH.MDA_SYS_ID = P_MDA_SYS_ID) 
					AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = GIO.GATE_SYS_ID AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) = 0 AND XZ.GROSS_WT_DT IS NULL)
					ORDER BY MH.PLANT_ID, GIO.GATE_IN_DT DESC) Z
					INNER JOIN mda_detail MD ON MD.PLANT_ID = Z.PLANT_ID AND MD.MDA_SYS_ID = Z.MDA_SYS_ID
					-- WHERE MD.PROD_SYS_ID IN (31,35,55,56)
			) X
		)
		SELECT (ROW_NUMBER() OVER (ORDER BY GIO.PLANT_ID, GATE_IN_DT DESC, GIO.GATE_SYS_ID, VEHICLE_NO)) AS SR_NO
        , (ROW_NUMBER() OVER (ORDER BY DIST DESC)) AS MDA_ORDER
		, GIO.PLANT_ID, GIO.GATE_SYS_ID, MDA_SYS_ID, VEHICLE_NO, MDA_NO, NULL MDA_DTL_SYS_ID
			, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
			, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
			, DATE_FORMAT(MDA_DT, '%d/%m/%Y') AS MDA_DT
			, INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = GIO.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE
			, DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = GIO.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
			, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
		, GIO.PLANT_CD, WH_CD, PARTY_NAME
		, PM.PROD_SYS_ID, PROD_SNO, PM.PRD_CD, PM.PRD_DESC, PM.SKU_CODE, PM.SKU_NAME
		, TM.TRANS_SYS_ID, TM.TPTR_CD AS TRANSPORTER_CODE, TM.TPTR_NAME AS TRANSPORTER_NAME, TM.TPTR_CD, TM.TPTR_NAME
		, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME, NULL TRANSACTION_TYPE, PM.SHIP_PER_PALLET
		, RM.RFSYSID, RM.RFIDSRNO, DIST, DESP_PLACE
				, ZZ.TARE_WT WEIGHIN_WT, ZZ.TARE_WT_NOTE WEIGHIN_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT
				, ZZ.GROSS_WT WEIGHOUT_WT, ZZ.GROSS_WT_NOTE WEIGHOUT_WT_NOTE, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHOUT_WT_DT
				, ZZ.NET_WT, ZZ.TOLERANCE_WT, BAG_NOS, Required_Shipper, Loaded_Shipper, REJECT_SHIPPER, NULL Qty, BAG_NOS Nett_Qty, BAG_NOS Gross_Qty
                , CASE WHEN (Required_Shipper <= Loaded_Shipper) THEN 1 ELSE 0 END AS Is_End_Loading
                , NULL STATUS, NULL Skip_LILO_Remarks, 'KG' UOM
		FROM TBL_RESULT GIO
		INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.PLANT_ID = GIO.PLANT_ID AND ZZ.GATE_SYS_ID = GIO.GATE_SYS_ID
		LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = GIO.PLANT_ID AND TM.TRANS_SYS_ID = GIO.TRANS_SYS_ID
		LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = GIO.PLANT_ID AND PM.PROD_SYS_ID = GIO.PROD_SYS_ID
		LEFT JOIN rfid_master RM ON RM.PLANT_ID = GIO.PLANT_ID AND RM.RFSYSID = GIO.RFSYSID 
		ORDER BY PLANT_ID, GATE_IN_DT DESC, GATE_SYS_ID, VEHICLE_NO;
        
ELSE

WITH TBL_MAIN AS (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, MH.MDA_SYS_ID, MH.MDA_NO, X.TRUCK_NO VEHICLE_NO, MH.PLANT_CD
		, GATE_IN_DT, GATE_OUT_DT, MH.MDA_DT, MH.OUT_TIME, X.CANCEL_GATE_IN
		, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
		, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DIST,MH.desp_place, X.RFSYSID
		, (ROW_NUMBER() OVER (PARTITION BY X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID ORDER BY MH.DIST DESC)) AS MDA_ORDER
		FROM (SELECT TRIM(SUBSTRING_INDEX(input_string, ',', 1)) AS PLANT_ID,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 2), ',', -1)) AS GATE_SYS_ID,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 3), ',', -1)) AS MDA_SYS_ID,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 4), ',', -1)) AS MDA_NO,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 5), ',', -1)) AS VEHICLE_NO,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 6), ',', -1)) AS MDA_DT,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 7), ',', -1)) AS OUT_TIME
								FROM (SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, '#', n.digit+1), '#', -1)) AS input_string
								FROM (SELECT FN_GATE_IN_OUT_MDA_GET(P_PLANT_ID, P_GATE_SYS_ID, P_MDA_SYS_ID, P_SEARCHTERM) AS input_string) AS data
								CROSS JOIN (SELECT 0 AS digit UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) AS n 
								WHERE n.digit < LENGTH(input_string) - LENGTH(REPLACE(input_string, '#', '')) + 1) X) XZ
        INNER JOIN fg_gate_in_out X ON X.PLANT_ID = XZ.PLANT_ID AND X.GATE_SYS_ID = XZ.GATE_SYS_ID
		INNER JOIN mda_header MH ON MH.PLANT_ID = X.PLANT_ID AND MH.MDA_SYS_ID = XZ.MDA_SYS_ID
)
SELECT (@rownum := @rownum + 1) SR_NO, X.*, CASE WHEN (X.Required_Shipper <= X.Loaded_Shipper) THEN 1 ELSE 0 END AS Is_End_Loading FROM (
	SELECT M_G.PLANT_ID, M_G.STATION_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, MD.MDA_DTL_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO, M_G.PLANT_CD
	, DATE_FORMAT(M_G.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(M_G.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
	, MD.BAG_NOS, MD.NETT_QTY, MD.GROSS_QTY, (MD.BAG_NOS / 24) Required_Shipper
    , (SELECT COUNT(*) FROM MDA_LOADING Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND Z.GATE_SYS_ID = M_G.GATE_SYS_ID AND Z.MDA_SYS_ID = M_G.MDA_SYS_ID) Loaded_Shipper
	, (SELECT COUNT(*) FROM QR_CODE_REJECTLIST XZ WHERE XZ.PLANT_ID = M_G.PLANT_ID AND XZ.MDA_SYS_ID = M_G.MDA_SYS_ID AND XZ.PRODUCT_SYS_ID = MD.PROD_SYS_ID) REJECT_SHIPPER
	, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT
	, MD.PROD_SYS_ID, MD.PROD_SNO, PM.SKU_CODE, PM.SKU_NAME, PM.PRD_CD, PM.PRD_DESC, PM.SHIP_PER_PALLET
	, M_G.DRIVER_ID_NUMBER, IFNULL(M_G.DRIVER_NAME, M_G.DRIVER_NAME_NEW)DRIVER_NAME, IFNULL(M_G.DRIVER_CONTACT, M_G.DRIVER_CONTACT_NEW)DRIVER_CONTACT, DRIVER_CHANGED, TRUCK_VALIDATION
	, M_G.TRANS_SYS_ID, TM.tptr_cd, TM.TPTR_NAME, M_G.WH_CD, M_G.PARTY_NAME, M_G.DIST, M_G.desp_place, M_G.RFSYSID, RM.RFIDSRNO
    , M_G.MDA_ORDER
	FROM TBL_MAIN M_G
	INNER JOIN mda_detail MD ON MD.PLANT_ID = M_G.PLANT_ID AND MD.MDA_SYS_ID = M_G.MDA_SYS_ID
	INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = M_G.GATE_SYS_ID AND ZZ.STATION_ID = M_G.STATION_ID AND ZZ.PLANT_ID = M_G.PLANT_ID
	INNER JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = M_G.PLANT_ID AND TM.TRANS_SYS_ID = M_G.TRANS_SYS_ID
	LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = M_G.PLANT_ID AND PM.PROD_SYS_ID = MD.PROD_SYS_ID
	LEFT JOIN rfid_master RM ON RM.PLANT_ID = M_G.PLANT_ID AND RM.RFSYSID = M_G.RFSYSID 
	WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL AND IFNULL(M_G.OUT_TIME, '') = ''
    AND IF(IFNULL(P_MDA_SYS_ID, 0) = 0, TRUE, M_G.MDA_SYS_ID = P_MDA_SYS_ID) 
    AND MD.PROD_SYS_ID IN (31,35,55,56) AND IFNULL(M_G.CANCEL_GATE_IN, 0) = 0
    ORDER BY M_G.GATE_IN_DT,  M_G.GATE_OUT_DT,  M_G.MDA_DT,  M_G.DIST 
) X;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_LOAD_MDA_GET_NEW_OLD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_LOAD_MDA_GET_NEW_OLD`(IN P_GATE_SYS_ID INT, IN P_MDA_SYS_ID INT, IN P_SEARCHTERM VARCHAR(255), IN P_PLANT_ID INT)
BEGIN

SET @rownum := 0;

IF IFNULL(P_GATE_SYS_ID,0) = 0 AND IFNULL(P_MDA_SYS_ID, 0) = 0 AND IFNULL(P_SEARCHTERM, '') = '' THEN

WITH TBL_MAIN AS (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, MH.MDA_SYS_ID, MH.MDA_NO, X.TRUCK_NO VEHICLE_NO, MH.PLANT_CD
		, GATE_IN_DT, GATE_OUT_DT, MH.MDA_DT, CANCEL_GATE_IN
		, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
		, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DIST,MH.desp_place, X.RFSYSID
		FROM fg_gate_in_out X
		INNER JOIN mda_header MH ON MH.PLANT_ID = X.PLANT_ID AND MH.MDA_SYS_ID = X.MDA_SYS_ID
		WHERE X.PLANT_ID = P_PLANT_ID AND GATE_OUT_DT IS NULL AND OUT_TIME IS NULL
        ORDER BY 3 DESC, 4 DESC
)
SELECT (@rownum := @rownum + 1) SR_NO, X.*, CASE WHEN (X.Required_Shipper <= X.Loaded_Shipper) THEN 1 ELSE 0 END AS Is_End_Loading FROM (
	SELECT M_G.PLANT_ID, M_G.STATION_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, MD.MDA_DTL_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO, M_G.PLANT_CD
	, DATE_FORMAT(M_G.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(M_G.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT, DATE_FORMAT(M_G.MDA_DT, '%d/%m/%Y') AS Mda_Dt_Str
	, MD.BAG_NOS, MD.NETT_QTY, MD.GROSS_QTY, (MD.BAG_NOS / 24) Required_Shipper
    , (SELECT COUNT(*) FROM MDA_LOADING Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND Z.GATE_SYS_ID = M_G.GATE_SYS_ID AND Z.MDA_SYS_ID = M_G.MDA_SYS_ID) Loaded_Shipper
	, (SELECT COUNT(*) FROM QR_CODE_REJECTLIST XZ WHERE XZ.PLANT_ID = M_G.PLANT_ID AND XZ.MDA_SYS_ID = M_G.MDA_SYS_ID AND XZ.PRODUCT_SYS_ID = MD.PROD_SYS_ID) REJECT_SHIPPER
	, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT
	, MD.PROD_SYS_ID, MD.PROD_SNO, PM.SKU_CODE, PM.SKU_NAME, PM.PRD_CD, PM.PRD_DESC, PM.SHIP_PER_PALLET
	, M_G.DRIVER_ID_NUMBER, IFNULL(M_G.DRIVER_NAME, M_G.DRIVER_NAME_NEW)DRIVER_NAME, IFNULL(M_G.DRIVER_CONTACT, M_G.DRIVER_CONTACT_NEW)DRIVER_CONTACT, DRIVER_CHANGED, TRUCK_VALIDATION
	, M_G.TRANS_SYS_ID, TM.tptr_cd, TM.TPTR_NAME, M_G.WH_CD, M_G.PARTY_NAME, M_G.DIST, M_G.desp_place, M_G.RFSYSID, RM.RFIDSRNO
    , (ROW_NUMBER() OVER (PARTITION BY M_G.PLANT_ID, M_G.STATION_ID, M_G.GATE_SYS_ID ORDER BY M_G.DIST DESC)) AS MDA_ORDER
	FROM TBL_MAIN M_G
	INNER JOIN mda_detail MD ON MD.PLANT_ID = M_G.PLANT_ID AND MD.MDA_SYS_ID = M_G.MDA_SYS_ID
	INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = M_G.GATE_SYS_ID AND ZZ.STATION_ID = M_G.STATION_ID AND ZZ.PLANT_ID = M_G.PLANT_ID
	INNER JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = M_G.PLANT_ID AND TM.TRANS_SYS_ID = M_G.TRANS_SYS_ID
	LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = M_G.PLANT_ID AND PM.PROD_SYS_ID = MD.PROD_SYS_ID
	LEFT JOIN rfid_master RM ON RM.PLANT_ID = M_G.PLANT_ID AND RM.RFSYSID = M_G.RFSYSID 
	WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL 
    AND MD.PROD_SYS_ID IN (31,35,55,56) AND IFNULL(M_G.CANCEL_GATE_IN, 0) = 0
	ORDER BY M_G.GATE_IN_DT  DESC, M_G.GATE_OUT_DT  DESC, M_G.MDA_DT  DESC, M_G.DIST ASC
) X;

ELSE

WITH TBL_MAIN AS (SELECT GIO.PLANT_ID, GIO.STATION_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO
	, GIO.GATE_IN_DT, GIO.GATE_OUT_DT, MH.MDA_DT, MH.OUT_TIME, GIO.CANCEL_GATE_IN, GIO.INWARD_SYS_ID, GIO.DRIVER_ID_TYPE, GIO.DRIVER_ID_NUMBER
	, IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_NAME_NEW, GIO.DRIVER_NAME) AS DRIVER_NAME,  IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_CONTACT_NEW, GIO.DRIVER_CONTACT) AS DRIVER_CONTACT, GIO.DRIVER_CHANGED
	, GIO.DRIVER_NAME_NEW, GIO.DRIVER_CONTACT_NEW, GIO.TRUCK_VALIDATION
	, GIO.MDA_SYS_IDS AS MDA_SYS_IDS, MH.MDA_SYS_ID, MH.MDA_NO
	, MH.PLANT_CD, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
	, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, GIO.RFSYSID
	, (ROW_NUMBER() OVER (PARTITION BY GIO.PLANT_ID, GIO.STATION_ID, GIO.GATE_SYS_ID ORDER BY MH.DIST DESC)) AS MDA_ORDER
					FROM fg_gate_in_out GIO
					INNER JOIN mda_header MH ON GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0
					WHERE COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
					-- AND GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL
					AND IF(IFNULL(P_GATE_SYS_ID,0)= 0, GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL, GIO.GATE_SYS_ID = P_GATE_SYS_ID) 
					AND IF(IFNULL(P_SEARCHTERM,'') = '', TRUE, 
								(GIO.TRUCK_NO = P_SEARCHTERM
								OR 0 < (SELECT COUNT(*) FROM mda_header MHZ WHERE GIO.PLANT_ID = MHZ.PLANT_ID AND MHZ.MDA_NO = P_SEARCHTERM AND FIND_IN_SET(MHZ.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0 AND MHZ.OUT_TIME IS NULL)
								OR GIO.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,'')))
								)
						)
					AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = GIO.GATE_SYS_ID 
								AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) = 0 AND XZ.GROSS_WT_DT IS NULL)
					ORDER BY MH.PLANT_ID, GIO.GATE_IN_DT DESC
)
SELECT (@rownum := @rownum + 1) SR_NO, X.*, CASE WHEN (X.Required_Shipper <= X.Loaded_Shipper) THEN 1 ELSE 0 END AS Is_End_Loading FROM (
	SELECT M_G.PLANT_ID, M_G.STATION_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, MD.MDA_DTL_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO, M_G.PLANT_CD
	, DATE_FORMAT(M_G.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(M_G.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT, DATE_FORMAT(M_G.MDA_DT, '%d/%m/%Y') AS Mda_Dt_Str
	, MD.BAG_NOS, MD.NETT_QTY, MD.GROSS_QTY, (MD.BAG_NOS / 24) Required_Shipper
    , (SELECT COUNT(*) FROM MDA_LOADING Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND Z.GATE_SYS_ID = M_G.GATE_SYS_ID AND Z.MDA_SYS_ID = M_G.MDA_SYS_ID) Loaded_Shipper
	, (SELECT COUNT(*) FROM QR_CODE_REJECTLIST XZ WHERE XZ.PLANT_ID = M_G.PLANT_ID AND XZ.MDA_SYS_ID = M_G.MDA_SYS_ID AND XZ.PRODUCT_SYS_ID = MD.PROD_SYS_ID) REJECT_SHIPPER
	, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT
	, MD.PROD_SYS_ID, MD.PROD_SNO, PM.SKU_CODE, PM.SKU_NAME, PM.PRD_CD, PM.PRD_DESC, PM.SHIP_PER_PALLET
	, M_G.DRIVER_ID_NUMBER, IFNULL(M_G.DRIVER_NAME, M_G.DRIVER_NAME_NEW)DRIVER_NAME, IFNULL(M_G.DRIVER_CONTACT, M_G.DRIVER_CONTACT_NEW)DRIVER_CONTACT, DRIVER_CHANGED, TRUCK_VALIDATION
	, M_G.TRANS_SYS_ID, TM.tptr_cd, TM.TPTR_NAME, M_G.WH_CD, M_G.PARTY_NAME, M_G.DIST, M_G.desp_place, M_G.RFSYSID, RM.RFIDSRNO
    , M_G.MDA_ORDER
	FROM TBL_MAIN M_G
	INNER JOIN mda_detail MD ON MD.PLANT_ID = M_G.PLANT_ID AND MD.MDA_SYS_ID = M_G.MDA_SYS_ID
	INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = M_G.GATE_SYS_ID AND ZZ.STATION_ID = M_G.STATION_ID AND ZZ.PLANT_ID = M_G.PLANT_ID
	INNER JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = M_G.PLANT_ID AND TM.TRANS_SYS_ID = M_G.TRANS_SYS_ID
	LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = M_G.PLANT_ID AND PM.PROD_SYS_ID = MD.PROD_SYS_ID
	LEFT JOIN rfid_master RM ON RM.PLANT_ID = M_G.PLANT_ID AND RM.RFSYSID = M_G.RFSYSID 
	WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL AND IFNULL(M_G.OUT_TIME, '') = ''
    AND IF(IFNULL(P_MDA_SYS_ID, 0) = 0, TRUE, M_G.MDA_SYS_ID = P_MDA_SYS_ID)
    AND MD.PROD_SYS_ID IN (31,35,55,56) AND IFNULL(M_G.CANCEL_GATE_IN, 0) = 0
    ORDER BY M_G.GATE_IN_DT,  M_G.GATE_OUT_DT,  M_G.MDA_DT,  M_G.DIST 
) X;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_LOGIN_AUTH` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_LOGIN_AUTH`(
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
            WHERE 1 = (CASE WHEN LENGTH(TRIM(IFNULL(P_USERNAME, ''))) > 0 AND UPPER(TRIM(IFNULL(X.USER_NAME, ''))) =  UPPER(TRIM(IFNULL(P_USERNAME, ''))) THEN 1 ELSE 0 END)
			ORDER BY ID DESC LIMIT 1;
    END IF;    
    
    IF LENGTH(TRIM(IFNULL(P_USERNAME, ''))) > 0 && LENGTH(TRIM(IFNULL(P_PASSWORD, ''))) > 0 && TRIM(IFNULL(P_PASSWORD, '')) != TRIM(IFNULL(TEMP_USER_PASSWORD, '')) THEN
        SET P_RESULT := 'Wrong Password';
    ELSEIF LENGTH(TRIM(IFNULL(P_USERNAME, ''))) > 0 && LENGTH(TRIM(IFNULL(P_PASSWORD, ''))) > 0 && TRIM(IFNULL(P_PASSWORD, '')) = TRIM(IFNULL(TEMP_USER_PASSWORD, '')) && TEMP_IS_ACTIVE = 0 THEN
        SET P_RESULT := 'Opps!... Your account was De-Active. Please contact the system administrator';
    END IF;

    SELECT COUNT(*) INTO TEMP_NUM FROM USER_ROLE_NEW Z WHERE USER_ID IN (SELECT X.ID FROM USER_MASTER_NEW X 
                                                            WHERE 1 = (CASE WHEN COALESCE(P_USER_ID, 0) = 0 AND UPPER(TRIM(IFNULL(X.USER_NAME, ''))) = UPPER(TRIM(IFNULL(P_USERNAME, ''))) /*AND X.USER_PASSWORD = P_PASSWORD*/ THEN 1 WHEN COALESCE(P_USER_ID, 0) > 0 AND X.ID = COALESCE(P_USER_ID, 0) THEN 1 ELSE 0 END)) 
                                AND Z.IS_DEFAULT = 'Y';

    IF COALESCE(TEMP_NUM, 0) > 0 AND COALESCE(P_PLANT_ID, 0) <= 0 THEN
            SELECT PLANT_ID INTO DEFAULT_PLANT FROM USER_ROLE_NEW Z WHERE USER_ID IN (SELECT X.ID FROM USER_MASTER_NEW X 
                                                    WHERE 1 = (CASE WHEN COALESCE(P_USER_ID, 0) = 0 AND  UPPER(TRIM(IFNULL(X.USER_NAME, ''))) =  UPPER(TRIM(IFNULL(P_USERNAME, ''))) /*AND X.USER_PASSWORD = P_PASSWORD*/ THEN 1 WHEN COALESCE(P_USER_ID, 0) > 0 AND X.ID = COALESCE(P_USER_ID, 0) THEN 1 ELSE 0 END)) 
                        AND Z.IS_DEFAULT = 'Y';
    ELSE
        SET DEFAULT_PLANT = P_PLANT_ID;
    END IF;    
    
    IF COALESCE(DEFAULT_PLANT, 0) <= 0 THEN
            SELECT MIN(Z.PLANT_ID) INTO DEFAULT_PLANT FROM USER_ROLE_NEW Z WHERE USER_ID IN (SELECT X.ID FROM USER_MASTER_NEW X 
                                                    WHERE 1 = (CASE WHEN COALESCE(P_USER_ID, 0) = 0 AND  UPPER(TRIM(IFNULL(X.USER_NAME, ''))) =  UPPER(TRIM(IFNULL(P_USERNAME, ''))) /*AND X.USER_PASSWORD = P_PASSWORD*/ THEN 1 WHEN COALESCE(P_USER_ID, 0) > 0 AND X.ID = COALESCE(P_USER_ID, 0) THEN 1 ELSE 0 END)) ;
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
	WHEN COALESCE(P_USER_ID, 0) = 0 AND  UPPER(TRIM(IFNULL(X.USER_NAME, ''))) =  UPPER(TRIM(IFNULL(P_USERNAME, ''))) /*AND X.USER_PASSWORD = P_PASSWORD*/ THEN 1 
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
    
    SELECT USER_ID, ROLE_ID, MENU_ID, PARENT_ID, AREA, CONTROLLER, DISPLAY_NAME, URL, DISPLAYORDER, ISADMIN, ISACTIVE 
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
					WHEN COALESCE(P_USER_ID, 0) = 0 AND  UPPER(TRIM(IFNULL(X.USER_NAME, ''))) =  UPPER(TRIM(IFNULL(P_USERNAME, ''))) /*AND X.USER_PASSWORD = P_PASSWORD*/ THEN 1 
					WHEN COALESCE(P_USER_ID, 0) > 0 AND X.ID = COALESCE(P_USER_ID, 0) THEN 1 
					ELSE 0 
				  END
		AND X.IS_ACTIVE = 'Y' AND Z.IS_ACTIVE = 'Y' AND ZY.IS_ACTIVE = 'Y' #AND ZZ.IS_ACTIVE = 'Y'
		AND Y.PLANT_ID = CASE
                            WHEN COALESCE( P_ROLE_ID, 0) = 1 THEN Y.PLANT_ID 
                            WHEN COALESCE( P_PLANT_ID, 0) > 0 THEN P_PLANT_ID
                            ELSE COALESCE( DEFAULT_PLANT, 0) 
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
	GROUP BY USER_ID, ROLE_ID, MENU_ID, PARENT_ID, AREA, CONTROLLER, DISPLAY_NAME, URL, DISPLAYORDER, ISADMIN, ISACTIVE
	ORDER BY PARENT_ID, DISPLAYORDER, MENU_ID;

    
	
	SELECT Y.PLANT_ID, ZZ.ROLE_ID, ZX.Plant_Name 
	FROM USER_MASTER_NEW X
	LEFT JOIN USER_ROLE_NEW Y ON X.ID = Y.USER_ID
	LEFT JOIN ROLE_MASTER_NEW ZZ ON Y.ROLE_ID = ZZ.ROLE_ID
    LEFT JOIN PLANT_MASTER ZX ON (1 = CASE WHEN Y.ROLE_ID = 1 THEN 1 WHEN Y.PLANT_ID = ZX.PLANTID THEN 1 ELSE 0 END)
	WHERE 1 = CASE
				WHEN COALESCE(P_USER_ID, 0) = 0 AND  UPPER(TRIM(IFNULL(X.USER_NAME, ''))) =  UPPER(TRIM(IFNULL(P_USERNAME, ''))) /*AND X.USER_PASSWORD = P_PASSWORD*/ THEN 1 
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_LOG_INSERT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_LOG_INSERT`(IN P_MESSAGE LONGTEXT)
BEGIN
	INSERT INTO log_service (MESSAGE) VALUES(P_MESSAGE);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_LOV_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_LOV_GET`(
IN P_LOV_COLUMN VARCHAR(255),
IN P_ISACTIVE VARCHAR(1),
IN P_PLANT_ID INT,
IN P_USER_ID INT,
IN P_ROLE_ID INT,
IN P_MENU_ID INT
)
BEGIN
IF TRIM(P_LOV_COLUMN) <> '' THEN
SELECT LOV_COLUMN, LOV_CODE, LOV_DESC, DISPLAY_SEQ_NO, IF(X.ISACTIVE = 'Y', 1, 0) AS ISACTIVE FROM LOV_MASTER X WHERE UPPER(LOV_COLUMN) = UPPER(P_LOV_COLUMN) AND X.ISACTIVE = IFNULL(P_ISACTIVE, X.ISACTIVE);
ELSE
SELECT LOV_COLUMN, LOV_CODE, LOV_DESC, DISPLAY_SEQ_NO, IF(X.ISACTIVE = 'Y', 1, 0) AS ISACTIVE FROM LOV_MASTER X WHERE X.ISACTIVE = IFNULL(P_ISACTIVE, X.ISACTIVE);
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_MDAWISEREJECTREPORT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MDAWISEREJECTREPORT`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_MDA_ADD_QTY_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MDA_ADD_QTY_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_MDA_BATCH_NO_LIST_REPORT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MDA_BATCH_NO_LIST_REPORT`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_MDA_CHECK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MDA_CHECK`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_MDA_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MDA_GET`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_MDA_REQUISITION_DATA_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MDA_REQUISITION_DATA_SAVE`(
    IN P_GATE_SYS_ID INT,
    IN P_MDA_SYS_ID INT,
    IN P_MDA_DTL_SYS_ID INT,
    IN P_PROD_SYS_ID INT,
    IN P_REASON  VARCHAR(2550),
    IN P_LOADING_PROGRESS  VARCHAR(2550),
    IN P_LOADING_BAY  VARCHAR(25),
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
        /*FROM (SELECT TRIM(SUBSTRING_INDEX(input_string, ',', 1)) AS PLANT_ID,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 2), ',', -1)) AS GATE_SYS_ID,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 3), ',', -1)) AS MDA_SYS_ID,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 4), ',', -1)) AS MDA_NO,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 5), ',', -1)) AS VEHICLE_NO,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 6), ',', -1)) AS MDA_DT,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 7), ',', -1)) AS OUT_TIME
								FROM (SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, '#', n.digit+1), '#', -1)) AS input_string
								FROM (SELECT FN_GATE_IN_OUT_MDA_GET(P_PLANT_ID, P_GATE_SYS_ID, P_MDA_SYS_ID, '') AS input_string) AS data
								CROSS JOIN (SELECT 0 AS digit UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) AS n 
								WHERE n.digit < LENGTH(input_string) - LENGTH(REPLACE(input_string, '#', '')) + 1) X) XZ
        INNER JOIN */ FROM fg_gate_in_out X -- ON X.PLANT_ID = XZ.PLANT_ID AND X.GATE_SYS_ID = XZ.GATE_SYS_ID
		INNER JOIN mda_header MH ON MH.PLANT_ID = X.PLANT_ID and find_in_set(MH.MDA_SYS_ID, X.MDA_SYS_IDS) > 0 -- AND MH.MDA_SYS_ID = XZ.MDA_SYS_ID
		LEFT JOIN MDA_DETAIL Y ON Y.PLANT_ID = MH.PLANT_ID AND Y.MDA_SYS_ID = MH.MDA_SYS_ID
		LEFT JOIN PRODUCT_MASTER P ON P.PLANT_ID = MH.PLANT_ID AND P.PROD_SYS_ID = Y.PROD_SYS_ID
        WHERE X.PLANT_ID = P_PLANT_ID AND MH.MDA_SYS_ID = P_MDA_SYS_ID AND X.GATE_SYS_ID = P_GATE_SYS_ID AND Y.PROD_SYS_ID = P_PROD_SYS_ID 
        AND IFNULL(MH.OUT_TIME, '') = '' AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL LIMIT 1;
		
		IF IFNULL(TEMP_CNT,0) > 0 THEN
			
            SELECT COUNT(*) INTO TEMP_CNT
			FROM mda_requisition_data Q
			WHERE Q.PLANT_ID = P_PLANT_ID AND Q.MDA_SYS_ID = P_MDA_SYS_ID AND Q.GATE_SYS_ID = P_GATE_SYS_ID AND Q.PROD_SYS_ID = P_PROD_SYS_ID;

			IF IFNULL(TEMP_CNT,0) = 0 THEN
						
				IF LENGTH(IFNULL(P_LOADING_PROGRESS,'')) = 0  THEN
						SET P_LOADING_PROGRESS = 'In Progress';
				END IF;
				
				INSERT INTO mda_requisition_data (PLANT_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, LOADING_STATUS, LOADING_PROGRESS, LOAD_IN_TIME, REASON
							, MDA_NO, TRUCK_NO, MDA_DATE, SKU_CODE, SKU_NAME, BOTTLE_QTY, CARTON_QTY, LOADED_QTY, LOADING_BAY)
                SELECT DISTINCT X.PLANT_ID, X.GATE_SYS_ID, MH.MDA_SYS_ID, Y.PROD_SYS_ID, 'New Dispatch', P_LOADING_PROGRESS, NOW(), P_REASON
							, MH.MDA_NO, X.TRUCK_NO, MH.MDA_DT, P.SKU_CODE, P.SKU_NAME, Y.BAG_NOS, CAST((Y.BAG_NOS / 24) AS UNSIGNED), 0, P_LOADING_BAY
				FROM fg_gate_in_out X 
				INNER JOIN mda_header MH ON MH.PLANT_ID = X.PLANT_ID and find_in_set(MH.MDA_SYS_ID, X.MDA_SYS_IDS) > 0 
				LEFT JOIN MDA_DETAIL Y ON Y.PLANT_ID = MH.PLANT_ID AND Y.MDA_SYS_ID = MH.MDA_SYS_ID
				LEFT JOIN PRODUCT_MASTER P ON P.PLANT_ID = MH.PLANT_ID AND P.PROD_SYS_ID = Y.PROD_SYS_ID
				WHERE X.PLANT_ID = P_PLANT_ID AND MH.MDA_SYS_ID = P_MDA_SYS_ID AND X.GATE_SYS_ID = P_GATE_SYS_ID AND Y.PROD_SYS_ID = P_PROD_SYS_ID 
				AND IFNULL(MH.OUT_TIME, '') = '' AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL LIMIT 1;
				
				SET P_RESULT = 'S|Record saved successfully|';
			ELSE
						
				IF LENGTH(IFNULL(P_LOADING_PROGRESS,'')) > 0 THEN
                
						UPDATE mda_requisition_data SET LOADING_PROGRESS = P_LOADING_PROGRESS, LOAD_OUT_TIME = NOW()
                        WHERE PLANT_ID = P_PLANT_ID AND MDA_SYS_ID = P_MDA_SYS_ID AND GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;
                        
				SET P_RESULT = 'S|Record saved successfully|';
				ELSE
					SET P_RESULT = 'S|Requisition data already inserted.|0';
				END IF;
		
				
			END IF;
		ELSE
			-- SET P_RESULT = 'E|Opps!... Something went wrong|0';
            SET P_RESULT = 'S|Record saved successfully|';
		END IF;
	END IF;

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_MDA_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MDA_SAVE`(
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
                        
							#SELECT IFNULL(MAX(TRANS_SYS_ID), 0) + 1 INTO TEMP_NUM FROM transporter_master;
							
                            INSERT INTO transporter_master (tptr_cd, tptr_name, IS_ENTRY_MANUAL, PLANT_ID, Created_DateTime, IS_POSTED)
                            VALUES(v_TPTR_CD, v_TPTR_NAME, 0, v_PLANT_ID, NOW(), 1);
                        
							COMMIT;
                            
                            SELECT TRANS_SYS_ID INTO v_TRANS_SYS_ID FROM transporter_master x WHERE x.tptr_cd = v_TPTR_CD AND x.PLANT_ID = v_PLANT_ID LIMIT 1;
                        
							#SET v_TRANS_SYS_ID = TEMP_NUM;
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
							
                            UPDATE mda_header 
                            SET BAG_NOS = CAST(v_BAG_NOS AS UNSIGNED), NETT_QTY = CAST(v_NETT_QTY AS UNSIGNED), GROSS_QTY = CAST(v_GROSS_QTY AS UNSIGNED)
                            , TRANS_SYS_ID = v_TRANS_SYS_ID, WH_CD = v_WH_CD, PARTY_NAME = v_PARTY_NAME, DRIVER = v_DRIVER, MOBILE_NO = v_MOBILE_NO
                            , desp_place = v_DESP_PLACE, DIST = CAST(v_DIST AS UNSIGNED), desp_place = v_DESP_PLACE
                            WHERE MDA_SYS_ID = P_ID;								
                            	   												
							UPDATE FG_GATE_IN_OUT SET DRIVER_NAME = v_DRIVER, DRIVER_CONTACT = v_MOBILE_NO, 
							DRIVER_NAME_NEW = v_DRIVER, DRIVER_CONTACT_NEW = v_MOBILE_NO
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
									SELECT PROD_SYS_ID INTO v_PROD_SYS_ID FROM product_master x WHERE x.PRD_CD = v_PRD_CD AND x.SKU_CODE = v_SKU_CODE AND PLANT_ID = P_PLANT_ID LIMIT 1;
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_MDA_STATUS_REPORT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MDA_STATUS_REPORT`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_MDA_WISE_DISPATCH_SUMMARY_REPORT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MDA_WISE_DISPATCH_SUMMARY_REPORT`(
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
			FROM SHIPPER_QRCODE_API  where Plant_id = P_PLANT_ID  and SHIPPER_QRCODE_API_SYSID in (
			select SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE where shipper_qrcode in 
		(select shipper_qr_code FROM MDA_LOADING where MDA_SYS_ID IN (select MDA_SYS_ID FROM MDA_HEADER where MDA_NO = mdahdr.MDA_NO )))) BATCH_NO, 
        (select GROUP_CONCAT(DATE_Format(MFG_DATE,'%d/%m/%Y'),'' ORDER BY DATE_Format(MFG_DATE,'%d/%m/%Y') SEPARATOR ',') MFGDT 
FROM SHIPPER_QRCODE_API  where Plant_id = P_PLANT_ID and SHIPPER_QRCODE_API_SYSID in (
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_MENU_COMBOFORROLE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MENU_COMBOFORROLE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_MENU_COMBOFORROLE_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MENU_COMBOFORROLE_NEW`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_MENU_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MENU_GET`(
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
            WHERE X.ID = P_ID AND X.IS_ACTIVE = IF(IFNULL(P_ISACTIVE, '') = '', X.IS_ACTIVE, P_ISACTIVE) AND UPPER(COALESCE(CONTROLLER, 'Z')) != 'MENU';
        ELSE
            #OPEN P_RESULT FOR
            SELECT ROW_NUMBER() OVER (ORDER BY PARENT_ID, ID, DISPLAYORDER) AS SR_NO, ID, PARENT_ID,
                (SELECT Z.DISPLAY_NAME FROM MENU_MASTER_NEW Z WHERE Z.ID = X.PARENT_ID LIMIT 1) AS PARENT_MENU_NAME,
                AREA, CONTROLLER, DISPLAY_NAME AS NAME, URL, DISPLAYORDER,
                CASE WHEN X.ISADMIN = 'Y' THEN 1 ELSE 0 END AS ISADMIN,
                CASE WHEN X.IS_ACTIVE = 'Y' THEN 1 ELSE 0 END AS ISACTIVE
            FROM MENU_MASTER_NEW X
            WHERE X.IS_ACTIVE = IF(IFNULL(P_ISACTIVE, '') = '', X.IS_ACTIVE, P_ISACTIVE) AND UPPER(COALESCE(CONTROLLER, 'Z')) != 'MENU';
        END IF;
    #END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_MENU_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MENU_SAVE`(
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
	DECLARE TEMP_NUM BIGINT;
    DECLARE TEMP_DISPLAYORDER INT;
             
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;


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
        SET P_RESULT := 'E|Role details is already exist.|0';    
    ELSEIF P_ID > 0 THEN
    
        UPDATE MENU_MASTER_NEW SET PARENT_ID = P_PARENT_ID, AREA = P_AREA, CONTROLLER = P_CONTROLLER, DISPLAY_NAME = P_NAME, URL = P_URL, DISPLAYORDER = TEMP_DISPLAYORDER, ISADMIN = P_ISADMIN, IS_ACTIVE = P_ISACTIVE
        WHERE ID = P_ID;
        
        SET P_RESULT := 'S|Record updated successfully|';
    ELSE
        SELECT COALESCE(MAX(ID), 0) + 1 INTO TEMP_NUM FROM MENU_MASTER_NEW;
        
        INSERT INTO MENU_MASTER_NEW (ID, PARENT_ID, AREA, CONTROLLER, DISPLAY_NAME, URL, DISPLAYORDER, ISADMIN, IS_ACTIVE, CREATED_BY, CREATED_DATETIME)
        VALUES(TEMP_NUM, P_PARENT_ID, P_AREA, P_CONTROLLER, P_NAME, P_URL, TEMP_DISPLAYORDER, P_ISADMIN, P_ISACTIVE, P_USER_ID, NOW());
        
        INSERT INTO ROLE_MENU_NEW (ROLE_ID, MENU_ID)
        VALUES(P_ROLE_ID, TEMP_NUM);
    
        SET P_RESULT := 'S|Record saved successfully|';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_MENU_SAVE_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_MENU_SAVE_NEW`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_NEW_TRUCK_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_NEW_TRUCK_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_OLD_TRUCK_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_OLD_TRUCK_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_OTHER_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_OTHER_SAVE`(
    IN P_ID INT,
    IN P_ORDER_NO VARCHAR(255),
    IN P_ORDER_DATE VARCHAR(255),
    IN P_TRANSPORTER VARCHAR(255),
    IN P_TRUCK_NO VARCHAR(255),
    IN P_DTLS VARCHAR(9999),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
    OUT P_RESULT VARCHAR(255)
)
BEGIN
    DECLARE TEMP_ORDER_SYS_ID INT DEFAULT 0;
    DECLARE TEMP_ORDER_DTL_SYS_ID INT DEFAULT 0;
    DECLARE TEMP_TRANS_SYS_ID INT DEFAULT 0;
    DECLARE TEMP_CNT INT DEFAULT 0;
    DECLARE TEMP_SR_NO INT DEFAULT 0;
    
    DECLARE v_counter BIGINT DEFAULT 1;
	DECLARE v_line VARCHAR(16300);
    
	DECLARE v_line_material VARCHAR(255);
	DECLARE v_line_desc VARCHAR(16300);
	DECLARE v_line_uom VARCHAR(255);
	DECLARE v_line_qty VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
		DELETE FROM OTHER_HEADER WHERE OTHER_SYS_ID = TEMP_ORDER_SYS_ID;
		DELETE FROM OTHER_DETAIL WHERE OTHER_SYS_ID = TEMP_ORDER_SYS_ID;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

	START TRANSACTION;
    
    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    SELECT COUNT(*) INTO TEMP_ORDER_SYS_ID FROM OTHER_HEADER WHERE ORDER_NO = P_ORDER_NO AND OTHER_SYS_ID != P_ID;

    IF IFNULL(TEMP_ORDER_SYS_ID, 0) > 0 THEN
        SET P_RESULT = CONCAT('E|Other Material Order No. is already exist.|', P_ID);
    ELSE
        SET TEMP_CNT = CHAR_LENGTH(IFNULL(P_DTLS, ''));

        IF IFNULL(TEMP_CNT, 0) > 0 AND P_ID = 0 THEN
        		          
						SELECT COUNT(*) INTO TEMP_TRANS_SYS_ID FROM transporter_master x WHERE x.tptr_cd = P_TRANSPORTER OR CONVERT(x.TRANS_SYS_ID,char) = P_TRANSPORTER;
						
						IF IFNULL(TEMP_TRANS_SYS_ID, 0) > 0 THEN						
							SELECT TRANS_SYS_ID INTO TEMP_TRANS_SYS_ID FROM transporter_master x WHERE x.tptr_cd = P_TRANSPORTER OR CONVERT(x.TRANS_SYS_ID,char) = P_TRANSPORTER LIMIT 1;
						ELSE
                        
                            INSERT INTO transporter_master (tptr_cd, tptr_name, IS_ENTRY_MANUAL, PLANT_ID, Created_DateTime, IS_POSTED)
                            VALUES('', P_TRANSPORTER, 0, P_PLANT_ID, NOW(), 1);
                        
							COMMIT;
                            
                            SELECT LAST_INSERT_ID() INTO TEMP_TRANS_SYS_ID;
                            
                            UPDATE transporter_master SET tptr_cd = CONCAT('TR00', '', TEMP_TRANS_SYS_ID) WHERE TRANS_SYS_ID = TEMP_TRANS_SYS_ID;
                            
						END IF;
               
               
            #SELECT IFNULL(MAX(ORDER_SYS_ID), 0) + 1 INTO TEMP_ORDER_SYS_ID FROM OTHER_HEADER;

            INSERT INTO OTHER_HEADER (PLANT_ID, ORDER_NO, ORDER_DATE, TRUCK_NO, TRANS_SYS_ID, Created_BY_ID, Created_DateTime, IS_POSTED) 
            VALUES (P_PLANT_ID, P_ORDER_NO, STR_TO_DATE(REPLACE(P_ORDER_DATE, '-', '/'), '%d/%m/%Y'), P_TRUCK_NO,TEMP_TRANS_SYS_ID, P_USER_ID, NOW(), 0);
            
                SELECT LAST_INSERT_ID() INTO TEMP_ORDER_SYS_ID;
                  
				SET v_counter = 1;            
				SET v_line = REGEXP_SUBSTR(IFNULL(P_DTLS, ''), '[^<#>]+', 1, v_counter);
                
				WHILE v_line IS NOT NULL DO
                
					SET v_line_material = REGEXP_SUBSTR(v_line, '[^|]+', 1, 1);
					SET v_line_desc = REGEXP_SUBSTR(v_line, '[^|]+', 1, 2);
					SET v_line_uom = REGEXP_SUBSTR(v_line, '[^|]+', 1, 3);
					SET v_line_qty = REGEXP_SUBSTR(v_line, '[^|]+', 1, 4);
                    
                    
                    #SELECT IFNULL(MAX(OTHER_DTL_SYS_ID), 0) + 1 INTO TEMP_ORDER_DTL_SYS_ID FROM OTHER_DETAIL;
					
					SELECT IFNULL(MAX(SR_NO), 0) + 1 INTO TEMP_SR_NO FROM OTHER_DETAIL WHERE PLANT_ID = P_PLANT_ID AND OTHER_SYS_ID = TEMP_ORDER_SYS_ID;
               
					INSERT INTO OTHER_DETAIL (OTHER_SYS_ID, SR_NO, MATERIAL, MATERIAL_DESC, UMO, QTY, Created_DateTime, IS_POSTED, PLANT_ID)
                    VALUES (TEMP_ORDER_SYS_ID, IFNULL(TEMP_SR_NO, 1), v_line_material, v_line_desc, v_line_uom, CAST(IFNULL(v_line_qty, '0') AS DECIMAL(10,4)), NOW(), 0, P_PLANT_ID);
                
					SET v_counter = v_counter + 1;
					SET v_line = REGEXP_SUBSTR(P_DTLS, '[^<#>]+', 1, v_counter);
                    
				END WHILE; 


			COMMIT;
            SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_ORDER_SYS_ID);

        ELSE
            SET P_RESULT = CONCAT('E|Please add Material details.|', P_ID);
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
CREATE  PROCEDURE `PC_PALLATE_CLOSE`(IN P_ID INT, IN P_DI_NO VARCHAR(255),IN P_PLANT_ID INT, OUT P_RESULT VARCHAR(16300))
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
CREATE  PROCEDURE `PC_PALLATE_DELETE`(
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
CREATE  PROCEDURE `PC_PALLATE_DI_GET`(
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
    WHERE GIO.PLANT_ID = MH.PLANT_ID AND MH.MDA_SYS_ID = GIO.MDA_SYS_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0 AND IFNULL(WD.TARE_WT,0) > 0 AND WD.TARE_WT_DT IS NOT NULL AND IFNULL(WD.GROSS_WT,0) = 0 AND WD.GROSS_WT_DT IS NULL))
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
    
		WITH TBL_RESULT AS (SELECT PLANT_ID, Id, DI_No, SSCC, Pallate_No, Pallate_Type, Shipper_Qty, Dispatch_Mode
            , (ROW_NUMBER() OVER (ORDER BY CREATED_DATETIME)) AS SR_NO
        FROM pallate_master X
        WHERE X.DI_No = TRIM(IFNULL(P_DI_No,'')))
        SELECT (SELECT COUNT(*) FROM TBL_RESULT) AS Count, PLANT_ID, Id, DI_No, SSCC, Pallate_No, Pallate_Type, Shipper_Qty, (Shipper_Qty * 24) Bottle_Qty, Dispatch_Mode, SR_NO
            , (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('Pallate_Type') AND Z.LOV_CODE = Pallate_Type LIMIT 1) AS Pallate_Type_Text
            , (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('DISPATCH_MODE') AND Z.LOV_CODE = Dispatch_Mode LIMIT 1) AS Dispatch_Mode_Text
        FROM TBL_RESULT X
        WHERE IF(IFNULL(P_ID,0) != -2, TRUE, 0 = (select COUNT(*) FROM exp_mda_pallate_loading Z WHERE Z.PLANT_ID = X.PLANT_ID AND Z.Pallate_Id = X.ID )) 
        AND IF(IFNULL(P_ID,0) != -2, TRUE, Shipper_Qty = (select COUNT(*) FROM pallate_shipper Z WHERE Z.Pallate_Id = X.ID AND Z.DI_No = X.DI_No AND Status = 'S' ));
            
    ELSEIF IFNULL(P_ID,0) > 0 AND TRIM(IFNULL(P_DI_No,'')) != '' THEN
    
		SELECT NULL Count, Id, DI_No, SSCC, Pallate_No, Pallate_Type, Shipper_Qty, (Shipper_Qty * 24) Bottle_Qty, Dispatch_Mode
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
CREATE  PROCEDURE `PC_PALLATE_GET`(
IN `P_ID` INT,
IN `P_PALLATE_NO` VARCHAR(255),
IN `P_MDA_NO` VARCHAR(255),
IN `P_PLANT_ID` INT
)
BEGIN

		IF P_ID < 0 THEN
            
			SELECT (COUNT(*) + 1) Max_Serial_No FROM pallate_master ;

        ELSEIF IFNULL(P_ID, 0) = 0 AND TRIM(IFNULL(P_MDA_NO,'')) != '' AND TRIM(IFNULL(P_PALLATE_NO,'')) = '' THEN
            
            WITH TBL_MDA AS (SELECT MH.MDA_SYS_ID, MH.VEHICLE_NO, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')MDA_DT 
				FROM mda_header MH 
				WHERE MH.MDA_NO = TRIM(IFNULL(P_MDA_NO,''))
				GROUP BY MH.MDA_SYS_ID, MH.VEHICLE_NO, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')
			)
			, TBL_MDA_DTLS AS (SELECT MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.VEHICLE_NO, MH.MDA_DT, MH.OUT_TIME, MH.PLANT_CD, MH.TRANS_SYS_ID, MD.PROD_SYS_ID
				, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
				, SUM(IFNULL(MD.BAG_NOS, 0))BAG_NOS, CAST((SUM(IFNULL(MD.BAG_NOS, 0)) / 24) as UNSIGNED) Required_Shipper
				FROM mda_header MH
				INNER JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
				-- WHERE (MH.VEHICLE_NO, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')) IN (SELECT VEHICLE_NO, MDA_DT FROM TBL_MH)
				 WHERE MH.MDA_SYS_ID IN (SELECT MDA_SYS_ID FROM TBL_MDA)
				AND MH.OUT_TIME IS NULL -- AND MD.PROD_SYS_ID IN (35,55,56)
				GROUP BY MH.PLANT_ID, MH.MDA_SYS_ID, MH.MDA_NO, MH.DI_NO, MH.VEHICLE_NO, MH.MDA_DT, MH.OUT_TIME, MH.PLANT_CD
				, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE, MD.PROD_SYS_ID
				ORDER BY MH.MDA_SYS_ID DESC, MH.MDA_DT DESC, MD.PROD_SYS_ID
			)
			, TBL_GATE_IN_MDA AS (SELECT X.PLANT_ID, X.GATE_SYS_ID, X.TRUCK_NO VEHICLE_NO, X.MDA_SYS_ID, Z.MDA_NO, Z.MDA_DT
					, X.GATE_IN_DT, X.GATE_OUT_DT, Z.PROD_SYS_ID, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER
					, IF(X.DRIVER_CHANGED = 1, X.DRIVER_NAME_NEW, X.DRIVER_NAME) AS DRIVER_NAME
					, IF(X.DRIVER_CHANGED = 1, X.DRIVER_CONTACT_NEW, X.DRIVER_CONTACT) AS DRIVER_CONTACT, X.DRIVER_CHANGED
					, Z.PLANT_CD, X.TRANS_SYS_ID, Z.WH_CD, Z.PARTY_NAME, Z.DIST, Z.DESP_PLACE, RFSYSID
					, X.VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID, IFNULL(EXPECTED_QTY, 0) Expected_Shipper
					, Z.BAG_NOS, Z.Required_Shipper
					FROM TBL_MDA_DTLS Z
					INNER JOIN exp_fg_gate_in_out X ON X.PLANT_ID = Z.PLANT_ID AND X.MDA_SYS_ID = Z.MDA_SYS_ID
					WHERE COALESCE(X.CANCEL_GATE_IN, 0) = 0
					ORDER BY X.GATE_IN_DT DESC
			)
			, TBL_PALLATE AS (SELECT Z.PLANT_ID, Z.MDA_SYS_ID, Z.GATE_SYS_ID, Z.Pallate_Id, Z.DI_No, X.Pallate_No, Pallate_Type
				, X.Shipper_Qty, (Shipper_Qty * 24) Bottle_Qty, Dispatch_Mode
				, (ROW_NUMBER() OVER (ORDER BY Z.CREATED_DATETIME)) AS SR_NO
				FROM exp_mda_pallate_loading Z 
				LEFT JOIN pallate_master X ON X.Id = Z.Pallate_Id
				WHERE (Z.MDA_SYS_ID, Z.GATE_SYS_ID) IN (SELECT MDA_SYS_ID, GATE_SYS_ID FROM TBL_GATE_IN_MDA)
			)
			SELECT NULL ID, X.PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Pallate Detail' REPORT_TITLE
				, Pallate_Id, Z.DI_No, Pallate_No, Pallate_Type
                , BAG_NOS, Required_Shipper, Expected_Shipper, (Expected_Shipper * 24) Expected_Bottle, Shipper_Qty Loaded_Shipper, Bottle_Qty Loaded_Bottle
                , Dispatch_Mode, PROD_SYS_ID, SR_NO
				, (SELECT LOV_DESC FROM LOV_MASTER ZL WHERE UPPER(ZL.LOV_COLUMN) = UPPER('Pallate_Type') AND ZL.LOV_CODE = Pallate_Type LIMIT 1) AS Pallate_Type_Text
				, (SELECT LOV_DESC FROM LOV_MASTER ZL WHERE UPPER(ZL.LOV_COLUMN) = UPPER('DISPATCH_MODE') AND ZL.LOV_CODE = Dispatch_Mode LIMIT 1) AS Dispatch_Mode_Text, NULL Dest_Country
			, X.GATE_SYS_ID, X.VEHICLE_NO, X.MDA_SYS_ID, X.MDA_NO, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
			, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
			, PLANT_CD, X.TRANS_SYS_ID, TM.tptr_name TRANS_NAME, WH_CD, PARTY_NAME, DIST, DESP_PLACE, RFSYSID, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
			FROM TBL_GATE_IN_MDA X
			LEFT JOIN TBL_PALLATE Z ON Z.MDA_SYS_ID = X.MDA_SYS_ID AND Z.GATE_SYS_ID = X.GATE_SYS_ID
			LEFT JOIN PLANT_MASTER PM ON PM.PlantID = X.PLANT_ID
			LEFT JOIN transporter_master TM ON TM.TRANS_SYS_ID = X.TRANS_SYS_ID;

			WITH TBL_MDA AS (SELECT PLANT_ID, MH.MDA_SYS_ID, MH.VEHICLE_NO, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')MDA_DT 
				FROM mda_header MH 
				WHERE MH.MDA_NO = TRIM(IFNULL(P_MDA_NO,''))
				GROUP BY MH.MDA_SYS_ID, MH.VEHICLE_NO, DATE_FORMAT(MH.MDA_DT, '%d/%m/%Y')
			)
			, TBL_GATE_IN_MDA AS (SELECT X.PLANT_ID, X.GATE_SYS_ID, X.MDA_SYS_ID
					FROM TBL_MDA Z
					INNER JOIN exp_fg_gate_in_out X ON X.PLANT_ID = Z.PLANT_ID AND X.MDA_SYS_ID = Z.MDA_SYS_ID
					WHERE COALESCE(X.CANCEL_GATE_IN, 0) = 0
					ORDER BY X.GATE_IN_DT DESC
			)
			, TBL_PALLATE AS (SELECT Z.PLANT_ID, Z.MDA_SYS_ID, Z.GATE_SYS_ID, Z.Pallate_Id, Z.DI_No, X.Pallate_No, X.SSCC, Pallate_Type, Shipper_Qty, (Shipper_Qty * 24) Bottle_Qty, Dispatch_Mode
				, (ROW_NUMBER() OVER (ORDER BY Z.CREATED_DATETIME)) AS SR_NO
				FROM exp_mda_pallate_loading Z 
				LEFT JOIN pallate_master X ON X.Id = Z.Pallate_Id
				WHERE (Z.MDA_SYS_ID, Z.GATE_SYS_ID) IN (SELECT MDA_SYS_ID, GATE_SYS_ID FROM TBL_GATE_IN_MDA)
			)
			SELECT X.Id, X.Pallate_Id, Z.DI_No, X.SSCC, Shipper_QR_Code, Status, Reason, CREATED_DATETIME, (ROW_NUMBER() OVER (PARTITION BY X.Pallate_Id ORDER BY CREATED_DATETIME DESC)) AS SR_NO
			FROM pallate_shipper X
            INNER JOIN TBL_PALLATE Z ON X.Pallate_Id = Z.Pallate_Id
			WHERE Status = 'S';
				
        ELSEIF IFNULL(P_ID, 0) = 0 AND TRIM(IFNULL(P_PALLATE_NO,'')) != '' AND TRIM(IFNULL(P_MDA_NO,'')) = '' THEN
            
            WITH TBL_PALLATE AS (SELECT PLANT_ID, Id, DI_No, SSCC, Pallate_No, Pallate_Type, Shipper_Qty, Dispatch_Mode, (ROW_NUMBER() OVER (ORDER BY CREATED_DATETIME)) AS SR_NO
				FROM pallate_master X WHERE X.Pallate_No = TRIM(IFNULL(P_PALLATE_NO,''))
			)
			, TBL_MDA_Load AS (SELECT X.PLANT_ID, XZ.MDA_SYS_ID, XZ.GATE_SYS_ID, X.DI_No, X.SSCC
					FROM TBL_PALLATE X
					LEFT JOIN exp_mda_pallate_loading XZ ON XZ.Pallate_Id = X.Id AND X.DI_No = XZ.DI_No
					GROUP BY X.PLANT_ID, XZ.MDA_SYS_ID, XZ.GATE_SYS_ID, X.DI_No, X.SSCC 
			)
			, TBL_GATE_IN_MDA AS (SELECT X.PLANT_ID, X.GATE_SYS_ID, X.TRUCK_NO VEHICLE_NO, X.MDA_SYS_ID, Z.MDA_NO
					, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER
					, IF(X.DRIVER_CHANGED = 1, X.DRIVER_NAME_NEW, X.DRIVER_NAME) AS DRIVER_NAME
					, IF(X.DRIVER_CHANGED = 1, X.DRIVER_CONTACT_NEW, X.DRIVER_CONTACT) AS DRIVER_CONTACT, X.DRIVER_CHANGED
					, Z.PLANT_CD, X.TRANS_SYS_ID, Z.WH_CD, Z.PARTY_NAME, Z.DIST, Z.DESP_PLACE, RFSYSID
					, X.VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID, IFNULL(EXPECTED_QTY, 0) Expected_Shipper
					FROM TBL_MDA_Load XZ
					INNER JOIN exp_fg_gate_in_out X ON X.PLANT_ID = XZ.PLANT_ID AND X.MDA_SYS_ID = XZ.MDA_SYS_ID
					INNER JOIN mda_header Z ON Z.PLANT_ID = XZ.PLANT_ID AND Z.MDA_SYS_ID = XZ.MDA_SYS_ID AND Z.DI_No = XZ.DI_No
					WHERE COALESCE(X.CANCEL_GATE_IN, 0) = 0
					ORDER BY X.GATE_IN_DT DESC
			)
			, TBL_MDA AS (SELECT X.PLANT_ID, GATE_SYS_ID, VEHICLE_NO, X.MDA_SYS_ID, X.MDA_NO, GATE_IN_DT, GATE_OUT_DT
							, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME
							, DIST, DESP_PLACE, RFSYSID, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
							, ZZ.BAG_NOS, Expected_Shipper, ZZ.PROD_SYS_ID
					FROM TBL_GATE_IN_MDA X
					LEFT JOIN mda_detail ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.MDA_SYS_ID = X.MDA_SYS_ID
			)
			SELECT X.PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Pallate Detail' REPORT_TITLE
				, Id, X.DI_No, Pallate_No, SSCC, Pallate_Type, Shipper_Qty, (Shipper_Qty * 24) Bottle_Qty, BAG_NOS, Expected_Shipper, (Expected_Shipper * 24) Expected_Bottle, Dispatch_Mode, SR_NO
				, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('Pallate_Type') AND Z.LOV_CODE = Pallate_Type LIMIT 1) AS Pallate_Type_Text
				, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('DISPATCH_MODE') AND Z.LOV_CODE = Dispatch_Mode LIMIT 1) AS Dispatch_Mode_Text, NULL Dest_Country
			, GATE_SYS_ID, VEHICLE_NO, MDA_SYS_ID, MDA_NO, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
            , INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
			, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DIST, DESP_PLACE, RFSYSID, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
            , PROD_SYS_ID, IF(IFNULL(MDA_NO, '') = '', 'In Stock','Dispatched') Pallate_Status
			FROM TBL_PALLATE X
			LEFT JOIN PLANT_MASTER PM ON PM.PlantID = X.PLANT_ID
			LEFT JOIN TBL_MDA Z ON 1 = 1;

			WITH TBL_PALLATE AS (SELECT PLANT_ID, Id, DI_No, Pallate_No, SSCC, Pallate_Type, Shipper_Qty, Dispatch_Mode, (ROW_NUMBER() OVER (ORDER BY CREATED_DATETIME)) AS SR_NO
				FROM pallate_master X WHERE X.Pallate_No = TRIM(IFNULL(P_PALLATE_NO,''))
			)
			SELECT X.Id, Pallate_Id, Z.DI_No, Z.SSCC, Shipper_QR_Code, Status, Reason, CREATED_DATETIME, (ROW_NUMBER() OVER (ORDER BY CREATED_DATETIME DESC)) AS SR_NO
			FROM pallate_shipper X
            INNER JOIN TBL_PALLATE Z ON X.Pallate_Id = Z.Id
			WHERE Status = 'S';
				
        ELSEIF P_ID > 0 THEN
            
            SELECT Id, MDA_SYS_ID, Pallate_No, X.SSCC, Pallate_Type, Shipper_Qty, Dispatch_Mode, Shipper_QR_Code, Created_DateTime, PLANT_ID
            FROM pallate_master X
            WHERE X.Id = P_ID;

        ELSE
        
            SELECT COUNT(*) AS COUNT_ROW, Id, Pallate_No, X.SSCC, Pallate_Type, Shipper_Qty, Dispatch_Mode, Created_DateTime, PLANT_ID
            , (ROW_NUMBER() OVER (ORDER BY Created_DateTime)) AS SR_NO
            , (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('Pallate_Type') AND Z.LOV_CODE = Pallate_Type LIMIT 1) AS Pallate_Type_Text
            , (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('DISPATCH_MODE') AND Z.LOV_CODE = Dispatch_Mode LIMIT 1) AS Dispatch_Mode_Text
			FROM pallate_master X
			GROUP BY Id, Pallate_No, SSCC, Pallate_Type, Shipper_Qty, Dispatch_Mode, Created_DateTime, PLANT_ID;

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
CREATE  PROCEDURE `PC_PALLATE_MDA_SAVE`(IN P_MDA_ID          INT, IN P_GATEIN_ID          INT,
                                  IN P_DI_No    VARCHAR(255),
                                  IN P_Pallate_Id    VARCHAR(16300),
                                  IN P_PLANT_ID    INT,
                                  IN P_USER_ID    INT,
								  OUT P_RESULT VARCHAR(16300))
BEGIN
             
	DECLARE TEMP_NUM BIGINT;
	DECLARE TEMP_LOAD_QTY BIGINT;
	DECLARE TEMP_Expected_QTY BIGINT;
    
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
			    							
			SELECT IFNULL(EXPECTED_QTY, 0) INTO TEMP_Expected_QTY
			FROM exp_fg_gate_in_out X
			WHERE X.GATE_SYS_ID = P_GATEIN_ID AND X.MDA_SYS_ID = P_MDA_ID AND COALESCE(X.CANCEL_GATE_IN, 0) = 0;
			
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
			SELECT SUM(Shipper_Qty) INTO TEMP_LOAD_QTY
			FROM pallate_master X
			INNER JOIN split_values Z ON X.Id = Z.value
			GROUP BY X.Id;

			IF IFNULL(TEMP_LOAD_QTY, 0) <= IFNULL(TEMP_Expected_QTY, 0) THEN
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
            ELSE
				SET P_RESULT = CONCAT('E|Load Qty is more then Expected Qty. Expected Qty in this vehicle is ', TEMP_Expected_QTY,  '.|0');
            END IF;
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_PALLATE_REPORT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_PALLATE_REPORT_GET`(
IN `P_DI_No` VARCHAR(255),
IN `P_MDA_No` VARCHAR(255),
IN `P_Vehicle_No` VARCHAR(255),
IN `P_Shipper_QR_Code` VARCHAR(255),
IN `P_Pallate_No` VARCHAR(255),
IN `P_FromDate` VARCHAR(255),
IN `P_ToDate` VARCHAR(255),
IN `P_PLANT_ID` INT
)
BEGIN

IF(TRIM(IFNULL(P_Pallate_No, '')) = '-1') THEN

	WITH TBL_SHIPPER AS (SELECT Pallate_Id FROM pallate_shipper WHERE Created_DateTime >= NOW() - INTERVAL 30 DAY AND Created_DateTime < NOW() + INTERVAL 1 DAY)
	SELECT DISTINCT X.Id Pallate_Id, X.Pallate_No
	FROM pallate_master X
	WHERE Id IN (SELECT Pallate_Id FROM TBL_SHIPPER)
	ORDER BY Pallate_No;
    
ELSE

WITH TBL_MDA_ AS (SELECT PLANT_ID, MDA_SYS_ID FROM mda_header
		WHERE IF(TRIM(IFNULL(P_MDA_No, '')) = '', FALSE, MDA_No = TRIM(IFNULL(P_MDA_No, '')))
		OR IF(TRIM(IFNULL(P_DI_No, '')) = '', FALSE, DI_No = TRIM(IFNULL(P_DI_No, '')))
)
, TBL_GIO AS (SELECT X.PLANT_ID, X.MDA_SYS_ID, X.GATE_SYS_ID, X.TRUCK_NO, X.GATE_IN_DT, X.GATE_OUT_DT
FROM exp_fg_gate_in_out X
WHERE IF(TRIM(IFNULL(P_Vehicle_No, '')) = '', FALSE, TRUCK_NO = TRIM(IFNULL(P_Vehicle_No, '')))
OR (PLANT_ID, MDA_SYS_ID) IN (SELECT PLANT_ID, MDA_SYS_ID FROM TBL_MDA_)
OR IF( TRIM(IFNULL(P_FromDate, '')) = '' AND TRIM(IFNULL(P_ToDate, '')) = '', 
        FALSE,
        IF(
            TRIM(IFNULL(P_FromDate, '')) IS NOT NULL AND TRIM(IFNULL(P_ToDate, '')) = '', 
            GATE_IN_DT >= STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') AND GATE_IN_DT < STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') + INTERVAL 31 DAY,
            IF(
                TRIM(IFNULL(P_FromDate, '')) = '' AND TRIM(IFNULL(P_ToDate, '')) IS NOT NULL, 
                GATE_IN_DT >= STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') - INTERVAL 30 DAY AND GATE_IN_DT < STR_TO_DATE(TRIM(IFNULL(P_ToDate, '')), '%d/%m/%Y') + INTERVAL 1 DAY,
                GATE_IN_DT >= STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') AND GATE_IN_DT < STR_TO_DATE(TRIM(IFNULL(P_ToDate, '')), '%d/%m/%Y') + INTERVAL 1 DAY
            )
        )
    ))
, TBL_SHIPPER AS (SELECT * FROM pallate_shipper WHERE IF(TRIM(IFNULL(P_Shipper_QR_Code, '')) = '', FALSE, Shipper_QR_Code LIKE CONCAT('%', TRIM(IFNULL(P_Shipper_QR_Code, '')))))
, TBL_MDA_Load AS (
SELECT X.PLANT_ID, XZ.MDA_SYS_ID, XZ.GATE_SYS_ID, X.Id Pallate_Id, XZ.DI_No, X.SSCC
FROM pallate_master X
LEFT JOIN exp_mda_pallate_loading XZ ON XZ.Pallate_Id = X.Id AND X.DI_No = XZ.DI_No
WHERE IF(TRIM(IFNULL(P_Pallate_No, '')) = '', FALSE, IF(TRIM(IFNULL(P_Pallate_No, '')) REGEXP '^[0-9]+$' = 0, X.Pallate_No = TRIM(IFNULL(P_Pallate_No, '')), X.Id = CAST(TRIM(IFNULL(P_Pallate_No, '')) AS UNSIGNED) )  )
OR XZ.Pallate_Id IN (SELECT Pallate_Id FROM TBL_SHIPPER)
OR (XZ.PLANT_ID, MDA_SYS_ID, GATE_SYS_ID) IN (SELECT PLANT_ID, MDA_SYS_ID, GATE_SYS_ID FROM TBL_GIO)
OR IF( TRIM(IFNULL(P_FromDate, '')) = '' AND TRIM(IFNULL(P_ToDate, '')) = '', 
        FALSE,
        IF(
            TRIM(IFNULL(P_FromDate, '')) IS NOT NULL AND TRIM(IFNULL(P_ToDate, '')) = '', 
            XZ.Created_DateTime >= STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') AND XZ.Created_DateTime < STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') + INTERVAL 31 DAY,
            IF(
                TRIM(IFNULL(P_FromDate, '')) = '' AND TRIM(IFNULL(P_ToDate, '')) IS NOT NULL, 
                XZ.Created_DateTime >= STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') - INTERVAL 30 DAY AND XZ.Created_DateTime < STR_TO_DATE(TRIM(IFNULL(P_ToDate, '')), '%d/%m/%Y') + INTERVAL 1 DAY,
                XZ.Created_DateTime >= STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') AND XZ.Created_DateTime < STR_TO_DATE(TRIM(IFNULL(P_ToDate, '')), '%d/%m/%Y') + INTERVAL 1 DAY
            )
        )
    )
)
, TBL_GATE_IN_MDA AS (
SELECT DISTINCT X.PLANT_ID, X.GATE_SYS_ID, X.TRUCK_NO VEHICLE_NO, X.MDA_SYS_ID, Z.MDA_NO
					, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER
					, IF(X.DRIVER_CHANGED = 1, X.DRIVER_NAME_NEW, X.DRIVER_NAME) AS DRIVER_NAME
					, IF(X.DRIVER_CHANGED = 1, X.DRIVER_CONTACT_NEW, X.DRIVER_CONTACT) AS DRIVER_CONTACT, X.DRIVER_CHANGED
					, Z.PLANT_CD, X.TRANS_SYS_ID, Z.WH_CD, Z.PARTY_NAME, Z.DIST, Z.DESP_PLACE, RFSYSID
					, X.VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID, IFNULL(EXPECTED_QTY, 0) Expected_Shipper
					FROM TBL_MDA_Load XZ
					LEFT JOIN exp_fg_gate_in_out X ON X.PLANT_ID = XZ.PLANT_ID AND X.MDA_SYS_ID = XZ.MDA_SYS_ID
					LEFT JOIN mda_header Z ON Z.PLANT_ID = XZ.PLANT_ID AND Z.MDA_SYS_ID = XZ.MDA_SYS_ID AND Z.DI_No = XZ.DI_No
					WHERE COALESCE(X.CANCEL_GATE_IN, 0) = 0
					ORDER BY X.GATE_IN_DT DESC
			)
			, TBL_MDA AS (
            SELECT X.PLANT_ID, GATE_SYS_ID, VEHICLE_NO, X.MDA_SYS_ID, X.MDA_NO, GATE_IN_DT, GATE_OUT_DT
							, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME
							, DIST, DESP_PLACE, RFSYSID, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
							, ZZ.BAG_NOS, Expected_Shipper, ZZ.PROD_SYS_ID
					FROM TBL_GATE_IN_MDA X
					LEFT JOIN mda_detail ZZ ON ZZ.PLANT_ID = X.PLANT_ID AND ZZ.MDA_SYS_ID = X.MDA_SYS_ID
			)
			SELECT DISTINCT (ROW_NUMBER() OVER (ORDER BY X.CREATED_DATETIME)) AS SR_NO, X.PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Pallate Detail' REPORT_TITLE
				, Id, X.DI_No, Pallate_No, SSCC, Pallate_Type, Shipper_Qty, (Shipper_Qty * 24) Bottle_Qty, BAG_NOS, Expected_Shipper, (Expected_Shipper * 24) Expected_Bottle, Dispatch_Mode
				, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('Pallate_Type') AND Z.LOV_CODE = Pallate_Type LIMIT 1) AS Pallate_Type_Text
				, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE UPPER(Z.LOV_COLUMN) = UPPER('DISPATCH_MODE') AND Z.LOV_CODE = Dispatch_Mode LIMIT 1) AS Dispatch_Mode_Text, NULL Dest_Country
			, GATE_SYS_ID, VEHICLE_NO, MDA_SYS_ID, MDA_NO, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
            , INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
			, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DIST, DESP_PLACE, RFSYSID, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
            , PROD_SYS_ID, IF(IFNULL(MDA_NO, '') = '', 'In Stock','Dispatched') Pallate_Status
			FROM pallate_master X, TBL_MDA Z
			LEFT JOIN PLANT_MASTER PM ON PM.PlantID = Z.PLANT_ID
            WHERE X.Id IN (SELECT Pallate_Id FROM TBL_MDA_Load)
            ORDER BY GATE_SYS_ID, MDA_SYS_ID;
            
WITH TBL_MDA_ AS (SELECT PLANT_ID, MDA_SYS_ID FROM mda_header
		WHERE IF(TRIM(IFNULL(P_MDA_No, '')) = '', FALSE, MDA_No = TRIM(IFNULL(P_MDA_No, '')))
		OR IF(TRIM(IFNULL(P_DI_No, '')) = '', FALSE, DI_No = TRIM(IFNULL(P_DI_No, '')))
)
, TBL_GIO AS (SELECT X.PLANT_ID, X.MDA_SYS_ID, X.GATE_SYS_ID, X.TRUCK_NO, X.GATE_IN_DT, X.GATE_OUT_DT
FROM exp_fg_gate_in_out X
WHERE IF(TRIM(IFNULL(P_Vehicle_No, '')) = '', FALSE, TRUCK_NO = TRIM(IFNULL(P_Vehicle_No, '')))
OR (PLANT_ID, MDA_SYS_ID) IN (SELECT PLANT_ID, MDA_SYS_ID FROM TBL_MDA_)
OR IF( TRIM(IFNULL(P_FromDate, '')) = '' AND TRIM(IFNULL(P_ToDate, '')) = '', 
        FALSE,
        IF(
            TRIM(IFNULL(P_FromDate, '')) IS NOT NULL AND TRIM(IFNULL(P_ToDate, '')) = '', 
            GATE_IN_DT >= STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') AND GATE_IN_DT < STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') + INTERVAL 31 DAY,
            IF(
                TRIM(IFNULL(P_FromDate, '')) = '' AND TRIM(IFNULL(P_ToDate, '')) IS NOT NULL, 
                GATE_IN_DT >= STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') - INTERVAL 30 DAY AND GATE_IN_DT < STR_TO_DATE(TRIM(IFNULL(P_ToDate, '')), '%d/%m/%Y') + INTERVAL 1 DAY,
                GATE_IN_DT >= STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') AND GATE_IN_DT < STR_TO_DATE(TRIM(IFNULL(P_ToDate, '')), '%d/%m/%Y') + INTERVAL 1 DAY
            )
        )
    ))
, TBL_SHIPPER AS (SELECT * FROM pallate_shipper WHERE IF(TRIM(IFNULL(P_Shipper_QR_Code, '')) = '', FALSE, Shipper_QR_Code LIKE CONCAT('%', TRIM(IFNULL(P_Shipper_QR_Code, '')))))
, TBL_PALLATE AS (
SELECT X.PLANT_ID, XZ.MDA_SYS_ID, XZ.GATE_SYS_ID, X.Id Pallate_Id, XZ.DI_No, X.SSCC
FROM pallate_master X
LEFT JOIN exp_mda_pallate_loading XZ ON XZ.Pallate_Id = X.Id AND X.DI_No = XZ.DI_No
WHERE IF(TRIM(IFNULL(P_Pallate_No, '')) = '', FALSE, IF(TRIM(IFNULL(P_Pallate_No, '')) REGEXP '^[0-9]+$' = 0, X.Pallate_No = TRIM(IFNULL(P_Pallate_No, '')), X.Id = CAST(TRIM(IFNULL(P_Pallate_No, '')) AS UNSIGNED) )  )
OR XZ.Pallate_Id IN (SELECT Pallate_Id FROM TBL_SHIPPER)
OR (XZ.PLANT_ID, MDA_SYS_ID, GATE_SYS_ID) IN (SELECT PLANT_ID, MDA_SYS_ID, GATE_SYS_ID FROM TBL_GIO)
OR IF( TRIM(IFNULL(P_FromDate, '')) = '' AND TRIM(IFNULL(P_ToDate, '')) = '', 
        FALSE,
        IF(
            TRIM(IFNULL(P_FromDate, '')) IS NOT NULL AND TRIM(IFNULL(P_ToDate, '')) = '', 
            XZ.Created_DateTime >= STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') AND XZ.Created_DateTime < STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') + INTERVAL 31 DAY,
            IF(
                TRIM(IFNULL(P_FromDate, '')) = '' AND TRIM(IFNULL(P_ToDate, '')) IS NOT NULL, 
                XZ.Created_DateTime >= STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') - INTERVAL 30 DAY AND XZ.Created_DateTime < STR_TO_DATE(TRIM(IFNULL(P_ToDate, '')), '%d/%m/%Y') + INTERVAL 1 DAY,
                XZ.Created_DateTime >= STR_TO_DATE(TRIM(IFNULL(P_FromDate, '')), '%d/%m/%Y') AND XZ.Created_DateTime < STR_TO_DATE(TRIM(IFNULL(P_ToDate, '')), '%d/%m/%Y') + INTERVAL 1 DAY
            )
        )
    )
)
SELECT X.Id, X.Pallate_Id, Z.SSCC, Z.DI_No, Shipper_QR_Code, Status, Reason, CREATED_DATETIME, (ROW_NUMBER() OVER (PARTITION BY X.Pallate_Id ORDER BY CREATED_DATETIME DESC)) AS SR_NO
			FROM pallate_shipper X
            INNER JOIN TBL_PALLATE Z ON X.Pallate_Id = Z.Pallate_Id
			WHERE Status = 'S';
     
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
CREATE  PROCEDURE `PC_PALLATE_SAVE`(IN P_ID          INT,
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
	DECLARE Required_Shipper INT DEFAULT 0;
	DECLARE Loaded_Shipper INT DEFAULT 0;
	DECLARE Remaining_Shipper INT DEFAULT 0;
    
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
        
        SELECT SUM(Shipper_Qty) INTO Loaded_Shipper FROM pallate_master X WHERE DI_No = P_DI_No AND X.Id != P_ID GROUP BY X.DI_No;
        
        SELECT CAST((SUM(IFNULL(MD.BAG_NOS, 0)) / 24) as UNSIGNED) INTO Required_Shipper
		FROM mda_header MH
		INNER JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
		WHERE DI_NO = TRIM(IFNULL('KL00009998','')) AND MH.OUT_TIME IS NULL
		GROUP BY DI_NO;
        
		SET Remaining_Shipper = (IFNULL(Required_Shipper, 0) - IFNULL(Loaded_Shipper, 0));

        IF IFNULL(TEMP_NUM, 0) > 0 THEN
			SET P_RESULT = 'E|Pallate already exists.|0';    
		ELSEIF IFNULL(Remaining_Shipper, 0) = 0 THEN
			SET P_RESULT = 'E|Selected DI is full.|0';
		ELSEIF IFNULL(Remaining_Shipper, 0) < IFNULL(P_Shipper_Qty, 0) THEN
			SET P_RESULT = CONCAT('E','|','You entered shipper qty is wrong. Remaining shipper is ',IFNULL(Remaining_Shipper, 0),'|','0');
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
CREATE  PROCEDURE `PC_PALLATE_SHIPPER_QRCODE_CHECK`(
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

        SET P_RESULT = CONCAT('E|NOK','_', @errmsg,'#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 0, '|-1');

    END;

		SELECT Shipper_Qty INTO TEMP_REQUIRED_SHIPPER FROM pallate_master X WHERE Id = IFNULL(P_ID,0) AND X.DI_No = TRIM(IFNULL(P_DI_NO,'')) LIMIT 1;
            
		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_ID,0) AND Z.DI_No = TRIM(IFNULL(P_DI_NO,'')) AND Z.Status = 'S';

		SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_ID,0) AND Z.DI_No = TRIM(IFNULL(P_DI_NO,'')) AND Z.Status != 'S';

        SET P_RESULT = CONCAT('E|NOK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 0, '|0');

		IF LENGTH(IFNULL(P_QR_CODE, '')) > 0 THEN
			
            SELECT COUNT(*) INTO TEMP_NUM FROM SHIPPER_QRCODE X WHERE X.SHIPPER_QRCODE = P_QR_CODE;

			IF IFNULL(TEMP_NUM, 0) > 0 THEN						
					
				SELECT COUNT(*) INTO TEMP_NUM FROM pallate_shipper Z WHERE Z.Status = 'S' AND Z.SHIPPER_QR_CODE = P_QR_CODE;

				IF IFNULL(TEMP_NUM, 0) = 0 THEN	
										 
					IF TEMP_REQUIRED_SHIPPER >= (TEMP_LOADED_SHIPPER + 1) THEN	
								
						INSERT INTO pallate_shipper (PLANT_ID, Pallate_Id, Shipper_QR_Code, DI_No, Status, Reason, CREATED_BY, CREATED_DATETIME) 
						VALUES (P_PLANT_ID, IFNULL(P_ID,0), P_QR_CODE, P_DI_NO, 'S', '', P_USER_ID, NOW());
						 
						 SET last_id = LAST_INSERT_ID();
						 
						SET TEMP_LOADED_SHIPPER = TEMP_LOADED_SHIPPER + 1;
				
						IF TEMP_REQUIRED_SHIPPER = TEMP_LOADED_SHIPPER THEN                        
							SET P_RESULT = CONCAT('E|OK_Pallate is full.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 1, '|', last_id);
						ELSEIF TEMP_REQUIRED_SHIPPER > TEMP_LOADED_SHIPPER THEN                        
							SET P_RESULT = CONCAT('S|OK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 1, '|', last_id);
						ELSE
							SET P_RESULT = CONCAT('E|NOK_Pallate is full.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 1, '|', last_id);
						END IF;
					ELSE  
							SET P_RESULT = CONCAT('E|NOK_Pallate is full.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 0, '|', last_id);                
					END IF;
				ELSE				
					IF TEMP_REQUIRED_SHIPPER >= (TEMP_LOADED_SHIPPER + 1) THEN	
						SET TEMP_REJECT_SHIPPER = TEMP_REJECT_SHIPPER + 1;
					
						INSERT INTO pallate_shipper (PLANT_ID, Pallate_Id, Shipper_QR_Code, DI_No, Status, Reason, CREATED_BY, CREATED_DATETIME) 
						VALUES (P_PLANT_ID, IFNULL(P_ID,0), P_QR_CODE, P_DI_NO, 'R', 'Duplicate QR Code found.', P_USER_ID, NOW());
						 
						SET last_id = LAST_INSERT_ID();
						 
						SET P_RESULT = CONCAT('E|NOK_Duplicate Shipper QR Code found.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 1, '|', last_id);
					ELSE  
						SET P_RESULT = CONCAT('E|NOK_Pallate is full.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 0, '|', last_id);                
					END IF;   
				END IF;
			ELSE            
					SET TEMP_REJECT_SHIPPER = TEMP_REJECT_SHIPPER + 1;
            
                    INSERT INTO pallate_shipper (PLANT_ID, Pallate_Id, Shipper_QR_Code, DI_No, Status, Reason, CREATED_BY, CREATED_DATETIME) 
					VALUES (P_PLANT_ID, IFNULL(P_ID,0), P_QR_CODE, P_DI_NO, 'R', 'QR Code not found.', P_USER_ID, NOW());
					 
	 				 SET last_id = LAST_INSERT_ID();
                     
					SET P_RESULT = CONCAT('E|NOK_QR Code not found.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 1, '|', last_id);   
			END IF;
                        
		END IF;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_PALLATE_SHIPPER_QRCODE_DELETE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_PALLATE_SHIPPER_QRCODE_DELETE`(
IN P_Pallate_Id INT,
IN P_DI_No NVARCHAR(255),
IN P_QR_Code_Id INT,
IN P_QR_Code_type NVARCHAR(255),
IN P_PLANT_ID INT,
IN P_USER_ID    INT,
OUT P_RESULT VARCHAR(16300))
BEGIN

	DECLARE TEMP_MSG VARCHAR(16300);
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

		SELECT Shipper_Qty INTO TEMP_REQUIRED_SHIPPER FROM pallate_master X WHERE Id = IFNULL(P_Pallate_Id,0) AND X.DI_No = TRIM(IFNULL(P_DI_No,'')) LIMIT 1;            
		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_Pallate_Id,0) AND Z.DI_No = TRIM(IFNULL(P_DI_No,'')) AND Z.Status = 'S';
		SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_Pallate_Id,0) AND Z.DI_No = TRIM(IFNULL(P_DI_No,'')) AND Z.Status = 'R';

		-- SET TEMP_MSG = CONCAT('E|NOK_', @errmsg);
        SET P_RESULT = CONCAT('E|NOK','_', @errmsg,'#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 0, '|-1');

    END;

		SELECT Shipper_Qty INTO TEMP_REQUIRED_SHIPPER FROM pallate_master X WHERE Id = IFNULL(P_Pallate_Id,0) AND X.DI_No = TRIM(IFNULL(P_DI_No,'')) LIMIT 1;            
		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_Pallate_Id,0) AND Z.DI_No = TRIM(IFNULL(P_DI_No,'')) AND Z.Status = 'S';
		SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_Pallate_Id,0) AND Z.DI_No = TRIM(IFNULL(P_DI_No,'')) AND Z.Status = 'R';

        SET P_RESULT = CONCAT('E|_Opps...! Somthing went wrong.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 0, '|0');

		SELECT COUNT(*) INTO TEMP_NUM FROM pallate_shipper Z WHERE Z.Status = IFNULL(P_QR_Code_type, '') AND Id = P_QR_Code_Id;

		IF IFNULL(TEMP_NUM, 0) > 0 AND IFNULL(P_QR_Code_Id, 0) > 0 THEN
			DELETE FROM pallate_shipper WHERE Status = IFNULL(P_QR_Code_type, '') AND Id = P_QR_Code_Id;
			SET TEMP_MSG = 'S|OK_Shipper QR Code is deleted.';
			-- SET P_RESULT = CONCAT('S|OK_Shipper QR Code is deleted.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 1, '|', last_id);						
		ELSEIF IFNULL(P_QR_Code_type, '') != '' AND IFNULL(P_QR_Code_Id, 0) = 0 THEN
			DELETE FROM pallate_shipper WHERE Status = IFNULL(P_QR_Code_type, '');
			SET TEMP_MSG = 'S|OK_Shipper QR Code is deleted.';
			-- SET P_RESULT = CONCAT('S|OK_Shipper QR Code is deleted.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 1, '|', last_id);						
		ELSE	
			SET TEMP_MSG = 'E|NOK_Shipper QR Code is not loaded.';
			-- SET P_RESULT = CONCAT('E|NOK_Pallate is full.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 0, '|', last_id);                
		END IF;
            
		SELECT Shipper_Qty INTO TEMP_REQUIRED_SHIPPER FROM pallate_master X WHERE Id = IFNULL(P_Pallate_Id,0) AND X.DI_No = TRIM(IFNULL(P_DI_No,'')) LIMIT 1;            
		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_Pallate_Id,0) AND Z.DI_No = TRIM(IFNULL(P_DI_No,'')) AND Z.Status = 'S';
		SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM pallate_shipper Z WHERE Z.Pallate_Id = IFNULL(P_Pallate_Id,0) AND Z.DI_No = TRIM(IFNULL(P_DI_No,'')) AND Z.Status = 'R';

		SET P_RESULT = CONCAT(TEMP_MSG,'#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', 1, '|', 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_PLANT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_PLANT_GET`(
IN `P_ID` INT,
IN `P_ISACTIVE` VARCHAR(255),
IN `P_PLANT_ID` INT,
IN `P_USER_ID` INT,
IN `P_ROLE_ID` INT,
IN `P_MENU_ID` INT
)
BEGIN
		IF P_ID > 0 THEN
            
            SELECT PLANTID ID, PLANTCODE CODE, PLANTADDRESS ADDRESS, PLANT_NAME NAME, PLANTID UNIT_CODE, 1 IS_ACTIVE  
            FROM PLANT_MASTER X
            WHERE X.PLANTID = P_ID;

        ELSE
            
            SELECT PLANTID ID, PLANTCODE CODE, PLANTADDRESS ADDRESS, PLANT_NAME NAME, PLANTID UNIT_CODE, 1 IS_ACTIVE 
            FROM PLANT_MASTER X;

        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_PLANT_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_PLANT_SAVE`(IN P_ID      INT,
                                 IN P_CODE    VARCHAR(255),
                                 IN P_NAME    VARCHAR(255),
                                 IN P_ADDRESS VARCHAR(255),
                                 IN P_UNIT_CODE   INT,
                                 IN P_ISACTIVE    VARCHAR(255),
                                 IN P_PLANT_ID    INT,
                                 IN P_USER_ID INT,
                                 IN P_ROLE_ID INT,
                                 IN P_MENU_ID INT,
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
		SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. |0';
		        
	SELECT COUNT(*) INTO TEMP_NUM FROM PLANT_MASTER X WHERE (X.PLANTCODE = P_CODE OR X.PLANT_NAME = P_NAME) AND X.PLANTID != P_ID;
	
    IF IFNULL(TEMP_NUM, 0) > 0
	   THEN
		  SET P_RESULT = 'E|Plant name or code is already exist.|0';
	ELSEIF P_ID > 0
	   THEN
		  UPDATE PLANT_MASTER
			 SET PLANTCODE = P_CODE,
				 PLANT_NAME = P_NAME,
				 PLANTADDRESS = P_ADDRESS
		   WHERE PLANTID = P_ID;

		  SET P_RESULT = 'S|Record updated successfully|';
	   ELSE
		  SELECT IFNULL(MAX(PLANTID), 0) + 1 INTO TEMP_NUM FROM PLANT_MASTER;

		  INSERT INTO PLANT_MASTER (PLANTID,
									PLANTCODE,
									PLANT_NAME,
									PLANTADDRESS)
			   VALUES (TEMP_NUM,
					   P_CODE,
					   P_NAME,
					   P_ADDRESS);


		  INSERT INTO USER_ROLE_NEW (USER_ID, PLANT_ID, ROLE_ID)
			   VALUES (P_USER_ID, TEMP_NUM, P_ROLE_ID);

		  SET P_RESULT = 'S|Record saved successfully|';
	   END IF;
			
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_PO_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_PO_SAVE`(
    IN P_ID BIGINT, 
    IN P_VENDOR_ID BIGINT, 
    IN P_VENDOR_NAME VARCHAR(255), 
    IN P_SITE_ID BIGINT, 
    IN P_SITE_NAME VARCHAR(255), 
    IN P_PO_NO VARCHAR(255), 
    IN P_PO_DATE VARCHAR(255), 
    IN P_PO_DESC VARCHAR(255), 
    IN P_TRUCK_NO VARCHAR(255), 
    IN P_TRANS_SYS_ID BIGINT, 
    IN P_TRANS_NAME VARCHAR(255), 
    IN P_PO_DTLS VARCHAR(255), 
    IN P_ISACTIVE VARCHAR(255), 
    IN P_PLANT_ID BIGINT, 
    IN P_USER_ID BIGINT,  
    IN P_ROLE_ID BIGINT, 
    IN P_MENU_ID BIGINT, 
    OUT P_RESULT VARCHAR(255))
BEGIN
DECLARE TEMP_NUM INT DEFAULT 0;
    DECLARE TEMP_PO_ID INT DEFAULT 0; 
    DECLARE TEMP_PO_DTLS_ID INT DEFAULT 0; 
    DECLARE TEMP_PO_DTLS_LINE_NO INT DEFAULT 0; 
    DECLARE TEMP_CNT INT DEFAULT 0;
    /*DECLARE TEMP_MAX_VENDOR_ID INT DEFAULT 0;
    DECLARE TEMP_MAX_TRANS_ID INT DEFAULT 0;    */
    DECLARE TEMP_VENDOR_ID INT DEFAULT 0;
    DECLARE TEMP_TRANS_ID INT DEFAULT 0;    
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




    /*IF(P_VENDOR_NAME != '' AND P_VENDOR_NAME != NULL) THEN
		INSERT INTO vendor_master(PLANT_ID,ORGANIZATION_NAME,VENDOR_SITE,Created_DateTime) VALUES(P_PLANT_ID,P_VENDOR_NAME,P_SITE_NAME,NOW());        
        SELECT MAX(VENDOR_SYS_ID) INTO TEMP_MAX_VENDOR_ID FROM vendor_master; 
        SET P_VENDOR_ID = TEMP_MAX_VENDOR_ID;
    END IF;    */
    
						SELECT COUNT(*) INTO TEMP_NUM FROM vendor_master X WHERE X.VENDOR_SYS_ID = P_VENDOR_ID;
						
						IF IFNULL(TEMP_NUM, 0) > 0 THEN						
							SET TEMP_VENDOR_ID = P_VENDOR_ID;
						ELSE
                        
                            INSERT INTO vendor_master (ORGANIZATION_NAME, VENDOR_SITE, PLANT_ID, Created_DateTime)
                            VALUES(P_VENDOR_NAME, P_SITE_NAME, P_PLANT_ID, NOW());
                        
							COMMIT;
                            
                            SELECT VENDOR_SYS_ID INTO TEMP_VENDOR_ID FROM vendor_master x WHERE x.ORGANIZATION_NAME = P_VENDOR_NAME AND x.VENDOR_SITE = P_SITE_NAME LIMIT 1;
                        
						END IF;
                        
                     
                        
    IF LENGTH(IFNULL(P_PO_NO, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter Vendor PO No.|0';
    ELSEIF IFNULL(TEMP_VENDOR_ID, 0) = 0 THEN
		SET P_RESULT := 'E|Please select Vendor.|0';
   -- ELSEIF IFNULL(P_SITE_NAME, '') = '' THEN
	-- SET P_RESULT := 'E|Please select Vendor Site.|0';
    ELSEIF LENGTH(IFNULL(P_PO_DATE, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter Vendor PO Date.|0';
    ELSEIF LENGTH(IFNULL(P_PO_DESC, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter Vendor PO description|0';
    ELSEIF LENGTH(IFNULL(P_TRUCK_NO, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter Vehicle No.|0';
    ELSEIF IFNULL(P_ID, 0) = 0 AND LENGTH(IFNULL(P_PO_DTLS, '')) = 0 THEN
		SET P_RESULT := 'E|Please enter Vendor PO details|0';
    ELSE 
    
		   
    /*IF(P_TRANS_NAME != '' AND P_TRANS_NAME != NULL) THEN
		INSERT INTO transporter_master(PLANT_ID,tptr_name,IS_ENTRY_MANUAL,Created_DateTime) VALUES(P_PLANT_ID,P_TRANS_NAME,1,NOW());       
        SELECT MAX(TRANS_SYS_ID) INTO TEMP_MAX_TRANS_ID FROM transporter_master;
        SET P_TRANS_SYS_ID = TEMP_MAX_TRANS_ID;
    END IF;*/
    
    
						SELECT COUNT(*) INTO TEMP_NUM FROM transporter_master X WHERE X.TRANS_SYS_ID = P_TRANS_SYS_ID;
						
						IF IFNULL(TEMP_NUM, 0) > 0 THEN						
							SET TEMP_TRANS_ID = P_TRANS_SYS_ID;
						ELSE
                        
                            INSERT INTO transporter_master (tptr_name, PLANT_ID, Created_DateTime)
                            VALUES(P_TRANS_NAME, P_PLANT_ID, NOW());
                        
							COMMIT;
                            
                            SELECT TRANS_SYS_ID INTO TEMP_TRANS_ID FROM transporter_master x WHERE x.tptr_name = P_TRANS_NAME LIMIT 1;
                        
							#SET v_TRANS_SYS_ID = TEMP_NUM;
						END IF;
                        
                        
		SELECT COUNT(*) INTO TEMP_CNT FROM po_header WHERE PLANT_ID = P_PLANT_ID AND PO_NO = P_PO_NO AND PO_SYS_ID != IFNULL(P_ID, 0);

		IF IFNULL(TEMP_CNT, 0) = 0 THEN
							
			SET v_PO_DATE = IF(IFNULL(P_PO_DATE, '') = '' OR P_PO_DATE = '=', NULL, STR_TO_DATE(REPLACE(P_PO_DATE, '-', '/'), '%d/%m/%Y %H:%i'));
                            
			IF IFNULL(P_ID, 0) > 0 THEN
			
            
            
            
				SET TEMP_PO_ID = IFNULL(P_ID, 0);
                
				SET P_RESULT = CONCAT('S|Record saved successfully|', TEMP_PO_ID);
			ELSE
				
				SELECT IFNULL(MAX(PO_SYS_ID), 0) + 1 INTO TEMP_PO_ID FROM po_header;
					
				INSERT INTO po_header (PO_SYS_ID, PO_NO, PO_DATE, VENDOR_SYS_ID, PO_DESCCRIPTION, TRANS_SYS_ID, TRUCK_NO, IS_PO_MANUAL, STATION_ID, PLANT_ID, Created_BY_ID, Created_DateTime, IS_POSTED)
				VALUES (TEMP_PO_ID, P_PO_NO, v_PO_DATE, TEMP_VENDOR_ID, P_PO_DESC, TEMP_TRANS_ID, P_TRUCK_NO, 1, TEMP_STATION_ID, P_PLANT_ID, P_USER_ID, NOW(), 0);
					
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_PRODUCT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_PRODUCT_GET`(
IN `P_ID` INT,
IN `P_ISACTIVE` VARCHAR(255),
IN `P_PLANT_ID` INT,
IN `P_USER_ID` INT,
IN `P_ROLE_ID` INT,
IN `P_MENU_ID` INT
)
BEGIN

		IF P_ID > 0 THEN
            
            SELECT PROD_SYS_ID ID, SKU_CODE, SKU_NAME, PRD_CD, PRD_DESC, PLANT_ID, IS_POSTED, PRD_WT_FILL, SHIP_WT_FILL
            , PROD_PER_SHIPPER, TOLERANCE_PER, PAL_WT_FILL, SHIP_PER_PALLET, NOTE, ISACTIVE, prd_desc_h, plant_cd, print_order, prd_desc_short
            , extra1, extra2, extra3, prd_type, sub_plant_cd, prd_category, active, hsn_code, prd_cd_group_app, uom, conv_factor, uom_evikas
            , GTIN, BPEX, VALIDITY_MONTH, ISACTIVE, NULL Qr_last_serial_no
			FROM PRODUCT_MASTER X
            WHERE X.PLANTID = P_ID;

        ELSE
        
            SELECT PROD_SYS_ID ID, SKU_CODE, SKU_NAME, PRD_CD, PRD_DESC, PLANT_ID, IS_POSTED, PRD_WT_FILL, SHIP_WT_FILL
            , PROD_PER_SHIPPER, TOLERANCE_PER, PAL_WT_FILL, SHIP_PER_PALLET, NOTE, ISACTIVE, prd_desc_h, plant_cd, print_order, prd_desc_short
            , extra1, extra2, extra3, prd_type, sub_plant_cd, prd_category, active, hsn_code, prd_cd_group_app, uom, conv_factor, uom_evikas
            , GTIN, BPEX, VALIDITY_MONTH, ISACTIVE, NULL Qr_last_serial_no
            FROM PRODUCT_MASTER X
            WHERE IFNULL(ISACTIVE, 0) = IF(TRIM(IFNULL(P_ISACTIVE, '')) = '', ISACTIVE, IF(TRIM(P_ISACTIVE) = 'Y', 1, 0));

        END IF;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_QR_CODE_CHECK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_QR_CODE_CHECK`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_QR_CODE_DELETE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_QR_CODE_DELETE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_QR_CODE_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_QR_CODE_GET`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_REPORT_BATCH_LOG_FILE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_REPORT_BATCH_LOG_FILE`(
IN P_SEARCH_TERM VARCHAR(255),
IN P_FROM_DATE VARCHAR(255),
IN P_TO_DATE VARCHAR(255),
IN P_PLANT_ID INT)
BEGIN

SELECT Plant_Name,PlantAddress FROM plant_master WHERE PlantID = P_PLANT_ID;

/*SELECT ROW_NUMBER() OVER (ORDER BY STARTDATE DESC) AS SR_NO, FILEUPLOADNAME FileName
, DATE_FORMAT(STARTDATE, '%d/%m/%Y %r') StartDate, DATE_FORMAT(ENDDATE, '%d/%m/%Y %r') EndDate, QRCODECOUNT QRCode_Count, FILESTATUS Status, REMARK 
, (REPLACE( SUBSTRING_INDEX(SUBSTRING_INDEX('_KL2UP241830116_200127_08082024', '_', 2), '_', -1), '_', '' )) AS batch_no
FROM shipper_qr_code_file_upload_status 
WHERE 1 = 1  AND (CASE WHEN LENGTH(IFNULL(P_SEARCH_TERM,'')) > 0 THEN upper(FILEUPLOADNAME) LIKE CONCAT(CONCAT('%', P_SEARCH_TERM), '%') ELSE TRUE END)
AND (STARTDATE >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y') AND STARTDATE < STR_TO_DATE(P_TO_DATE, '%d/%m/%Y') + INTERVAL 1 DAY
	OR ENDDATE >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y') AND ENDDATE < STR_TO_DATE(P_TO_DATE, '%d/%m/%Y') + INTERVAL 1 DAY)
ORDER BY STARTDATE DESC;*/

		WITH TBL_MAIN AS (
			SELECT 
				ROW_NUMBER() OVER (ORDER BY STARTDATE DESC) AS SR_NO,
				FILEUPLOADNAME AS FileName,
				DATE_FORMAT(STARTDATE, '%d/%m/%Y %r') AS StartDate,
				DATE_FORMAT(ENDDATE, '%d/%m/%Y %r') AS EndDate,
				QRCODECOUNT AS QRCode_Count,
				FILESTATUS AS Status,
				/*CASE 
					WHEN LENGTH(REMARK) > 1500 THEN CONCAT(LEFT(REMARK, 1500), '...  Cont.')
					ELSE REMARK
				END AS */REMARK,
				(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(FILEUPLOADNAME, '_', 2), '_', -1), '_', '')) AS batch_no
			FROM shipper_qr_code_file_upload_status
WHERE 1 = 1  AND (CASE WHEN LENGTH(IFNULL(P_SEARCH_TERM,'')) > 0 THEN upper(FILEUPLOADNAME) LIKE CONCAT(CONCAT('%', P_SEARCH_TERM), '%') ELSE TRUE END)
AND (STARTDATE >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y') AND STARTDATE < STR_TO_DATE(P_TO_DATE, '%d/%m/%Y') + INTERVAL 1 DAY
	OR ENDDATE >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y') AND ENDDATE < STR_TO_DATE(P_TO_DATE, '%d/%m/%Y') + INTERVAL 1 DAY)
		)
        , TBL_SHIPPER_COUNT AS (SELECT SHIPPER_QRCODE_API_SYSID, COUNT(*) total_shipper_qty FROM SHIPPER_QRCODE Z GROUP BY SHIPPER_QRCODE_API_SYSID)
		, TBL_BATCH AS (
			SELECT X.*, (total_shipper_qty * 24) total_bottle_qty  
				FROM (SELECT PLANT_ID, SHIPPER_QRCODE_API_SYSID,
				batch_no, 
				mfg_date, 
				expiry_date, 
				eventtime, 
				-- (SELECT COUNT(*) CNT FROM SHIPPER_QRCODE Z WHERE X.PLANT_ID = Z.PLANT_ID AND X.SHIPPER_QRCODE_API_SYSID = Z.SHIPPER_QRCODE_API_SYSID GROUP BY SHIPPER_QRCODE_API_SYSID) total_shipper_qty  
				(SELECT total_shipper_qty FROM TBL_SHIPPER_COUNT Z WHERE X.SHIPPER_QRCODE_API_SYSID = Z.SHIPPER_QRCODE_API_SYSID )  total_shipper_qty  
            FROM shipper_qrcode_api X
			WHERE  batch_no IN (SELECT DISTINCT batch_no FROM TBL_MAIN)) X
        /*
			SELECT 
				batch_no, 
				mfg_date, 
				expiry_date, 
				eventtime, 
				total_shipper_qty 
			FROM shipper_qrcode_api 
			WHERE batch_no IN (SELECT batch_no FROM TBL_MAIN)*/
		)
		SELECT 
			M.SR_NO,
			M.FileName,
			M.StartDate,
			M.EndDate,
			#M.QRCode_Count,
			M.Status,
			M.REMARK,
            B.batch_no,
			B.mfg_date,
			B.expiry_date,
			#B.eventtime,
			B.total_shipper_qty,
			B.total_bottle_qty QRCode_Count
		FROM 
			TBL_MAIN M
		LEFT JOIN 
			TBL_BATCH B ON M.batch_no = B.batch_no
		GROUP BY M.SR_NO,
			M.FileName,
			M.StartDate,
			M.EndDate,
			#M.QRCode_Count,
			M.Status,
			M.REMARK,
            B.batch_no,
			B.mfg_date,
			B.expiry_date,
			#B.eventtime,
			B.total_shipper_qty,
			B.total_bottle_qty;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_REPORT_DISPATCH_SUMMARY_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_REPORT_DISPATCH_SUMMARY_NEW`(
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

SELECT TEMP_PAGE_TITLE AS MAIN_HEADER, (SELECT PLANT_NAME FROM PLANT_MASTER WHERE PLANTID = P_PLANT_ID LIMIT 1) AS PLANT_NAME;


WITH TBL_MAIN AS (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
                    , X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
                    , X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, Y.DI_NO, Y.PLANT_CD
                    , Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
            FROM fg_gate_in_out X, 
            (SELECT Z.* FROM mda_header Z
                WHERE Z.PLANT_ID = P_PLANT_ID
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
SELECT DISTINCT X.PLANT_ID, PL.Plant_Name, PL.PlantAddress , X.STATION_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, X.MDA_NO, X.VEHICLE_NO, MB.BATCH_NO, MB.MFG_DATE, MB.Shipper_Qty, MB.Bottle_Qty
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_REPORT_GATE_IN_OUT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_REPORT_GATE_IN_OUT`(
IN P_SEARCHTERM VARCHAR(20),
IN P_TYPE VARCHAR(20),
IN P_PLANT_ID BIGINT
)
BEGIN



/*
WITH TBL_MAIN AS (SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, MDA_DT, TRANS_SYS_ID, INWARD_SYS_ID
					, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION
					, RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD, IS_GOODS_TRANSFER
					, DI_NO, PLANT_CD, WH_CD, PARTY_NAME, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, OUT_TIME, desp_place
						FROM (
					SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID,  Z.MDA_SYS_ID,  Z.MDA_NO,  Z.VEHICLE_NO,  Z.MDA_DT,  Z.TRANS_SYS_ID
						, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
						, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER,  Z.DI_NO,  Z.PLANT_CD
						,  Z.WH_CD,  Z.PARTY_NAME,  Z.DIST,  Z.BAG_NOS,  Z.NETT_QTY,  Z.GROSS_QTY,  Z.ECHIT_NO,  Z.GST_NO,  Z.OUT_TIME,  Z.desp_place
								FROM fg_gate_in_out X
								INNER JOIN mda_header Z ON Z.PLANT_ID = X.PLANT_ID AND COALESCE(X.CANCEL_GATE_IN, 0) = 0
                                AND (CASE WHEN IFNULL(00,0) > 0 OR IFNULL(P_SEARCHTERM,'') != '' 
																THEN TRUCK_NO = VEHICLE_NO 
																WHEN IFNULL(00,0) = 0 THEN Z.MDA_SYS_ID = X.MDA_SYS_ID
                                                                ELSE FALSE END)
							-- AND Z.OUT_TIME IS NULL #(CASE WHEN IFNULL(0,0) = 1 THEN Z.OUT_TIME IS NULL ELSE TRUE END)
					WHERE X.PLANT_ID = P_PLANT_ID AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_IN_DT IS NOT NULL -- AND X.GATE_OUT_DT IS NULL AND Z.OUT_TIME IS NULL
					AND ((Z.MDA_NO, DATE_FORMAT(Z.MDA_DT, '%d/%m/%Y')) IN (SELECT MHZ.MDA_NO, DATE_FORMAT(MHZ.MDA_DT, '%d/%m/%Y') FROM mda_header MHZ WHERE MHZ.MDA_NO = P_SEARCHTERM)
					OR (CASE WHEN IFNULL(P_SEARCHTERM,'') != '' THEN X.TRUCK_NO = P_SEARCHTERM
							  WHEN IFNULL(00,0) > 0 THEN X.GATE_SYS_ID = 00
							  ELSE TRUE END))
							) M_G
					) */
/*WITH TBL_MAIN AS (select gio.PLANT_ID, STATION_ID,  gio.GATE_SYS_ID,  gio.MDA_SYS_ID, mh.MDA_NO, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, mh.MDA_DT, TRANS_SYS_ID, INWARD_SYS_ID
					, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION
					, RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD, IS_GOODS_TRANSFER
					, DI_NO, PLANT_CD, WH_CD, PARTY_NAME, DIST, md.BAG_NOS, md.NETT_QTY, md.GROSS_QTY, ECHIT_NO, GST_NO, OUT_TIME, desp_place
from fg_gate_in_out gio 
join mda_header mh on gio.PLANT_ID = mh.PLANT_ID and find_in_set(mh.MDA_SYS_ID,gio.MDA_SYS_IDS) > 0 
left join mda_detail md on md.PLANT_ID = mh.PLANT_ID and md.MDA_SYS_ID = mh.MDA_SYS_ID 
WHERE MH.MDA_NO = IFNULL(P_SEARCHTERM,'') AND IFNULL(CANCEL_GATE_IN, 0) = 0
order by gio.PLANT_ID,gio.GATE_IN_DT desc,gio.GATE_OUT_DT desc,mh.MDA_NO desc
)
SELECT X.PLANT_ID, PL.PlantAddress, X.STATION_ID, X.GATE_SYS_ID ID, X.MDA_SYS_ID, X.MDA_NO, X.VEHICLE_NO
, DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(X.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
, X.TRANS_SYS_ID, X.INWARD_SYS_ID
, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD
, X.IS_GOODS_TRANSFER, NULL AS IS_UNLOAD_TRUCK, NULL AS VENDOR_SYS_ID, NULL AS CUST_SITE_CD, NULL AS SITE_NAME
, X.DI_NO, X.PLANT_CD, X.WH_CD, X.PARTY_NAME, X.DIST
, Y.PROD_SYS_ID, PRD_CD, PRD_DESC, X.BAG_NOS, CAST((X.BAG_NOS / 24) AS unsigned) AS Required_SHIPPER
, (SELECT COUNT(*) FROM mda_loading Z WHERE Z.MDA_SYS_ID  = X.MDA_SYS_ID)LOADED_SHIPPER
, X.NETT_QTY, X.GROSS_QTY, X.ECHIT_NO, X.GST_NO, X.OUT_TIME, X.desp_place, PL.PLANT_NAME
FROM TBL_MAIN X
LEFT JOIN MDA_DETAIL Y ON Y.MDA_SYS_ID = X.MDA_SYS_ID
LEFT JOIN PRODUCT_MASTER Z ON Z.PROD_SYS_ID = Y.PROD_SYS_ID
LEFT JOIN PLANT_MASTER  PL ON X.PLANT_ID = PL.PLANTID;*/

WITH TBL_MAIN AS (SELECT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO
, DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
, DATE_FORMAT(Y.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT, DATE_FORMAT(Y.OUT_TIME, '%d/%m/%Y %H:%i') AS OUT_TIME, Y.desp_place
, Y.TRANS_SYS_ID, X.INWARD_SYS_ID
, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD
, X.IS_GOODS_TRANSFER
, Y.DI_NO, Y.PLANT_CD, Y.WH_CD, Y.PARTY_NAME, Y.DIST
, Z.PROD_SYS_ID-- , PRD_CD, PRD_DESC
, Z.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO
-- , NULL PLANT_NAME, NULL PlantAddress, NULL AS IS_UNLOAD_TRUCK, NULL AS VENDOR_SYS_ID, NULL AS CUST_SITE_CD, NULL AS SITE_NAME
from fg_gate_in_out X 
join mda_header Y on X.PLANT_ID = Y.PLANT_ID and find_in_set(Y.MDA_SYS_ID, X.MDA_SYS_IDS) > 0 
left join mda_detail Z on Z.PLANT_ID = Y.PLANT_ID and Z.MDA_SYS_ID = Y.MDA_SYS_ID 
WHERE Y.MDA_NO = IFNULL(P_SEARCHTERM,'') AND IFNULL(X.CANCEL_GATE_IN, 0) = 0 
order by X.PLANT_ID, X.GATE_IN_DT desc, X.GATE_OUT_DT desc, Y.MDA_NO desc)
SELECT X.PLANT_ID, STATION_ID, GATE_SYS_ID ID, MDA_SYS_ID, MDA_NO, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, MDA_DT, OUT_TIME, desp_place
, TRANS_SYS_ID, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW
, TRUCK_VALIDATION, RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD, IS_GOODS_TRANSFER, DI_NO
, X.PLANT_CD, PLANT_NAME, PlantAddress, WH_CD, PARTY_NAME, DIST, X.PROD_SYS_ID, PRD_CD, PRD_DESC, BAG_NOS, CAST((X.BAG_NOS / 24) AS unsigned) AS Required_SHIPPER
, (SELECT COUNT(*) FROM mda_loading Z WHERE Z.GATE_SYS_ID = X.GATE_SYS_ID AND Z.MDA_SYS_ID  = X.MDA_SYS_ID)LOADED_SHIPPER
, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO 
FROM TBL_MAIN X
LEFT JOIN PRODUCT_MASTER Z ON Z.PROD_SYS_ID = X.PROD_SYS_ID
LEFT JOIN PLANT_MASTER  PL ON X.PLANT_ID = PL.PLANTID;

IF IFNULL(P_TYPE, '') = '' THEN

WITH TBL_MG AS (select GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO, ML.SHIPPER_QR_CODE, ML.Created_DateTime
					, GIO.GATE_IN_DT, GIO.GATE_OUT_DT, GIO.INWARD_SYS_ID, GIO.DRIVER_ID_TYPE
                    , GIO.DRIVER_ID_NUMBER, IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_NAME_NEW, GIO.DRIVER_NAME) AS DRIVER_NAME,  IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_CONTACT_NEW, GIO.DRIVER_CONTACT) AS DRIVER_CONTACT, GIO.DRIVER_CHANGED
					, GIO.MDA_SYS_IDS AS MDA_SYS_IDS, MH.MDA_SYS_ID, MH.MDA_NO
					, MH.PLANT_CD, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
					, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, GIO.RFSYSID
from fg_gate_in_out gio 
join mda_header mh on gio.PLANT_ID = mh.PLANT_ID and find_in_set(mh.MDA_SYS_ID,gio.MDA_SYS_IDS) > 0 
left join mda_detail md on md.PLANT_ID = mh.PLANT_ID and md.MDA_SYS_ID = mh.MDA_SYS_ID 
left join MDA_LOADING ML on ML.GATE_SYS_ID = gio.GATE_SYS_ID AND ML.MDA_SYS_ID = mh.MDA_SYS_ID
WHERE MH.MDA_NO = IFNULL(P_SEARCHTERM,'') AND IFNULL(CANCEL_GATE_IN, 0) = 0
order by gio.PLANT_ID,gio.GATE_IN_DT desc,gio.GATE_OUT_DT desc,mh.MDA_NO desc
)
-- SELECT * FROM TBL_MG
, TBL_MAIN AS (SELECT (ROW_NUMBER() OVER (ORDER BY M_G.Created_DateTime)) AS RNUM, M_G.PLANT_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO
						##########################
						, M_G.SHIPPER_QR_CODE, SQA.BATCH_NO, DATE_FORMAT(SQA.mfg_date, '%d/%m/%Y %H:%i') AS mfg_date, DATE_FORMAT(SQA.expiry_date, '%d/%m/%Y %H:%i') AS expiry_date
                        , SUM(COUNT(M_G.SHIPPER_QR_CODE)) OVER () AS COUNT_ROW#LOADED_SHIPPER 
                        , M_G.Created_DateTime
						FROM TBL_MG M_G
						LEFT JOIN SHIPPER_QRCODE SQ ON SQ.PLANT_ID = M_G.PLANT_ID AND SQ.SHIPPER_QRCODE = M_G.SHIPPER_QR_CODE
						LEFT JOIN SHIPPER_QRCODE_API SQA ON SQA.PLANT_ID = M_G.PLANT_ID AND SQA.SHIPPER_QRCODE_API_SYSID = SQ.SHIPPER_QRCODE_API_SYSID
                        GROUP BY M_G.PLANT_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO
                        , M_G.SHIPPER_QR_CODE, SQA.BATCH_NO, SQA.expiry_date, SQA.mfg_date, M_G.Created_DateTime
)
SELECT RNUM SR_NO, COUNT_ROW, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, VEHICLE_NO, SHIPPER_QR_CODE, BATCH_NO, mfg_date, expiry_date, Created_DateTime FROM TBL_MAIN ;



/*WITH TBL_MG AS (SELECT GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO
					, GIO.GATE_IN_DT, GIO.GATE_OUT_DT, GIO.INWARD_SYS_ID, GIO.DRIVER_ID_TYPE, GIO.DRIVER_ID_NUMBER, IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_NAME_NEW, GIO.DRIVER_NAME) AS DRIVER_NAME,  IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_CONTACT_NEW, GIO.DRIVER_CONTACT) AS DRIVER_CONTACT, GIO.DRIVER_CHANGED
					, GIO.MDA_SYS_IDS AS MDA_SYS_IDS, MH.MDA_SYS_ID, MH.MDA_NO
					, MH.PLANT_CD, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
					, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, GIO.RFSYSID
					FROM fg_gate_in_out GIO
					INNER JOIN mda_header MH ON GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0
					WHERE MH.PLANT_ID = P_PLANT_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
					-- AND GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL
					-- AND IF(IFNULL(P_GATE_SYS_ID,0)= 0, GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL, GIO.GATE_SYS_ID = P_GATE_SYS_ID) 
					AND IF(IFNULL(P_SEARCHTERM,'') = '', TRUE, 
								(GIO.TRUCK_NO = P_SEARCHTERM
								OR 0 < (SELECT COUNT(*) FROM mda_header MHZ WHERE GIO.PLANT_ID = MHZ.PLANT_ID AND MHZ.MDA_NO = P_SEARCHTERM AND FIND_IN_SET(MHZ.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0)
								OR GIO.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,'')))
								)
						)
					AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = GIO.GATE_SYS_ID 
								AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0 AND XZ.GROSS_WT_DT IS NOT NULL)
					ORDER BY MH.PLANT_ID, GIO.GATE_IN_DT DESC)
, TBL_MAIN AS (SELECT (ROW_NUMBER() OVER ()) AS RNUM, M_G.PLANT_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO
						##########################
						, ML.SHIPPER_QR_CODE, SQA.BATCH_NO, DATE_FORMAT(SQA.mfg_date, '%d/%m/%Y %H:%i') AS mfg_date, DATE_FORMAT(SQA.expiry_date, '%d/%m/%Y %H:%i') AS expiry_date
                        , SUM(COUNT(ML.SHIPPER_QR_CODE)) OVER () AS COUNT_ROW#LOADED_SHIPPER 
						FROM TBL_MG M_G
						INNER JOIN MDA_LOADING ML ON ML.MDA_SYS_ID = M_G.MDA_SYS_ID
						LEFT JOIN SHIPPER_QRCODE SQ ON SQ.PLANT_ID = M_G.PLANT_ID AND SQ.SHIPPER_QRCODE = ML.SHIPPER_QR_CODE
						LEFT JOIN SHIPPER_QRCODE_API SQA ON SQA.PLANT_ID = M_G.PLANT_ID AND SQA.SHIPPER_QRCODE_API_SYSID = SQ.SHIPPER_QRCODE_API_SYSID
                        GROUP BY M_G.PLANT_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO
                        , ML.SHIPPER_QR_CODE, SQA.BATCH_NO, SQA.expiry_date, SQA.mfg_date
)
SELECT RNUM SR_NO, COUNT_ROW, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, VEHICLE_NO, SHIPPER_QR_CODE, BATCH_NO, mfg_date, expiry_date FROM TBL_MAIN ;
*/
	/*WITH TBL_MAIN AS (SELECT (ROW_NUMBER() OVER ()) AS RNUM, M_G.PLANT_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO
						##########################
						, ML.SHIPPER_QR_CODE, SQA.BATCH_NO, DATE_FORMAT(SQA.mfg_date, '%d/%m/%Y %H:%i') AS mfg_date, DATE_FORMAT(SQA.expiry_date, '%d/%m/%Y %H:%i') AS expiry_date
                        , SUM(COUNT(ML.SHIPPER_QR_CODE)) OVER () AS COUNT_ROW#LOADED_SHIPPER 
						FROM
                        (SELECT 
									TRIM(SUBSTRING_INDEX(input_string, ',', 1)) AS PLANT_ID,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 2), ',', -1)) AS GATE_SYS_ID,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 3), ',', -1)) AS MDA_SYS_ID,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 4), ',', -1)) AS MDA_NO,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 5), ',', -1)) AS VEHICLE_NO,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 6), ',', -1)) AS MDA_DT,
									TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 7), ',', -1)) AS OUT_TIME
								FROM (SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, '#', n.digit+1), '#', -1)) AS input_string
								FROM (SELECT FN_GATE_IN_OUT_MDA_GET(P_PLANT_ID, 00, 0, P_SEARCHTERM) AS input_string) AS data
								CROSS JOIN (SELECT 0 AS digit UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) AS n 
								WHERE n.digit < LENGTH(input_string) - LENGTH(REPLACE(input_string, '#', '')) + 1) X
						) M_G
						INNER JOIN MDA_LOADING ML ON ML.MDA_SYS_ID = M_G.MDA_SYS_ID
						LEFT JOIN SHIPPER_QRCODE SQ ON SQ.PLANT_ID = M_G.PLANT_ID AND SQ.SHIPPER_QRCODE = ML.SHIPPER_QR_CODE
						LEFT JOIN SHIPPER_QRCODE_API SQA ON SQA.PLANT_ID = M_G.PLANT_ID AND SQA.SHIPPER_QRCODE_API_SYSID = SQ.SHIPPER_QRCODE_API_SYSID
                        WHERE M_G.MDA_NO = P_SEARCHTERM
						GROUP BY M_G.PLANT_ID, M_G.GATE_SYS_ID, M_G.MDA_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO, ML.SHIPPER_QR_CODE, SQA.BATCH_NO, SQA.expiry_date, SQA.mfg_date
		)
		SELECT RNUM SR_NO, COUNT_ROW, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, VEHICLE_NO, SHIPPER_QR_CODE, BATCH_NO, mfg_date, expiry_date FROM TBL_MAIN ;*/
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_REPORT_LOG_SERVICE_FILE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_REPORT_LOG_SERVICE_FILE`(
IN P_FROM_DATE VARCHAR(255))
BEGIN

SELECT ID,MESSAGE, CREATED_DATE FROM log_service where (CREATED_DATE >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y') AND CREATED_DATE < now());

/*
SELECT * FROM user_log_details where LOG_TYPE = 'E' AND PLANT_ID = P_PLANT_ID and
(Created_DateTime >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y') AND Created_DateTime < now());*/


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_REPORT_USER_LOG_FILE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_REPORT_USER_LOG_FILE`(
IN P_FROM_DATE VARCHAR(255))
BEGIN

SELECT ID,MESSAGE, CREATED_DATE FROM log_service where (CREATED_DATE >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y') AND CREATED_DATE < now());

/*
SELECT * FROM user_log_details where LOG_TYPE = 'E' AND PLANT_ID = P_PLANT_ID and
(Created_DateTime >= STR_TO_DATE(P_FROM_DATE, '%d/%m/%Y') AND Created_DateTime < now());*/


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_REPORT_WEIGHT_IN_OUT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_REPORT_WEIGHT_IN_OUT_GET`(
IN P_GATE_SYS_ID INT
, IN P_SEARCHTERM VARCHAR(255)
, IN P_FROMDATE VARCHAR(255)
, IN P_TODATE VARCHAR(255)
, IN P_IS_OUT_TIME_NULL INT
, IN P_PLANT_ID INT)
BEGIN

SET @rownum := 0;

WITH TBL_MAIN AS (SELECT PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS
					FROM fg_gate_in_out
					WHERE PLANT_ID = P_PLANT_ID AND COALESCE(CANCEL_GATE_IN, 0) = 0
                    AND IF(IFNULL(TRIM(P_SEARCHTERM),'') = '', TRUE, TRUCK_NO = TRIM(P_SEARCHTERM)) 
					AND (CASE WHEN IFNULL(TRIM(P_FROMDATE),'') != '' THEN GATE_IN_DT >= STR_TO_DATE(P_FROMDATE, '%d/%m/%Y') 
							  WHEN IFNULL(TRIM(P_TODATE),'') != '' THEN GATE_OUT_DT < (STR_TO_DATE(P_TODATE, '%d/%m/%Y') + INTERVAL 1 DAY) 
							ELSE TRUE END)
					ORDER BY PLANT_ID, GATE_SYS_ID DESC
)
, TBL_MAIN_ AS (SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO
	, GROUP_CONCAT(DISTINCT MDA_NO ORDER BY MDA_SYS_ID SEPARATOR ',') AS MDA_NO
	, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, MAX(TRANS_SYS_ID)TRANS_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
	, GROUP_CONCAT(DISTINCT PLANT_CD ORDER BY PLANT_CD SEPARATOR ',') AS PLANT_CD 
	-- , GROUP_CONCAT(DISTINCT TRANS_SYS_ID ORDER BY TRANS_SYS_ID SEPARATOR ',') AS TRANS_SYS_IDS
	, GROUP_CONCAT(DISTINCT WH_CD ORDER BY WH_CD SEPARATOR ',') AS WH_CD 
	, GROUP_CONCAT(DISTINCT PARTY_NAME ORDER BY PARTY_NAME SEPARATOR ',') AS PARTY_NAME 
	, GROUP_CONCAT(DISTINCT DIST ORDER BY DIST SEPARATOR ',') AS DIST 
	, GROUP_CONCAT(DISTINCT desp_place ORDER BY desp_place SEPARATOR ',') AS desp_place 
	, GROUP_CONCAT(DISTINCT RFSYSID ORDER BY RFSYSID SEPARATOR ',') AS RFSYSID 
	FROM (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, X.MDA_SYS_IDS, MH.MDA_SYS_ID, MH.MDA_NO, X.TRUCK_NO VEHICLE_NO, MH.PLANT_CD
		, GATE_IN_DT, GATE_OUT_DT, MH.MDA_DT
		, DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, IFNULL(X.DRIVER_NAME, X.DRIVER_NAME_NEW)DRIVER_NAME, IFNULL(X.DRIVER_CONTACT, X.DRIVER_CONTACT_NEW)DRIVER_CONTACT, X.DRIVER_CHANGED -- , X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
		, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DIST, MH.desp_place, X.RFSYSID, INWARD_SYS_ID
		FROM fg_gate_in_out X
		INNER JOIN mda_header MH ON MH.PLANT_ID = X.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, X.MDA_SYS_IDS) > 0
		WHERE (X.PLANT_ID, X.GATE_SYS_ID) IN (SELECT PLANT_ID, GATE_SYS_ID FROM TBL_MAIN)
        -- AND (CASE WHEN IFNULL(P_IS_OUT_TIME_NULL,0) = 1 THEN MH.OUT_TIME IS NULL AND X.GATE_OUT_DT IS NULL ELSE TRUE END)
        ORDER BY 3 DESC, 4 DESC
	) X
	GROUP BY PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
)
SELECT (ROW_NUMBER() OVER (ORDER BY M_G.GATE_IN_DT DESC, M_G.GATE_OUT_DT DESC)) AS SR_NO
, M_G.PLANT_ID, M_G.STATION_ID, M_G.GATE_SYS_ID, M_G.MDA_NO, M_G.VEHICLE_NO TRUCK_NO, M_G.INWARD_SYS_ID, 'FG' Purpose_Type
, DATE_FORMAT(M_G.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT-- , DATE_FORMAT(M_G.MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
, (SELECT CAST((SUM(BAG_NOS) / 24) AS unsigned) FROM mda_detail Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND FIND_IN_SET(Z.MDA_SYS_ID, M_G.MDA_SYS_IDS) > 0) Required_Shipper
, (SELECT COUNT(*) FROM MDA_LOADING Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND Z.GATE_SYS_ID = M_G.GATE_SYS_ID AND FIND_IN_SET(Z.MDA_SYS_ID, M_G.MDA_SYS_IDS) > 0) Loaded_Shipper
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


/*WITH TBL_MAIN AS (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, MH.MDA_SYS_ID, MH.MDA_NO, X.TRUCK_NO VEHICLE_NO, MH.PLANT_CD
		, GATE_IN_DT, GATE_OUT_DT, MH.MDA_DT
		, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
		, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DIST,MH.desp_place, X.RFSYSID
		FROM fg_gate_in_out X
		INNER JOIN mda_header MH ON MH.PLANT_ID = X.PLANT_ID AND (CASE WHEN IFNULL(P_GATE_SYS_ID,0) > 0 OR IFNULL(P_SEARCHTERM,'') != '' THEN TRUCK_NO = VEHICLE_NO
																		WHEN IFNULL(P_GATE_SYS_ID,0) = 0 THEN  MH.MDA_SYS_ID = X.MDA_SYS_ID 
                                                                        ELSE FALSE END)
									AND (CASE WHEN IFNULL(P_IS_OUT_TIME_NULL,0) = 1 THEN MH.OUT_TIME IS NULL AND X.GATE_OUT_DT IS NULL ELSE TRUE END)
		WHERE X.PLANT_ID = P_PLANT_ID AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_IN_DT IS NOT NULL 
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
, MD.BAG_NOS, CAST((MD.BAG_NOS / 24) AS unsigned) Required_Shipper, (SELECT COUNT(*) FROM MDA_LOADING Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND Z.GATE_SYS_ID = M_G.GATE_SYS_ID AND Z.MDA_SYS_ID = M_G.MDA_SYS_ID) Loaded_Shipper
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
) X;*/
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_RFID_DELETE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RFID_DELETE`(
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
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

    SET P_RESULT := 'E|Opps!... Something went wrong. Please contact system administrator|0';

    -- IF NVL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
    --     SET P_RESULT := 'E|You are not authorized to perform this operation.|0';
    -- ELSE
        IF P_ID > 0 THEN
            -- UPDATE RFID_MASTER SET IS_ACTIVE = 'N' WHERE RFSYSID = P_ID;
			DELETE FROM RFID_MASTER WHERE RFSYSID = P_ID;
            SET P_RESULT := 'S|Record deleted successfully|';
        END IF;
    -- END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_RFID_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RFID_GET`(
    IN P_ID INT,
    IN P_ISACTIVE VARCHAR(255),
    IN P_RFID_NO VARCHAR(255),
    IN P_RFID_CODE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN
IF P_ID < 0 THEN
	   
    IF P_ID < 0 AND IFNULL(P_RFID_NO, '') = '' AND IFNULL(P_RFID_CODE, '') = '' THEN
		SELECT CONCAT('AN', LPAD((COALESCE(MAX(RFSYSID),0) + 1), 5, '0')) AS SRNO 
		FROM RFID_MASTER 
		WHERE PLANT_ID = P_PLANT_ID;
    ELSE
		SELECT RFSYSID ID, RFIDSRNO SRNO, RFIDCODE CODE, STATUS, REASONFOREDIT, STATION_ID, PLANT_ID
		FROM RFID_MASTER 
		WHERE RFIDSRNO = IFNULL(P_RFID_NO, '') OR RFIDCODE = IFNULL(P_RFID_CODE, '');
	END IF;

ELSEIF P_ID > 0 AND IFNULL(P_RFID_NO, '') = '' AND IFNULL(P_RFID_CODE, '') = '' THEN
	SELECT RFSYSID ID, RFIDSRNO SRNO, RFIDCODE CODE, STATUS, REASONFOREDIT, STATION_ID, PLANT_ID#, IF(X.IS_ACTIVE='Y', 1, 0) ISACTIVE  
	FROM RFID_MASTER X 
	WHERE X.RFSYSID = P_ID 
	#AND X.IS_ACTIVE = IF(COALESCE(P_ISACTIVE, '')='', X.IS_ACTIVE, P_ISACTIVE) 
	AND PLANT_ID = P_PLANT_ID;
ELSEIF P_ID = 0 AND IFNULL(P_RFID_NO, '') = '' AND IFNULL(P_RFID_CODE, '') = '' THEN
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_RFID_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RFID_SAVE`(
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
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

SELECT COUNT(*) INTO TEMP_NUM FROM RFID_MASTER X WHERE X.RFIDCODE = P_RFIDCODE AND X.RFSYSID != P_ID;

IF COALESCE(TEMP_NUM, 0) > 0 THEN
SET P_RESULT = 'E|RFID is already exist.|0';    
ELSEIF P_ID > 0 THEN

UPDATE RFID_MASTER SET RFIDCODE = P_RFIDCODE, RFIDSRNO = P_RFIDSRNO, STATUS = P_STATUS, REASONFOREDIT = P_REASONFOREDIT, STATION_ID = P_STATION_ID-- , IS_ACTIVE = P_ISACTIVE
WHERE RFSYSID = P_ID;

SET P_RESULT = 'S|Record updated successfully|';

ELSE

SELECT COALESCE(MAX(RFSYSID), 0) + 1 INTO TEMP_NUM FROM RFID_MASTER;

INSERT INTO RFID_MASTER (RFSYSID, RFIDSRNO, RFIDCODE, STATUS, REASONFOREDIT, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME)
VALUES(TEMP_NUM, P_RFIDSRNO, P_RFIDCODE, P_STATUS, P_REASONFOREDIT, P_STATION_ID, P_PLANT_ID, P_USER_ID, NOW());

SET P_RESULT = 'S|Record saved successfully|';
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_RM_GATE_IN_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RM_GATE_IN_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_RM_GATE_OUT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RM_GATE_OUT_GET`(
    IN P_ID INT
    ,IN P_SEARCHTERM VARCHAR(255)    
    ,IN P_PLANT_ID INT
    /*,IN P_ISACTIVE VARCHAR(255)
    ,IN P_USER_ID INT
    ,IN P_ROLE_ID INT
    ,IN P_MENU_ID INT*/
)
BEGIN
	DECLARE TEMP_STATION_ID INT DEFAULT 7;
    
    
WITH TBL_MAIN AS 
(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.PO_SYS_ID, Y.PO_NO, Y.TRUCK_NO, Y.PO_DATE, Y.TRANS_SYS_ID, X.TRANSPORTER_NAME
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.IS_UNLOAD_TRUCK, (select PlantCode from plant_master where PlantID = Y.PLANT_ID) PLANT_CD
				FROM RM_GATE_IN_OUT X, 
				(SELECT Z.* FROM PO_HEADER Z
					WHERE Z.PLANT_ID = P_PLANT_ID
					AND ((Z.PO_SYS_ID IN (SELECT XZ.PO_SYS_ID FROM RM_GATE_IN_OUT XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'')) OR  XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (126, 2))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND P_ID = 0, 1, 0))
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.PO_SYS_ID = Y.PO_SYS_ID AND 1 = (CASE WHEN IFNULL(P_SEARCHTERM,'') = '' THEN (CASE WHEN COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL THEN 1 ELSE 0 END ) ELSE 1 END ) 
				AND 0 < (SELECT COUNT(*) FROM RM_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0)
	)
SELECT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID Gate_In_Id, X.PO_SYS_ID COMMON_SYS_ID, X.PO_NO COMMON_NO, X.TRUCK_NO TRUCK_NO
, DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(X.PO_DATE, '%d/%m/%Y %H:%i') AS PO_DATE
, X.TRANS_SYS_ID, X.TRANSPORTER_NAME AS TRANSPORTER_NAME_NEW, (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) AS TRANSPORTER_NAME
, X.INWARD_SYS_ID, (SELECT Z.INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = IF(X.INWARD_SYS_ID = 2, 126, X.INWARD_SYS_ID) LIMIT 1) AS INWARD_TYPE
, X.DRIVER_ID_TYPE, (SELECT Z.LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON
, X.IS_UNLOAD_TRUCK, X.PLANT_CD PLANT_CODE -- , X.WH_CD, X.PARTY_NAME, X.DIST, X.BAG_NOS, X.NETT_QTY, X.GROSS_QTY, X.ECHIT_NO, X.GST_NO, X.OUT_TIME, X.desp_place
, ZZ.WT_SYS_ID, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.TARE_WT_MANUALLY, ZZ.TARE_WT_NOTE
, ZZ.GROSS_WT, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, ZZ.GROSS_WT_MANUALLY, ZZ.GROSS_WT_NOTE, ZZ.NET_WT
FROM TBL_MAIN X 
LEFT JOIN RM_WEIGHMENT_DETAIL ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID AND ZZ.PLANT_ID = X.PLANT_ID
AND ZZ.TARE_WT IS NOT NULL AND COALESCE(ZZ.TARE_WT,0) > 0 AND ZZ.GROSS_WT_DT IS NOT NULL AND COALESCE(ZZ.GROSS_WT,0) > 0;
   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_RM_GATE_OUT_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RM_GATE_OUT_SAVE`(
    IN P_ID INT,
    IN P_PO_SYS_ID INT,
    IN P_GATE_OUT_NOTE VARCHAR(255),
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
    DECLARE TEMP_PO_NO VARCHAR(255);
    DECLARE TEMP_GATE_OUT_DT VARCHAR(255) DEFAULT NULL;
    DECLARE TEMP_INVOICE_QR_CODE VARCHAR(255) DEFAULT NULL;
      
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SELECT X.RFSYSID, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_RFID, TEMP_GATE_OUT_DT FROM RM_GATE_IN_OUT X WHERE X.GATE_SYS_ID = P_ID AND X.PO_SYS_ID = P_PO_SYS_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NULL THEN
			
            SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0'); 
            
        END IF;
        
    END;

	SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
	
    IF P_ID > 0 THEN

        
        SELECT X.RFSYSID, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_RFID, TEMP_GATE_OUT_DT FROM RM_GATE_IN_OUT X WHERE X.GATE_SYS_ID = P_ID AND X.PO_SYS_ID = P_PO_SYS_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NULL THEN
        
            UPDATE RM_GATE_IN_OUT 
            SET GATE_OUT_DT = CURRENT_TIMESTAMP(), IS_UNLOAD_TRUCK = 1
            WHERE GATE_SYS_ID = P_ID AND COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND STATION_ID = TEMP_STATION_ID AND PLANT_ID = P_PLANT_ID;
			
            /*UPDATE PO_header PO_U
			INNER JOIN RM_GATE_IN_OUT GIO ON PO_U.PLANT_ID = GIO.PLANT_ID AND GIO.TRUCK_NO = PO_U.VEHICLE_NO
			INNER JOIN PO_header PO ON PO.PLANT_ID = GIO.PLANT_ID AND GIO.TRUCK_NO = PO.VEHICLE_NO
			SET PO_U.OUT_TIME = NOW()
			WHERE GIO.PLANT_ID = P_PLANT_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0 AND GIO.GATE_IN_DT IS NOT NULL AND GIO.GATE_OUT_DT IS NULL AND PO.OUT_TIME IS NULL AND PO_U.OUT_TIME IS NULL
			AND GIO.GATE_SYS_ID = P_ID AND PO_U.PLANT_ID = PO.PLANT_ID AND PO.PO_SYS_ID = PO_U.PO_SYS_ID;*/

			SELECT PO_NO INTO TEMP_PO_NO FROM PO_header Z WHERE PO_SYS_ID = P_PO_SYS_ID AND PLANT_ID = P_PLANT_ID LIMIT 1;           
			
            COMMIT;
            
            UPDATE RFID_MASTER SET STATUS = 'Active' 
            WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM RM_GATE_IN_OUT X
								INNER JOIN PO_header Y ON Y.PLANT_ID = X.PLANT_ID AND Y.PO_SYS_ID = X.PO_SYS_ID
								WHERE GATE_OUT_DT IS NULL AND DATE_FORMAT(X.GATE_IN_DT, '%Y') = '2024'
								ORDER BY 1 DESC) 
			AND PLANT_ID = P_PLANT_ID;
            
            COMMIT;
            
            SET P_RESULT := 'S|Record saved successfully|0';  
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_RM_UNLOADING_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RM_UNLOADING_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
)
BEGIN
    SELECT DISTINCT 
        X.PLANT_ID, 
        X.STATION_ID, 
        X.GATE_SYS_ID,
        Y.PO_DTL_SYS_ID,  
        Y.PO_SYS_ID, 
        Y.PO_LINE_NO, 
        Y.LINE_DESC, 
        Y.UMO, 
        Y.LINE_QTY, 
        X.TRANSPORTER_NAME,
        X.GATE_IN_DT, 
        X.GATE_OUT_DT, 
        X.INWARD_SYS_ID, 
        X.RFSYSID, 
        (SELECT ZX.RFIDSRNO 
         FROM RFID_MASTER ZX 
         WHERE ZX.RFSYSID = X.RFSYSID) AS RFIDSRNO, 
        (SELECT PlantCode 
         FROM plant_master 
         WHERE PlantID = Y.PLANT_ID) AS PLANT_CD
    FROM rm_gate_in_out X
    JOIN (
        SELECT Z.* 
        FROM po_detail Z
        WHERE Z.PLANT_ID = P_PLANT_ID
        AND Z.PO_SYS_ID = (
            SELECT XZ.PO_SYS_ID 
            FROM rm_gate_in_out XZ
            WHERE XZ.PO_SYS_ID = (
                SELECT ZX.PO_SYS_ID 
                FROM po_header ZX
                WHERE ZX.PO_NO = IFNULL(P_SEARCHTERM, '')
            ) 
            AND XZ.INWARD_SYS_ID IN (126, 2)
        )
    ) Y ON X.PLANT_ID = Y.PLANT_ID 
    AND X.PO_SYS_ID = Y.PO_SYS_ID
    WHERE COALESCE(X.CANCEL_GATE_IN, 0) = 0 
    AND X.GATE_OUT_DT IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_RM_UNLOADING_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RM_UNLOADING_SAVE`(
IN P_ID INT, 
IN P_PO_ID INT, 
IN P_RECEIVE_QTY DECIMAL, 
IN P_RECEIVE_UOM VARCHAR(255),
IN P_SHORT_QTY DECIMAL, 
IN P_PLANT_ID INT, 
OUT P_RESULT VARCHAR(255)
)
BEGIN
DECLARE TEMP_NUM INT DEFAULT 0;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';
END;

SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

IF P_ID > 0 THEN

	UPDATE po_detail SET RECEIVE_QTY = P_RECEIVE_QTY, RECEIVE_UOM = P_RECEIVE_UOM, SHORT_QTY = P_SHORT_QTY
	WHERE PO_DTL_SYS_ID = P_ID AND PLANT_ID = P_PLANT_ID;

SET P_RESULT = 'S|Record saved successfully|';

END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_RM_WEIGHMENT_IN_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RM_WEIGHMENT_IN_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    -- IN P_ISACTIVE VARCHAR(10),
    IN P_PLANT_ID INT
    -- IN P_USER_ID INT,
    -- IN P_ROLE_ID INT,
    -- IN P_MENU_ID INT
)
BEGIN
    
    WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.PO_SYS_ID, Y.PO_NO, Y.TRUCK_NO, Y.PO_DATE, Y.TRANS_SYS_ID, X.TRANSPORTER_NAME
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFSYSID = X.RFSYSID) RFIDSRNO, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.IS_UNLOAD_TRUCK, (select PlantCode from plant_master where PlantID = Y.PLANT_ID) PLANT_CD
		-- , Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
				FROM rm_gate_in_out X, 
				(SELECT Z.* FROM po_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID -- AND GATE_OUT_DT IS NULL
					AND ((-- Z.TRUCK_NO = P_SEARCHTERM
							-- OR Z.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM po_header XZ WHERE XZ.PO_NO = P_SEARCHTERM OR XZ.PO_SYS_ID = IFNULL(P_ID,0)) 
							-- OR Z.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM rm_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID IN (126, 2))
                            Z.PO_SYS_ID IN (SELECT XZ.PO_SYS_ID FROM rm_gate_in_out XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,''))) OR  XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (126, 2))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0)
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID 
                AND X.PO_SYS_ID = Y.PO_SYS_ID
                -- AND X.TRUCK_NO = Y.TRUCK_NO 
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 
                AND X.GATE_OUT_DT IS NULL 
                AND X.GATE_IN_DT IS NOT NULL
				-- AND 0 < (SELECT COUNT(*) FROM rm_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.GROSS_WT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0) -- AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) = 0)
	)
	SELECT X.PLANT_ID, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.PO_SYS_ID COMMON_SYS_ID, X.PO_NO COMMON_NO, X.TRUCK_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(PO_DATE, '%d/%m/%Y %H:%i') AS PO_DATE
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION, X.RFSYSID, X.RFIDSRNO
	, X.TRANS_SYS_ID, X.TRANSPORTER_NAME AS TRANSPORTER_NAME_NEW , (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.GROSS_WT, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT
	FROM TBL_MAIN X 
	LEFT JOIN rm_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
	-- WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL
	ORDER BY X.GATE_IN_DT DESC, X.PO_DATE DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_RM_WEIGHMENT_IN_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RM_WEIGHMENT_IN_SAVE`(
    IN P_ID INT, 
    IN P_INWARD_SYS_ID INT, 
    IN P_GROSS_WT DECIMAL(10,2), 
    IN P_GROSS_WT_MANUALLY INT, 
    IN P_GROSS_WT_NOTE VARCHAR(255), 
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
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;


    -- Initial default result
    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    IF P_ID > 0 THEN
        -- Check for conditions in FG_GATE_IN_OUT
        IF COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 2 THEN
        
        SELECT COUNT(*) INTO TEMP_NUM FROM rm_weighment_detail X WHERE X.GATE_SYS_ID = P_ID;
        
        END IF;


            IF IFNULL(P_GROSS_WT, 0) <= 0 THEN
                SET P_RESULT = 'E|Gross weight require.|0';
            ELSE

				IF COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 2 AND COALESCE(TEMP_NUM, 0) = 0 THEN
				
					-- Get the next WT_SYS_ID
					SELECT COALESCE(MAX(WT_SYS_ID), 0) + 1 INTO TEMP_NUM FROM rm_weighment_detail;

					-- Insert the record
					INSERT INTO rm_weighment_detail (WT_SYS_ID, GATE_SYS_ID, GROSS_WT, GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME) 
					VALUES (TEMP_NUM, P_ID, P_GROSS_WT, NOW(), 1, P_GROSS_WT_NOTE, 7, P_PLANT_ID, P_USER_ID, NOW());

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
/*!50003 DROP PROCEDURE IF EXISTS `PC_RM_WEIGHMENT_IN_SLIP_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RM_WEIGHMENT_IN_SLIP_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
)
BEGIN
    
    WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.PO_SYS_ID, Y.PO_NO, Y.TRUCK_NO, Y.PO_DATE, Y.TRANS_SYS_ID, X.TRANSPORTER_NAME
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFSYSID = X.RFSYSID) RFIDSRNO, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.IS_UNLOAD_TRUCK, (select PlantCode from plant_master where PlantID = Y.PLANT_ID) PLANT_CD
				FROM rm_gate_in_out X, 
				(SELECT Z.* FROM po_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID -- AND GATE_OUT_DT IS NULL
					AND ((Z.PO_SYS_ID IN (SELECT XZ.PO_SYS_ID FROM rm_gate_in_out XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'')) OR  XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (126, 2))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0))
				) Y WHERE X.PLANT_ID = Y.PLANT_ID 
                AND X.PO_SYS_ID = Y.PO_SYS_ID
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 
                AND X.GATE_OUT_DT IS NULL 
                AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM rm_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID) -- AND XZ.GROSS_WT IS NULL AND IFNULL(XZ.GROSS_WT,0) AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0)
	)
	SELECT X.PLANT_ID, PLANT.Plant_Name, PLANT.PlantAddress, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.PO_SYS_ID COMMON_SYS_ID, X.PO_NO COMMON_NO, X.TRUCK_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(PO_DATE, '%d/%m/%Y %H:%i') AS PO_DATE
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION, X.RFSYSID, X.RFIDSRNO
	, X.TRANS_SYS_ID, X.TRANSPORTER_NAME AS TRANSPORTER_NAME_NEW, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT,ZZ.TARE_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.GROSS_WT, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, ZZ.GROSS_WT_NOTE
	FROM TBL_MAIN X 
	LEFT JOIN rm_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
    LEFT JOIN PLANT_MASTER PLANT ON PLANT.PlantID = X.PLANT_ID
	#WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL
	ORDER BY X.GATE_IN_DT DESC, X.PO_DATE DESC;
    
   SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.PO_SYS_ID, Y.PO_LINE_NO, Y.LINE_DESC, 'KG' UMO, Y.LINE_QTY		
				FROM rm_gate_in_out X, 
				(SELECT Z.* FROM po_detail Z
					WHERE Z.PLANT_ID = P_PLANT_ID
					AND ((Z.PO_SYS_ID IN (SELECT XZ.PO_SYS_ID FROM rm_gate_in_out XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'')) OR  XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (126, 2))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0))
				) Y WHERE X.PLANT_ID = Y.PLANT_ID 
                AND X.PO_SYS_ID = Y.PO_SYS_ID
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 
                AND X.GATE_OUT_DT IS NULL 
                AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM rm_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_RM_WEIGHMENT_OUT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RM_WEIGHMENT_OUT_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    -- IN P_ISACTIVE VARCHAR(10),
    IN P_PLANT_ID INT
    -- IN P_USER_ID INT,
    -- IN P_ROLE_ID INT,
    -- IN P_MENU_ID INT
)
BEGIN
    
    WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.PO_SYS_ID, Y.PO_NO, Y.TRUCK_NO, Y.PO_DATE, Y.TRANS_SYS_ID, X.TRANSPORTER_NAME
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFSYSID = X.RFSYSID) RFIDSRNO, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.IS_UNLOAD_TRUCK, (select PlantCode from plant_master where PlantID = Y.PLANT_ID) PLANT_CD
		-- , Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
				FROM rm_gate_in_out X, 
				(SELECT Z.* FROM po_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID -- AND GATE_OUT_DT IS NULL
					AND ((-- Z.TRUCK_NO = P_SEARCHTERM
							-- OR Z.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM po_header XZ WHERE XZ.PO_NO = P_SEARCHTERM OR XZ.PO_SYS_ID = IFNULL(P_ID,0)) 
							-- OR Z.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM rm_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID IN (126, 2))
                            Z.PO_SYS_ID IN (SELECT XZ.PO_SYS_ID FROM rm_gate_in_out XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,''))) OR XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (126, 2))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0)
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID 
                AND X.PO_SYS_ID = Y.PO_SYS_ID
                -- AND X.TRUCK_NO = Y.TRUCK_NO 
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 
                AND X.GATE_OUT_DT IS NULL 
                AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM rm_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.GROSS_WT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0 AND XZ.TARE_WT_DT IS NULL AND IFNULL(XZ.TARE_WT,0) = 0)
	)
	SELECT X.PLANT_ID, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.PO_SYS_ID COMMON_SYS_ID, X.PO_NO COMMON_NO, X.TRUCK_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(PO_DATE, '%d/%m/%Y %H:%i') AS PO_DATE
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION, X.RFSYSID, X.RFIDSRNO
	, X.TRANS_SYS_ID, X.TRANSPORTER_NAME AS TRANSPORTER_NAME_NEW, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.GROSS_WT, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT
	FROM TBL_MAIN X 
	LEFT JOIN rm_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
	-- WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL
	ORDER BY X.GATE_IN_DT DESC, X.PO_DATE DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_RM_WEIGHMENT_OUT_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RM_WEIGHMENT_OUT_SAVE`(
    IN P_ID INT, 
    IN P_GATE_IN_ID INT, 
    IN P_INWARD_SYS_ID INT, 
    IN P_TARE_WT DECIMAL(10,2), 
    IN P_NET_WT_MANUALLY INT, 
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
    DECLARE TEMP_GROSS_WT DECIMAL(10,2);
    DECLARE TEMP_INWARD_SYS_ID INT;
    DECLARE TEMP_STATION_ID INT DEFAULT 7;
          
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;


    -- Initial default result
    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

	IF P_ID > 0 AND P_GATE_IN_ID > 0 THEN
        -- Fetch INWARD_SYS_ID
        SELECT INWARD_SYS_ID INTO TEMP_INWARD_SYS_ID
        FROM rm_gate_in_out
        WHERE GATE_SYS_ID = P_GATE_IN_ID AND IFNULL(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND STATION_ID = TEMP_STATION_ID;

        -- IF IFNULL(TEMP_INWARD_SYS_ID, 0) > 0 AND TEMP_INWARD_SYS_ID = 125 THEN
            -- Fetch TARE_WT
            SELECT IFNULL(GROSS_WT, 0) INTO TEMP_GROSS_WT
            FROM rm_weighment_detail
            WHERE WT_SYS_ID = P_ID AND GATE_SYS_ID = P_GATE_IN_ID;

            -- Validate gross weight
            IF IFNULL(P_TARE_WT, 0) > IFNULL(TEMP_GROSS_WT, 0) THEN
                SET P_RESULT = 'E|Tare weight is not more than Gross weight.|0';
            ELSE
                -- Update record
                UPDATE rm_weighment_detail
                SET TARE_WT = P_TARE_WT,
                    TARE_WT_DT = NOW(),
                    TARE_WT_MANUALLY = 1,
                    TARE_WT_NOTE = P_TARE_WT_NOTE,
                    NET_WT = (IFNULL(TEMP_GROSS_WT, 0) - IFNULL(P_TARE_WT, 0))
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_RM_WEIGHMENT_OUT_SLIP_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_RM_WEIGHMENT_OUT_SLIP_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
)
BEGIN
    
    WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.PO_SYS_ID, Y.PO_NO, Y.TRUCK_NO, Y.PO_DATE, Y.TRANS_SYS_ID, X.TRANSPORTER_NAME
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFSYSID = X.RFSYSID) RFIDSRNO, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.IS_UNLOAD_TRUCK, (select PlantCode from plant_master where PlantID = Y.PLANT_ID) PLANT_CD
				FROM rm_gate_in_out X, 
				(SELECT Z.* FROM po_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID -- AND GATE_OUT_DT IS NULL
					AND ((Z.PO_SYS_ID IN (SELECT XZ.PO_SYS_ID FROM rm_gate_in_out XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'')) OR  XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (126, 2))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0))
				) Y WHERE X.PLANT_ID = Y.PLANT_ID 
                AND X.PO_SYS_ID = Y.PO_SYS_ID
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 
                AND X.GATE_OUT_DT IS NULL 
                AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM rm_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.GROSS_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0)
	)
	SELECT X.PLANT_ID, PLANT.Plant_Name, PLANT.PlantAddress, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.PO_SYS_ID COMMON_SYS_ID, X.PO_NO COMMON_NO, X.TRUCK_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(PO_DATE, '%d/%m/%Y %H:%i') AS PO_DATE
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION, X.RFSYSID, X.RFIDSRNO
	, X.TRANS_SYS_ID, X.TRANSPORTER_NAME AS TRANSPORTER_NAME_NEW, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.NET_WT, ZZ.TARE_WT,ZZ.TARE_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.GROSS_WT, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT
	FROM TBL_MAIN X 
	LEFT JOIN rm_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
    LEFT JOIN PLANT_MASTER PLANT ON PLANT.PlantID = X.PLANT_ID
	ORDER BY X.GATE_IN_DT DESC, X.PO_DATE DESC;
    
   SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.PO_SYS_ID, Y.PO_LINE_NO, Y.LINE_DESC, Y.UMO, Y.LINE_QTY, Y.LINE_DESC, Y.RECEIVE_UOM, Y.RECEIVE_QTY		
				FROM rm_gate_in_out X, 
				(SELECT Z.* FROM po_detail Z
					WHERE Z.PLANT_ID = P_PLANT_ID
					AND ((Z.PO_SYS_ID IN (SELECT XZ.PO_SYS_ID FROM rm_gate_in_out XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'')) OR  XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (126, 2))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0))
				) Y WHERE X.PLANT_ID = Y.PLANT_ID 
                AND X.PO_SYS_ID = Y.PO_SYS_ID
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 
                AND X.GATE_OUT_DT IS NULL 
                AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM rm_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.GROSS_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_ROLE_DELETE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_ROLE_DELETE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_ROLE_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_ROLE_GET`(
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
	SELECT DISTINCT X.MENU_ID,
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
    
    SELECT DISTINCT X.ROLE_ID AS ID,
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

	SELECT DISTINCT X.ROLE_ID AS ID,
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_ROLE_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_ROLE_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SCAN_CODE_HISTORY_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SCAN_CODE_HISTORY_GET`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SHIPPER_QRCODE_CHECK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SHIPPER_QRCODE_CHECK`(
IN P_LOADING_BAY NVARCHAR(255),
IN P_QR_CODE NVARCHAR(255),
IN P_GATE_SYS_ID INT,
IN P_MDA_SYS_ID INT,
IN P_MDA_DTL_SYS_ID INT,
IN P_PROD_SYS_ID INT,
IN P_IS_MANUAL_SCAN INT,
IN P_PLANT_ID INT,
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
                                               
		SELECT CAST((Z.BAG_NOS / 24) AS unsigned) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
            
		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;

		SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM QR_CODE_REJECTLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

        SET P_RESULT = CONCAT('E|NOK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '#', @errmsg, '|-1');

    END;

		SELECT CAST((Z.BAG_NOS / 24) AS unsigned) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
            
		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;

		SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM QR_CODE_REJECTLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

        SET P_RESULT = CONCAT('E|NOK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|0');

		IF LENGTH(COALESCE(P_QR_CODE, '')) > 0 THEN
			
			SELECT MDA_NO INTO TEMP_MDA_NO FROM mda_header Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID LIMIT 1;
            
            SELECT COUNT(*) INTO TEMP_NUM FROM SHIPPER_QRCODE X WHERE X.SHIPPER_QRCODE = P_QR_CODE;

			IF IFNULL(TEMP_NUM, 0) > 0 THEN						
					
				SELECT COUNT(*) INTO TEMP_NUM FROM mda_loading Z WHERE Z.SHIPPER_QR_CODE = P_QR_CODE;

				IF IFNULL(TEMP_NUM, 0) = 0 THEN	
					                     
					IF TEMP_REQUIRED_SHIPPER >= (TEMP_LOADED_SHIPPER + 1) THEN	
							
						INSERT INTO QR_CODE_SUCCESSLIST ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, ENTRY_TIME) 
						VALUES (P_PLANT_ID, 2, P_QR_CODE, P_PROD_SYS_ID, TEMP_MDA_NO, P_MDA_SYS_ID, NOW());
						 
						 SET last_id = LAST_INSERT_ID();
						 
						INSERT INTO QR_CODE_SUCCESSLIST_LOG ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO) 
						VALUES (P_PLANT_ID, 2, P_QR_CODE, P_PROD_SYS_ID, TEMP_MDA_NO);
						 
						SET TEMP_LOADED_SHIPPER = TEMP_LOADED_SHIPPER + 1;
            
                        SELECT MAX(MDA_LOD_SYS_ID) + 1 INTO TEMP_NUM FROM mda_loading Z ;

						INSERT INTO MDA_LOADING ( MDA_LOD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER, SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, CREATED_DATETIME, PLANT_ID, IS_POSTED, ENTRY_TIME) 
						VALUES (TEMP_NUM, P_GATE_SYS_ID, P_MDA_SYS_ID, P_PROD_SYS_ID, TEMP_REQUIRED_SHIPPER, TEMP_LOADED_SHIPPER, P_QR_CODE, P_IS_MANUAL_SCAN, 1, NOW(), P_PLANT_ID, 0, NOW() );
						
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
					VALUES (P_PLANT_ID, 2, P_QR_CODE, P_PROD_SYS_ID, TEMP_MDA_NO, P_MDA_SYS_ID, 'Duplicate QR Code found.', NOW());
					 
	 				 SET last_id = LAST_INSERT_ID();
                     
					INSERT INTO QR_CODE_REJECTLIST_LOG ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, REJECT_REASON) 
					VALUES (P_PLANT_ID, 2, P_QR_CODE, P_PROD_SYS_ID, TEMP_MDA_NO, 'Duplicate QR Code found.');
							
					SET P_RESULT = CONCAT('E|NOK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);   
				END IF;
			ELSE
            
					SET TEMP_REJECT_SHIPPER = TEMP_REJECT_SHIPPER + 1;
            
					INSERT INTO QR_CODE_REJECTLIST ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, REJECT_REASON, ENTRY_TIME) 
					VALUES (P_PLANT_ID, 2, P_QR_CODE, P_PROD_SYS_ID, TEMP_MDA_NO, P_MDA_SYS_ID, 'QR Code not found.', NOW());
					 
					SET last_id = LAST_INSERT_ID();
                     
					INSERT INTO QR_CODE_REJECTLIST_LOG ( PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, REJECT_REASON) 
					VALUES (P_PLANT_ID, 2, P_QR_CODE, P_PROD_SYS_ID, TEMP_MDA_NO, 'QR Code not found.');
						
					SET P_RESULT = CONCAT('E|NOK#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|', last_id);   
			END IF;
                        
		END IF;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_SHIPPER_QRCODE_DELETE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SHIPPER_QRCODE_DELETE`(
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
                        AND MDA_LOD_SYS_ID IN (SELECT MDA_LOD_SYS_ID FROM mda_loading Z 
												WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID
												AND SHIPPER_QR_CODE IN (SELECT QRCODE FROM qr_code_successlist WHERE SID = CAST(v_id AS UNSIGNED) AND MDA_SYS_ID = P_MDA_SYS_ID 
                                                AND Product_SYS_ID = P_PROD_SYS_ID AND PLANT_ID = P_PLANT_ID));
						-- AND SHIPPER_QR_CODE IN (SELECT QRCODE FROM qr_code_successlist WHERE SID = CAST(v_id AS UNSIGNED) AND MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID AND PLANT_ID = P_PLANT_ID);
                                        
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SHIPPER_QRCODE_DELETE_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SHIPPER_QRCODE_DELETE_NEW`(
    IN P_GATE_SYS_ID INT,
    IN P_MDA_SYS_ID INT,
    IN P_MDA_DTL_SYS_ID INT,
    IN P_PROD_SYS_ID INT,
    IN P_QR_CODE_ID INT,
    IN P_QR_CODE_TYPE  VARCHAR(255),
    IN P_QR_CODE  VARCHAR(255),
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
										 
			SELECT CAST((Z.BAG_NOS / 24) AS unsigned) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
				
			SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;

			SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM QR_CODE_REJECTLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

			SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|-1');

		END;
						 
			SELECT CAST((Z.BAG_NOS / 24) AS unsigned) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
				
			SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;

			SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM QR_CODE_REJECTLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

			SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator.#', TEMP_REQUIRED_SHIPPER, '#', TEMP_LOADED_SHIPPER, '#', TEMP_REJECT_SHIPPER, '|0');


		IF LENGTH(IFNULL(P_QR_CODE_TYPE, '')) > 0 AND IFNULL(P_QR_CODE_TYPE, '') = 'A' THEN
        
				IF LENGTH(IFNULL(P_QR_CODE, '')) > 0 THEN
                
                        DELETE FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID 
                        AND TRIM(SHIPPER_QR_CODE) = TRIM(P_QR_CODE);
                        
						DELETE FROM qr_code_successlist WHERE MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID 
                        AND TRIM(QRCODE) = TRIM(P_QR_CODE);
                        
						DELETE FROM qr_code_rejectlist WHERE MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID 
                        AND TRIM(QRCODE) = TRIM(P_QR_CODE);
                        
				ELSE
                
                        DELETE FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;
                        
						DELETE FROM qr_code_successlist WHERE MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID;
                        
						DELETE FROM qr_code_rejectlist WHERE MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID;
                        
				END IF;
                
		ELSEIF LENGTH(IFNULL(P_QR_CODE_TYPE, '')) > 0 AND IFNULL(P_QR_CODE_TYPE, '') = 'S' THEN
        
				IF LENGTH(IFNULL(P_QR_CODE, '')) > 0 THEN
                
                        DELETE FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID 
                        AND TRIM(SHIPPER_QR_CODE) = TRIM(P_QR_CODE);
                        
						DELETE FROM qr_code_successlist WHERE MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID 
                        AND TRIM(QRCODE) = TRIM(P_QR_CODE);
                        
				ELSE
                
                        DELETE FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID;
                        
						DELETE FROM qr_code_successlist WHERE MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID;
                        
				END IF;
                
		ELSEIF LENGTH(IFNULL(P_QR_CODE_TYPE, '')) > 0 AND IFNULL(P_QR_CODE_TYPE, '') = 'R' THEN
        
				IF LENGTH(IFNULL(P_QR_CODE, '')) > 0 THEN
                
						DELETE FROM qr_code_rejectlist WHERE RID = P_QR_CODE_ID AND MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID 
                        AND TRIM(QRCODE) = TRIM(P_QR_CODE);
                        
				ELSE
                
						DELETE FROM qr_code_rejectlist WHERE MDA_SYS_ID = P_MDA_SYS_ID AND Product_SYS_ID = P_PROD_SYS_ID;
                        
				END IF;
                
		END IF;
        
        			 
			SELECT CAST((Z.BAG_NOS / 24) AS unsigned) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
				
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SHIPPER_QRCODE_GET_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SHIPPER_QRCODE_GET_NEW`(IN P_QRCODE NVARCHAR(255),
IN `P_GATE_SYS_ID` INT,
IN `P_MDA_SYS_ID` INT,
IN `P_MDA_DTL_SYS_ID` INT,
IN `P_PROD_SYS_ID` INT,
IN `P_IS_MANUAL_SCAN` INT,
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
						VALUES (TEMP_NUM, P_GATE_SYS_ID, P_MDA_SYS_ID, P_PROD_SYS_ID, TEMP_REQUIRED_SHIPPER, TEMP_LOADED_SHIPPER, P_QRCODE, P_IS_MANUAL_SCAN, 1, NOW(), 4, 0, NOW() );
					
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SHIPPER_QRCODE_HISTORY_GET_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SHIPPER_QRCODE_HISTORY_GET_NEW`(
IN `P_GATE_SYS_ID` INT,
IN `P_MDA_SYS_ID` INT,
IN `P_MDA_DTL_SYS_ID` INT,
IN `P_PROD_SYS_ID` INT
)
BEGIN

	DECLARE TEMP_REQUIRED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_LOADED_SHIPPER INT DEFAULT 0;
	DECLARE TEMP_REJECT_SHIPPER INT DEFAULT 0;
                                                   
		SELECT CAST((Z.BAG_NOS / 24) AS unsigned) INTO TEMP_REQUIRED_SHIPPER FROM mda_detail Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PROD_SYS_ID = P_PROD_SYS_ID LIMIT 1;
            
		-- SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM mda_loading Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.GATE_SYS_ID = P_GATE_SYS_ID AND Z.PROD_SYS_ID = P_PROD_SYS_ID;

		SELECT COUNT(*) INTO TEMP_LOADED_SHIPPER FROM QR_CODE_SUCCESSLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

		SELECT COUNT(*) INTO TEMP_REJECT_SHIPPER FROM QR_CODE_REJECTLIST Z WHERE Z.MDA_SYS_ID = P_MDA_SYS_ID AND Z.PRODUCT_SYS_ID = P_PROD_SYS_ID;

WITH TBL_RESULT AS (SELECT ROW_NUMBER() OVER (ORDER BY ENTRY_TIME) AS SrNo, ID, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, LOG_Type, ENTRY_TIME, REJECT_REASON 
FROM ( SELECT SID AS ID, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, 'S' AS LOG_Type, ENTRY_TIME, NULL AS REJECT_REASON 
		FROM QR_CODE_SUCCESSLIST X 
        WHERE X.MDA_SYS_ID = P_MDA_SYS_ID AND X.PRODUCT_SYS_ID = P_PROD_SYS_ID 
        UNION ALL 
        SELECT RID AS ID, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, 'R' AS LOG_Type, ENTRY_TIME, REJECT_REASON 
        FROM QR_CODE_REJECTLIST X 
        WHERE X.MDA_SYS_ID = P_MDA_SYS_ID AND X.PRODUCT_SYS_ID = P_PROD_SYS_ID 
) Z ORDER BY ENTRY_TIME)
SELECT SrNo, ID, PLANT_ID, BELT_NO, QRCODE, PRODUCT_SYS_ID, MDA_NO, MDA_SYS_ID, LOG_Type, ENTRY_TIME, REJECT_REASON 
, TEMP_REQUIRED_SHIPPER REQUIRED_SHIPPER, TEMP_LOADED_SHIPPER LOADED_SHIPPER, TEMP_REJECT_SHIPPER REJECT_SHIPPER
FROM TBL_RESULT
UNION ALL 
SELECT 0 SRNO, 0 ID, 0 PLANT_ID, 0 BELT_NO, '' QRCODE, 0 PRODUCT_SYS_ID, '' MDA_NO, 0 MDA_SYS_ID, '' LOG_Type, NULL ENTRY_TIME, NULL REJECT_REASON
, TEMP_REQUIRED_SHIPPER REQUIRED_SHIPPER, TEMP_LOADED_SHIPPER LOADED_SHIPPER, TEMP_REJECT_SHIPPER REJECT_SHIPPER
WHERE 0 = (SELECT COUNT(*) FROM TBL_RESULT);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_SO_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SO_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SO_SAVE_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SO_SAVE_NEW`(
    IN P_ID BIGINT, 
    IN P_VENDOR_ID BIGINT, 
    IN P_SITE_NAME VARCHAR(255), 
    IN P_SO_NO BIGINT, 
    IN P_SO_DATE VARCHAR(255),
    IN P_TRANSPORTER_NAME VARCHAR(255), 
    IN P_TRUCK_NO VARCHAR(255), 
    IN P_LOADING_GATE VARCHAR(255),  
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
					DECLARE v_line_loading_uom VARCHAR(255);
					DECLARE v_line_loading_qty VARCHAR(255);
                
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
					SO_SYS_ID, PLANT_ID, VENSOR_SYS_ID, SO_NO, SO_DATE, TRUCK_NO, TRANSPORTER_NAME, LOADING_GATE, RIVISION, TENDER_TYPE, 
					SO_RELEASE_DATE, SO_VALID_DATE, EMD_AMT, AMEND_NO, CUST_NAME, SITE_NAME, 
					ADD1, CITY, STATE, PAN_NO, GSTN_NO, TERMS_PRICE, TERMS_PYMT_TERM, 
					TERMS_LIFTING_PERIOD_DAYS, SO_REMARKS, STATUS_REMARKS, CREATED_DATETIME
						) VALUES (
					TEMP_SO_ID, P_PLANT_ID, P_VENDOR_ID, P_SO_NO, STR_TO_DATE(REPLACE(P_SO_DATE, '-', '/'), '%d/%m/%Y'), 
					P_TRUCK_NO, P_TRANSPORTER_NAME, P_LOADING_GATE, P_RIVISION, P_TENDER_TYPE, STR_TO_DATE(REPLACE(P_SO_RELEASE_DATE, '-', '/'), '%d/%m/%Y'), 
					STR_TO_DATE(REPLACE(P_SO_VALID_DATE, '-', '/'), '%d/%m/%Y'), P_EMD_AMT, P_MSR_NO, P_CUST_NAME, 
					P_SITE_NAME, P_ADDRESS, P_CITY, P_STATE, P_PANNO, P_GSTNNO, P_TERMS_PRICE, P_TERMS_PYMT_TERM, 
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
					SET v_line_loading_qty = REGEXP_SUBSTR(v_line, '[^|]+', 1, 6);
					SET v_line_loading_uom = REGEXP_SUBSTR(v_line, '[^|]+', 1, 7);
                
					SELECT IFNULL(MAX(SO_DTL_SYS_ID), 0) + 1 INTO TEMP_SO_DTLS_ID FROM SO_DETAIL;
					
                    IF CAST(IFNULL(v_line_no, '0') AS UNSIGNED) > 0 THEN SET TEMP_SO_DTLS_LINE_NO = CAST(IFNULL(v_line_no, '0') AS UNSIGNED);
                    ELSE SELECT IFNULL(MAX(SLNO), 0) + 1 INTO TEMP_SO_DTLS_LINE_NO FROM SO_DETAIL WHERE PLANT_ID = P_PLANT_ID AND SO_SYS_ID = TEMP_SO_ID; END IF;
                    
					INSERT INTO SO_DETAIL (SO_DTL_SYS_ID, SO_SYS_ID, SO_NO, SLNO, SCRAP_DESC, UOM, SO_QTY, LOADING_QTY, LOADING_UOM, IS_POSTED, PLANT_ID)
                    VALUES (TEMP_SO_DTLS_ID, TEMP_SO_ID, P_SO_NO, TEMP_SO_DTLS_LINE_NO, v_line_desc, v_line_uom, CAST(IFNULL(v_line_qty, '0') AS UNSIGNED), CAST(IFNULL(v_line_loading_qty, '0') AS UNSIGNED), v_line_loading_uom, 0, P_PLANT_ID);
                
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SplitString` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SplitString`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SP_GATE_IN_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SP_GATE_IN_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SP_GATE_OUT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SP_GATE_OUT_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
    /*IN P_ISACTIVE VARCHAR(255),
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT*/
)
BEGIN
	DECLARE TEMP_STATION_ID INT DEFAULT 7;
    
    
WITH TBL_MAIN AS 
(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.SO_SYS_ID, Y.SO_NO, X.TRUCK_NO, Y.SO_DATE, X.TRANS_SYS_ID, X.TRANSPORTER_NAME
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, (select PlantCode from plant_master where PlantID = Y.PLANT_ID) PLANT_CD
				FROM sp_gate_in_out X, 
				(SELECT Z.* FROM so_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID
					AND ((Z.SO_SYS_ID IN (SELECT XZ.SO_SYS_ID FROM sp_gate_in_out XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'')) OR  XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (127, 3))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND P_ID = 0, 1, 0))
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.SO_SYS_ID = Y.SO_SYS_ID AND 1 = (CASE WHEN IFNULL(P_SEARCHTERM,'') = '' THEN (CASE WHEN COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL THEN 1 ELSE 0 END ) ELSE 1 END ) 
				AND 0 < (SELECT COUNT(*) FROM sp_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0)
	)
SELECT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID Gate_In_Id, X.SO_SYS_ID COMMON_SYS_ID, X.SO_NO COMMON_NO, X.TRUCK_NO TRUCK_NO
, DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(X.SO_DATE, '%d/%m/%Y %H:%i') AS SO_DATE
, X.TRANS_SYS_ID, X.TRANSPORTER_NAME -- , (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID LIMIT 1) AS TRANSPORTER_NAME
, X.INWARD_SYS_ID, (SELECT Z.INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = IF(X.INWARD_SYS_ID = 3, 127, X.INWARD_SYS_ID) LIMIT 1) AS INWARD_TYPE
, X.DRIVER_ID_TYPE, (SELECT Z.LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD
, X.IS_GOODS_TRANSFER, X.PLANT_CD PLANT_CODE, ZZ.WT_SYS_ID, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.TARE_WT_MANUALLY, ZZ.TARE_WT_NOTE
, ZZ.GROSS_WT, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT, ZZ.GROSS_WT_MANUALLY, ZZ.GROSS_WT_NOTE, ZZ.NET_WT
FROM TBL_MAIN X 
LEFT JOIN sp_weighment_detail ZZ ON X.GATE_SYS_ID = ZZ.GATE_SYS_ID AND ZZ.PLANT_ID = X.PLANT_ID
AND ZZ.TARE_WT IS NOT NULL AND COALESCE(ZZ.TARE_WT,0) > 0 AND ZZ.GROSS_WT_DT IS NOT NULL AND COALESCE(ZZ.GROSS_WT,0) > 0;
   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_SP_GATE_OUT_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SP_GATE_OUT_SAVE`(
    IN P_ID INT,
    IN P_SO_SYS_ID INT,
    IN P_GATE_OUT_NOTE VARCHAR(255),
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
    DECLARE TEMP_SO_NO VARCHAR(255);
    DECLARE TEMP_GATE_OUT_DT VARCHAR(255) DEFAULT NULL;
    DECLARE TEMP_INVOICE_QR_CODE VARCHAR(255) DEFAULT NULL;
      
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SELECT X.RFSYSID, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_RFID, TEMP_GATE_OUT_DT FROM SP_GATE_IN_OUT X WHERE X.GATE_SYS_ID = P_ID AND X.SO_SYS_ID = P_SO_SYS_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NULL THEN
			
            SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0'); 
            
        END IF;
        
    END;

	SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
	
    IF P_ID > 0 THEN

        
        SELECT X.RFSYSID, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') INTO TEMP_RFID, TEMP_GATE_OUT_DT FROM SP_GATE_IN_OUT X WHERE X.GATE_SYS_ID = P_ID AND X.SO_SYS_ID = P_SO_SYS_ID AND X.PLANT_ID = P_PLANT_ID LIMIT 1;
        
        IF TEMP_GATE_OUT_DT IS NULL THEN
        
            UPDATE SP_GATE_IN_OUT 
            SET GATE_OUT_DT = CURRENT_TIMESTAMP(), IS_GOODS_TRANSFER = 1
            WHERE GATE_SYS_ID = P_ID AND COALESCE(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND STATION_ID = TEMP_STATION_ID AND PLANT_ID = P_PLANT_ID;
			
            /*UPDATE SO_header SO_U
			INNER JOIN SP_GATE_IN_OUT GIO ON SO_U.PLANT_ID = GIO.PLANT_ID AND GIO.TRUCK_NO = SO_U.VEHICLE_NO
			INNER JOIN SO_header SO ON SO.PLANT_ID = GIO.PLANT_ID AND GIO.TRUCK_NO = SO.VEHICLE_NO
			SET SO_U.OUT_TIME = NOW()
			WHERE GIO.PLANT_ID = P_PLANT_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0 AND GIO.GATE_IN_DT IS NOT NULL AND GIO.GATE_OUT_DT IS NULL AND SO.OUT_TIME IS NULL AND SO_U.OUT_TIME IS NULL
			AND GIO.GATE_SYS_ID = P_ID AND SO_U.PLANT_ID = SO.PLANT_ID AND SO.SO_SYS_ID = SO_U.SO_SYS_ID;*/

			SELECT SO_NO INTO TEMP_SO_NO FROM SO_header Z WHERE SO_SYS_ID = P_SO_SYS_ID AND PLANT_ID = P_PLANT_ID LIMIT 1;           
			
            COMMIT;
            
            UPDATE RFID_MASTER SET STATUS = 'Active' 
            WHERE RFSYSID NOT IN (SELECT DISTINCT RFSYSID FROM SP_GATE_IN_OUT X
								INNER JOIN SO_header Y ON Y.PLANT_ID = X.PLANT_ID AND Y.SO_SYS_ID = X.SO_SYS_ID
								WHERE GATE_OUT_DT IS NULL AND DATE_FORMAT(X.GATE_IN_DT, '%Y') = '2024'
								ORDER BY 1 DESC) 
			AND PLANT_ID = P_PLANT_ID;
            
            COMMIT;
            
            SET P_RESULT := 'S|Record saved successfully|0';  
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SP_WEIGHMENT_IN_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SP_WEIGHMENT_IN_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    -- IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT
    -- IN P_USER_ID INT,
    -- IN P_ROLE_ID INT,
    -- IN P_MENU_ID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error
        ROLLBACK;
    END;
    
    WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.SO_SYS_ID, Y.SO_NO, X.TRUCK_NO, Y.SO_DATE, X.TRANS_SYS_ID, X.TRANSPORTER_NAME
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFSYSID = X.RFSYSID) RFIDSRNO, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, (select PlantCode from plant_master where PlantID = Y.PLANT_ID) PLANT_CD
		-- , Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
				FROM sp_gate_in_out X, 
				(SELECT Z.* FROM so_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID -- AND OUT_TIME IS NULL
					 AND ((Z.SO_SYS_ID IN (SELECT XZ.SO_SYS_ID FROM sp_gate_in_out XZ WHERE (XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,XZ.TRUCK_NO) OR XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,'')) ) ) AND XZ.INWARD_SYS_ID IN (127, 3))
						  ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0)
						 )
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.SO_SYS_ID = Y.SO_SYS_ID
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
				AND 0 = (SELECT COUNT(*) FROM sp_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID) -- AND XZ.TARE_WT_DT IS NULL AND IFNULL(XZ.TARE_WT,0) = 0) -- AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0)
	)
	SELECT X.PLANT_ID, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.SO_SYS_ID COMMON_SYS_ID, X.SO_NO COMMON_NO, X.TRUCK_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(SO_DATE, '%d/%m/%Y %H:%i') AS SO_DATE
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION, X.RFSYSID, X.RFIDSRNO
	, X.TRANS_SYS_ID, X.TRANSPORTER_NAME -- (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT
	FROM TBL_MAIN X 
	LEFT JOIN sp_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID 
    AND ZZ.STATION_ID = X.STATION_ID 
    AND ZZ.PLANT_ID = X.PLANT_ID;
	-- WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL ORDER BY X.GATE_IN_DT DESC, X.SO_DATE DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_SP_WEIGHMENT_IN_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SP_WEIGHMENT_IN_SAVE`(
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
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;


    -- Initial default result
    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    IF P_ID > 0 THEN
        -- Check for conditions in FG_GATE_IN_OUT
        IF COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 3 THEN
        
        SELECT COUNT(*) INTO TEMP_NUM FROM sp_weighment_detail X WHERE X.GATE_SYS_ID = P_ID;
        
        END IF;


            IF IFNULL(P_TARE_WT, 0) <= 0 THEN
                SET P_RESULT = 'E|Tare weight require.|0';
            ELSE

				IF COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 3 AND COALESCE(TEMP_NUM, 0) = 0 THEN
				
					-- Get the next WT_SYS_ID
					SELECT COALESCE(MAX(WT_SYS_ID), 0) + 1 INTO TEMP_NUM FROM sp_weighment_detail;

					-- Insert the record
					INSERT INTO sp_weighment_detail (WT_SYS_ID, GATE_SYS_ID, TARE_WT, TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME) 
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SP_WEIGHMENT_IN_SLIP_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SP_WEIGHMENT_IN_SLIP_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error
        ROLLBACK;
    END;
    
    WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.SO_SYS_ID, Y.SO_NO, X.TRUCK_NO, Y.SO_DATE, X.TRANS_SYS_ID, X.TRANSPORTER_NAME
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFSYSID = X.RFSYSID) RFIDSRNO, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD
        , X.IS_GOODS_TRANSFER, (select PlantCode from plant_master where PlantID = Y.PLANT_ID) PLANT_CD
				FROM sp_gate_in_out X, 
				(SELECT Z.* FROM so_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID
					 AND ((Z.SO_SYS_ID IN (SELECT XZ.SO_SYS_ID FROM sp_gate_in_out XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'')) OR  XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (127, 3))
						  ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0))
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.SO_SYS_ID = Y.SO_SYS_ID
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM sp_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID) -- AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0)
	)
	SELECT X.PLANT_ID, PLANT.Plant_Name, PLANT.PlantAddress, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.SO_SYS_ID COMMON_SYS_ID, X.SO_NO COMMON_NO, X.TRUCK_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(SO_DATE, '%d/%m/%Y %H:%i') AS SO_DATE
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION, X.RFSYSID, X.RFIDSRNO
	, X.TRANS_SYS_ID, X.TRANSPORTER_NAME -- (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT
	FROM TBL_MAIN X 
	LEFT JOIN sp_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID
    LEFT JOIN PLANT_MASTER PLANT ON PLANT.PlantID = X.PLANT_ID
    -- AND ZZ.STATION_ID = X.STATION_ID 
    AND ZZ.PLANT_ID = X.PLANT_ID;
    
    SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.SO_SYS_ID, Y.SO_NO, X.TRUCK_NO, Y.SLNO, Y.SCRAP_CD, Y.SCRAP_DESC, Y.UOM
    , Y.SO_QTY, Y.BASIC_AMT, X.TRANS_SYS_ID		
				FROM sp_gate_in_out X, 
				(SELECT Z.* FROM so_detail Z
					WHERE Z.PLANT_ID = P_PLANT_ID
					 AND ((Z.SO_SYS_ID IN (SELECT XZ.SO_SYS_ID FROM sp_gate_in_out XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'')) OR  XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (127, 3))
						  ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0))
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.SO_SYS_ID = Y.SO_SYS_ID
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM sp_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_SP_WEIGHMENT_OUT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SP_WEIGHMENT_OUT_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    -- IN P_ISACTIVE VARCHAR(10),
    IN P_PLANT_ID INT
    -- IN P_USER_ID INT,
    -- IN P_ROLE_ID INT,
    -- IN P_MENU_ID INT
)
BEGIN
    
    WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.SO_SYS_ID, Y.SO_NO, X.TRUCK_NO, Y.SO_DATE, X.TRANS_SYS_ID, X.TRANSPORTER_NAME
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFSYSID = X.RFSYSID) RFIDSRNO, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, (select PlantCode from plant_master where PlantID = Y.PLANT_ID) PLANT_CD
		-- , Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
				FROM sp_gate_in_out X, 
				(SELECT Z.* FROM so_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID -- AND OUT_TIME IS NULL
					 AND ((
                            Z.SO_SYS_ID IN (SELECT XZ.SO_SYS_ID FROM sp_gate_in_out XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,'')) ) OR  XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (127, 3))
						  ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(0,0) = 0, 1, 0)
						 )
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.SO_SYS_ID = Y.SO_SYS_ID
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM sp_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0)
	)
	SELECT X.PLANT_ID, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.SO_SYS_ID COMMON_SYS_ID, X.SO_NO COMMON_NO, X.TRUCK_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(SO_DATE, '%d/%m/%Y %H:%i') AS SO_DATE
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION, X.RFSYSID, X.RFIDSRNO
	, X.TRANS_SYS_ID, X.TRANSPORTER_NAME -- , (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT
	FROM TBL_MAIN X 
	LEFT JOIN sp_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID 
    -- AND ZZ.STATION_ID = X.STATION_ID 
    AND ZZ.PLANT_ID = X.PLANT_ID;
	-- WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL ORDER BY X.GATE_IN_DT DESC, X.SO_DATE DESC;
    
   /* WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.SO_SYS_ID, Y.SO_NO, X.TRUCK_NO, Y.SO_DATE, X.TRANS_SYS_ID
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER, (select PlantCode from plant_master where PlantID = Y.PLANT_ID) PLANT_CD
		-- , Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
				FROM sp_gate_in_out X, 
				(SELECT Z.* FROM so_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID -- AND OUT_TIME IS NULL
					-- AND ((Z.VEHICLE_NO = P_SEARCHTERM
							-- OR Z.VEHICLE_NO IN (SELECT XZ.VEHICLE_NO FROM so_header XZ WHERE XZ.MDA_NO = P_SEARCHTERM OR XZ.MDA_SYS_ID = IFNULL(P_ID,0)) 
							-- OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM sp_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID IN (127, 3))
						 -- ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0)
						-- )
				) Y WHERE X.PLANT_ID = Y.PLANT_ID -- AND X.TRUCK_NO = Y.VEHICLE_NO 
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM sp_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0)
	)
	SELECT X.PLANT_ID, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.SO_SYS_ID COMMON_SYS_ID, X.SO_NO COMMON_NO, X.TRUCK_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(SO_DATE, '%d/%m/%Y %H:%i') AS SO_DATE
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
	, X.TRANS_SYS_ID, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT
	FROM TBL_MAIN X 
	LEFT JOIN sp_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
	-- WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL
	ORDER BY X.GATE_IN_DT DESC, X.SO_DATE DESC; */
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_SP_WEIGHMENT_OUT_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SP_WEIGHMENT_OUT_SAVE`(
    IN P_ID INT, 
    IN P_GATE_IN_ID INT, 
    -- IN P_INWARD_SYS_ID INT, 
    IN P_GROSS_WT DECIMAL(10,2), 
    IN P_GROSS_WT_MANUALLY INT, 
    IN P_GROSS_WT_NOTE VARCHAR(255), 
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
    DECLARE TEMP_TARE_WT DECIMAL(10,2);
    DECLARE TEMP_INWARD_SYS_ID INT;
    DECLARE TEMP_STATION_ID INT DEFAULT 7;
          
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;


    -- Initial default result
    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    IF P_ID > 0 AND P_GATE_IN_ID > 0 THEN
        -- Fetch INWARD_SYS_ID
        SELECT INWARD_SYS_ID INTO TEMP_INWARD_SYS_ID
        FROM sp_gate_in_out
        WHERE GATE_SYS_ID = P_GATE_IN_ID AND IFNULL(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL AND STATION_ID = TEMP_STATION_ID;

        -- IF IFNULL(TEMP_INWARD_SYS_ID, 0) > 0 AND TEMP_INWARD_SYS_ID = 125 THEN
            -- Fetch TARE_WT
            SELECT IFNULL(TARE_WT, 0) INTO TEMP_TARE_WT
            FROM sp_weighment_detail
            WHERE WT_SYS_ID = P_ID AND GATE_SYS_ID = P_GATE_IN_ID;

            -- Validate gross weight
            IF IFNULL(P_GROSS_WT, 0) < IFNULL(TEMP_TARE_WT, 0) THEN
                SET P_RESULT = 'E|Gross weight is less than Tare weight.|0';
            ELSE
                -- Update record
                UPDATE sp_weighment_detail
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SP_WEIGHMENT_OUT_SLIP_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SP_WEIGHMENT_OUT_SLIP_GET`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error
        ROLLBACK;
    END;
    
    WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.SO_SYS_ID, Y.SO_NO, X.TRUCK_NO, Y.SO_DATE, X.TRANS_SYS_ID, X.TRANSPORTER_NAME
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFSYSID = X.RFSYSID) RFIDSRNO, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD
        , X.IS_GOODS_TRANSFER, (select PlantCode from plant_master where PlantID = Y.PLANT_ID) PLANT_CD
				FROM sp_gate_in_out X, 
				(SELECT Z.* FROM so_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID
					 AND ((Z.SO_SYS_ID IN (SELECT XZ.SO_SYS_ID FROM sp_gate_in_out XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'')) OR  XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (127, 3))
						  ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0))
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.SO_SYS_ID = Y.SO_SYS_ID
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM sp_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0)
	)
	SELECT X.PLANT_ID, PLANT.Plant_Name, PLANT.PlantAddress, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.SO_SYS_ID COMMON_SYS_ID, X.SO_NO COMMON_NO, X.TRUCK_NO TRUCK_NO, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(SO_DATE, '%d/%m/%Y %H:%i') AS SO_DATE
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION, X.RFSYSID, X.RFIDSRNO
	, X.TRANS_SYS_ID, X.TRANSPORTER_NAME -- , (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.NET_WT, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT, ZZ.GROSS_WT, ZZ.GROSS_WT_NOTE, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS GROSS_WT_DT
	FROM TBL_MAIN X 
	LEFT JOIN sp_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID
    LEFT JOIN PLANT_MASTER PLANT ON PLANT.PlantID = X.PLANT_ID
    -- AND ZZ.STATION_ID = X.STATION_ID 
    AND ZZ.PLANT_ID = X.PLANT_ID;
    
    SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.SO_SYS_ID, Y.SO_NO, X.TRUCK_NO, Y.SLNO, Y.SCRAP_CD, Y.SCRAP_DESC, Y.UOM
    , Y.SO_QTY, Y.LOADING_QTY, Y.LOADING_UOM, Y.BASIC_AMT, X.TRANS_SYS_ID		
				FROM sp_gate_in_out X, 
				(SELECT Z.* FROM so_detail Z
					WHERE Z.PLANT_ID = P_PLANT_ID
					 AND ((Z.SO_SYS_ID IN (SELECT XZ.SO_SYS_ID FROM sp_gate_in_out XZ WHERE (XZ.RFSYSID IN (SELECT ZX.RFIDSRNO FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'')) OR  XZ.TRUCK_NO = IFNULL(P_SEARCHTERM,'') ) AND XZ.INWARD_SYS_ID IN (127, 3))
						  ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0))
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.SO_SYS_ID = Y.SO_SYS_ID
                AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM sp_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_STATE_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_STATE_GET`(IN P_ID          INT, IN P_COUNTRY_ID          INT,
                                  IN P_ISACTIVE    VARCHAR(255),
                                  IN P_PLANT_ID    INT,
                                  IN P_USER_ID     INT,
                                  IN P_ROLE_ID     INT,
                                  IN P_MENU_ID     INT)
BEGIN
IF P_ID > 0 THEN
      
            SELECT X.STATE_ID ID,
                   NULL CODE,
                   X.STATE_NAME NAME,
					COUNTRY_ID,
                   (SELECT COUNTRY_NAME
                      FROM countrymaster
                     WHERE X.COUNTRY_ID = COUNTRY_ID)
                      COUNTRY_NAME,
                   PLANT_ID,
                   CREATED_BY,
                   CREATED_DATETIME,
                   1 ISACTIVE
              FROM statemaster X
             WHERE X.COUNTRY_ID = P_ID;
             
      ELSE
      
            SELECT X.STATE_ID ID,
                   NULL CODE,
                   X.STATE_NAME NAME,
					COUNTRY_ID,
                   (SELECT COUNTRY_NAME
                      FROM countrymaster
                     WHERE X.COUNTRY_ID = COUNTRY_ID)
                      COUNTRY_NAME,
                   PLANT_ID,
                   CREATED_BY,
                   CREATED_DATETIME,
                   1 ISACTIVE
              FROM statemaster X;
      END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_SYNC_BATCH_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SYNC_BATCH_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SYNC_PLANT_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SYNC_PLANT_SAVE`(
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

    DECLARE v_plant_id VARCHAR(255);
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
					SET v_plant_id = REGEXP_SUBSTR(v_line, '[^|]+', 1, 6);

					IF LENGTH(IFNULL(v_plant_cd, '')) > 0 AND LENGTH(IFNULL(v_plant_name, '')) > 0 THEN
							
						SELECT COUNT(*) INTO TEMP_CNT FROM plant_master WHERE PlantCode = v_plant_cd;

						IF IFNULL(TEMP_CNT, 0) = 0 THEN
							
							-- SELECT IFNULL(MAX(PlantID), 0) + 1 INTO TEMP_PLANT_ID FROM plant_master;

							SET TEMP_PLANT_ID = CAST(v_plant_id AS SIGNED);
                            
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SYNC_PRODUCT_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SYNC_PRODUCT_SAVE`(
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

    DECLARE v_prd_id VARCHAR(255);
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
					SET v_prd_id = REGEXP_SUBSTR(v_line, '[^|]+', 1, 19);

					IF LENGTH(IFNULL(v_prd_cd, '')) > 0 AND LENGTH(IFNULL(v_prd_desc, '')) > 0 THEN
							IF LENGTH(IFNULL(v_plant_cd, '')) > 0 THEN
								SELECT PLANTID INTO TEMP_PLANT_ID FROM PLANT_MASTER WHERE PLANTCODE = v_plant_cd LIMIT 1;
							END IF;

							IF IFNULL(TEMP_PLANT_ID, 0) <= 0 THEN
								SET TEMP_PLANT_ID = P_PLANT_ID;
							END IF;
                            
						SELECT COUNT(*) INTO TEMP_CNT FROM PRODUCT_MASTER WHERE PRD_CD = v_prd_cd;

						SET TEMP_PRODUCT_ID = CAST(v_prd_id AS SIGNED);

						IF IFNULL(TEMP_CNT, 0) = 0 AND IFNULL(TEMP_PRODUCT_ID, 0) > 0 THEN
							
							-- SELECT IFNULL(MAX(PROD_SYS_ID), 0) + 1 INTO TEMP_PRODUCT_ID FROM PRODUCT_MASTER;

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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SYNC_RETAILER_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SYNC_RETAILER_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SYNC_WAREHOUSE_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SYNC_WAREHOUSE_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_SYNC_WHOLESALER_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_SYNC_WHOLESALER_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_TRANSPORTER_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_TRANSPORTER_GET`(
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
        SELECT TRANS_SYS_ID AS ID, TPTR_NAME AS NAME, TPTR_CD, IS_ENTRY_MANUAL, PLANT_ID, 1 IS_ACTIVE -- , CASE WHEN X.IS_ACTIVE = 'Y' THEN 1 ELSE 0 END AS IS_ACTIVE
        FROM TRANSPORTER_MASTER X
        WHERE PLANT_ID = P_PLANT_ID AND X.TRANS_SYS_ID = P_ID; -- AND X.IS_ACTIVE = CASE WHEN IFNULL(P_ISACTIVE, '') = '' THEN X.IS_ACTIVE ELSE P_ISACTIVE END;
    ELSE
        SELECT TRANS_SYS_ID AS ID, TPTR_NAME AS NAME, TPTR_CD, IS_ENTRY_MANUAL, PLANT_ID, 1 IS_ACTIVE -- , CASE WHEN X.IS_ACTIVE = 'Y' THEN 1 ELSE 0 END AS IS_ACTIVE
        FROM TRANSPORTER_MASTER X
        WHERE PLANT_ID = P_PLANT_ID; -- AND 1 = CASE WHEN IFNULL(P_ISACTIVE, '') = '' THEN 1 ELSE (CASE WHEN X.IS_ACTIVE = P_ISACTIVE THEN 1 ELSE 0 END) END;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_TRANSPORTER_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_TRANSPORTER_SAVE`(
    IN P_ID INT,
    IN P_CODE    VARCHAR(255),
    IN P_NAME    VARCHAR(255),
    IN P_IS_ENTRY_MANUAL    VARCHAR(255),
    IN P_ISACTIVE VARCHAR(1),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT,
	OUT P_RESULT VARCHAR(16300)
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


	START TRANSACTION;
		SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator. DB_ERROR|0';
		
        SELECT COUNT(*) INTO TEMP_NUM FROM transporter_master X WHERE  X.tptr_cd = P_CODE AND X.tptr_name = P_NAME AND X.TRANS_SYS_ID != P_ID;
        
        IF TEMP_NUM > 0 THEN
			SET P_RESULT = 'E|Transporter name and code already exists.|0';    
		ELSEIF P_ID > 0 THEN

			UPDATE transporter_master SET tptr_cd = P_CODE, tptr_name = P_NAME, IS_ENTRY_MANUAL = IF(IFNULL(P_IS_ENTRY_MANUAL, '') != '' AND IFNULL(P_IS_ENTRY_MANUAL, '') = 'Y', 1, 0)
			WHERE TRANS_SYS_ID = P_ID;

			SET P_RESULT = 'S|Record updated successfully|';

		ELSE

			INSERT INTO transporter_master (tptr_cd, tptr_name, IS_ENTRY_MANUAL, PLANT_ID, CREATED_DATETIME)
			VALUES(P_CODE, P_NAME, IF(IFNULL(P_IS_ENTRY_MANUAL, '') != '' AND IFNULL(P_IS_ENTRY_MANUAL, '') = 'Y', 1, 0), P_PLANT_ID, NOW());

			SET P_RESULT = 'S|Record saved successfully|';
		END IF;
        
	COMMIT;
  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_USER_DELETE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_USER_DELETE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_USER_DELETE_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_USER_DELETE_NEW`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_USER_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_USER_GET`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_USER_GET_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_USER_GET_NEW`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_USER_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_USER_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_VENDOR_CHANGEPASSWORD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_VENDOR_CHANGEPASSWORD`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_VENDOR_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_VENDOR_GET`(
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
        
			SELECT PLANT_ID, VENDOR_SYS_ID AS ID, VENDOR_CODE, ORGANIZATION_NAME, VENDOR_SITE, FIRST_NAME, MIDDLE_NAME, LAST_NAME, PRIMARY_MOBILE AS MOBILE_NO, ALTERNATIVE_MOBILE, PRIMARY_EMAIL AS EMAIL_ID, ALTERNATIVE_EMAIL
            , PHONE_NUMBER, COUNTRY_ID, STATE_ID, DISTRICT_ID, CITY, ADDRESS, IS_SYSTEM_USER, PASSWORD, ACTIVE, USER_LOCK, Created_DateTime, IS_POSTED, VENDOR_TYPE, VENDOR_CODE_TEMP, PRINT_LABEL_QTY, ROLE_ID
			, 'No' IS_ERP_VENDOR
            FROM vendor_master X
            WHERE X.VENDOR_CODE = P_VENDOR_CODE AND IFNULL(VENDOR_SITE, '') != '';
            
            /*SELECT VENDOR_SYS_ID AS ID, PLANT_ID, NULL AS SITE_CODE, NULL AS SITE_NAME, ORGANIZATION_NAME, VENDOR_CODE, VENDOR_CODE_TEMP, VENDOR_TYPE,
            FIRST_NAME, MIDDLE_NAME, LAST_NAME, PRIMARY_MOBILE AS MOBILE_NO, NULL AS ALT_MOBILE_NO, PRIMARY_EMAIL AS EMAIL_ID, NULL AS ALT_EMAIL_ID, NULL AS FULL_ADDRESS, NULL AS COUNTRY_ID, NULL AS STATE_ID, NULL AS DISTRICT_ID, NULL AS CITY, NULL AS POSTAL_CODE, PRINT_LABEL_QTY,
            CASE WHEN IS_SYSTEM_USER = 'Y' THEN 1 ELSE 0 END AS IS_SYSTEM_USER, CASE WHEN X.IS_POSTED = 'Y' THEN 1 ELSE 0 END AS IS_POSTED, CASE WHEN X.USER_LOCK = 1 THEN 1 ELSE 0 END AS IS_LOCK, CASE WHEN X.ACTIVE = 1 THEN 1 ELSE 0 END AS ISACTIVE, NULL AS PLANTS, CASE WHEN COALESCE(X.VENDOR_CODE, 0) = COALESCE(X.VENDOR_CODE_TEMP, 0) THEN 'No' ELSE 'Yes' END AS IS_ERP_VENDOR
            FROM VENDOR_MASTER X
            WHERE X.VENDOR_CODE = P_VENDOR_CODE OR X.VENDOR_CODE_TEMP = P_VENDOR_CODE;

            SELECT DISTINCT VENDOR_SYS_ID AS ID, Z.PLANT_ID, Y.SITE_ID, Y.SITE_CODE, Y.SITE_NAME, ORGANIZATION_NAME, VENDOR_CODE, VENDOR_CODE_TEMP, VENDOR_TYPE,
            FIRST_NAME, MIDDLE_NAME, LAST_NAME, Y.PRIMARY_MOBILE AS ALT_MOBILE_NO, NULL AS MOBILE_NO, Y.PRIMARY_EMAIL AS ALT_EMAIL_ID, NULL AS EMAIL_ID, Y.ADDRESS AS FULL_ADDRESS, X.COUNTRY_ID, Y.STATE_ID, DISTRICT_ID, Y.CITY, Y.PIN_CODE AS POSTAL_CODE, NULL AS PRINT_LABEL_QTY,
            CASE WHEN IS_SYSTEM_USER = 'Y' THEN 1 ELSE 0 END AS IS_SYSTEM_USER, CASE WHEN X.IS_POSTED = 'Y' THEN 1 ELSE 0 END AS IS_POSTED, CASE WHEN X.USER_LOCK = 1 THEN 1 ELSE 0 END AS IS_LOCK, CASE WHEN X.ACTIVE = 1 THEN 1 ELSE 0 END AS ISACTIVE, NULL AS PLANTS, CASE WHEN COALESCE(X.VENDOR_CODE, 0) = COALESCE(X.VENDOR_CODE_TEMP, 0) THEN 'No' ELSE 'Yes' END AS IS_ERP_VENDOR
            FROM VENDOR_MASTER X, SITE_MASTER Y, SITE_MASTER_PLANT Z
            WHERE X.VENDOR_SYS_ID = Y.VENDER_ID AND Y.SITE_ID = Z.SITE_ID AND Z.PLANT_ID = CASE WHEN P_VENDOR_CODE = P_ID THEN Z.PLANT_ID ELSE P_PLANT_ID END AND (X.VENDOR_CODE = P_VENDOR_CODE OR X.VENDOR_CODE_TEMP = P_VENDOR_CODE);
			*/
            
        ELSEIF P_ID > 0 THEN
        
			SELECT PLANT_ID, VENDOR_SYS_ID AS ID, VENDOR_CODE, ORGANIZATION_NAME, VENDOR_SITE, FIRST_NAME, MIDDLE_NAME, LAST_NAME, PRIMARY_MOBILE AS MOBILE_NO, ALTERNATIVE_MOBILE, PRIMARY_EMAIL AS EMAIL_ID, ALTERNATIVE_EMAIL
            , PHONE_NUMBER, COUNTRY_ID, STATE_ID, DISTRICT_ID, CITY, ADDRESS, IS_SYSTEM_USER, PASSWORD, ACTIVE, USER_LOCK, Created_DateTime, IS_POSTED, VENDOR_TYPE, VENDOR_CODE_TEMP, PRINT_LABEL_QTY, ROLE_ID
			, 'No' IS_ERP_VENDOR
            FROM vendor_master X
            WHERE X.VENDOR_CODE IN (SELECT Z.VENDOR_CODE FROM vendor_master Z WHERE Z.VENDOR_SYS_ID = P_ID) AND IFNULL(VENDOR_SITE, '') != '';
            
            /*SELECT VENDOR_SYS_ID AS ID, Z.PLANT_ID,
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
			*/
            
        ELSEIF P_ID = 0 THEN
            /*SELECT MAX(VENDOR_SYS_ID) AS ID, Z.PLANT_ID, X.ORGANIZATION_NAME, X.VENDOR_CODE, X.VENDOR_TYPE, X.FIRST_NAME, X.MIDDLE_NAME, X.LAST_NAME, X.PRIMARY_MOBILE AS MOBILE_NO, X.PRIMARY_EMAIL AS EMAIL_ID,
            CASE WHEN IS_SYSTEM_USER = 'Y' THEN 1 ELSE 0 END AS IS_SYSTEM_USER, CASE WHEN X.IS_POSTED = 'Y' THEN 1 ELSE 0 END AS IS_POSTED, CASE WHEN X.USER_LOCK = 1 THEN 1 ELSE 0 END AS IS_LOCK, CASE WHEN X.ACTIVE = 1 THEN 1 ELSE 0 END AS ISACTIVE, NULL AS PLANTS, CASE WHEN COALESCE(X.VENDOR_CODE, 0) = COALESCE(X.VENDOR_CODE_TEMP, 0) THEN 'No' ELSE 'Yes' END AS IS_ERP_VENDOR
            FROM VENDOR_MASTER X, SITE_MASTER Y, SITE_MASTER_PLANT Z
            WHERE X.VENDOR_SYS_ID = Y.VENDER_ID AND Y.SITE_ID = Z.SITE_ID AND Z.PLANT_ID = P_PLANT_ID AND X.ACTIVE = CASE WHEN IFNULL(P_ISACTIVE, '') = '' THEN X.ACTIVE ELSE CASE WHEN P_ISACTIVE = 'Y' THEN 1 ELSE 0 END END
            AND 1 = (CASE WHEN LENGTH(IFNULL(P_SEARCHTERM, '')) > 0 THEN (CASE WHEN TRIM(UPPER(ORGANIZATION_NAME)) LIKE CONCAT('%', TRIM(UPPER(P_SEARCHTERM)), '%') THEN 1 ELSE 0 END) ELSE 1 END)
            GROUP BY Z.PLANT_ID, X.ORGANIZATION_NAME, X.VENDOR_CODE, X.VENDOR_CODE_TEMP, X.VENDOR_TYPE, X.FIRST_NAME, X.MIDDLE_NAME, X.LAST_NAME, X.PRIMARY_MOBILE, X.PRIMARY_EMAIL, X.IS_SYSTEM_USER, X.IS_POSTED, X.USER_LOCK, X.ACTIVE;
			*/
            
			SELECT PLANT_ID, VENDOR_SYS_ID AS ID, VENDOR_CODE, ORGANIZATION_NAME, VENDOR_SITE, FIRST_NAME, MIDDLE_NAME, LAST_NAME, PRIMARY_MOBILE AS MOBILE_NO, ALTERNATIVE_MOBILE, PRIMARY_EMAIL AS EMAIL_ID, ALTERNATIVE_EMAIL
            , PHONE_NUMBER, COUNTRY_ID, STATE_ID, DISTRICT_ID, CITY, ADDRESS, IS_SYSTEM_USER, PASSWORD, ACTIVE, USER_LOCK, Created_DateTime, IS_POSTED, VENDOR_TYPE, VENDOR_CODE_TEMP, PRINT_LABEL_QTY, ROLE_ID
			, 'No' IS_ERP_VENDOR
            FROM vendor_master 
            WHERE IFNULL(VENDOR_SITE, '') != '';
            
        END IF;
    -- END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_VENDOR_LOGIN_AUTH` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_VENDOR_LOGIN_AUTH`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_IN_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_IN_GET`(
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
							OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,'')) ) AND XZ.INWARD_SYS_ID IN (125, 1))
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_IN_GET_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_IN_GET_NEW`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(255),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT
)
BEGIN

WITH TBL_RESULT AS (SELECT PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO
	, GROUP_CONCAT(DISTINCT MDA_NO ORDER BY MDA_SYS_ID SEPARATOR ',') AS MDA_NO
	, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
	, GROUP_CONCAT(DISTINCT PLANT_CD ORDER BY PLANT_CD SEPARATOR ',') AS PLANT_CD 
	, GROUP_CONCAT(DISTINCT TRANS_SYS_ID ORDER BY TRANS_SYS_ID SEPARATOR ',') AS TRANS_SYS_IDS
	, GROUP_CONCAT(DISTINCT PROD_SYS_ID ORDER BY PROD_SYS_ID SEPARATOR ',') AS PROD_SYS_IDS
	, GROUP_CONCAT(DISTINCT WH_CD ORDER BY WH_CD SEPARATOR ',') AS WH_CD 
	, GROUP_CONCAT(DISTINCT PARTY_NAME ORDER BY PARTY_NAME SEPARATOR ',') AS PARTY_NAME 
    , VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID
	FROM (SELECT GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO
		, GIO.GATE_IN_DT, GIO.GATE_OUT_DT, GIO.INWARD_SYS_ID, GIO.DRIVER_ID_TYPE, GIO.DRIVER_ID_NUMBER, IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_NAME_NEW, GIO.DRIVER_NAME) AS DRIVER_NAME,  IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_CONTACT_NEW, GIO.DRIVER_CONTACT) AS DRIVER_CONTACT, GIO.DRIVER_CHANGED
		, GIO.MDA_SYS_IDS AS MDA_SYS_IDS, MH.MDA_SYS_ID, MH.MDA_NO
		, MH.PLANT_CD, MH.TRANS_SYS_ID, MD.PROD_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
        , GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID
		FROM fg_gate_in_out GIO
		INNER JOIN mda_header MH ON GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0
		LEFT JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
		WHERE MH.PLANT_ID = P_PLANT_ID AND GIO.GATE_OUT_DT IS NULL AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
		AND MH.OUT_TIME IS NULL -- AND MD.PROD_SYS_ID IN (35,55,56)
        AND IF(IFNULL(P_SEARCHTERM,'') = '', TRUE, 
				(GIO.TRUCK_NO = P_SEARCHTERM
					OR 0 < (SELECT COUNT(*) FROM mda_header MHZ WHERE GIO.PLANT_ID = MHZ.PLANT_ID AND MHZ.MDA_NO = P_SEARCHTERM AND FIND_IN_SET(MHZ.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0 AND MHZ.OUT_TIME IS NULL)
					OR GIO.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,'')))
                )
			)
		AND 0 = (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = GIO.GATE_SYS_ID)
		ORDER BY MH.PLANT_ID, GIO.GATE_IN_DT DESC
	) X
	GROUP BY PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY GIO.PLANT_ID, GATE_IN_DT DESC, GATE_SYS_ID, VEHICLE_NO)) AS SR_NO
, GIO.PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, MDA_NO COMMON_NO
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
    , DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
	, INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = GIO.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE
    , DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = GIO.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
    , DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, GIO.PLANT_CD, TRANS_SYS_IDS, PROD_SYS_IDS, WH_CD, PARTY_NAME
, GROUP_CONCAT(DISTINCT PM.PROD_SYS_ID ORDER BY PM.PROD_SYS_ID SEPARATOR ',') AS PROD_SYS_IDS
, GROUP_CONCAT(DISTINCT PM.PRD_CD ORDER BY PM.PRD_CD SEPARATOR ',') AS PROD_CD
, GROUP_CONCAT(DISTINCT PM.PRD_DESC ORDER BY PM.PRD_DESC SEPARATOR ',') AS PROD_NAME
, GROUP_CONCAT(DISTINCT TM.TRANS_SYS_ID ORDER BY TM.TRANS_SYS_ID SEPARATOR ',') AS TRANS_SYS_IDS
, GROUP_CONCAT(DISTINCT TM.TPTR_CD ORDER BY TM.TPTR_CD SEPARATOR ',') AS TRANS_CD
, GROUP_CONCAT(DISTINCT TM.TPTR_NAME ORDER BY TM.TPTR_NAME SEPARATOR ',') AS TRANS_NAME
, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME
FROM TBL_RESULT GIO
LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = GIO.PLANT_ID AND FIND_IN_SET(TM.TRANS_SYS_ID, GIO.TRANS_SYS_IDS) > 0
LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = GIO.PLANT_ID AND FIND_IN_SET(PM.PROD_SYS_ID, GIO.PROD_SYS_IDS) > 0
GROUP BY GIO.PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, MDA_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
ORDER BY PLANT_ID, GATE_IN_DT DESC, GATE_SYS_ID, VEHICLE_NO;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_IN_GET_OTHER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_IN_GET_OTHER`(
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
        INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE,
        ORDER_NO COMMON_NO, OTHER_SYS_ID COMMON_SYS_ID, TRANS_SYS_ID, TRANSACTION_TYPE,
        (SELECT TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME, TRANSACTION_TYPE,
        TRUCK_NO, DRIVER_ID_TYPE,
        (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT,
        DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION,
        X.RFSYSID, XZ.RFIDSRNO, XZ.RFIDCODE,
        VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME, NULL GATE_SYS_ID_OLD, NULL CANCEL_GATE_IN, NULL CANCEL_GATE_REASON,
        NULL VENDOR_SYS_ID, NULL VENDOR_CODE, NULL VENDOR_NAME
        , NULL CUST_CD, NULL CUST_NAME, NULL CUST_SITE_CD, NULL SITE_NAME, X.STATION_ID, X.PLANT_ID, PM.PLANT_NAME, PM.PLANTCODE AS PLANT_CODE
    FROM (
        SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.OTHER_SYS_ID, Y.ORDER_NO, Y.TRUCK_NO, Y.ORDER_DATE, Y.TRANS_SYS_ID, X.TRANSACTION_TYPE
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID
				FROM other_gate_in_out X, 
				(SELECT Z.* FROM other_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID
					AND ((Z.TRUCK_NO = P_SEARCHTERM 
							OR Z.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_header XZ WHERE XZ.ORDER_NO = P_SEARCHTERM OR XZ.OTHER_SYS_ID = IFNULL(P_ID,0)) 
							OR Z.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID = 4)
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0)
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.TRUCK_NO 
                 AND 0 = (SELECT COUNT(*) FROM other_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID)
                AND 1 = (CASE WHEN IFNULL(P_SEARCHTERM,'') = '' THEN (CASE WHEN X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL THEN 1 ELSE 0 END ) ELSE 1 END ) 
    ) X
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_IN_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_IN_SAVE`(
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_IN_SAVE_OTHER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_IN_SAVE_OTHER`(
    IN P_ID INT, 
    IN P_INWARD_SYS_ID INT, 
    IN P_WEIGH_IN_WT DECIMAL(10,2), 
    IN P_WEIGH_IN_WT_NOTE VARCHAR(255), 
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

            IF IFNULL(P_WEIGH_IN_WT, 0) <= 0 THEN
                SET P_RESULT = 'E|Weigh In weight require.|0';
            ELSE

				IF COALESCE(P_INWARD_SYS_ID, 0) > 0 AND P_INWARD_SYS_ID = 4 AND COALESCE(TEMP_NUM, 0) = 0 THEN
				
					INSERT INTO other_weighment_detail (GATE_SYS_ID, WEIGHIN_WT, WEIGHIN_WT_DT, WEIGHIN_WT_NOTE, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME) 
					VALUES (P_ID, P_WEIGH_IN_WT, NOW(), P_WEIGH_IN_WT_NOTE, 7, P_PLANT_ID, P_USER_ID, NOW());

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
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_IN_SLIP_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_IN_SLIP_GET`(
    IN P_PURPOSE_TYPE INT,
    IN P_GATE_SYS_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
)
BEGIN

IF IFNULL(P_PURPOSE_TYPE, 1) = 1 THEN
		
		SELECT PlantID PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Weighment Slip - Weigh In' REPORT_TITLE
		FROM PLANT_MASTER WHERE PlantID = P_PLANT_ID;
		
		WITH TBL_RESULT AS (SELECT X.PLANT_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, VEHICLE_NO, X.MDA_NO
			, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
			, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID, RFSYSID, DIST, DESP_PLACE
			, PROD_SYS_ID, BAG_NOS, CAST((BAG_NOS / 24) AS unsigned) Required_Shipper
			-- , (SELECT COUNT(*) FROM MDA_LOADING ML WHERE ML.PLANT_ID = X.PLANT_ID AND ML.GATE_SYS_ID = X.GATE_SYS_ID AND ML.MDA_SYS_ID = X.MDA_SYS_ID AND ML.PROD_SYS_ID = X.PROD_SYS_ID) 
            , NULL Loaded_Shipper, NULL Qty
			FROM (
				SELECT Z.PLANT_ID, Z.GATE_SYS_ID, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID
				, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
				, MDA_SYS_IDS, MD.MDA_SYS_ID, Z.MDA_NO, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, MOBILE_NO, DIST, DESP_PLACE, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID, RFSYSID
				, MD.PROD_SYS_ID, MD.BAG_NOS
				FROM (SELECT GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO
					, GIO.GATE_IN_DT, GIO.GATE_OUT_DT, GIO.INWARD_SYS_ID, GIO.DRIVER_ID_TYPE, GIO.DRIVER_ID_NUMBER, IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_NAME_NEW, GIO.DRIVER_NAME) AS DRIVER_NAME,  IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_CONTACT_NEW, GIO.DRIVER_CONTACT) AS DRIVER_CONTACT, GIO.DRIVER_CHANGED
					, GIO.MDA_SYS_IDS AS MDA_SYS_IDS, MH.MDA_SYS_ID, MH.MDA_NO
					, MH.PLANT_CD, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
					, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, GIO.RFSYSID
					FROM fg_gate_in_out GIO
					INNER JOIN mda_header MH ON GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0
					WHERE MH.PLANT_ID = P_PLANT_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
					-- AND GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL
					AND IF(IFNULL(P_GATE_SYS_ID,0)= 0, GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL, GIO.GATE_SYS_ID = P_GATE_SYS_ID) 
					AND IF(IFNULL(P_SEARCHTERM,'') = '', TRUE, 
								(GIO.TRUCK_NO = P_SEARCHTERM
								OR 0 < (SELECT COUNT(*) FROM mda_header MHZ WHERE GIO.PLANT_ID = MHZ.PLANT_ID AND MHZ.MDA_NO = P_SEARCHTERM AND FIND_IN_SET(MHZ.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0 AND MHZ.OUT_TIME IS NULL)
								OR GIO.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,'')))
								)
						)
					AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = GIO.GATE_SYS_ID AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL)
                    -- AND 0 = (SELECT COUNT(*) FROM MDA_LOADING ML WHERE ML.PLANT_ID = MH.PLANT_ID AND ML.MDA_SYS_ID = MH.MDA_SYS_ID )
					ORDER BY MH.PLANT_ID, GIO.GATE_IN_DT DESC) Z
					INNER JOIN mda_detail MD ON MD.PLANT_ID = Z.PLANT_ID AND MD.MDA_SYS_ID = Z.MDA_SYS_ID
					-- WHERE MD.PROD_SYS_ID IN (35,55,56)
			) X
		)
		SELECT (ROW_NUMBER() OVER (ORDER BY GIO.PLANT_ID, GATE_IN_DT DESC, GIO.GATE_SYS_ID, VEHICLE_NO)) AS SR_NO
		, GIO.PLANT_ID, GIO.GATE_SYS_ID, MDA_SYS_ID, VEHICLE_NO, MDA_NO COMMON_NO
			, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
			, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
			, INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = GIO.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE
			, DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = GIO.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
			, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
		, GIO.PLANT_CD, WH_CD, PARTY_NAME
		, PM.PROD_SYS_ID, PM.PRD_CD AS PRODUCT_CODE, PM.PRD_DESC AS PRODUCT_DESC
		, TM.TRANS_SYS_ID, TM.TPTR_CD AS TRANSPORTER_CODE, TM.TPTR_NAME AS TRANSPORTER_NAME
		, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME, NULL TRANSACTION_TYPE
		, RM.RFSYSID, RM.RFIDSRNO, DIST AS DISTANCE, DESP_PLACE
				, ZZ.TARE_WT WEIGHIN_WT, ZZ.TARE_WT_NOTE WEIGHIN_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT
				, ZZ.GROSS_WT WEIGHOUT_WT, ZZ.GROSS_WT_NOTE WEIGHOUT_WT_NOTE, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHOUT_WT_DT
				, ZZ.NET_WT, ZZ.TOLERANCE_WT, BAG_NOS, Required_Shipper, Loaded_Shipper, NULL Qty
                , NULL STATUS, NULL Skip_LILO_Remarks, 'KG' UOM, 'Kg' WEIGHT_UOM
		FROM TBL_RESULT GIO
		INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.PLANT_ID = GIO.PLANT_ID AND ZZ.GATE_SYS_ID = GIO.GATE_SYS_ID
		LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = GIO.PLANT_ID AND TM.TRANS_SYS_ID = GIO.TRANS_SYS_ID
		LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = GIO.PLANT_ID AND PM.PROD_SYS_ID = GIO.PROD_SYS_ID
		LEFT JOIN rfid_master RM ON RM.PLANT_ID = GIO.PLANT_ID AND RM.RFSYSID = GIO.RFSYSID 
		ORDER BY PLANT_ID, GATE_IN_DT DESC, GATE_SYS_ID, VEHICLE_NO;

	ELSEIF IFNULL(P_PURPOSE_TYPE, 1) = 4 THEN
    
		SELECT PlantID PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Weighment Slip - Weigh In Other Material' REPORT_TITLE
		FROM PLANT_MASTER WHERE PlantID = P_PLANT_ID;
		
        WITH TBL_MAIN AS (SELECT PLANT_ID, GATE_SYS_ID
							FROM other_gate_in_out
							WHERE PLANT_ID = P_PLANT_ID AND COALESCE(CANCEL_GATE_IN, 0) = 0 
							AND (CASE WHEN IFNULL(TRIM(P_SEARCHTERM),'') != '' AND IFNULL(P_GATE_SYS_ID, 0) > 0 THEN GATE_SYS_ID = IFNULL(P_GATE_SYS_ID, 0) AND TRUCK_NO = TRIM(P_SEARCHTERM) 
							 WHEN IFNULL(TRIM(P_SEARCHTERM),'') = '' AND IFNULL(P_GATE_SYS_ID, 0) = 0 THEN FALSE 
							 WHEN IFNULL(TRIM(P_SEARCHTERM),'') != '' AND IFNULL(P_GATE_SYS_ID, 0) = 0 THEN TRUCK_NO = TRIM(P_SEARCHTERM) 
							 WHEN IFNULL(TRIM(P_SEARCHTERM),'') = '' AND IFNULL(P_GATE_SYS_ID, 0) > 0 THEN GATE_SYS_ID = IFNULL(P_GATE_SYS_ID, 0) ELSE FALSE END)
							ORDER BY PLANT_ID, GATE_SYS_ID DESC)
        SELECT (ROW_NUMBER() OVER (ORDER BY ORDER_DATE DESC, GATE_IN_DT DESC)) AS SR_NO
        , X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID ID, X.TRANSACTION_TYPE, OH.OTHER_SYS_ID COMMON_ID, OH.ORDER_NO COMMON_NO, X.TRUCK_NO VEHICLE_NO
		, DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(OH.ORDER_DATE, '%d/%m/%Y %H:%i') AS COMMON_DT
		, NULL BAG_NOS, NULL Required_Shipper, NULL Loaded_Shipper
		, ZZ.WEIGHIN_WT, ZZ.WEIGHIN_WT_NOTE, DATE_FORMAT(ZZ.WEIGHIN_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT
		, ZZ.WEIGHOUT_WT, ZZ.WEIGHOUT_WT_NOTE, DATE_FORMAT(ZZ.WEIGHOUT_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHOUT_WT_DT
		, NULL NET_WT, NULL TOLERANCE_WT
		, OD.SR_NO PROD_SYS_ID, OD.MATERIAL PRODUCT_CODE, OD.MATERIAL_DESC PRODUCT_DESC
		, X.TRANS_SYS_ID, TM.tptr_cd TRANSPORTER_CODE, TM.TPTR_NAME TRANSPORTER_NAME, 'IFFCO' PARTY_NAME
		, NULL WH_CD, 'IFFCO' PARTY_NAME, NULL Distance, NULL desp_place
		, X.RFSYSID, RM.RFIDSRNO, NULL STATUS, NULL Skip_LILO_Remarks, OD.QTY, OD.UMO UOM, 'Kg' WEIGHT_UOM
		FROM other_gate_in_out X
		INNER JOIN other_header OH ON OH.PLANT_ID = X.PLANT_ID AND OH.OTHER_SYS_ID = X.OTHER_SYS_ID
		INNER JOIN other_detail OD ON OD.PLANT_ID = X.PLANT_ID AND OD.OTHER_SYS_ID = X.OTHER_SYS_ID
		INNER JOIN other_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
		INNER JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = X.PLANT_ID AND TM.TRANS_SYS_ID = X.TRANS_SYS_ID
		LEFT JOIN rfid_master RM ON RM.PLANT_ID = X.PLANT_ID AND RM.RFSYSID = X.RFSYSID 
		WHERE X.PLANT_ID = P_PLANT_ID
					/*AND ((X.TRUCK_NO = P_SEARCHTERM 
							OR X.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_header XZ WHERE XZ.ORDER_NO = P_SEARCHTERM) 
							OR X.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_gate_in_out XZ WHERE XZ.GATE_SYS_ID = IFNULL(P_GATE_SYS_ID, 0) OR XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID = 4)
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_GATE_SYS_ID,0) = 0, 1, 0)
						)*/
		AND (X.PLANT_ID, X.GATE_SYS_ID) IN (SELECT PLANT_ID, GATE_SYS_ID FROM TBL_MAIN)
		-- AND X.GATE_IN_DT IS NOT NULL AND X.GATE_OUT_DT IS NULL
        AND IFNULL(ZZ.WEIGHIN_WT,0) > 0 AND ZZ.WEIGHIN_WT_DT IS NOT NULL -- AND IFNULL(ZZ.WEIGHOUT_WT,0) = 0 AND ZZ.WEIGHOUT_WT_DT IS NULL
		ORDER BY X.GATE_IN_DT  DESC, X.GATE_OUT_DT  DESC, OH.ORDER_DATE  DESC;
        
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_IN_SLIP_GET_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_IN_SLIP_GET_NEW`(
    IN P_PURPOSE_TYPE INT,
    IN P_GATE_SYS_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
)
BEGIN
    
    IF IFNULL(P_PURPOSE_TYPE, 1) = 1 THEN
		
		SELECT PlantID PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Weighment Slip - Weigh In' REPORT_TITLE
		FROM PLANT_MASTER WHERE PlantID = P_PLANT_ID;
		
		WITH TBL_MAIN AS (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, MH.MDA_SYS_ID, MH.MDA_NO, X.TRUCK_NO VEHICLE_NO, MH.PLANT_CD
				, GATE_IN_DT, GATE_OUT_DT, MH.MDA_DT, MH.OUT_TIME
				, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
				, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DIST,MH.desp_place, X.RFSYSID
				FROM (SELECT 
						TRIM(SUBSTRING_INDEX(input_string, ',', 1)) AS PLANT_ID,
						TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 2), ',', -1)) AS GATE_SYS_ID,
						TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 3), ',', -1)) AS MDA_SYS_ID,
						TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 4), ',', -1)) AS MDA_NO,
						TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 5), ',', -1)) AS VEHICLE_NO,
						TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 6), ',', -1)) AS MDA_DT,
						TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 7), ',', -1)) AS OUT_TIME
					FROM (SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, '#', n.digit+1), '#', -1)) AS input_string
					FROM (SELECT FN_GATE_IN_OUT_MDA_GET(P_PLANT_ID, P_GATE_SYS_ID, 0, P_SEARCHTERM) AS input_string) AS data
					CROSS JOIN (SELECT 0 AS digit UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) AS n 
					WHERE n.digit < LENGTH(input_string) - LENGTH(REPLACE(input_string, '#', '')) + 1) X) XZ
				INNER JOIN fg_gate_in_out X ON X.PLANT_ID = XZ.PLANT_ID AND X.GATE_SYS_ID = XZ.GATE_SYS_ID
				INNER JOIN mda_header MH ON MH.PLANT_ID = X.PLANT_ID AND MH.MDA_SYS_ID = XZ.MDA_SYS_ID
				WHERE X.PLANT_ID = XZ.PLANT_ID AND X.GATE_IN_DT IS NOT NULL AND COALESCE(X.CANCEL_GATE_IN, 0) = 0
				AND (CASE WHEN IFNULL(P_SEARCHTERM,'') != '' THEN X.TRUCK_NO = P_SEARCHTERM OR MH.MDA_NO = P_SEARCHTERM
						  WHEN IFNULL(P_GATE_SYS_ID,0) > 0 THEN X.GATE_SYS_ID = P_GATE_SYS_ID
						  ELSE FALSE END)
				ORDER BY 3 DESC, 4 DESC
		)
		SELECT (ROW_NUMBER() OVER (ORDER BY X.Distance DESC)) AS SR_NO, X.* 
		FROM (
		SELECT M_G.PLANT_ID, M_G.STATION_ID, M_G.GATE_SYS_ID ID, NULL TRANSACTION_TYPE, M_G.MDA_SYS_ID COMMON_ID, M_G.MDA_NO COMMON_NO, M_G.VEHICLE_NO
		, DATE_FORMAT(M_G.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(M_G.MDA_DT, '%d/%m/%Y %H:%i') AS COMMON_DT
		, MD.BAG_NOS, (MD.BAG_NOS / 24) Required_Shipper
		, (SELECT COUNT(*) FROM MDA_LOADING Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND Z.GATE_SYS_ID = M_G.GATE_SYS_ID AND Z.MDA_SYS_ID = M_G.MDA_SYS_ID) Loaded_Shipper, NULL Qty
		, ZZ.TARE_WT WEIGHIN_WT, ZZ.TARE_WT_NOTE WEIGHIN_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT
		, ZZ.GROSS_WT WEIGHOUT_WT, ZZ.GROSS_WT_NOTE WEIGHOUT_WT_NOTE, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHOUT_WT_DT
		, ZZ.NET_WT, ZZ.TOLERANCE_WT
		, MD.PROD_SYS_ID, PRD_CD PRODUCT_CODE, PRD_DESC PRODUCT_DESC
		, M_G.TRANS_SYS_ID, TM.tptr_cd TRANSPORTER_CODE, TM.TPTR_NAME TRANSPORTER_NAME, 'IFFCO' PARTY_NAME
		, M_G.WH_CD, /*M_G.PARTY_NAME,*/ M_G.DIST Distance, M_G.desp_place
		, M_G.RFSYSID, RM.RFIDSRNO, NULL STATUS, NULL Skip_LILO_Remarks, 'KG' UOM
		FROM TBL_MAIN M_G
		INNER JOIN mda_detail MD ON MD.PLANT_ID = M_G.PLANT_ID AND MD.MDA_SYS_ID = M_G.MDA_SYS_ID
		INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = M_G.GATE_SYS_ID AND ZZ.STATION_ID = M_G.STATION_ID AND ZZ.PLANT_ID = M_G.PLANT_ID
		INNER JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = M_G.PLANT_ID AND TM.TRANS_SYS_ID = M_G.TRANS_SYS_ID
		LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = M_G.PLANT_ID AND PM.PROD_SYS_ID = MD.PROD_SYS_ID
		LEFT JOIN rfid_master RM ON RM.PLANT_ID = M_G.PLANT_ID AND RM.RFSYSID = M_G.RFSYSID 
		WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL 
		AND (CASE WHEN IFNULL(P_SEARCHTERM,'') != '' THEN IFNULL(M_G.OUT_TIME, '')='' ELSE TRUE END)
		ORDER BY M_G.GATE_IN_DT  DESC, M_G.GATE_OUT_DT  DESC, M_G.MDA_DT  DESC
		) X;

	ELSEIF IFNULL(P_PURPOSE_TYPE, 1) = 4 THEN
    
		SELECT PlantID PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Weighment Slip - Weigh In Other Material' REPORT_TITLE
		FROM PLANT_MASTER WHERE PlantID = P_PLANT_ID;
		
        SELECT (ROW_NUMBER() OVER (ORDER BY ORDER_DATE DESC, GATE_IN_DT DESC)) AS SR_NO
        , X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID ID, X.TRANSACTION_TYPE, OH.OTHER_SYS_ID COMMON_ID, OH.ORDER_NO COMMON_NO, X.TRUCK_NO VEHICLE_NO
		, DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(OH.ORDER_DATE, '%d/%m/%Y %H:%i') AS COMMON_DT
		, NULL BAG_NOS, NULL Required_Shipper, NULL Loaded_Shipper
		, ZZ.WEIGHIN_WT, ZZ.WEIGHIN_WT_NOTE, DATE_FORMAT(ZZ.WEIGHIN_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT
		, ZZ.WEIGHOUT_WT, ZZ.WEIGHOUT_WT_NOTE, DATE_FORMAT(ZZ.WEIGHOUT_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHOUT_WT_DT
		, NULL NET_WT, NULL TOLERANCE_WT
		, OD.SR_NO PROD_SYS_ID, OD.MATERIAL PRODUCT_CODE, OD.MATERIAL_DESC PRODUCT_DESC
		, X.TRANS_SYS_ID, TM.tptr_cd TRANSPORTER_CODE, TM.TPTR_NAME TRANSPORTER_NAME, 'IFFCO' PARTY_NAME
		, NULL WH_CD, 'IFFCO' PARTY_NAME, NULL Distance, NULL desp_place
		, X.RFSYSID, RM.RFIDSRNO, NULL STATUS, NULL Skip_LILO_Remarks, OD.QTY, OD.UMO UOM
		FROM other_gate_in_out X
		INNER JOIN other_header OH ON OH.PLANT_ID = X.PLANT_ID AND OH.OTHER_SYS_ID = X.OTHER_SYS_ID
		INNER JOIN other_detail OD ON OD.PLANT_ID = X.PLANT_ID AND OD.OTHER_SYS_ID = X.OTHER_SYS_ID
		INNER JOIN other_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
		INNER JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = X.PLANT_ID AND TM.TRANS_SYS_ID = X.TRANS_SYS_ID
		LEFT JOIN rfid_master RM ON RM.PLANT_ID = X.PLANT_ID AND RM.RFSYSID = X.RFSYSID 
		WHERE X.PLANT_ID = P_PLANT_ID
					AND ((X.TRUCK_NO = P_SEARCHTERM 
							OR X.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_header XZ WHERE XZ.ORDER_NO = P_SEARCHTERM) 
							OR X.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_gate_in_out XZ WHERE XZ.GATE_SYS_ID = IFNULL(P_GATE_SYS_ID, 0) OR XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID = 4)
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_GATE_SYS_ID,0) = 0, 1, 0)
						)
		AND X.GATE_IN_DT IS NOT NULL AND X.GATE_OUT_DT IS NULL
        AND IFNULL(ZZ.WEIGHIN_WT,0) > 0 AND ZZ.WEIGHIN_WT_DT IS NOT NULL AND IFNULL(ZZ.WEIGHOUT_WT,0) = 0 AND ZZ.WEIGHOUT_WT_DT IS NULL
		ORDER BY X.GATE_IN_DT  DESC, X.GATE_OUT_DT  DESC, OH.ORDER_DATE  DESC;
        
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_OUT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_OUT_GET`(
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
							OR Z.VEHICLE_NO IN (SELECT XZ.TRUCK_NO FROM fg_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,'')) ) AND XZ.INWARD_SYS_ID IN (125, 1))
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0)
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.VEHICLE_NO AND COALESCE(X.CANCEL_GATE_IN, 0) = 0 AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND XZ.TARE_WT IS NOT NULL AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.GROSS_WT_DT IS NULL AND IFNULL(XZ.GROSS_WT,0) = 0)
	)
	SELECT X.PLANT_ID, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.MDA_SYS_ID COMMON_SYS_ID, X.MDA_NO COMMON_NO, X.VEHICLE_NO TRUCK_NO, INWARD_SYS_ID, X.PLANT_CD PLANT_CODE
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i') AS MDA_DT
	, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
	, X.TRANS_SYS_ID, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.TARE_WT, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS TARE_WT_DT
	FROM TBL_MAIN X 
	LEFT JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
	-- WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) = 0 AND ZZ.GROSS_WT_DT IS NULL
	ORDER BY X.GATE_IN_DT DESC, X.MDA_DT DESC;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_OUT_GET_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_OUT_GET_NEW`(
	IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(10),
    IN P_PLANT_ID INT,
    IN P_USER_ID INT,
    IN P_ROLE_ID INT,
    IN P_MENU_ID INT)
BEGIN

WITH TBL_RESULT AS (SELECT PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO
	, GROUP_CONCAT(DISTINCT MDA_NO ORDER BY MDA_SYS_ID SEPARATOR ',') AS MDA_NO
	, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
	, GROUP_CONCAT(DISTINCT PLANT_CD ORDER BY PLANT_CD SEPARATOR ',') AS PLANT_CD 
	, GROUP_CONCAT(DISTINCT TRANS_SYS_ID ORDER BY TRANS_SYS_ID SEPARATOR ',') AS TRANS_SYS_IDS
	, GROUP_CONCAT(DISTINCT PROD_SYS_ID ORDER BY PROD_SYS_ID SEPARATOR ',') AS PROD_SYS_IDS
	, GROUP_CONCAT(DISTINCT WH_CD ORDER BY WH_CD SEPARATOR ',') AS WH_CD 
	, GROUP_CONCAT(DISTINCT PARTY_NAME ORDER BY PARTY_NAME SEPARATOR ',') AS PARTY_NAME 
    , VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID
	FROM (SELECT GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO
		, GIO.GATE_IN_DT, GIO.GATE_OUT_DT, GIO.INWARD_SYS_ID, GIO.DRIVER_ID_TYPE, GIO.DRIVER_ID_NUMBER, IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_NAME_NEW, GIO.DRIVER_NAME) AS DRIVER_NAME,  IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_CONTACT_NEW, GIO.DRIVER_CONTACT) AS DRIVER_CONTACT, GIO.DRIVER_CHANGED
		, GIO.MDA_SYS_IDS AS MDA_SYS_IDS, MH.MDA_SYS_ID, MH.MDA_NO
		, MH.PLANT_CD, MH.TRANS_SYS_ID, MD.PROD_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
        , GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID
		FROM fg_gate_in_out GIO
		INNER JOIN mda_header MH ON GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0
		LEFT JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
		WHERE MH.PLANT_ID = P_PLANT_ID AND GIO.GATE_OUT_DT IS NULL AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
		AND MH.OUT_TIME IS NULL -- AND MD.PROD_SYS_ID IN (35,55,56)
        AND IF(IFNULL(P_SEARCHTERM,'') = '', TRUE, 
				(GIO.TRUCK_NO = P_SEARCHTERM
					OR 0 < (SELECT COUNT(*) FROM mda_header MHZ WHERE GIO.PLANT_ID = MHZ.PLANT_ID AND MHZ.MDA_NO = P_SEARCHTERM AND FIND_IN_SET(MHZ.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0 AND MHZ.OUT_TIME IS NULL)
					OR GIO.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,'')))
                )
			)
		AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = GIO.GATE_SYS_ID 
								AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) = 0 AND XZ.GROSS_WT_DT IS NULL)
		ORDER BY MH.PLANT_ID, GIO.GATE_IN_DT DESC
	) X
	GROUP BY PLANT_ID, GATE_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID
)
SELECT (ROW_NUMBER() OVER (ORDER BY GIO.PLANT_ID, GATE_IN_DT DESC, GIO.GATE_SYS_ID, VEHICLE_NO)) AS SR_NO
, GIO.PLANT_ID, GIO.GATE_SYS_ID, ZZ.WT_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, MDA_NO COMMON_NO
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
    , DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
	, INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = GIO.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE
    , DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = GIO.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
    , DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
, GIO.PLANT_CD, TRANS_SYS_IDS, PROD_SYS_IDS, WH_CD, PARTY_NAME
, GROUP_CONCAT(DISTINCT PM.PROD_SYS_ID ORDER BY PM.PROD_SYS_ID SEPARATOR ',') AS PROD_SYS_IDS
, GROUP_CONCAT(DISTINCT PM.PRD_CD ORDER BY PM.PRD_CD SEPARATOR ',') AS PROD_CD
, GROUP_CONCAT(DISTINCT PM.PRD_DESC ORDER BY PM.PRD_DESC SEPARATOR ',') AS PROD_NAME
, GROUP_CONCAT(DISTINCT TM.TRANS_SYS_ID ORDER BY TM.TRANS_SYS_ID SEPARATOR ',') AS TRANS_SYS_IDS
, GROUP_CONCAT(DISTINCT TM.TPTR_CD ORDER BY TM.TPTR_CD SEPARATOR ',') AS TRANS_CD
, GROUP_CONCAT(DISTINCT TM.TPTR_NAME ORDER BY TM.TPTR_NAME SEPARATOR ',') AS TRANS_NAME
, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME
, ZZ.TARE_WT WEIGHIN_WT, ZZ.TARE_WT_NOTE WEIGHIN_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT, NULL TRANSACTION_TYPE
FROM TBL_RESULT GIO
INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.PLANT_ID = GIO.PLANT_ID AND ZZ.GATE_SYS_ID = GIO.GATE_SYS_ID
LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = GIO.PLANT_ID AND FIND_IN_SET(TM.TRANS_SYS_ID, GIO.TRANS_SYS_IDS) > 0
LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = GIO.PLANT_ID AND FIND_IN_SET(PM.PROD_SYS_ID, GIO.PROD_SYS_IDS) > 0
GROUP BY GIO.PLANT_ID, GATE_SYS_ID, ZZ.WT_SYS_ID, MDA_SYS_IDS, VEHICLE_NO, MDA_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
		, ZZ.TARE_WT, ZZ.TARE_WT_NOTE, ZZ.TARE_WT_DT
ORDER BY PLANT_ID, GATE_IN_DT DESC, GATE_SYS_ID, VEHICLE_NO;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_OUT_GET_OTHER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_OUT_GET_OTHER`(
    IN P_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_ISACTIVE VARCHAR(10),
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
    
    WITH TBL_MAIN AS 
	(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.OTHER_SYS_ID, Y.ORDER_NO, Y.TRUCK_NO, Y.ORDER_DATE, Y.TRANS_SYS_ID, X.TRANSACTION_TYPE,
        INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = X.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE
		, X.GATE_IN_DT, X.GATE_OUT_DT, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
		, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID
				FROM other_gate_in_out X, 
				(SELECT Z.* FROM other_header Z
					WHERE Z.PLANT_ID = P_PLANT_ID 
					AND ((Z.TRUCK_NO = P_SEARCHTERM
							OR Z.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_header XZ WHERE XZ.TRUCK_NO = P_SEARCHTERM OR XZ.OTHER_SYS_ID = IFNULL(P_ID,0)) 
							OR Z.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_gate_in_out XZ WHERE XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID = 4)
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_ID,0) = 0, 1, 0)
						)
				) Y WHERE X.PLANT_ID = Y.PLANT_ID AND X.TRUCK_NO = Y.TRUCK_NO AND X.GATE_OUT_DT IS NULL AND X.GATE_IN_DT IS NOT NULL
				AND 0 < (SELECT COUNT(*) FROM other_weighment_detail XZ WHERE XZ.GATE_SYS_ID = X.GATE_SYS_ID AND IFNULL(XZ.WEIGHIN_WT,0) > 0 AND XZ.WEIGHIN_WT_DT IS NOT NULL AND IFNULL(XZ.WEIGHOUT_WT,0) = 0 AND XZ.WEIGHOUT_WT_DT IS NULL)
	)
	SELECT X.PLANT_ID, X.STATION_ID, ZZ.WT_SYS_ID ID, X.GATE_SYS_ID Gate_In_Id, X.OTHER_SYS_ID COMMON_SYS_ID, X.ORDER_NO COMMON_NO, X.TRUCK_NO
	, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(ORDER_DATE, '%d/%m/%Y %H:%i') AS ORDER_DATE
	, X.INWARD_SYS_ID, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
	, X.TRANS_SYS_ID, (SELECT Z.TPTR_NAME FROM TRANSPORTER_MASTER Z WHERE Z.TRANS_SYS_ID = X.TRANS_SYS_ID and Z.Plant_ID = X.PLANT_ID LIMIT 1) AS TRANSPORTER_NAME
	, X.DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = X.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
	, ZZ.WEIGHIN_WT, DATE_FORMAT(ZZ.WEIGHIN_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT
    , X.PLANT_ID, PM.PLANT_NAME, PM.PLANTCODE AS PLANT_CODE, X.TRANSACTION_TYPE
    , X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME
	FROM TBL_MAIN X 
	LEFT JOIN other_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.PLANT_ID = X.PLANT_ID
    LEFT JOIN RFID_MASTER XZ ON X.RFSYSID = XZ.RFSYSID AND X.STATION_ID = XZ.STATION_ID AND X.PLANT_ID = XZ.PLANT_ID
    LEFT JOIN PLANT_MASTER PM ON X.PLANT_ID = PM.PLANTID
	WHERE IFNULL(ZZ.WEIGHIN_WT,0) > 0 AND ZZ.WEIGHIN_WT_DT IS NOT NULL AND IFNULL(ZZ.WEIGHOUT_WT,0) = 0 AND ZZ.WEIGHOUT_WT_DT IS NULL
	ORDER BY X.GATE_IN_DT DESC, X.ORDER_DATE DESC;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_OUT_SAVE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_OUT_SAVE`(
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
        -- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_OUT_SAVE_OTHER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_OUT_SAVE_OTHER`(
    IN P_ID INT,
    IN P_GATE_IN_ID INT,
    IN P_NET_WT DECIMAL(10,2),
    IN P_WEIGH_OUT_WT DECIMAL(10,2),
    IN P_WEIGH_OUT_WT_NOTE VARCHAR(255),
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
    DECLARE TEMP_WEIGHIN_WT DECIMAL(10,2);
    DECLARE TEMP_INWARD_SYS_ID INT;
    DECLARE TEMP_TRANSACTION_TYPE VARCHAR(255);
          
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Error handling
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
		#SELECT @sqlstate AS State, @errmsg AS Message;
		ROLLBACK;
    
        SET P_RESULT = CONCAT('E|Opps!... Something went wrong. Please Contact system administrator. ', @errmsg,  '|0');
    END;

    SET P_RESULT = 'E|Opps!... Something went wrong. Please Contact system administrator|0';

    -- Authorization check
    #IF IFNULL(FN_IsAuthorize_User(P_PLANT_ID, P_USER_ID, P_ROLE_ID, P_MENU_ID), 0) <= 0 THEN
        #SET P_RESULT = 'E|You are not authorized to perform this operation.|0';
    #ELSE
    IF P_ID > 0 AND P_GATE_IN_ID > 0 THEN
        -- Fetch INWARD_SYS_ID
        SELECT INWARD_SYS_ID, TRANSACTION_TYPE INTO TEMP_INWARD_SYS_ID, TEMP_TRANSACTION_TYPE
        FROM other_gate_in_out
        WHERE GATE_SYS_ID = P_GATE_IN_ID AND IFNULL(CANCEL_GATE_IN, 0) = 0 AND GATE_OUT_DT IS NULL;

        -- IF IFNULL(TEMP_INWARD_SYS_ID, 0) > 0 AND TEMP_INWARD_SYS_ID = 125 THEN
            -- Fetch WEIGHIN_WT
            SELECT IFNULL(WEIGHIN_WT, 0) INTO TEMP_WEIGHIN_WT
            FROM other_weighment_detail
            WHERE WT_SYS_ID = P_ID AND GATE_SYS_ID = P_GATE_IN_ID;

            -- Validate gross weight
            IF IFNULL(P_WEIGH_OUT_WT, 0) > IFNULL(TEMP_WEIGHIN_WT, 0) AND TEMP_TRANSACTION_TYPE = 'UNLOAD' THEN
                SET P_RESULT = 'E|Tare weight is less than Gross weight.|0';
            ELSEIF IFNULL(P_WEIGH_OUT_WT, 0) < IFNULL(TEMP_WEIGHIN_WT, 0) AND TEMP_TRANSACTION_TYPE = 'LOAD' THEN
                SET P_RESULT = 'E|Gross weight is less than Tare weight.|0';
            ELSE
                -- Update record
                UPDATE other_weighment_detail
                SET WEIGHOUT_WT = P_WEIGH_OUT_WT,
                    WEIGHOUT_WT_DT = NOW(),
                    NET_WT = P_NET_WT,
                    WEIGHOUT_WT_NOTE = P_WEIGH_OUT_WT_NOTE
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
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_OUT_SLIP_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_OUT_SLIP_GET`(
    IN P_PURPOSE_TYPE INT,
    IN P_GATE_SYS_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
)
BEGIN

    IF IFNULL(P_PURPOSE_TYPE, 1) = 1 THEN
		
		SELECT PlantID PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Weighment Slip - Weigh Out' REPORT_TITLE
		FROM PLANT_MASTER WHERE PlantID = P_PLANT_ID;
		
		WITH TBL_RESULT AS (SELECT X.PLANT_ID, X.GATE_SYS_ID, X.MDA_SYS_ID, VEHICLE_NO, X.MDA_NO
			, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
			, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, VERIFIED_DOCUMENTS, X.VERIFIED_OFFICER_ID, RFSYSID, DIST, DESP_PLACE
			, PROD_SYS_ID, BAG_NOS, CAST((BAG_NOS / 24) AS unsigned) Required_Shipper
			, (SELECT COUNT(*) FROM MDA_LOADING ML WHERE ML.MDA_SYS_ID = X.MDA_SYS_ID) Loaded_Shipper, NULL Qty
			FROM (
				SELECT Z.PLANT_ID, Z.GATE_SYS_ID, VEHICLE_NO, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID
				, DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
				, MDA_SYS_IDS, MD.MDA_SYS_ID, Z.MDA_NO, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, MOBILE_NO, DIST, DESP_PLACE, VERIFIED_DOCUMENTS, VERIFIED_OFFICER_ID, RFSYSID
				, MD.PROD_SYS_ID, MD.BAG_NOS
				FROM (SELECT GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO
					, GIO.GATE_IN_DT, GIO.GATE_OUT_DT, GIO.INWARD_SYS_ID, GIO.DRIVER_ID_TYPE, GIO.DRIVER_ID_NUMBER, IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_NAME_NEW, GIO.DRIVER_NAME) AS DRIVER_NAME,  IF(GIO.DRIVER_CHANGED = 1, GIO.DRIVER_CONTACT_NEW, GIO.DRIVER_CONTACT) AS DRIVER_CONTACT, GIO.DRIVER_CHANGED
					, GIO.MDA_SYS_IDS AS MDA_SYS_IDS, MH.MDA_SYS_ID, MH.MDA_NO
					, MH.PLANT_CD, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DRIVER, MH.MOBILE_NO, MH.DIST, MH.DESP_PLACE
					, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, GIO.RFSYSID
					FROM fg_gate_in_out GIO
					INNER JOIN mda_header MH ON GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0
					WHERE MH.PLANT_ID = P_PLANT_ID AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
					-- AND GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL
					AND IF(IFNULL(P_GATE_SYS_ID,0)= 0, GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL, GIO.GATE_SYS_ID = P_GATE_SYS_ID) 
					AND IF(IFNULL(P_SEARCHTERM,'') = '', TRUE, 
								(GIO.TRUCK_NO = P_SEARCHTERM
								OR 0 < (SELECT COUNT(*) FROM mda_header MHZ WHERE GIO.PLANT_ID = MHZ.PLANT_ID AND MHZ.MDA_NO = P_SEARCHTERM AND FIND_IN_SET(MHZ.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0 AND MHZ.OUT_TIME IS NULL)
								OR GIO.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE LOWER(ZX.STATUS) = 'assigned' AND (ZX.RFIDSRNO = IFNULL(P_SEARCHTERM,'') OR ZX.RFIDCODE = IFNULL(P_SEARCHTERM,'')))
								)
						)
					AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = GIO.GATE_SYS_ID 
								AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0 AND XZ.GROSS_WT_DT IS NOT NULL)
					ORDER BY MH.PLANT_ID, GIO.GATE_IN_DT DESC) Z
					INNER JOIN mda_detail MD ON MD.PLANT_ID = Z.PLANT_ID AND MD.MDA_SYS_ID = Z.MDA_SYS_ID
					-- WHERE MD.PROD_SYS_ID IN (31,35,55,56)
			) X
		)
		SELECT (ROW_NUMBER() OVER (ORDER BY GIO.PLANT_ID, GATE_IN_DT DESC, GIO.GATE_SYS_ID, VEHICLE_NO)) AS SR_NO
		, GIO.PLANT_ID, GIO.GATE_SYS_ID, MDA_SYS_ID, VEHICLE_NO, MDA_NO COMMON_NO
			, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT
			, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT
			, INWARD_SYS_ID, (SELECT INWARD_TYPE FROM INWARD_MASTER Z WHERE Z.INWARD_SYS_ID = GIO.INWARD_SYS_ID LIMIT 1) AS INWARD_TYPE
			, DRIVER_ID_TYPE, (SELECT LOV_DESC FROM LOV_MASTER Z WHERE Z.LOV_COLUMN = 'DRVIDPROOF' AND Z.LOV_CODE = GIO.DRIVER_ID_TYPE LIMIT 1) AS DRIVER_ID_TYPE_TEXT
			, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED
		, GIO.PLANT_CD, WH_CD, PARTY_NAME
		, PM.PROD_SYS_ID, PM.PRD_CD AS PRODUCT_CODE, PM.PRD_DESC AS PRODUCT_DESC
		, TM.TRANS_SYS_ID, TM.TPTR_CD AS TRANSPORTER_CODE, TM.TPTR_NAME AS TRANSPORTER_NAME
		, GIO.VERIFIED_DOCUMENTS, GIO.VERIFIED_OFFICER_ID, NULL AS VERIFIED_OFFICER_NAME, NULL TRANSACTION_TYPE
		, RM.RFSYSID, RM.RFIDSRNO, DIST AS DISTANCE, DESP_PLACE
				, ZZ.TARE_WT WEIGHIN_WT, ZZ.TARE_WT_NOTE WEIGHIN_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT
				, ZZ.GROSS_WT WEIGHOUT_WT, ZZ.GROSS_WT_NOTE WEIGHOUT_WT_NOTE, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHOUT_WT_DT
				, ZZ.NET_WT, ZZ.TOLERANCE_WT, BAG_NOS, Required_Shipper, Loaded_Shipper, NULL Qty
                , NULL STATUS, NULL Skip_LILO_Remarks, 'KG' UOM, 'Kg' WEIGHT_UOM
		FROM TBL_RESULT GIO
		INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.PLANT_ID = GIO.PLANT_ID AND ZZ.GATE_SYS_ID = GIO.GATE_SYS_ID
		LEFT JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = GIO.PLANT_ID AND TM.TRANS_SYS_ID = GIO.TRANS_SYS_ID
		LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = GIO.PLANT_ID AND PM.PROD_SYS_ID = GIO.PROD_SYS_ID
		LEFT JOIN rfid_master RM ON RM.PLANT_ID = GIO.PLANT_ID AND RM.RFSYSID = GIO.RFSYSID 
		ORDER BY PLANT_ID, GATE_IN_DT DESC, GATE_SYS_ID, VEHICLE_NO;

	ELSEIF IFNULL(P_PURPOSE_TYPE, 1) = 4 THEN
    
		SELECT PlantID PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Weighment Slip - Weigh Out Other Material' REPORT_TITLE
		FROM PLANT_MASTER WHERE PlantID = P_PLANT_ID;
		
        WITH TBL_MAIN AS (SELECT PLANT_ID, GATE_SYS_ID
							FROM other_gate_in_out
							WHERE PLANT_ID = P_PLANT_ID AND COALESCE(CANCEL_GATE_IN, 0) = 0 
							AND (CASE WHEN IFNULL(TRIM(P_SEARCHTERM),'') != '' AND IFNULL(P_GATE_SYS_ID, 0) > 0 THEN GATE_SYS_ID = IFNULL(P_GATE_SYS_ID, 0) AND TRUCK_NO = TRIM(P_SEARCHTERM) 
							 WHEN IFNULL(TRIM(P_SEARCHTERM),'') = '' AND IFNULL(P_GATE_SYS_ID, 0) = 0 THEN FALSE 
							 WHEN IFNULL(TRIM(P_SEARCHTERM),'') != '' AND IFNULL(P_GATE_SYS_ID, 0) = 0 THEN TRUCK_NO = TRIM(P_SEARCHTERM) 
							 WHEN IFNULL(TRIM(P_SEARCHTERM),'') = '' AND IFNULL(P_GATE_SYS_ID, 0) > 0 THEN GATE_SYS_ID = IFNULL(P_GATE_SYS_ID, 0) ELSE FALSE END)
							ORDER BY PLANT_ID, GATE_SYS_ID DESC)
        SELECT (ROW_NUMBER() OVER (ORDER BY ORDER_DATE DESC, GATE_IN_DT DESC)) AS SR_NO
        , X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID ID, X.TRANSACTION_TYPE, OH.OTHER_SYS_ID COMMON_ID, OH.ORDER_NO COMMON_NO, X.TRUCK_NO VEHICLE_NO
		, DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(OH.ORDER_DATE, '%d/%m/%Y %H:%i') AS COMMON_DT
		, NULL BAG_NOS, NULL Required_Shipper, NULL Loaded_Shipper
		, ZZ.WEIGHIN_WT, ZZ.WEIGHIN_WT_NOTE, DATE_FORMAT(ZZ.WEIGHIN_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT
		, ZZ.WEIGHOUT_WT, ZZ.WEIGHOUT_WT_NOTE, DATE_FORMAT(ZZ.WEIGHOUT_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHOUT_WT_DT
		, ZZ.NET_WT, NULL TOLERANCE_WT
		, OD.SR_NO PROD_SYS_ID, OD.MATERIAL PRODUCT_CODE, OD.MATERIAL_DESC PRODUCT_DESC
		, X.TRANS_SYS_ID, TM.tptr_cd TRANSPORTER_CODE, TM.TPTR_NAME TRANSPORTER_NAME, 'IFFCO' PARTY_NAME
		, NULL WH_CD, 'IFFCO' PARTY_NAME, NULL Distance, NULL desp_place
		, X.RFSYSID, RM.RFIDSRNO, NULL STATUS, NULL Skip_LILO_Remarks, OD.QTY, OD.UMO UOM, 'Kg' WEIGHT_UOM
		FROM other_gate_in_out X
		INNER JOIN other_header OH ON OH.PLANT_ID = X.PLANT_ID AND OH.OTHER_SYS_ID = X.OTHER_SYS_ID
		INNER JOIN other_detail OD ON OD.PLANT_ID = X.PLANT_ID AND OD.OTHER_SYS_ID = X.OTHER_SYS_ID
		INNER JOIN other_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
		INNER JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = X.PLANT_ID AND TM.TRANS_SYS_ID = X.TRANS_SYS_ID
		LEFT JOIN rfid_master RM ON RM.PLANT_ID = X.PLANT_ID AND RM.RFSYSID = X.RFSYSID 
		WHERE X.PLANT_ID = P_PLANT_ID
					/*AND ((X.TRUCK_NO = P_SEARCHTERM 
							OR X.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_header XZ WHERE XZ.ORDER_NO = P_SEARCHTERM) 
							OR X.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_gate_in_out XZ WHERE XZ.GATE_SYS_ID = IFNULL(P_GATE_SYS_ID, 0) OR XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID = 4)
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_GATE_SYS_ID,0) = 0, 1, 0)
						)*/
		AND (X.PLANT_ID, X.GATE_SYS_ID) IN (SELECT PLANT_ID, GATE_SYS_ID FROM TBL_MAIN)
		-- AND X.GATE_IN_DT IS NOT NULL AND X.GATE_OUT_DT IS NULL
        AND IFNULL(ZZ.WEIGHIN_WT,0) > 0 AND ZZ.WEIGHIN_WT_DT IS NOT NULL -- AND IFNULL(ZZ.WEIGHOUT_WT,0) > 0 AND ZZ.WEIGHOUT_WT_DT IS NOT NULL
		ORDER BY X.GATE_IN_DT  DESC, X.GATE_OUT_DT  DESC, OH.ORDER_DATE  DESC;
        
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHMENT_OUT_SLIP_GET_NEW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHMENT_OUT_SLIP_GET_NEW`(
    IN P_PURPOSE_TYPE INT,
    IN P_GATE_SYS_ID INT,
    IN P_SEARCHTERM VARCHAR(255),
    IN P_PLANT_ID INT
)
BEGIN
    
    IF IFNULL(P_PURPOSE_TYPE, 1) = 1 THEN
		
		SELECT PlantID PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Weighment Slip - Weigh Out' REPORT_TITLE
		FROM PLANT_MASTER WHERE PlantID = P_PLANT_ID;
		
		WITH TBL_MAIN AS (SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, MH.MDA_SYS_ID, MH.MDA_NO, X.TRUCK_NO VEHICLE_NO, MH.PLANT_CD
				, GATE_IN_DT, GATE_OUT_DT, MH.MDA_DT, MH.OUT_TIME
				, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW, X.TRUCK_VALIDATION
				, MH.TRANS_SYS_ID, MH.WH_CD, MH.PARTY_NAME, MH.DIST,MH.desp_place, X.RFSYSID
				FROM (SELECT 
						TRIM(SUBSTRING_INDEX(input_string, ',', 1)) AS PLANT_ID,
						TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 2), ',', -1)) AS GATE_SYS_ID,
						TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 3), ',', -1)) AS MDA_SYS_ID,
						TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 4), ',', -1)) AS MDA_NO,
						TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 5), ',', -1)) AS VEHICLE_NO,
						TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 6), ',', -1)) AS MDA_DT,
						TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 7), ',', -1)) AS OUT_TIME
					FROM (SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, '#', n.digit+1), '#', -1)) AS input_string
					FROM (SELECT FN_GATE_IN_OUT_MDA_GET(P_PLANT_ID, P_GATE_SYS_ID, 0, P_SEARCHTERM) AS input_string) AS data
					CROSS JOIN (SELECT 0 AS digit UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) AS n 
					WHERE n.digit < LENGTH(input_string) - LENGTH(REPLACE(input_string, '#', '')) + 1) X) XZ
				INNER JOIN fg_gate_in_out X ON X.PLANT_ID = XZ.PLANT_ID AND X.GATE_SYS_ID = XZ.GATE_SYS_ID
				INNER JOIN mda_header MH ON MH.PLANT_ID = X.PLANT_ID AND MH.MDA_SYS_ID = XZ.MDA_SYS_ID
				WHERE X.PLANT_ID = XZ.PLANT_ID AND X.GATE_IN_DT IS NOT NULL AND COALESCE(X.CANCEL_GATE_IN, 0) = 0
				AND (CASE WHEN IFNULL(P_SEARCHTERM,'') != '' THEN X.TRUCK_NO = P_SEARCHTERM OR MH.MDA_NO = P_SEARCHTERM
						  WHEN IFNULL(P_GATE_SYS_ID,0) > 0 THEN X.GATE_SYS_ID = P_GATE_SYS_ID
				 		  ELSE FALSE END)
				ORDER BY 3 DESC, 4 DESC
		)
		SELECT (ROW_NUMBER() OVER (ORDER BY X.Distance DESC)) AS SR_NO, X.* 
		FROM (
		SELECT M_G.PLANT_ID, M_G.STATION_ID, M_G.GATE_SYS_ID ID, NULL TRANSACTION_TYPE, M_G.MDA_SYS_ID COMMON_ID, M_G.MDA_NO COMMON_NO, M_G.VEHICLE_NO
		, DATE_FORMAT(M_G.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(M_G.MDA_DT, '%d/%m/%Y %H:%i') AS COMMON_DT
		, MD.BAG_NOS, (MD.BAG_NOS / 24) Required_Shipper
		, (SELECT COUNT(*) FROM MDA_LOADING Z WHERE Z.PLANT_ID = M_G.PLANT_ID AND Z.MDA_SYS_ID = M_G.MDA_SYS_ID) Loaded_Shipper, NULL Qty
		, ZZ.TARE_WT WEIGHIN_WT, ZZ.TARE_WT_NOTE WEIGHIN_WT_NOTE, DATE_FORMAT(ZZ.TARE_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT
		, ZZ.GROSS_WT WEIGHOUT_WT, ZZ.GROSS_WT_NOTE WEIGHOUT_WT_NOTE, DATE_FORMAT(ZZ.GROSS_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHOUT_WT_DT
		, ZZ.NET_WT, ZZ.TOLERANCE_WT
		, MD.PROD_SYS_ID, PRD_CD PRODUCT_CODE, PRD_DESC PRODUCT_DESC
		, M_G.TRANS_SYS_ID, TM.tptr_cd TRANSPORTER_CODE, TM.TPTR_NAME TRANSPORTER_NAME, 'IFFCO' PARTY_NAME
		, M_G.WH_CD, /*M_G.PARTY_NAME,*/ M_G.DIST Distance, M_G.desp_place
		, M_G.RFSYSID, RM.RFIDSRNO, NULL STATUS, NULL Skip_LILO_Remarks, 'KG' UOM
		FROM TBL_MAIN M_G
		INNER JOIN mda_detail MD ON MD.PLANT_ID = M_G.PLANT_ID AND MD.MDA_SYS_ID = M_G.MDA_SYS_ID
		INNER JOIN FG_WEIGHMENT_DETAIL ZZ ON ZZ.GATE_SYS_ID = M_G.GATE_SYS_ID AND ZZ.STATION_ID = M_G.STATION_ID AND ZZ.PLANT_ID = M_G.PLANT_ID
		INNER JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = M_G.PLANT_ID AND TM.TRANS_SYS_ID = M_G.TRANS_SYS_ID
		LEFT JOIN PRODUCT_MASTER PM ON PM.PLANT_ID = M_G.PLANT_ID AND PM.PROD_SYS_ID = MD.PROD_SYS_ID
		LEFT JOIN rfid_master RM ON RM.PLANT_ID = M_G.PLANT_ID AND RM.RFSYSID = M_G.RFSYSID 
		WHERE IFNULL(ZZ.TARE_WT,0) > 0 AND ZZ.TARE_WT_DT IS NOT NULL AND IFNULL(ZZ.GROSS_WT,0) > 0 AND ZZ.GROSS_WT_DT IS NOT NULL
		AND (CASE WHEN IFNULL(P_SEARCHTERM,'') != '' THEN IFNULL(M_G.OUT_TIME, '')='' ELSE TRUE END)
		ORDER BY M_G.GATE_IN_DT  DESC, M_G.GATE_OUT_DT  DESC, M_G.MDA_DT  DESC
		) X;

	ELSEIF IFNULL(P_PURPOSE_TYPE, 1) = 4 THEN
    
		SELECT PlantID PLANT_ID, CONCAT('NANO FERTILIZER PROJECT', ' - ', PLANT_NAME) PLANT_NAME, PlantAddress PLANT_ADDRESS, 'Weighment Slip - Weigh Out Other Material' REPORT_TITLE
		FROM PLANT_MASTER WHERE PlantID = P_PLANT_ID;
		
        SELECT (ROW_NUMBER() OVER (ORDER BY ORDER_DATE DESC, GATE_IN_DT DESC)) AS SR_NO
        , X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID ID, X.TRANSACTION_TYPE, OH.OTHER_SYS_ID COMMON_ID, OH.ORDER_NO COMMON_NO, X.TRUCK_NO VEHICLE_NO
		, DATE_FORMAT(X.GATE_IN_DT, '%d/%m/%Y %H:%i') AS GATE_IN_DT, DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT, DATE_FORMAT(OH.ORDER_DATE, '%d/%m/%Y %H:%i') AS COMMON_DT
		, NULL BAG_NOS, NULL Required_Shipper, NULL Loaded_Shipper
		, ZZ.WEIGHIN_WT, ZZ.WEIGHIN_WT_NOTE, DATE_FORMAT(ZZ.WEIGHIN_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHIN_WT_DT
		, ZZ.WEIGHOUT_WT, ZZ.WEIGHOUT_WT_NOTE, DATE_FORMAT(ZZ.WEIGHOUT_WT_DT, '%d/%m/%Y %H:%i') AS WEIGHOUT_WT_DT
		, NULL NET_WT, NULL TOLERANCE_WT
		, OD.SR_NO PROD_SYS_ID, OD.MATERIAL PRODUCT_CODE, OD.MATERIAL_DESC PRODUCT_DESC
		, X.TRANS_SYS_ID, TM.tptr_cd TRANSPORTER_CODE, TM.TPTR_NAME TRANSPORTER_NAME, 'IFFCO' PARTY_NAME
		, NULL WH_CD, 'IFFCO' PARTY_NAME, NULL Distance, NULL desp_place
		, X.RFSYSID, RM.RFIDSRNO, NULL STATUS, NULL Skip_LILO_Remarks, OD.QTY, OD.UMO UOM
		FROM other_gate_in_out X
		INNER JOIN other_header OH ON OH.PLANT_ID = X.PLANT_ID AND OH.OTHER_SYS_ID = X.OTHER_SYS_ID
		INNER JOIN other_detail OD ON OD.PLANT_ID = X.PLANT_ID AND OD.OTHER_SYS_ID = X.OTHER_SYS_ID
		INNER JOIN other_weighment_detail ZZ ON ZZ.GATE_SYS_ID = X.GATE_SYS_ID AND ZZ.STATION_ID = X.STATION_ID AND ZZ.PLANT_ID = X.PLANT_ID
		INNER JOIN TRANSPORTER_MASTER TM ON TM.PLANT_ID = X.PLANT_ID AND TM.TRANS_SYS_ID = X.TRANS_SYS_ID
		LEFT JOIN rfid_master RM ON RM.PLANT_ID = X.PLANT_ID AND RM.RFSYSID = X.RFSYSID 
		WHERE X.PLANT_ID = P_PLANT_ID
					AND ((X.TRUCK_NO = P_SEARCHTERM 
							OR X.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_header XZ WHERE XZ.ORDER_NO = P_SEARCHTERM) 
							OR X.TRUCK_NO IN (SELECT XZ.TRUCK_NO FROM other_gate_in_out XZ WHERE XZ.GATE_SYS_ID = IFNULL(P_GATE_SYS_ID, 0) OR XZ.RFSYSID IN (SELECT ZX.RFSYSID FROM RFID_MASTER ZX WHERE ZX.RFIDSRNO = P_SEARCHTERM) AND XZ.INWARD_SYS_ID = 4)
						 ) OR 1 = IF(IFNULL(P_SEARCHTERM,'') = '' AND IFNULL(P_GATE_SYS_ID,0) = 0, 1, 0)
						)
		AND X.GATE_IN_DT IS NOT NULL AND X.GATE_OUT_DT IS NULL
        AND IFNULL(ZZ.WEIGHIN_WT,0) > 0 AND ZZ.WEIGHIN_WT_DT IS NOT NULL AND IFNULL(ZZ.WEIGHOUT_WT,0) > 0 AND ZZ.WEIGHOUT_WT_DT IS NOT NULL
		ORDER BY X.GATE_IN_DT  DESC, X.GATE_OUT_DT  DESC, OH.ORDER_DATE  DESC;
        
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PC_WEIGHT_IN_OUT_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `PC_WEIGHT_IN_OUT_GET`(IN P_SEARCHTERM VARCHAR(255), IN P_PLANT_ID INT)
BEGIN
	WITH TBL_MAIN AS 
		(SELECT DISTINCT X.PLANT_ID, X.STATION_ID, X.GATE_SYS_ID, Y.MDA_SYS_ID, Y.MDA_NO, Y.VEHICLE_NO, Y.MDA_DT, Y.TRANS_SYS_ID
			, X.GATE_IN_DT, X.GATE_OUT_DT, X.INWARD_SYS_ID, X.DRIVER_ID_TYPE, X.DRIVER_ID_NUMBER, X.DRIVER_NAME, X.DRIVER_CONTACT, X.DRIVER_CHANGED, X.DRIVER_NAME_NEW, X.DRIVER_CONTACT_NEW
			, X.TRUCK_VALIDATION, X.RFSYSID, X.VERIFIED_DOCUMENTS, X.RFID_RECEIVE, X.VERIFIED_OFFICER_ID, X.CANCEL_GATE_IN, X.CANCEL_GATE_REASON, X.GATE_SYS_ID_OLD, X.IS_GOODS_TRANSFER
			, Y.DI_NO, Y.PLANT_CD, Y.WH_CD, Y.PARTY_NAME, Y.DIST, Y.BAG_NOS, Y.NETT_QTY, Y.GROSS_QTY, Y.ECHIT_NO, Y.GST_NO, Y.OUT_TIME, Y.desp_place
					FROM fg_gate_in_out X, 
					(SELECT Z.* FROM mda_header Z
						WHERE Z.PLANT_ID = P_PLANT_ID AND OUT_TIME IS NULL
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

--
-- Final view structure for view `vw_exp_get_gate_in_mda_id`
--

/*!50001 DROP VIEW IF EXISTS `vw_exp_get_gate_in_mda_id`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `vw_exp_get_gate_in_mda_id` AS select distinct `gio`.`PLANT_ID` AS `PLANT_ID`,`gio`.`GATE_SYS_ID` AS `GATE_SYS_ID`,`gio`.`TRUCK_NO` AS `VEHICLE_NO`,`mh`.`MDA_SYS_ID` AS `MDA_SYS_ID`,`mh`.`MDA_NO` AS `MDA_NO`,`mh`.`MDA_DT` AS `MDA_DT`,`gio`.`GATE_IN_DT` AS `GATE_IN_DT`,`gio`.`GATE_OUT_DT` AS `GATE_OUT_DT`,`mh`.`OUT_TIME` AS `OUT_TIME`,`gio`.`CANCEL_GATE_IN` AS `CANCEL_GATE_IN` from ((`exp_fg_gate_in_out` `gio` join `mda_header` `mh` on(((`gio`.`PLANT_ID` = `mh`.`PLANT_ID`) and (`mh`.`MDA_SYS_ID` = `gio`.`MDA_SYS_ID`)))) left join `mda_detail` `md` on(((`md`.`PLANT_ID` = `mh`.`PLANT_ID`) and (`md`.`MDA_SYS_ID` = `mh`.`MDA_SYS_ID`)))) order by `gio`.`PLANT_ID`,`gio`.`GATE_IN_DT` desc,`gio`.`GATE_OUT_DT` desc,`mh`.`MDA_NO` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_get_gate_in_mda_id`
--

/*!50001 DROP VIEW IF EXISTS `vw_get_gate_in_mda_id`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `vw_get_gate_in_mda_id` AS select distinct `gio`.`PLANT_ID` AS `PLANT_ID`,`gio`.`GATE_SYS_ID` AS `GATE_SYS_ID`,`gio`.`TRUCK_NO` AS `VEHICLE_NO`,`mh`.`MDA_SYS_ID` AS `MDA_SYS_ID`,`mh`.`MDA_NO` AS `MDA_NO`,`mh`.`MDA_DT` AS `MDA_DT`,`gio`.`GATE_IN_DT` AS `GATE_IN_DT`,`gio`.`GATE_OUT_DT` AS `GATE_OUT_DT`,`mh`.`OUT_TIME` AS `OUT_TIME`,`gio`.`CANCEL_GATE_IN` AS `CANCEL_GATE_IN` from ((`fg_gate_in_out` `gio` join `mda_header` `mh` on(((`gio`.`PLANT_ID` = `mh`.`PLANT_ID`) and (find_in_set(`mh`.`MDA_SYS_ID`,`gio`.`MDA_SYS_IDS`) > 0)))) left join `mda_detail` `md` on(((`md`.`PLANT_ID` = `mh`.`PLANT_ID`) and (`md`.`MDA_SYS_ID` = `mh`.`MDA_SYS_ID`)))) order by `gio`.`PLANT_ID`,`gio`.`GATE_IN_DT` desc,`gio`.`GATE_OUT_DT` desc,`mh`.`MDA_NO` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_get_gate_in_mda_no_gate_out`
--

/*!50001 DROP VIEW IF EXISTS `vw_get_gate_in_mda_no_gate_out`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `vw_get_gate_in_mda_no_gate_out` AS select `gm`.`PLANT_ID` AS `PLANT_ID`,`gm`.`GATE_SYS_ID` AS `GATE_SYS_ID`,`gm`.`VEHICLE_NO` AS `VEHICLE_NO`,`gm`.`MDA_SYS_ID` AS `MDA_SYS_ID`,`gm`.`MDA_NO` AS `MDA_NO`,`gm`.`MDA_DT` AS `MDA_DT`,`gm`.`GATE_IN_DT` AS `GATE_IN_DT`,`gm`.`GATE_OUT_DT` AS `GATE_OUT_DT`,`gm`.`OUT_TIME` AS `OUT_TIME`,`gm`.`CANCEL_GATE_IN` AS `CANCEL_GATE_IN`,`gm`.`BAG_NOS` AS `BAG_NOS`,(`gm`.`BAG_NOS` / 24) AS `Required_Shipper`,`fgw`.`TARE_WT` AS `WEIGHIN_WT`,`fgw`.`TARE_WT_NOTE` AS `WEIGHIN_WT_NOTE`,date_format(`fgw`.`TARE_WT_DT`,'%d/%m/%Y %H:%i') AS `WEIGHIN_WT_DT`,`fgw`.`GROSS_WT` AS `WEIGHOUT_WT`,`fgw`.`GROSS_WT_NOTE` AS `WEIGHOUT_WT_NOTE`,date_format(`fgw`.`GROSS_WT_DT`,'%d/%m/%Y %H:%i') AS `WEIGHOUT_WT_DT`,`fgw`.`NET_WT` AS `NET_WT`,`fgw`.`TOLERANCE_WT` AS `TOLERANCE_WT` from ((select distinct `gio`.`PLANT_ID` AS `PLANT_ID`,`gio`.`GATE_SYS_ID` AS `GATE_SYS_ID`,`gio`.`TRUCK_NO` AS `VEHICLE_NO`,`mh`.`MDA_SYS_ID` AS `MDA_SYS_ID`,`mh`.`MDA_NO` AS `MDA_NO`,`mh`.`MDA_DT` AS `MDA_DT`,`gio`.`GATE_IN_DT` AS `GATE_IN_DT`,`gio`.`GATE_OUT_DT` AS `GATE_OUT_DT`,`mh`.`OUT_TIME` AS `OUT_TIME`,`gio`.`CANCEL_GATE_IN` AS `CANCEL_GATE_IN`,`md`.`BAG_NOS` AS `BAG_NOS`,(`md`.`BAG_NOS` / 24) AS `Required_Shipper` from ((`fg_gate_in_out` `gio` join `mda_header` `mh` on(((`gio`.`PLANT_ID` = `mh`.`PLANT_ID`) and (find_in_set(`mh`.`MDA_SYS_ID`,`gio`.`MDA_SYS_IDS`) > 0)))) left join `mda_detail` `md` on(((`md`.`PLANT_ID` = `mh`.`PLANT_ID`) and (`md`.`MDA_SYS_ID` = `mh`.`MDA_SYS_ID`)))) where ((`mh`.`PLANT_ID` = 4) and (`gio`.`GATE_OUT_DT` is null) and (`mh`.`OUT_TIME` is null))) `gm` left join `fg_weighment_detail` `fgw` on((`fgw`.`GATE_SYS_ID` = `gm`.`GATE_SYS_ID`))) order by `gm`.`PLANT_ID`,`gm`.`GATE_IN_DT` desc,`gm`.`GATE_OUT_DT` desc,`gm`.`MDA_NO` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_mda_fg_gate_dtls`
--

/*!50001 DROP VIEW IF EXISTS `vw_mda_fg_gate_dtls`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `vw_mda_fg_gate_dtls` (`PLANT_ID`,`GATE_SYS_ID`,`MDA_SYS_ID`,`MDA_NO`,`VEHICLE_NO`,`GATE_IN_DT`,`GATE_OUT_DT`,`MDA_DT`,`GROSS_WT`,`NET_WT`,`BAG_NOS`,`PROD_SYS_ID`,`PRD_CD`,`PRD_DESC`) AS select `m_g`.`PLANT_ID` AS `PLANT_ID`,`m_g`.`GATE_SYS_ID` AS `GATE_SYS_ID`,`m_g`.`MDA_SYS_ID` AS `MDA_SYS_ID`,`m_g`.`MDA_NO` AS `MDA_NO`,`m_g`.`VEHICLE_NO` AS `VEHICLE_NO`,`m_g`.`GATE_IN_DT` AS `GATE_IN_DT`,`m_g`.`GATE_OUT_DT` AS `GATE_OUT_DT`,`m_g`.`MDA_DT` AS `MDA_DT`,`wd`.`GROSS_WT` AS `GROSS_WT`,`wd`.`NET_WT` AS `NET_WT`,`m_g`.`BAG_NOS` AS `BAG_NOS`,`md`.`PROD_SYS_ID` AS `PROD_SYS_ID`,`pm`.`PRD_CD` AS `PRD_CD`,`pm`.`PRD_DESC` AS `PRD_DESC` from ((((select distinct `x`.`PLANT_ID` AS `PLANT_ID`,`x`.`STATION_ID` AS `STATION_ID`,`x`.`GATE_SYS_ID` AS `GATE_SYS_ID`,`z`.`MDA_SYS_ID` AS `MDA_SYS_ID`,`z`.`MDA_NO` AS `MDA_NO`,`z`.`VEHICLE_NO` AS `VEHICLE_NO`,`z`.`MDA_DT` AS `MDA_DT`,`z`.`TRANS_SYS_ID` AS `TRANS_SYS_ID`,`x`.`GATE_IN_DT` AS `GATE_IN_DT`,`x`.`GATE_OUT_DT` AS `GATE_OUT_DT`,`z`.`BAG_NOS` AS `BAG_NOS` from (`fg_gate_in_out` `x` join `mda_header` `z` on(((`z`.`PLANT_ID` = `x`.`PLANT_ID`) and (`x`.`TRUCK_NO` = `z`.`VEHICLE_NO`)))) where (coalesce(`x`.`CANCEL_GATE_IN`,0) = 0)) `m_g` left join `fg_weighment_detail` `wd` on(((`wd`.`GATE_SYS_ID` = `m_g`.`GATE_SYS_ID`) and (`wd`.`PLANT_ID` = `m_g`.`PLANT_ID`)))) left join `mda_detail` `md` on(((`md`.`MDA_SYS_ID` = `m_g`.`MDA_SYS_ID`) and (`md`.`PLANT_ID` = `m_g`.`PLANT_ID`)))) left join `product_master` `pm` on(((`pm`.`PROD_SYS_ID` = `md`.`PROD_SYS_ID`) and (`pm`.`PLANT_ID` = `m_g`.`PLANT_ID`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-28 17:12:05
