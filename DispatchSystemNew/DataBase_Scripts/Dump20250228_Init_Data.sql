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
-- Dumping data for table `countrymaster`
--

LOCK TABLES `countrymaster` WRITE;
/*!40000 ALTER TABLE `countrymaster` DISABLE KEYS */;
INSERT INTO `countrymaster` VALUES (1,'INDIA',1,18,'2023-03-20 16:12:40');
/*!40000 ALTER TABLE `countrymaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `districtmaster`
--

LOCK TABLES `districtmaster` WRITE;
/*!40000 ALTER TABLE `districtmaster` DISABLE KEYS */;
INSERT INTO `districtmaster` VALUES (1,'NA',121,62,1,1,'2023-03-25 15:08:41'),(2,'Ahmedabad',1,1,1,18,'2023-03-25 15:08:41'),(3,'Kalol',1,1,1,18,'2023-03-25 15:08:41');
/*!40000 ALTER TABLE `districtmaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `inward_master`
--

LOCK TABLES `inward_master` WRITE;
/*!40000 ALTER TABLE `inward_master` DISABLE KEYS */;
INSERT INTO `inward_master` VALUES (3,'Scrap',0,3),(2,'Raw Material',0,2),(1,'Finish Goods (MDA)',0,1),(4,'Other Material',0,4);
/*!40000 ALTER TABLE `inward_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lov_master`
--

LOCK TABLES `lov_master` WRITE;
/*!40000 ALTER TABLE `lov_master` DISABLE KEYS */;
INSERT INTO `lov_master` VALUES ('DISPATCH_MODE','AIR','By Air',3,1,'2024-03-13 15:37:44',NULL,NULL,'Y'),('DISPATCH_MODE','RAIL','By Rail',2,1,'2024-03-13 15:37:44',NULL,NULL,'Y'),('DISPATCH_MODE','ROAD','By Road',1,1,'2024-03-13 15:37:44',NULL,NULL,'Y'),('DISPATCH_MODE','SHIP','By Ship',4,1,'2024-03-13 15:37:44',NULL,NULL,'Y'),('DRVIDPROOF','Aadhar Card','Aadhar Card',1,1,NULL,NULL,NULL,'Y'),('DRVIDPROOF','Driving License No.','Driver License No',2,1,NULL,NULL,NULL,'Y'),('DRVIDPROOF','Others','Others',4,1,NULL,NULL,NULL,'Y'),('DRVIDPROOF','PAN Card','Pan Card',3,1,NULL,NULL,NULL,'Y'),('Gender','F','Female',0,1,'2024-03-02 09:41:44',1,'2024-03-02 11:11:33','Y'),('Gender','M','Male',0,1,'2024-03-02 10:11:21',1,'2024-03-02 11:11:33','Y'),('Pallate_Type','OTH','Other',1,1,'2024-12-09 16:41:53',NULL,NULL,'Y'),('Pallate_Type','PLASTIC','Plastic',3,1,'2024-12-19 14:08:56',NULL,NULL,'Y'),('Pallate_Type','WOODEN','Wooden',1,1,'2024-12-09 16:41:44',NULL,NULL,'Y'),('QR_GEN','DISP','Dispatched',5,1,'2024-03-13 15:37:42',NULL,NULL,'Y'),('QR_GEN','DOWN','Download',3,1,'2024-03-13 15:37:36',NULL,NULL,'Y'),('QR_GEN','EMAL','Emailed',2,1,'2024-03-13 15:37:33',NULL,NULL,'Y'),('QR_GEN','PEND','Pending',1,1,'2024-03-13 15:37:31',NULL,NULL,'Y'),('QR_GEN','PRNT','Printed',4,1,'2024-03-13 15:37:38',NULL,NULL,'Y'),('QR_GEN','RECV','Received',6,1,'2024-03-13 15:37:44',NULL,NULL,'Y'),('RFID_LOST','A','Assign',0,1,'2024-05-01 09:41:44',NULL,NULL,'Y'),('RFID_LOST','ACT','Active',1,1,'2024-05-01 09:41:44',NULL,NULL,'Y'),('RFID_LOST','L','LOST',2,1,'2024-05-01 09:41:44',NULL,NULL,'Y'),('UOM','KG','Kilogram',4,1,'2024-03-01 13:59:28',NULL,NULL,'Y'),('UOM','LT','Litre',2,1,'2024-03-01 13:59:28',NULL,NULL,'Y'),('UOM','ML','Miligram',3,1,'2024-03-01 13:59:28',NULL,NULL,'N'),('UOM','MT','Matric Ton',5,1,NULL,NULL,NULL,'Y'),('UOM','NO','Number',1,1,'2024-03-01 13:59:28',NULL,NULL,'Y');
/*!40000 ALTER TABLE `lov_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `menu_master_new`
--

LOCK TABLES `menu_master_new` WRITE;
/*!40000 ALTER TABLE `menu_master_new` DISABLE KEYS */;
INSERT INTO `menu_master_new` VALUES (7,0,NULL,NULL,'Transaction',NULL,10,'N','Y',NULL,NULL,NULL,NULL),(1,0,NULL,NULL,'Master',NULL,1,'N','Y',NULL,NULL,NULL,NULL),(2,1,'Admin','Plant','Plant',NULL,2,'Y','Y',NULL,NULL,NULL,NULL),(3,1,'Admin','Role','Role',NULL,3,'N','Y',NULL,NULL,NULL,NULL),(4,1,'Admin','User','User',NULL,4,'N','Y',NULL,NULL,NULL,NULL),(5,1,'Admin','UserAccess','User Access',NULL,4,'N','N',NULL,NULL,NULL,NULL),(6,1,'Admin','Menu','Menu',NULL,3,'N','Y',NULL,NULL,NULL,NULL),(8,1,'Admin','Country','Country',NULL,11,'N','Y',NULL,NULL,NULL,NULL),(9,1,'Admin','State','State',NULL,12,'N','Y',NULL,NULL,NULL,NULL),(10,1,'Admin','District','District',NULL,13,'N','Y',NULL,NULL,NULL,NULL),(12,1,'Admin','WorkStation','Work Station',NULL,15,'N','Y',NULL,NULL,NULL,NULL),(14,1,'Admin','Designation','Designation',NULL,17,'N','Y',NULL,NULL,NULL,NULL),(13,1,'Admin','WorkShift','Work Shift',NULL,16,'N','Y',NULL,NULL,NULL,NULL),(15,1,'Admin','Product','Product',NULL,15,'N','Y',NULL,NULL,NULL,NULL),(21,1,'Admin','LOV','LOV',NULL,18,'N','Y',1,NULL,NULL,NULL),(38,0,'Vendor','ChangePassword','Change Password',NULL,17,'N','Y',1,NULL,NULL,NULL),(39,0,NULL,'Home','Sync Data','Home/SyncData',19,'N','Y',1,NULL,NULL,NULL),(52,42,'Dispatch','CancleGateIn','Cancle Gate In',NULL,10,'N','Y',1,NULL,NULL,NULL),(42,0,NULL,NULL,'Dispatch ',NULL,20,'N','Y',1,NULL,NULL,NULL),(43,42,'Dispatch','RFID','RFID',NULL,1,'N','Y',1,NULL,NULL,NULL),(41,1,'Admin','Transporter','Transporter',NULL,19,'N','Y',1,NULL,NULL,NULL),(54,42,'Dispatch','TransportOfGoods','Transport Of Goods',NULL,12,'N','Y',1,NULL,NULL,NULL),(44,42,'Dispatch','GateIn','Gate In',NULL,2,'N','Y',1,NULL,NULL,NULL),(45,42,'Dispatch','GateOut','Gate Out',NULL,7,'N','Y',1,NULL,NULL,NULL),(47,42,'Dispatch','LoadBatch','Load Batch',NULL,5,'N','Y',1,NULL,NULL,NULL),(48,55,'Dispatch','WeighmentInSlip','Weighment In Slip',NULL,4,'N','Y',1,NULL,NULL,NULL),(49,55,'Dispatch','WeighmentOutSlip','Weighment Out Slip',NULL,6,'N','Y',1,NULL,NULL,NULL),(50,42,'Dispatch','WeightIn','Weight In',NULL,3,'N','Y',1,NULL,NULL,NULL),(51,42,'Dispatch','WeightOut','Weight Out',NULL,5,'N','Y',1,NULL,NULL,NULL),(55,0,NULL,NULL,'Station 7&8 Reports',NULL,21,'N','Y',1,NULL,NULL,NULL),(22,7,'Admin','ChangePassword','Change Password',NULL,17,'N','Y',1,NULL,NULL,NULL),(40,7,'MDA_Automation','Load_MDA','Load MDA',NULL,18,'N','Y',1,NULL,NULL,NULL),(53,42,'Dispatch','LostRFIDCard','Lost RFID Card',NULL,11,'N','Y',1,NULL,NULL,NULL),(65,55,'Dispatch','Reports','Shipper QR Code By MDA','Dispatch/Reports/Index?type=S',7,'N','Y',1,'2024-06-24 09:21:51',NULL,NULL),(66,55,'Dispatch','Reports','Reject Shipper QR Code By MDA','Dispatch/Reports/Index?type=R',8,'N','Y',1,'2024-06-24 09:24:36',NULL,NULL),(67,55,'Dispatch','Reports','Dispatch Summary','Dispatch/Reports/Index?type=DS',9,'N','Y',1,'2024-06-29 10:36:55',NULL,NULL),(69,55,'Dispatch','Reports','MDA Wise Dispatch Summary','Dispatch/Reports/Index?type=DS_MDA',11,'N','Y',1,'2024-07-02 09:17:13',NULL,NULL),(72,42,'Dispatch','RmGateIn','RM - Gate In',NULL,3,'N','Y',1,'2024-07-10 13:47:06',NULL,NULL),(73,42,'Dispatch','SpGateIn','Scrap - Gate In',NULL,4,'N','Y',1,'2024-07-10 13:47:35',NULL,NULL),(74,42,'Dispatch','Reports','Gate In/Out Report','Dispatch/Reports/Gate_In_Out_Report',5,'N','Y',1,'2024-07-11 10:38:29',NULL,NULL),(77,55,'Dispatch','Reports','Know Your Batch Logs','Dispatch/Reports/Index?type=BL',15,'N','Y',1,'2024-07-23 14:10:34',NULL,NULL),(78,42,'Dispatch','RmSpWeightIn','RM-SP Weight In',NULL,13,'N','Y',1,'2024-07-26 11:31:26',NULL,NULL),(79,42,'Dispatch','RmSpWeightOut','RM-SP Weight Out',NULL,14,'N','Y',1,'2024-07-26 11:32:13',NULL,NULL),(80,42,'Dispatch','RmSpGateOut','RM-SP Gate Out',NULL,15,'N','Y',1,'2024-07-26 11:33:36',NULL,NULL),(83,42,'Dispatch','RmSpWeighmentInSlip','RM/SP Weighment In Slip',NULL,15,'N','Y',1,'2024-08-01 11:33:15',NULL,NULL),(84,42,'Dispatch','RmSpWeighmentOutSlip','RM/SP Weighment Out Slip',NULL,16,'N','Y',1,'2024-08-01 11:33:32',NULL,NULL),(85,42,'Dispatch','RmUnloading','RM Unloading','',17,'N','Y',1,'2024-08-05 14:58:28',NULL,NULL),(86,42,'MDA_Automation','Update_MDA','Update MDA',NULL,18,'N','Y',1,'2024-08-16 14:43:15',NULL,NULL),(87,55,'Dispatch','Report','Know Your Batch Logs Live','Dispatch/Reports/Index?type=BL_LIVE',16,'N','Y',1,'2024-08-21 15:39:31',NULL,NULL),(88,55,'Dispatch','Reports','Know Your Batch - Month Wise','Dispatch/Reports/Index?type=KBMW',17,'N','Y',1,'2024-10-25 10:58:44',NULL,NULL),(89,0,'Export',NULL,'Export',NULL,23,'N','Y',1,'2024-11-18 14:34:25',NULL,NULL),(90,89,'Export','GateIn','Gate In',NULL,2,'N','Y',1,'2024-11-18 14:34:49',NULL,NULL),(91,89,'Export','WeightIn','Weight In',NULL,3,'N','Y',1,'2024-11-19 14:50:15',NULL,NULL),(92,89,'Export','WeightOut','Weight Out',NULL,5,'N','Y',1,'2024-11-19 14:50:33',NULL,NULL),(93,89,'Export','GateOut','Gate Out',NULL,6,'N','Y',1,'2024-11-19 14:50:55',NULL,NULL),(94,89,'Export','WeighmentInSlip','Weighment In Slip',NULL,7,'N','Y',1,'2024-11-20 14:59:48',NULL,NULL),(95,89,'Export','WeighmentOutSlip','Weighment Out Slip',NULL,8,'N','Y',1,'2024-11-20 15:00:38',NULL,NULL),(96,0,NULL,'GenerateBatchQR','LineMaster',NULL,23,'N','Y',1,'2024-12-04 11:59:19',NULL,NULL),(97,96,'LineMaster','GenerateBatchQR','Generate Batch QR Image',NULL,1,'N','Y',1,'2024-12-04 11:59:39',NULL,NULL),(98,55,'Dispatch','Reports','Know Your Batch - Issue','Dispatch/Reports/Index?type=BL_Issue',18,'N','Y',1,'2024-12-05 12:08:21',NULL,NULL),(99,89,'Export','CancleGateIn','Cancle Gate In',NULL,9,'N','Y',1,'2024-12-05 15:31:06',NULL,NULL),(100,89,'Export','Reports','Gate In/Out Report','Export/Reports/Gate_In_Out_Report',13,'N','Y',1,'2024-12-05 15:32:09',NULL,NULL),(101,89,'Export','Pallate','Pallate','Export/Pallate/Index',1,'N','Y',1,'2024-12-09 10:21:58',NULL,NULL),(102,89,'Export','Pallate','Load Pallate','Export/Pallate/Load',4,'N','Y',1,'2024-12-12 13:11:28',NULL,NULL),(103,0,NULL,NULL,'Export Reports',NULL,24,'N','Y',1,'2024-12-18 10:18:13',NULL,NULL),(104,103,'Export','Reports','Pallate','Export/Reports/Pallate',14,'N','Y',1,'2024-12-18 10:19:22',NULL,NULL),(105,103,'Export','Reports','MDA wise Pallate','Export/Reports/MDA_Wise_Pallate',15,'N','Y',1,'2024-12-18 16:00:55',NULL,NULL),(106,89,'Export','Invoice','Invoice',NULL,19,'N','Y',1,'2024-12-21 09:53:17',NULL,NULL),(107,7,'Export','Pallate','Load Shipper in Pallate',NULL,17,'N','Y',1,'2024-12-26 11:11:41',NULL,NULL);
/*!40000 ALTER TABLE `menu_master_new` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `plant_master`
--

LOCK TABLES `plant_master` WRITE;
/*!40000 ALTER TABLE `plant_master` DISABLE KEYS */;
INSERT INTO `plant_master` VALUES (4,'KL0','P.O KASTURINAGAR , GANDHINAGAR ,GUJARAT-382423','KALOL NANO UNIT'),(5,'AN0','UP','AONLA PLANT'),(6,'PH0','UP','PHULPUR PLANT');
/*!40000 ALTER TABLE `plant_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_master`
--

LOCK TABLES `product_master` WRITE;
/*!40000 ALTER TABLE `product_master` DISABLE KEYS */;
INSERT INTO `product_master` VALUES (30,'D03','NANO UREA LIQUID 500 ML KALOL','D03','NANO UREA LIQUID 500 ML KALOL',4,'2024-05-10 20:11:50',0,5543,14.5,24,1,12,60,'test',1,'uSuks ;wfj;k fyDoM 500 ,e,y','KL0',99,'NANOU500ML','NANO','NANO','NANO UREA','D','KL1','INDIGENOUS','Y',31051000,'DU0','LT',0.5,'NO','08905204000004','30',24),(31,'D04','NANO DAP LIQUID 500 ML KALOL','D04','NANO DAP LIQUID 500 ML KALOL',4,'2024-05-10 20:11:50',0,5543,14.5,24,1,12,60,'DAP',1,'uSuks Mh,ih rjy 500 fe-yh- dyksy','KL0',99,'NANOD500ML','NANO','NANO','NANO DAP','D','KL1','INDIGENOUS','Y',31051000,'DD0','LT',0.5,'NO','08905204000011','30',24),(28,'D01','NANO ZINC 250 ML','D01','NANO ZINC 250 ML',4,'2024-05-10 20:11:50',NULL,NULL,14.5,24,1,12,60,NULL,1,'uSuks ftad 250 ,e,y','KL0',99,'NANOZ250ML','NANO','NANO','NANO','D','KL1','INDIGENOUS','N',2853,NULL,'LT',0.25,'NO','08908021065004','30',24),(29,'D02','NANO COPPER 250 ML','D02','NANO COPPER 250 ML',4,'2024-05-10 20:11:50',NULL,NULL,14.5,24,1,12,60,NULL,1,'uSuks dkWij 250 fe-yh-','KL0',99,'NANOC250ML','NANO','NANO','NANO','D','KL1','INDIGENOUS','N',2853,NULL,'LT',0.25,'NO','08908021065005','30',24),(32,'D05','NANO DAP LIQUID 500 ML KALOL NV','D05','NANO DAP LIQUID 500 ML KALOL NV',4,'2024-05-10 20:11:50',0,5543,14.5,24,1,12,60,'DAP',1,'uSuks Mh,ih rjy 500 fe-yh- dyksy ,uoh','KL0',99,'NANOD500NV','NANO','NANO','NANO DAP','D','KL1','INDIGENOUS','Y',31051000,'DD0','LT',0.5,'NO','08905204000028','30',24),(6,'D06','SNU 500 ML KALOL NV','D06','SNU 500 ML KALOL NV',4,'2024-05-10 20:11:50',NULL,NULL,14.5,24,1,12,60,NULL,1,NULL,'KL0',99,'SNU500MLNV','NANO','NANO','SNU','D','KL1','INDIGENOUS','Y',31051000,'DS0','LT',0.5,'NO',NULL,'30',24),(11,'D07','NANO UREA LIQUID 500 ML KALOL (2YR)','D07','NANO UREA LIQUID 500 ML KALOL (2YR)',4,'2024-05-10 20:11:50',NULL,NULL,14.5,24,1,12,60,NULL,1,'uSuks ;wfj;k fyDoM 500 ,e,y','KL0',99,'NANOU5KL2Y','NANO','NANO','NANO UREA','D','KL1','INDIGENOUS','Y',31051000,'DU0','LT',0.5,'NO',NULL,'30',24),(35,'D09','NANO UREA PLUS 500 ML KALOL','D09','NANO UREA PLUS 500 ML KALOL',4,'2024-05-10 20:11:50',0,0.5543,14.5,24,1,12,60,'UREA',1,NULL,'KL0',99,'NUP500MLKL','NANO','NANO','NANO UREA PLUS','D','KL1','INDIGENOUS','Y',31051000,'DS0','LT',0.5,'NO','08905204000035','30',24),(51,'D08','NANO UREA LIQUID 500 ML KALOL NV','D08','NANO UREA LIQUID 500 ML KALOL NV',4,'2024-05-10 20:11:50',NULL,NULL,NULL,24,NULL,NULL,NULL,NULL,NULL,NULL,'KL0',99,'NANOU500NV','NANO','NANO','NANO UREA','D','KL1','INDIGENOUS','Y',31051000,'DU0','LT',0.5,'NO',NULL,NULL,24),(54,'D31','NANO UREA SUPER 500 ML KALOL NV','D31','NANO UREA SUPER 500 ML KALOL NV',4,'2024-09-02 12:02:12',0,NULL,NULL,24,NULL,NULL,NULL,NULL,1,'=','KL0',99,'NUS500ML','NANO','NANO','NANO UREA','D','KL1','INDIGENOUS','Y',31051000,NULL,'LT',1,'NO',NULL,NULL,24),(55,'D32','NANO UREA PLUS 500 ML KALOL (IPL)','D32','NANO UREA PLUS 500 ML KALOL (IPL)',4,'2024-09-02 12:02:12',0,NULL,NULL,24,NULL,NULL,NULL,NULL,1,'=','KL0',99,'NUP500IPL','NANO','NANO','NANO UREA','D','KL1','INDIGENOUS','Y',31051000,NULL,'LT',1,'NO',NULL,NULL,24),(56,'D33','NANO DAP LIQUID 500 ML KALOL (IPL)','D33','NANO DAP LIQUID 500 ML KALOL (IPL)',4,'2024-09-02 12:02:12',0,NULL,NULL,24,NULL,NULL,NULL,NULL,1,'=','KL0',99,'NANOD500IP','NANO','NANO','NANO DAP','D','KL1','INDIGENOUS','Y',31051000,NULL,'LT',1,'NO',NULL,NULL,24),(72,'D34','NANO UREA PLUS 2.5 GALLON KALOL NV','D34','NANO UREA PLUS 2.5 GALLON KALOL NV',4,'2024-10-30 11:10:18',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'=','KL0',99,'NUP2.5GKLN','NANO','NANO','NANO UREA','D','KL1','INDIGENOUS','Y',31021090,NULL,'LT',9,'NO',NULL,NULL,24),(73,'D35','NANO DAP LIQUID 2.5 GALLON KALOL NV','D35','NANO DAP LIQUID 2.5 GALLON KALOL NV',4,'2024-10-30 11:10:18',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'=','KL0',99,'ND2.5GKLNV','NANO','NANO','NANO DAP','D','KL1','INDIGENOUS','Y',31053000,NULL,'LT',9,'NO',NULL,NULL,24);
/*!40000 ALTER TABLE `product_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `rfid_master`
--

LOCK TABLES `rfid_master` WRITE;
/*!40000 ALTER TABLE `rfid_master` DISABLE KEYS */;
INSERT INTO `rfid_master` VALUES (1,'KL00001','E28011602000603E56E50ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(2,'KL00002','E28011602000741E56EB0ABD','Assigned','Testing',7,4,1,'2023-10-13 11:40:23',1),(3,'KL00003','E28011602000726E56F80ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(4,'KL00004','E2801160200062DE56F80ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(5,'KL00005','E2801160200070BE56FD0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(6,'KL00006','E28011602000609E56E50ABD','Assigned','Testing',7,4,1,'2023-10-13 11:40:23',1),(7,'KL00007','E2801160200064CE56EB0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(8,'KL00008','E28011602000603E56F20ABD','Assigned','Testing',7,4,1,'2023-10-13 11:40:23',1),(9,'KL00009','E28011602000743E56F70ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(10,'KL00010','E28011602000626E57020ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(11,'KL00011','E28011602000623E56EB0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(12,'KL00012','E2801160200062AE56EB0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(13,'KL00013','E28011602000609E56F20ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(14,'KL00014','E2801160200064DE56F70ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(15,'KL00015','E2801160200062EE56F80ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(16,'KL00016','E28011602000702E56E50ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(17,'KL00017','E28011602000640E56EB0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(18,'KL00018','E28011602000725E56F80ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(19,'KL00019','E28011602000704E56F20ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(20,'KL00020','E28011602000644E56F70ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(21,'KL00021','E28011602000708E56E50ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(22,'KL00022','E2801160200074BE56EB0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(23,'KL00023','E2801160200072BE56EB0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(24,'KL00024','E2801160200060AE56F20ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(25,'KL00025','E2801160200064EE56F70ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(26,'KL00026','E28011602000740E56B50ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(27,'KL00027','E28011602000622E56C10ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(28,'KL00028','E28011602000729E56C10ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(29,'KL00029','E28011602000623E56DD0ABD','Assigned','Testing',7,4,1,'2023-10-13 11:40:23',1),(30,'KL00030','E2801160200062AE56DD0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(31,'KL00031','E2801160200062AE56B40ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(32,'KL00032','E28011602000708E56BC0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(33,'KL00033','E2801160200074AE56C10ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(34,'KL00034','E28011602000709E56D70ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(35,'KL00035','E2801160200074BE56DD0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(36,'KL00036','E28011602000621E56C10ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(37,'KL00037','E28011602000702E56BC0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(38,'KL00038','E28011602000722E56DD0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(39,'KL00039','E28011602000703E56D70ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(40,'KL00040','E28011602000741E56DD0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(41,'KL00041','E28011602000707E56BC0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(42,'KL00042','E28011602000749E56C10ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(43,'KL00043','E28011602000608E56D70ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(44,'KL00044','E2801160200064AE56DD0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(45,'KL00045','E2801160200072BE56DD0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(46,'KL00046','E28011602000701E56BC0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(47,'KL00047','E2801160200072FE56C10ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(48,'KL00048','E28011602000602E56D70ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1),(49,'KL00049','E28011602000640E56DD0ABD','Assigned','Testing',7,4,1,'2023-10-13 11:40:23',1),(50,'KL00050','E28011602000722E56EB0ABD','Active','Testing',7,4,1,'2023-10-13 11:40:23',1);
/*!40000 ALTER TABLE `rfid_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `role_master`
--

LOCK TABLES `role_master` WRITE;
/*!40000 ALTER TABLE `role_master` DISABLE KEYS */;
INSERT INTO `role_master` VALUES (1,'SuperAdmin',1,1,NULL),(94,'Admin',4,18,'2023-05-03 09:14:45'),(150,'Station Seven',4,18,'2023-10-12 09:13:01'),(151,'Station six',4,18,'2023-10-12 09:13:16'),(170,'Administrator',4,18,'2023-12-28 08:54:27'),(230,'ADMIN WITH REPORT',4,198,'2024-01-30 04:59:52');
/*!40000 ALTER TABLE `role_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `role_master_new`
--

LOCK TABLES `role_master_new` WRITE;
/*!40000 ALTER TABLE `role_master_new` DISABLE KEYS */;
INSERT INTO `role_master_new` VALUES (1,'SuperAdmin',1,1,NULL,'Y','Y',NULL,NULL),(2,'Admin',0,1,'2024-05-29 16:23:13','Y','Y',1,'2024-12-26 11:12:04'),(3,'Station Six',4,1,'2024-05-29 17:01:28','Y','N',1,'2024-08-06 16:21:15'),(4,'Station Seven',0,1,'2024-05-29 17:02:24','Y','N',1,'2024-12-09 10:22:11'),(5,'Station 7 & 8 Reports',0,1,'2024-06-18 16:46:46','Y','N',1,'2024-12-05 12:08:33'),(6,'ADMIN WITH REPORT',0,1,'2024-06-27 10:22:38','Y','N',1,'2024-07-26 14:23:21'),(7,'Station 1',4,1,'2024-07-10 11:14:50','Y','N',1,'2024-07-26 14:23:11'),(8,'Test1',4,1,'2024-07-26 16:18:12','Y','N',1,'2024-07-27 10:38:01'),(9,'Station Six Export',0,1,'2024-12-26 11:10:53','Y','N',1,'2025-01-01 13:30:08');
/*!40000 ALTER TABLE `role_master_new` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `role_menu_new`
--

LOCK TABLES `role_menu_new` WRITE;
/*!40000 ALTER TABLE `role_menu_new` DISABLE KEYS */;
INSERT INTO `role_menu_new` VALUES (7,0),(7,1),(7,1),(7,3),(7,1),(7,4),(7,0),(7,7),(7,7),(7,11),(7,7),(7,16),(7,7),(7,17),(7,0),(7,18),(7,18),(7,19),(7,7),(7,20),(7,7),(7,22),(7,18),(7,23),(7,18),(7,26),(7,0),(7,27),(7,27),(7,28),(7,27),(7,29),(7,27),(7,30),(7,27),(7,32),(7,27),(7,36),(6,0),(6,1),(6,1),(6,4),(6,0),(6,7),(6,7),(6,11),(6,1),(6,12),(6,1),(6,13),(6,7),(6,16),(6,7),(6,17),(6,0),(6,18),(6,18),(6,19),(6,7),(6,20),(6,7),(6,22),(6,18),(6,23),(6,18),(6,26),(6,0),(6,27),(6,27),(6,28),(6,27),(6,29),(6,27),(6,30),(6,27),(6,32),(6,0),(6,33),(6,33),(6,34),(6,33),(6,35),(6,27),(6,36),(6,7),(6,40),(1,82),(8,1),(8,2),(8,1),(8,3),(8,1),(8,4),(8,1),(8,8),(8,1),(8,9),(8,1),(8,10),(8,1),(8,12),(8,1),(8,15),(8,1),(8,13),(8,1),(8,14),(8,1),(8,21),(8,1),(8,41),(8,1),(8,81),(3,0),(3,0),(3,7),(3,7),(3,40),(1,86),(1,87),(1,88),(1,89),(1,90),(1,91),(1,92),(1,93),(1,94),(1,95),(1,96),(1,97),(1,98),(5,55),(5,65),(5,55),(5,66),(5,55),(5,67),(5,55),(5,69),(5,55),(5,77),(5,55),(5,88),(5,55),(5,98),(1,99),(1,100),(1,101),(4,42),(4,43),(4,42),(4,44),(4,42),(4,50),(4,42),(4,72),(4,42),(4,73),(4,42),(4,51),(4,42),(4,74),(4,42),(4,45),(4,42),(4,52),(4,42),(4,53),(4,42),(4,78),(4,42),(4,79),(4,42),(4,80),(4,42),(4,83),(4,42),(4,84),(4,42),(4,85),(4,42),(4,86),(4,55),(4,48),(4,55),(4,49),(4,55),(4,65),(4,55),(4,66),(4,55),(4,77),(4,89),(4,90),(4,89),(4,91),(4,89),(4,92),(4,89),(4,93),(4,89),(4,94),(4,89),(4,95),(4,89),(4,99),(4,89),(4,100),(4,89),(4,101),(4,96),(4,97),(1,102),(1,103),(1,104),(1,105),(1,106),(1,107),(2,1),(2,2),(2,1),(2,3),(2,1),(2,4),(2,1),(2,8),(2,1),(2,9),(2,1),(2,10),(2,1),(2,12),(2,1),(2,15),(2,1),(2,13),(2,1),(2,14),(2,1),(2,21),(2,1),(2,41),(2,7),(2,22),(2,7),(2,40),(2,7),(2,107),(2,0),(2,38),(2,0),(2,39),(2,42),(2,43),(2,42),(2,44),(2,42),(2,50),(2,42),(2,47),(2,42),(2,51),(2,42),(2,45),(2,42),(2,52),(2,42),(2,53),(2,42),(2,54),(2,55),(2,48),(2,55),(2,49),(2,55),(2,65),(2,55),(2,66),(2,55),(2,67),(2,55),(2,69),(2,55),(2,77),(2,55),(2,88),(2,55),(2,98),(2,89),(2,90),(2,89),(2,91),(2,89),(2,92),(2,89),(2,93),(2,89),(2,94),(2,89),(2,95),(2,89),(2,99),(2,89),(2,100),(2,89),(2,101),(2,89),(2,102),(2,89),(2,106),(2,96),(2,97),(2,103),(2,104),(2,103),(2,105),(9,7),(9,107),(9,89),(9,101),(9,89),(9,102);
/*!40000 ALTER TABLE `role_menu_new` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `statemaster`
--

LOCK TABLES `statemaster` WRITE;
/*!40000 ALTER TABLE `statemaster` DISABLE KEYS */;
INSERT INTO `statemaster` VALUES (1,'Gujarat',1,1,18,'2023-03-20 16:12:40');
/*!40000 ALTER TABLE `statemaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `transporter_master`
--

LOCK TABLES `transporter_master` WRITE;
/*!40000 ALTER TABLE `transporter_master` DISABLE KEYS */;
INSERT INTO `transporter_master` VALUES (1,'KL0SF0','SELF',1,4,'2023-10-14 12:29:13',1),(2,'KL0JET','JET ROADLINES(IND)PVT.LTD',1,4,'2023-10-26 13:03:04',1),(3,'KL0JTG','JAIN TRANSPORT SERVICE(GUJ).',1,4,'2023-11-29 11:50:35',1),(4,'KL0RRS','RISHABH ROAD SERVICE',1,4,'2023-11-29 14:01:06',1),(5,'0','RITCOLOGISTIC',1,4,'2024-03-02 12:08:23',1),(6,'0','ritco',1,4,'2024-03-04 11:01:49',1),(7,'0','new hariyana punjab trans. cop',1,4,'2024-03-15 13:36:14',1),(8,'KL0YES','YES_SUPPLY_CHAIN',1,4,'2024-05-20 08:38:53',1),(9,'KL0DBR','DELHI BANGLORE ROADLINES',1,4,'2024-05-21 10:58:43',1),(10,'KL0KGT','KANPUR_ETAH GOODS TRANSPORT',1,4,'2024-05-24 16:33:40',1),(11,'KL0NAN','NANOVENTION_COIMBATORE',0,4,'2024-06-29 16:56:31',1),(12,'0','One Drive Transport Solution LLP',1,4,'2024-07-19 14:26:08',NULL),(13,'TEST','Test',1,4,'2024-07-27 10:21:43',NULL),(14,NULL,'Test',NULL,4,'2024-07-27 14:02:20',NULL),(15,NULL,'Test',NULL,4,'2024-07-27 14:05:54',NULL),(16,'=','=',0,NULL,'2024-08-03 11:26:29',1),(17,'TR0017','1',0,4,'2024-08-05 16:22:48',1),(18,'TR0018','1',0,4,'2024-08-05 16:29:02',1),(19,'TR0019','1',0,4,'2024-08-05 16:33:04',1),(20,'TR0020','1',0,4,'2024-08-05 16:35:12',1),(21,'TR0021','1',0,4,'2024-08-05 16:38:20',1),(22,'TR0022','1',0,4,'2024-08-05 16:39:21',1),(23,'TR0023','1',0,4,'2024-08-05 16:41:08',1),(24,'TR0024','Test123456',0,4,'2024-08-05 16:59:29',1),(25,'TR0025','KL0RRS - RISHABH ROAD SERVICE',0,4,'2024-09-16 10:57:14',1),(26,'TEST2111','Test 2111',0,4,'2024-11-21 11:15:54',NULL),(27,'TEST21111','TEST_2111_1',1,4,'2024-11-21 11:29:43',NULL);
/*!40000 ALTER TABLE `transporter_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_master_new`
--

LOCK TABLES `user_master_new` WRITE;
/*!40000 ALTER TABLE `user_master_new` DISABLE KEYS */;
INSERT INTO `user_master_new` VALUES (1,'Admin','OxJcKnX/dBM=','Super',NULL,'Admin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'N',NULL,'Y',NULL,NULL,NULL,NULL),(2,'KL06','dsDW36iENyglAAJ/cL7EWw==','KL ',NULL,'SIX','9999999999',NULL,'example@mail.com',NULL,'NA',0,0,0,NULL,'0','',0,0,0,'N','','Y',1,'2024-05-29 16:39:36',1,'2024-06-27 09:11:59'),(3,'KL67','SM8c7ckHAFA=','Admin',NULL,'NA','9999999999',NULL,'example@mail.com',NULL,'NA',0,0,0,NULL,'0','',0,0,0,'N','','Y',1,'2024-05-29 17:06:44',1,'2024-10-25 11:01:49'),(4,'kl07','dsDW36iENyglAAJ/cL7EWw==','KL',NULL,'SEVEN','9999999999',NULL,'abc@gmail.com',NULL,'KALOL',1,281,0,'KALOL','0','',0,0,0,'N','','Y',1,'2024-05-29 17:07:32',1,'2024-05-29 17:07:32'),(5,'KL01','SM8c7ckHAFA=','USER - ',NULL,'STATION ONE','9999999999',NULL,'example@mail.com',NULL,'NA',0,0,0,NULL,'0','',0,0,0,'N','','Y',1,'2024-07-10 11:36:59',1,'2024-07-10 11:37:54'),(6,'Admin_KL','SM8c7ckHAFA=','KL',NULL,'Admin','9876543210',NULL,'example@mail.com',NULL,'NA',1,0,0,NULL,'0','',0,0,0,'N','','Y',1,'2024-07-27 08:44:02',1,'2025-01-01 13:29:02'),(7,'TS7','dsDW36iENyglAAJ/cL7EWw==','TS',NULL,'1','9865326589',NULL,'ts@gmail.com',NULL,'Kalol',1,1,2,'Kalol','0','',0,0,0,'N','','Y',1,'2024-08-06 16:07:06',NULL,NULL),(8,'TSV','dsDW36iENyglAAJ/cL7EWw==','T Super',NULL,'Wiser','9865326598',NULL,'tsv@gmail.com',NULL,'Kalol',1,1,3,'Kalol','0','',0,0,0,'N','','Y',1,'2024-08-06 16:14:27',NULL,NULL),(9,'107367','dsDW36iENyglAAJ/cL7EWw==','Vikram',NULL,'Bali','9016575588',NULL,'vikram@iffco.in',NULL,'IFFCO KALOL',0,0,0,NULL,'0','',0,0,0,'N','','Y',1,'2024-08-21 12:19:54',NULL,NULL),(10,'107015','dsDW36iENyglAAJ/cL7EWw==','Anand',NULL,'Srivastav','9015478545',NULL,'anand@iffco.in',NULL,'IFFCO NANO',0,0,0,NULL,'0','',0,0,0,'N','','Y',1,'2024-08-21 12:21:14',1,'2025-01-01 15:19:03'),(11,'KL06E','dsDW36iENyglAAJ/cL7EWw==','KL06',NULL,'Export','9876543210',NULL,'test@mail.com',NULL,'NA',0,0,0,NULL,'0','',0,0,0,'N','','Y',1,'2024-12-26 11:13:38',1,'2025-01-01 13:30:46'),(12,'107206','dsDW36iENyglAAJ/cL7EWw==','107206',NULL,'NA','9876543210',NULL,'test@mail.com',NULL,'NA',0,0,0,NULL,'0','',0,0,0,'N','','Y',1,'2025-01-01 15:15:49',NULL,NULL),(13,'105596','dsDW36iENyglAAJ/cL7EWw==','105596',NULL,'NA','9876543210',NULL,'test2@mail.com',NULL,'NA',0,0,0,NULL,'0','',0,0,0,'N','','Y',1,'2025-01-01 15:16:31',NULL,NULL);
/*!40000 ALTER TABLE `user_master_new` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_role_new`
--

LOCK TABLES `user_role_new` WRITE;
/*!40000 ALTER TABLE `user_role_new` DISABLE KEYS */;
INSERT INTO `user_role_new` VALUES (1,4,1,1,NULL,NULL,NULL,'Y'),(4,4,4,1,'2024-05-29 17:07:32',NULL,NULL,'Y'),(2,4,3,1,'2024-06-27 09:11:59',NULL,NULL,'Y'),(5,4,7,1,'2024-07-10 11:37:54',NULL,NULL,'Y'),(7,4,4,1,'2024-08-06 16:07:06',NULL,NULL,'Y'),(8,4,4,1,'2024-08-06 16:14:27',NULL,NULL,'Y'),(9,4,5,1,'2024-08-21 12:19:54',NULL,NULL,'Y'),(3,4,5,1,'2024-10-25 11:01:49',NULL,NULL,'Y'),(6,4,2,1,'2025-01-01 13:29:02',NULL,NULL,'Y'),(11,4,9,1,'2025-01-01 13:30:46',NULL,NULL,'Y'),(12,4,9,1,'2025-01-01 15:15:49',NULL,NULL,'Y'),(13,4,9,1,'2025-01-01 15:16:31',NULL,NULL,'Y'),(10,4,5,1,'2025-01-01 15:19:03',NULL,NULL,'Y'),(10,4,9,1,'2025-01-01 15:19:03',NULL,NULL,'Y');
/*!40000 ALTER TABLE `user_role_new` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `vendor_master`
--

LOCK TABLES `vendor_master` WRITE;
/*!40000 ALTER TABLE `vendor_master` DISABLE KEYS */;
INSERT INTO `vendor_master` VALUES (4,1,45872,'gail',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0,NULL,0,0,'2024-03-02 12:08:23',0,NULL,NULL,0,0),(4,2,12,'grasim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0,NULL,0,0,'2024-03-15 13:36:14',0,NULL,NULL,0,0),(4,3,22543,'STORE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,0,NULL,0,0,'2024-07-19 14:26:08',0,NULL,NULL,0,0),(4,5,NULL,'Test','Test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-07-27 14:05:54',NULL,NULL,NULL,NULL,NULL),(4,6,NULL,'IFFCO KANDLA','KANDLA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-08-01 11:20:46',NULL,NULL,NULL,NULL,NULL),(4,11,NULL,'GROU ALOGISTICS INDIA PVT','MUMBAI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-09-16 10:39:34',NULL,NULL,NULL,NULL,NULL),(4,10,NULL,'GROU ALOGISTICS INDIA PVT','MUMBAI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-09-16 10:38:58',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `vendor_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `work_shift_master`
--

LOCK TABLES `work_shift_master` WRITE;
/*!40000 ALTER TABLE `work_shift_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `work_shift_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `work_station_master`
--

LOCK TABLES `work_station_master` WRITE;
/*!40000 ALTER TABLE `work_station_master` DISABLE KEYS */;
INSERT INTO `work_station_master` VALUES (1,'Station 1',4,1,NULL),(2,'Station 2',4,1,NULL),(6,'Station 6',4,1,NULL),(7,'Station 7',4,1,NULL),(8,'Station 8',4,1,NULL);
/*!40000 ALTER TABLE `work_station_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-28 17:13:44
