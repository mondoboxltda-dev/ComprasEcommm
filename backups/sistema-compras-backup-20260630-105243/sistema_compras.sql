-- MySQL dump 10.13  Distrib 8.4.9, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sistema_compras
-- ------------------------------------------------------
-- Server version	8.4.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `sistema_compras`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sistema_compras` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `sistema_compras`;

--
-- Table structure for table `autorizacoes`
--

DROP TABLE IF EXISTS `autorizacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autorizacoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ordem_id` int NOT NULL,
  `autorizado_por` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_aprovacao` date DEFAULT NULL,
  `status` enum('pendente','aprovada','reprovada') COLLATE utf8mb4_unicode_ci DEFAULT 'pendente',
  `observacao` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ordem_id` (`ordem_id`),
  CONSTRAINT `fk_aut_ordem` FOREIGN KEY (`ordem_id`) REFERENCES `ordens_compra` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autorizacoes`
--

LOCK TABLES `autorizacoes` WRITE;
/*!40000 ALTER TABLE `autorizacoes` DISABLE KEYS */;
INSERT INTO `autorizacoes` VALUES (3,3,NULL,NULL,'pendente',NULL);
/*!40000 ALTER TABLE `autorizacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cadastro_categorias`
--

DROP TABLE IF EXISTS `cadastro_categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cadastro_categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('ativo','inativo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ativo',
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `atualizado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=2919 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cadastro_categorias`
--

LOCK TABLES `cadastro_categorias` WRITE;
/*!40000 ALTER TABLE `cadastro_categorias` DISABLE KEYS */;
INSERT INTO `cadastro_categorias` VALUES (1,'Importado via NF-e','ativo','2026-06-25 17:18:34','2026-06-25 17:18:34'),(28,'2.3.18 Caçamba','ativo','2026-06-25 17:22:19','2026-06-25 17:22:19'),(37,'2.3.13 Eventos/Investimentos','ativo','2026-06-25 17:22:31','2026-06-25 17:22:31'),(42,'2.1.10 Embalagem','ativo','2026-06-25 17:22:39','2026-06-25 17:22:39'),(47,'2.3.14 Endomarketing','ativo','2026-06-25 17:22:48','2026-06-25 17:22:48'),(52,'2.3.19 Farmacia','ativo','2026-06-25 17:22:54','2026-06-25 17:22:54'),(57,'2.3.20 Frete','ativo','2026-06-25 17:23:01','2026-06-25 17:23:01'),(62,'2.3.6 Gasto com Veiculos','ativo','2026-06-25 17:23:11','2026-06-25 17:23:11'),(67,'2.3.5 Manutençao Predial','ativo','2026-06-25 17:23:21','2026-06-25 17:23:21'),(72,'2.1.11 Tercerizados','ativo','2026-06-25 17:23:29','2026-06-25 17:23:29'),(77,'2.1.2 Matéria-Prima MDF','ativo','2026-06-25 17:23:35','2026-06-25 17:23:35'),(82,'2.1.3 Matéria-Prima Cola','ativo','2026-06-25 17:23:42','2026-06-25 17:23:42'),(87,'2.1.5 Matéria-Prima Carpete','ativo','2026-06-25 17:23:55','2026-06-25 17:23:55'),(92,'2.1.4 Matéria-Prima Sisal','ativo','2026-06-25 17:24:01','2026-06-25 17:24:01'),(97,'2.1.6 Matéria-Prima Injetavel','ativo','2026-06-25 17:24:08','2026-06-25 17:24:08'),(102,'2.1.7 Matéria-Prima Tecido','ativo','2026-06-25 17:24:14','2026-06-25 17:24:14'),(107,'2.1.8 Matéria-Prima Acrilico','ativo','2026-06-25 17:24:23','2026-06-25 17:24:23'),(112,'2.1.9 Matéria-Prima Outros','ativo','2026-06-25 17:24:32','2026-06-25 17:24:32'),(117,'2.3.21 Material de Escritório','ativo','2026-06-25 17:24:39','2026-06-25 17:24:39'),(122,'2.1.1 Compra de Mercadorias','ativo','2026-06-25 17:24:46','2026-06-25 17:24:46'),(127,'2.3.16 Supermercado','ativo','2026-06-25 17:24:53','2026-06-25 17:24:53'),(132,'2.1.12 Insumos de Fabricação','ativo','2026-06-25 17:24:59','2026-06-25 17:24:59'),(1083,'2.3.23 EPI','ativo','2026-06-25 20:17:13','2026-06-25 20:17:13');
/*!40000 ALTER TABLE `cadastro_categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cadastro_tipos_pagamento`
--

DROP TABLE IF EXISTS `cadastro_tipos_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cadastro_tipos_pagamento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('ativo','inativo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ativo',
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `atualizado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=2808 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cadastro_tipos_pagamento`
--

LOCK TABLES `cadastro_tipos_pagamento` WRITE;
/*!40000 ALTER TABLE `cadastro_tipos_pagamento` DISABLE KEYS */;
INSERT INTO `cadastro_tipos_pagamento` VALUES (1,'PIX','ativo','2026-06-25 17:18:34','2026-06-25 17:18:34'),(2,'Boleto','ativo','2026-06-25 17:18:34','2026-06-25 17:18:34'),(3,'Cartao de Credito','ativo','2026-06-25 17:18:34','2026-06-25 17:18:34'),(4,'Cartao de Debito','ativo','2026-06-25 17:18:34','2026-06-25 17:18:34'),(5,'Dinheiro','ativo','2026-06-25 17:18:34','2026-06-25 17:18:34'),(6,'Transferencia','ativo','2026-06-25 17:18:34','2026-06-25 17:18:34');
/*!40000 ALTER TABLE `cadastro_tipos_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedores`
--

DROP TABLE IF EXISTS `fornecedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cnpj` varchar(18) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contato` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ativo','inativo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ativo',
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedores`
--

LOCK TABLES `fornecedores` WRITE;
/*!40000 ALTER TABLE `fornecedores` DISABLE KEYS */;
INSERT INTO `fornecedores` VALUES (3,'GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','44.479.620/0001-20',NULL,NULL,NULL,'ativo','2026-06-24 20:41:58'),(5,'MARCIO JOSE JACOMASSI ME','05.455.097/0001-40',NULL,NULL,NULL,'ativo','2026-06-25 17:46:29'),(6,'PAVESA COMERCIO DE FERRAGENS E FERRAMENTAS LTDA','10.779.926/0001-80',NULL,NULL,NULL,'ativo','2026-06-25 17:46:29'),(7,'IDEAL - BOX E EMBALAGENS LTDA','22.962.695/0001-25',NULL,NULL,NULL,'ativo','2026-06-25 17:46:29'),(8,'J C SOUZA FERNANDES','39.511.397/0001-11',NULL,NULL,NULL,'ativo','2026-06-25 17:46:29'),(9,'MADEIRANIT COM E IND DE  MADEIRAS LTDA','46.676.813/0001-05',NULL,NULL,NULL,'ativo','2026-06-25 17:46:29'),(10,'INYLBRA INDUSTRIA E COMERCIO LTDA','59.135.509/0006-07',NULL,NULL,NULL,'ativo','2026-06-25 17:46:29'),(11,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','64.262.083/0001-70',NULL,NULL,NULL,'ativo','2026-06-25 17:46:29'),(12,'ADAR IND. COM. IMPORT. E EXPORT. LTDA.','03.442.526/0001-10',NULL,NULL,NULL,'ativo','2026-06-25 17:46:29'),(13,'Marcos Fornecedor','22022894000153','19 99889-8955','19 99889-8955','','ativo','2026-06-25 20:16:14'),(14,'UREL & UREL COMPENSADOS LTDA','22.320.037/0001-30','Não informado','1935853155','Não informado','ativo','2026-06-26 18:26:50');
/*!40000 ALTER TABLE `fornecedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_custos`
--

DROP TABLE IF EXISTS `historico_custos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_custos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produto_id` int NOT NULL,
  `fornecedor` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documento` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_entrada` date NOT NULL,
  `quantidade` decimal(14,4) NOT NULL,
  `unidade_compra` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantidade_por_unidade_compra` decimal(14,4) NOT NULL DEFAULT '1.0000',
  `unidade_base` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantidade_total_base` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `valor_unitario` decimal(14,4) NOT NULL,
  `valor_unitario_base` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `valor_total` decimal(14,2) NOT NULL,
  `origem` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `recebimento_id` int NOT NULL,
  `recebimento_item_id` int NOT NULL,
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_custo_item` (`recebimento_item_id`,`origem`),
  KEY `fk_custo_produto` (`produto_id`),
  KEY `fk_custo_recebimento` (`recebimento_id`),
  CONSTRAINT `fk_custo_item` FOREIGN KEY (`recebimento_item_id`) REFERENCES `nfe_importacao_itens` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_custo_produto` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`),
  CONSTRAINT `fk_custo_recebimento` FOREIGN KEY (`recebimento_id`) REFERENCES `nfe_importacoes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_custos`
--

LOCK TABLES `historico_custos` WRITE;
/*!40000 ALTER TABLE `historico_custos` DISABLE KEYS */;
INSERT INTO `historico_custos` VALUES (33,3,'MARCIO JOSE JACOMASSI ME','1378','2026-06-26',1000.0000,'PECAS',1.0000,'UN',1000.0000,0.5300,0.5300,530.00,'XML',18,35,'2026-06-26 16:47:46'),(34,4,'PAVESA COMERCIO DE FERRAGENS E FERRAMENTAS LTDA','7727','2026-06-26',38.5000,'MIL',1.0000,'UN',38.5000,1.9000,1.9000,73.15,'XML',19,36,'2026-06-26 16:47:47'),(35,5,'IDEAL - BOX E EMBALAGENS LTDA','14613','2026-06-26',350.0000,'UN',1.0000,'UN',350.0000,4.1600,4.1600,1456.00,'XML',20,37,'2026-06-26 16:47:48'),(36,6,'IDEAL - BOX E EMBALAGENS LTDA','14613','2026-06-26',540.0000,'UN',1.0000,'UN',540.0000,2.5400,2.5400,1371.60,'XML',20,38,'2026-06-26 16:47:48'),(37,7,'J C SOUZA FERNANDES','1813','2026-06-26',50.0000,'KG',1.0000,'UN',50.0000,15.9600,15.9600,798.00,'XML',21,39,'2026-06-26 16:47:49'),(38,8,'J C SOUZA FERNANDES','1813','2026-06-26',10.0000,'UN',1.0000,'UN',10.0000,16.0000,16.0000,160.00,'XML',21,40,'2026-06-26 16:47:49'),(39,7,'J C SOUZA FERNANDES','1819','2026-06-26',150.0000,'KG',1.0000,'UN',150.0000,21.0000,21.0000,3150.00,'XML',22,41,'2026-06-26 16:47:49'),(40,8,'J C SOUZA FERNANDES','1819','2026-06-26',30.0000,'UN',1.0000,'UN',30.0000,16.0000,16.0000,480.00,'XML',22,42,'2026-06-26 16:47:49'),(41,2,'GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','156437','2026-06-26',2.0000,'PALLET',126.0000,'CHAPAS',252.0000,7994.7000,63.4500,15989.40,'XML',23,43,'2026-06-26 16:47:50'),(42,2,'GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','156899','2026-06-26',1.0000,'PALLET',126.0000,'CHAPAS',126.0000,7994.7000,63.4500,7994.70,'XML',24,44,'2026-06-26 16:47:51'),(43,9,'GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','157040','2026-06-26',2.0000,'PALLET',168.0000,'CHAPAS',336.0000,7660.8000,45.6000,15321.60,'XML',25,45,'2026-06-26 16:47:52'),(44,10,'MADEIRANIT COM E IND DE  MADEIRAS LTDA','675861','2026-06-26',200.0000,'CHAPAS',1.0000,'CHAPAS',200.0000,44.9500,44.9500,8990.00,'XML',26,46,'2026-06-26 16:47:53'),(45,11,'MADEIRANIT COM E IND DE  MADEIRAS LTDA','675861','2026-06-26',3.0000,'CHAPAS',1.0000,'CHAPAS',3.0000,0.0500,0.0500,0.15,'XML',26,47,'2026-06-26 16:47:53'),(46,12,'INYLBRA INDUSTRIA E COMERCIO LTDA','131490','2026-06-26',160.0000,'M2',1.0000,'UN',160.0000,7.3700,7.3700,1179.20,'XML',27,48,'2026-06-26 16:47:54'),(47,12,'INYLBRA INDUSTRIA E COMERCIO LTDA','131490','2026-06-26',160.0000,'M2',1.0000,'UN',160.0000,7.3700,7.3700,1179.20,'XML',27,49,'2026-06-26 16:47:54'),(48,12,'INYLBRA INDUSTRIA E COMERCIO LTDA','131490','2026-06-26',160.0000,'M2',1.0000,'UN',160.0000,7.3700,7.3700,1179.20,'XML',27,50,'2026-06-26 16:47:54'),(49,12,'INYLBRA INDUSTRIA E COMERCIO LTDA','131490','2026-06-26',160.0000,'M2',1.0000,'UN',160.0000,7.3700,7.3700,1179.20,'XML',27,51,'2026-06-26 16:47:54'),(50,12,'INYLBRA INDUSTRIA E COMERCIO LTDA','131490','2026-06-26',160.0000,'M2',1.0000,'UN',160.0000,7.3700,7.3700,1179.20,'XML',27,52,'2026-06-26 16:47:54'),(51,12,'INYLBRA INDUSTRIA E COMERCIO LTDA','131490','2026-06-26',160.0000,'M2',1.0000,'UN',160.0000,7.3700,7.3700,1179.20,'XML',27,53,'2026-06-26 16:47:54'),(52,12,'INYLBRA INDUSTRIA E COMERCIO LTDA','131490','2026-06-26',160.0000,'M2',1.0000,'UN',160.0000,7.3700,7.3700,1179.20,'XML',27,54,'2026-06-26 16:47:54'),(53,12,'INYLBRA INDUSTRIA E COMERCIO LTDA','131490','2026-06-26',160.0000,'M2',1.0000,'UN',160.0000,7.3700,7.3700,1179.20,'XML',27,55,'2026-06-26 16:47:54'),(54,12,'INYLBRA INDUSTRIA E COMERCIO LTDA','131490','2026-06-26',160.0000,'M2',1.0000,'UN',160.0000,7.3700,7.3700,1179.20,'XML',27,56,'2026-06-26 16:47:54'),(55,12,'INYLBRA INDUSTRIA E COMERCIO LTDA','131490','2026-06-26',160.0000,'M2',1.0000,'UN',160.0000,7.3700,7.3700,1179.20,'XML',27,57,'2026-06-26 16:47:54'),(56,13,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','967','2026-06-26',4.0000,'UN',1.0000,'UN',4.0000,10.0000,10.0000,40.00,'XML',28,58,'2026-06-26 16:47:55'),(57,14,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','967','2026-06-26',4.0000,'UN',1.0000,'UN',4.0000,10.0000,10.0000,40.00,'XML',28,59,'2026-06-26 16:47:55'),(58,15,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','967','2026-06-26',4.0000,'UN',1.0000,'UN',4.0000,10.0000,10.0000,40.00,'XML',28,60,'2026-06-26 16:47:55'),(59,16,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','967','2026-06-26',1.0000,'UN',1.0000,'UN',1.0000,10.0000,10.0000,10.00,'XML',28,61,'2026-06-26 16:47:55'),(60,17,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','1095','2026-06-26',1.0000,'UN',1.0000,'UN',1.0000,98.0000,98.0000,98.00,'XML',29,62,'2026-06-26 16:47:56'),(61,18,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','1095','2026-06-26',1.0000,'UN',1.0000,'UN',1.0000,98.0000,98.0000,98.00,'XML',29,63,'2026-06-26 16:47:56'),(62,2,'GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','157341','2026-06-26',1.0000,'PALLET',126.0000,'CHAPAS',126.0000,7994.7000,63.4500,7994.70,'XML',30,64,'2026-06-26 16:47:57'),(63,2,'GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','157342','2026-06-26',1.0000,'PALLET',126.0000,'CHAPAS',126.0000,7994.7200,63.4502,7994.72,'XML',31,65,'2026-06-26 16:47:58'),(64,19,'ADAR IND. COM. IMPORT. E EXPORT. LTDA.','1567553','2026-06-26',1400.0000,'MT',1.0000,'UN',1400.0000,3.8000,3.8000,5320.00,'XML',32,66,'2026-06-26 16:47:59'),(65,20,'UREL & UREL COMPENSADOS LTDA','31257','2026-06-26',312.0000,'UN',1.0000,'CHAPAS',312.0000,50.0000,50.0000,15599.99,'XML',33,67,'2026-06-26 18:26:50'),(66,2,'GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','144240','2026-06-26',2.0000,'PALLET',126.0000,'CHAPAS',252.0000,7182.0000,57.0000,14364.00,'XML',34,68,'2026-06-26 20:00:24');
/*!40000 ALTER TABLE `historico_custos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimentacoes_estoque`
--

DROP TABLE IF EXISTS `movimentacoes_estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimentacoes_estoque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produto_id` int NOT NULL,
  `recebimento_id` int NOT NULL,
  `recebimento_item_id` int NOT NULL,
  `data_movimentacao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantidade` decimal(14,4) NOT NULL,
  `valor_unitario` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `valor_total` decimal(14,2) NOT NULL DEFAULT '0.00',
  `origem` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `usuario` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Sistema',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_mov_item` (`recebimento_item_id`,`tipo`),
  KEY `fk_mov_produto` (`produto_id`),
  KEY `fk_mov_recebimento` (`recebimento_id`),
  CONSTRAINT `fk_mov_item` FOREIGN KEY (`recebimento_item_id`) REFERENCES `nfe_importacao_itens` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mov_produto` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`),
  CONSTRAINT `fk_mov_recebimento` FOREIGN KEY (`recebimento_id`) REFERENCES `nfe_importacoes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimentacoes_estoque`
--

LOCK TABLES `movimentacoes_estoque` WRITE;
/*!40000 ALTER TABLE `movimentacoes_estoque` DISABLE KEYS */;
INSERT INTO `movimentacoes_estoque` VALUES (33,3,18,35,'2026-06-26 13:47:46','entrada',1000.0000,0.5300,530.00,'XML','Sistema'),(34,4,19,36,'2026-06-26 13:47:47','entrada',38.5000,1.9000,73.15,'XML','Sistema'),(35,5,20,37,'2026-06-26 13:47:48','entrada',350.0000,4.1600,1456.00,'XML','Sistema'),(36,6,20,38,'2026-06-26 13:47:48','entrada',540.0000,2.5400,1371.60,'XML','Sistema'),(37,7,21,39,'2026-06-26 13:47:49','entrada',50.0000,15.9600,798.00,'XML','Sistema'),(38,8,21,40,'2026-06-26 13:47:49','entrada',10.0000,16.0000,160.00,'XML','Sistema'),(39,7,22,41,'2026-06-26 13:47:49','entrada',150.0000,21.0000,3150.00,'XML','Sistema'),(40,8,22,42,'2026-06-26 13:47:49','entrada',30.0000,16.0000,480.00,'XML','Sistema'),(41,2,23,43,'2026-06-26 13:47:50','entrada',2.0000,7994.7000,15989.40,'XML','Sistema'),(42,2,24,44,'2026-06-26 13:47:51','entrada',1.0000,7994.7000,7994.70,'XML','Sistema'),(43,9,25,45,'2026-06-26 13:47:52','entrada',2.0000,7660.8000,15321.60,'XML','Sistema'),(44,10,26,46,'2026-06-26 13:47:53','entrada',200.0000,44.9500,8990.00,'XML','Sistema'),(45,11,26,47,'2026-06-26 13:47:53','entrada',3.0000,0.0500,0.15,'XML','Sistema'),(46,12,27,48,'2026-06-26 13:47:54','entrada',160.0000,7.3700,1179.20,'XML','Sistema'),(47,12,27,49,'2026-06-26 13:47:54','entrada',160.0000,7.3700,1179.20,'XML','Sistema'),(48,12,27,50,'2026-06-26 13:47:54','entrada',160.0000,7.3700,1179.20,'XML','Sistema'),(49,12,27,51,'2026-06-26 13:47:54','entrada',160.0000,7.3700,1179.20,'XML','Sistema'),(50,12,27,52,'2026-06-26 13:47:54','entrada',160.0000,7.3700,1179.20,'XML','Sistema'),(51,12,27,53,'2026-06-26 13:47:54','entrada',160.0000,7.3700,1179.20,'XML','Sistema'),(52,12,27,54,'2026-06-26 13:47:54','entrada',160.0000,7.3700,1179.20,'XML','Sistema'),(53,12,27,55,'2026-06-26 13:47:54','entrada',160.0000,7.3700,1179.20,'XML','Sistema'),(54,12,27,56,'2026-06-26 13:47:54','entrada',160.0000,7.3700,1179.20,'XML','Sistema'),(55,12,27,57,'2026-06-26 13:47:54','entrada',160.0000,7.3700,1179.20,'XML','Sistema'),(56,13,28,58,'2026-06-26 13:47:55','entrada',4.0000,10.0000,40.00,'XML','Sistema'),(57,14,28,59,'2026-06-26 13:47:55','entrada',4.0000,10.0000,40.00,'XML','Sistema'),(58,15,28,60,'2026-06-26 13:47:55','entrada',4.0000,10.0000,40.00,'XML','Sistema'),(59,16,28,61,'2026-06-26 13:47:55','entrada',1.0000,10.0000,10.00,'XML','Sistema'),(60,17,29,62,'2026-06-26 13:47:56','entrada',1.0000,98.0000,98.00,'XML','Sistema'),(61,18,29,63,'2026-06-26 13:47:56','entrada',1.0000,98.0000,98.00,'XML','Sistema'),(62,2,30,64,'2026-06-26 13:47:57','entrada',1.0000,7994.7000,7994.70,'XML','Sistema'),(63,2,31,65,'2026-06-26 13:47:58','entrada',1.0000,7994.7200,7994.72,'XML','Sistema'),(64,19,32,66,'2026-06-26 13:47:59','entrada',1400.0000,3.8000,5320.00,'XML','Sistema'),(65,20,33,67,'2026-06-26 15:26:50','entrada',312.0000,50.0000,15599.99,'XML','Sistema'),(66,2,34,68,'2026-06-26 17:00:24','entrada',2.0000,7182.0000,14364.00,'XML','Sistema');
/*!40000 ALTER TABLE `movimentacoes_estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nfe_importacao_itens`
--

DROP TABLE IF EXISTS `nfe_importacao_itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nfe_importacao_itens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nfe_importacao_id` int NOT NULL,
  `produto_id` int DEFAULT NULL,
  `codigo_fornecedor` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descricao` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ncm` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cfop` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cest` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unidade` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantidade` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `valor_unitario` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `desconto` decimal(14,2) NOT NULL DEFAULT '0.00',
  `valor_total` decimal(14,2) NOT NULL DEFAULT '0.00',
  `ean` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('vinculado','pendente') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendente',
  PRIMARY KEY (`id`),
  KEY `fk_nfe_item_importacao` (`nfe_importacao_id`),
  KEY `fk_nfe_item_produto` (`produto_id`),
  CONSTRAINT `fk_nfe_item_importacao` FOREIGN KEY (`nfe_importacao_id`) REFERENCES `nfe_importacoes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nfe_item_produto` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfe_importacao_itens`
--

LOCK TABLES `nfe_importacao_itens` WRITE;
/*!40000 ALTER TABLE `nfe_importacao_itens` DISABLE KEYS */;
INSERT INTO `nfe_importacao_itens` VALUES (35,18,3,'392','PORTA COPOS','76151000','5101','2806100','PC',1000.0000,0.5300,0.00,530.00,'SEM GTIN','vinculado'),(36,19,4,'8004N2','GRAMPO 80/04','83052000','5102','','MIL',38.5000,1.9000,0.00,73.15,'SEM GTIN','vinculado'),(37,20,5,'CX21616','Caixa de papelao ondulado CX 04','48191000','5101','','un',350.0000,4.1600,0.00,1456.00,'SEM GTIN','vinculado'),(38,20,6,'CX21652','Caixa de papelao ondulado CX 05','48191000','5101','','un',540.0000,2.5400,0.00,1371.60,'SEM GTIN','vinculado'),(39,21,7,'241','COLA 345 LV/B50','35069190','5102','','KG',50.0000,15.9600,0.00,798.00,'SEM GTIN','vinculado'),(40,21,8,'1707','ADESIVO INSTANTANEO N7 100G POWER BOND','35061010','5405','','UN',10.0000,16.0000,0.00,160.00,'7898512372967','vinculado'),(41,22,7,'241','COLA 345 LV/B50','35069190','5102','','KG',150.0000,21.0000,0.00,3150.00,'SEM GTIN','vinculado'),(42,22,8,'1707','ADESIVO INSTANTANEO N7 100G POWER BOND','35061010','5405','','UN',30.0000,16.0000,0.00,480.00,'7898512372967','vinculado'),(43,23,2,'421381','MDF CRU 04MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 126 CHAPAS)','44111210','5102','2803600','PT',2.0000,7994.7000,0.00,15989.40,'SEM GTIN','vinculado'),(44,24,2,'421381','MDF CRU 04MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 126 CHAPAS) - BERNECK','44111210','5102','2803600','PT',1.0000,7994.7000,0.00,7994.70,'SEM GTIN','vinculado'),(45,25,9,'394821','MDF CRU 2,8MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 168 CHAPAS)','44111210','5102','2803600','PT',2.0000,7660.8000,0.00,15321.60,'SEM GTIN','vinculado'),(46,26,10,'MDBKCRU002','BERNECK MDF  2,8 MM 185X275 CRU','44111210','5102','','CH',200.0000,44.9500,0.00,8990.00,'SEM GTIN','vinculado'),(47,26,11,'CAFDMDF046','CHAPA MDF 2 QUALIDADE','44111490','5102','','CH',3.0000,0.0500,0.00,0.15,'SEM GTIN','vinculado'),(48,27,12,'7036003','FELTRO AGULHADO INYLTEX GRAFITE 2,00-','56021000','5101','','M2',160.0000,7.3700,0.00,1179.20,'7897034621102','vinculado'),(49,27,12,'7036003','FELTRO AGULHADO INYLTEX GRAFITE 2,00-','56021000','5101','','M2',160.0000,7.3700,0.00,1179.20,'7897034621102','vinculado'),(50,27,12,'7036003','FELTRO AGULHADO INYLTEX GRAFITE 2,00-','56021000','5101','','M2',160.0000,7.3700,0.00,1179.20,'7897034621102','vinculado'),(51,27,12,'7036003','FELTRO AGULHADO INYLTEX GRAFITE 2,00-','56021000','5101','','M2',160.0000,7.3700,0.00,1179.20,'7897034621102','vinculado'),(52,27,12,'7036003','FELTRO AGULHADO INYLTEX GRAFITE 2,00-','56021000','5101','','M2',160.0000,7.3700,0.00,1179.20,'7897034621102','vinculado'),(53,27,12,'7036003','FELTRO AGULHADO INYLTEX GRAFITE 2,00-','56021000','5101','','M2',160.0000,7.3700,0.00,1179.20,'7897034621102','vinculado'),(54,27,12,'7036003','FELTRO AGULHADO INYLTEX GRAFITE 2,00-','56021000','5101','','M2',160.0000,7.3700,0.00,1179.20,'7897034621102','vinculado'),(55,27,12,'7036003','FELTRO AGULHADO INYLTEX GRAFITE 2,00-','56021000','5101','','M2',160.0000,7.3700,0.00,1179.20,'7897034621102','vinculado'),(56,27,12,'7036003','FELTRO AGULHADO INYLTEX GRAFITE 2,00-','56021000','5101','','M2',160.0000,7.3700,0.00,1179.20,'7897034621102','vinculado'),(57,27,12,'7036003','FELTRO AGULHADO INYLTEX GRAFITE 2,00-','56021000','5101','','M2',160.0000,7.3700,0.00,1179.20,'7897034621102','vinculado'),(58,28,13,'10.301','LUVA NBR AZUL NITRIL. Tam.G','40151900','5102','','UNID',4.0000,10.0000,0.00,40.00,'SEM GTIN','vinculado'),(59,28,14,'10.303','LUVA NBR AZUL NITRIL. Tam.M','40151900','5102','','UNID',4.0000,10.0000,0.00,40.00,'SEM GTIN','vinculado'),(60,28,15,'10.302','LUVA NBR AZUL NITRIL. Tam.P','40151900','5102','','UNID',4.0000,10.0000,0.00,40.00,'SEM GTIN','vinculado'),(61,28,16,'10.300','LUVA NBR AZUL NITRIL. Tam.GG','40151900','5102','','UNID',1.0000,10.0000,0.00,10.00,'SEM GTIN','vinculado'),(62,29,17,'10.427','SAPATO ELASTICO B.PVC N37','64039190','5102','','UNID',1.0000,98.0000,0.00,98.00,'7893764053107','vinculado'),(63,29,18,'10.433','SAPATO ELASTICO B.PVC N43','64039190','5102','','UNID',1.0000,98.0000,0.00,98.00,'7893764052643','vinculado'),(64,30,2,'421381','MDF CRU 04MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 126 CHAPAS)','44111210','5102','2803600','PT',1.0000,7994.7000,0.00,7994.70,'SEM GTIN','vinculado'),(65,31,2,'421381','MDF CRU 04MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 126 CHAPAS)','44111210','5102','2803600','PT',1.0000,7994.7200,0.00,7994.72,'SEM GTIN','vinculado'),(66,32,19,'225.D12.A30','OXFORD STRETCH SUPER BLANC','54075210','6102','','MT',1400.0000,3.8000,0.00,5320.00,'SEM GTIN','vinculado'),(67,33,20,'2','MDF CRU 2,8MM 275X185 BERNECK','44111210','5102','2805700','UN',312.0000,50.0000,0.00,15599.99,'7890000000024','vinculado'),(68,34,2,'421381','MDF CRU 04MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 126 CHAPAS) - BERNECK','44111210','5102','2803600','PT',2.0000,7182.0000,0.00,14364.00,'SEM GTIN','vinculado');
/*!40000 ALTER TABLE `nfe_importacao_itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nfe_importacoes`
--

DROP TABLE IF EXISTS `nfe_importacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nfe_importacoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ordem_id` int DEFAULT NULL,
  `origem` enum('XML','Manual') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'XML',
  `fornecedor` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fornecedor_cnpj` varchar(18) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_nf` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_documento` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Nota Fiscal',
  `serie` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chave_nfe` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_emissao` date DEFAULT NULL,
  `data_entrada` date NOT NULL,
  `valor_total` decimal(14,2) NOT NULL DEFAULT '0.00',
  `condicao_pagamento` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacoes` text COLLATE utf8mb4_unicode_ci,
  `usuario_responsavel` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Sistema',
  `status_recebimento` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pendente',
  `confirmado_em` datetime DEFAULT NULL,
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_nfe` (`chave_nfe`),
  UNIQUE KEY `uk_nfe_fornecedor_numero_serie` (`fornecedor_cnpj`,`numero_nf`,`serie`),
  KEY `fk_nfe_ordem` (`ordem_id`),
  CONSTRAINT `fk_nfe_ordem` FOREIGN KEY (`ordem_id`) REFERENCES `ordens_compra` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfe_importacoes`
--

LOCK TABLES `nfe_importacoes` WRITE;
/*!40000 ALTER TABLE `nfe_importacoes` DISABLE KEYS */;
INSERT INTO `nfe_importacoes` VALUES (18,NULL,'XML','MARCIO JOSE JACOMASSI ME','05.455.097/0001-40','1378','Nota Fiscal','1','35260505455097000140550010000013781958238090','2026-05-12','2026-06-26',530.00,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:45','2026-06-26 16:47:45'),(19,NULL,'XML','PAVESA COMERCIO DE FERRAGENS E FERRAMENTAS LTDA','10.779.926/0001-80','7727','Nota Fiscal','1','35260510779926000180550010000077271000203450','2026-05-06','2026-06-26',109.95,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:46','2026-06-26 16:47:46'),(20,NULL,'XML','IDEAL - BOX E EMBALAGENS LTDA','22.962.695/0001-25','14613','Nota Fiscal','1','35260522962695000125550010000146131000366173','2026-05-23','2026-06-26',3251.74,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:47','2026-06-26 16:47:47'),(21,NULL,'XML','J C SOUZA FERNANDES','39.511.397/0001-11','1813','Nota Fiscal','2','35260539511397000111550020000018131000040439','2026-05-25','2026-06-26',958.00,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:48','2026-06-26 16:47:48'),(22,NULL,'XML','J C SOUZA FERNANDES','39.511.397/0001-11','1819','Nota Fiscal','2','35260539511397000111550020000018191000003839','2026-05-27','2026-06-26',3630.00,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:49','2026-06-26 16:47:49'),(23,NULL,'XML','GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','44.479.620/0001-20','156437','Nota Fiscal','1','35260544479620000120550010001564371034995312','2026-05-21','2026-06-26',15989.40,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:50','2026-06-26 16:47:50'),(24,NULL,'XML','GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','44.479.620/0001-20','156899','Nota Fiscal','1','35260544479620000120550010001568991035043719','2026-05-27','2026-06-26',7994.70,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:51','2026-06-26 16:47:51'),(25,NULL,'XML','GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','44.479.620/0001-20','157040','Nota Fiscal','1','35260544479620000120550010001570401035058914','2026-05-28','2026-06-26',15321.60,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:52','2026-06-26 16:47:52'),(26,NULL,'XML','MADEIRANIT COM E IND DE  MADEIRAS LTDA','46.676.813/0001-05','675861','Nota Fiscal','3','35260546676813000105550030006758611145461693','2026-05-22','2026-06-26',8990.16,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:53','2026-06-26 16:47:53'),(27,NULL,'XML','INYLBRA INDUSTRIA E COMERCIO LTDA','59.135.509/0006-07','131490','Nota Fiscal','4','35260559135509000607550040001314901638362671','2026-05-21','2026-06-26',11792.00,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:54','2026-06-26 16:47:54'),(28,NULL,'XML','AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','64.262.083/0001-70','967','Nota Fiscal','1','35260564262083000170550010000009671998893891','2026-05-15','2026-06-26',130.00,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:55','2026-06-26 16:47:55'),(29,NULL,'XML','AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','64.262.083/0001-70','1095','Nota Fiscal','1','35260564262083000170550010000010951082795104','2026-05-29','2026-06-26',196.00,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:56','2026-06-26 16:47:56'),(30,NULL,'XML','GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','44.479.620/0001-20','157341','Nota Fiscal','1','35260644479620000120550010001573411035089710','2026-06-01','2026-06-26',7994.70,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:57','2026-06-26 16:47:57'),(31,NULL,'XML','GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','44.479.620/0001-20','157342','Nota Fiscal','1','35260644479620000120550010001573421035089814','2026-06-01','2026-06-26',7994.72,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:58','2026-06-26 16:47:58'),(32,NULL,'XML','ADAR IND. COM. IMPORT. E EXPORT. LTDA.','03.442.526/0001-10','1567553','Nota Fiscal','10','50260503442526000110550100015675531374122883','2026-05-15','2026-06-26',5320.00,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 13:47:59','2026-06-26 16:47:59'),(33,NULL,'XML','UREL & UREL COMPENSADOS LTDA','22.320.037/0001-30','31257','Nota Fiscal','1','35260522320037000130550010000312571359840731','2026-05-26','2026-06-26',15599.99,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 15:26:50','2026-06-26 18:26:50'),(34,NULL,'XML','GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','44.479.620/0001-20','144240','Nota Fiscal','1','35260144479620000120550010001442401033712012','2026-01-19','2026-06-26',14364.00,NULL,NULL,'Sistema','Aguardando Ordem de Compra','2026-06-26 17:00:24','2026-06-26 20:00:24');
/*!40000 ALTER TABLE `nfe_importacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orcamentos`
--

DROP TABLE IF EXISTS `orcamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orcamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoria` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ano` smallint NOT NULL,
  `categoria_id` int DEFAULT NULL,
  `valor_orcamento` decimal(14,2) DEFAULT NULL,
  `data_importacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_importacao` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mes` tinyint NOT NULL,
  `orcamento_previsto` decimal(14,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_orcamento_categoria_competencia` (`categoria_id`,`ano`,`mes`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orcamentos`
--

LOCK TABLES `orcamentos` WRITE;
/*!40000 ALTER TABLE `orcamentos` DISABLE KEYS */;
INSERT INTO `orcamentos` VALUES (1,NULL,2026,92,13573.00,'2026-06-25 19:41:00','Importacao XLSX',6,13573.00),(2,NULL,2026,127,1987.00,'2026-06-25 19:41:01','Importacao XLSX',6,1987.00),(3,NULL,2026,82,13560.00,'2026-06-25 19:41:01','Importacao XLSX',6,13560.00),(4,NULL,2026,87,23584.00,'2026-06-25 19:41:01','Importacao XLSX',6,23584.00),(5,NULL,2026,77,148010.00,'2026-06-25 19:41:01','Importacao XLSX',6,148010.00),(6,NULL,2026,42,27804.00,'2026-06-25 19:41:01','Importacao XLSX',6,27804.00),(7,NULL,2026,132,9430.00,'2026-06-25 19:41:01','Importacao XLSX',6,9430.00),(8,NULL,2026,122,14683.00,'2026-06-25 19:41:01','Importacao XLSX',6,14683.00),(9,NULL,2026,107,0.00,'2026-06-25 19:41:01','Importacao XLSX',6,0.00),(10,NULL,2026,67,0.00,'2026-06-25 19:41:01','Importacao XLSX',6,0.00),(11,NULL,2026,112,1790.00,'2026-06-25 19:41:01','Importacao XLSX',6,1790.00),(12,NULL,2026,117,0.00,'2026-06-25 19:41:01','Importacao XLSX',6,0.00),(13,NULL,2026,102,0.00,'2026-06-25 19:41:01','Importacao XLSX',6,0.00),(14,NULL,2026,97,0.00,'2026-06-25 19:41:01','Importacao XLSX',6,0.00),(15,NULL,2026,72,0.00,'2026-06-25 19:41:01','Importacao XLSX',6,0.00),(16,NULL,2026,92,15851.00,'2026-06-25 19:41:01','Importacao XLSX',7,15851.00),(17,NULL,2026,127,2000.00,'2026-06-25 19:41:01','Importacao XLSX',7,2000.00),(18,NULL,2026,82,13000.00,'2026-06-25 19:41:01','Importacao XLSX',7,13000.00),(19,NULL,2026,87,30000.00,'2026-06-25 19:41:01','Importacao XLSX',7,30000.00),(20,NULL,2026,77,160000.00,'2026-06-25 19:41:01','Importacao XLSX',7,160000.00),(21,NULL,2026,42,28000.00,'2026-06-25 19:41:01','Importacao XLSX',7,28000.00),(22,NULL,2026,132,5000.00,'2026-06-25 19:41:01','Importacao XLSX',7,5000.00),(23,NULL,2026,122,1837.00,'2026-06-25 19:41:01','Importacao XLSX',7,1837.00),(24,NULL,2026,107,5277.00,'2026-06-25 19:41:01','Importacao XLSX',7,5277.00),(25,NULL,2026,67,2000.00,'2026-06-25 19:41:01','Importacao XLSX',7,2000.00),(26,NULL,2026,112,104.00,'2026-06-25 19:41:01','Importacao XLSX',7,104.00),(27,NULL,2026,117,500.00,'2026-06-25 19:41:01','Importacao XLSX',7,500.00),(28,NULL,2026,102,0.00,'2026-06-25 19:41:01','Importacao XLSX',7,0.00),(29,NULL,2026,97,500.00,'2026-06-25 19:41:01','Importacao XLSX',7,500.00),(30,NULL,2026,92,12759.00,'2026-06-25 19:41:01','Importacao XLSX',8,12759.00),(31,NULL,2026,127,2000.00,'2026-06-25 19:41:01','Importacao XLSX',8,2000.00),(32,NULL,2026,82,13000.00,'2026-06-25 19:41:01','Importacao XLSX',8,13000.00),(33,NULL,2026,87,30000.00,'2026-06-25 19:41:01','Importacao XLSX',8,30000.00),(34,NULL,2026,77,160000.00,'2026-06-25 19:41:01','Importacao XLSX',8,160000.00),(35,NULL,2026,42,28000.00,'2026-06-25 19:41:01','Importacao XLSX',8,28000.00),(36,NULL,2026,132,5000.00,'2026-06-25 19:41:01','Importacao XLSX',8,5000.00),(37,NULL,2026,122,0.00,'2026-06-25 19:41:01','Importacao XLSX',8,0.00),(38,NULL,2026,107,5277.00,'2026-06-25 19:41:01','Importacao XLSX',8,5277.00),(39,NULL,2026,67,2000.00,'2026-06-25 19:41:01','Importacao XLSX',8,2000.00),(40,NULL,2026,112,104.00,'2026-06-25 19:41:01','Importacao XLSX',8,104.00),(41,NULL,2026,117,500.00,'2026-06-25 19:41:01','Importacao XLSX',8,500.00),(42,NULL,2026,102,2746.00,'2026-06-25 19:41:01','Importacao XLSX',8,2746.00),(43,NULL,2026,97,500.00,'2026-06-25 19:41:01','Importacao XLSX',8,500.00),(44,NULL,2026,92,15713.00,'2026-06-25 19:41:01','Importacao XLSX',9,15713.00),(45,NULL,2026,127,2000.00,'2026-06-25 19:41:01','Importacao XLSX',9,2000.00),(46,NULL,2026,82,13000.00,'2026-06-25 19:41:01','Importacao XLSX',9,13000.00),(47,NULL,2026,87,30000.00,'2026-06-25 19:41:01','Importacao XLSX',9,30000.00),(48,NULL,2026,77,160000.00,'2026-06-25 19:41:01','Importacao XLSX',9,160000.00),(49,NULL,2026,42,28000.00,'2026-06-25 19:41:01','Importacao XLSX',9,28000.00),(50,NULL,2026,132,5000.00,'2026-06-25 19:41:01','Importacao XLSX',9,5000.00),(51,NULL,2026,122,0.00,'2026-06-25 19:41:01','Importacao XLSX',9,0.00),(52,NULL,2026,107,5277.00,'2026-06-25 19:41:01','Importacao XLSX',9,5277.00),(53,NULL,2026,67,2000.00,'2026-06-25 19:41:01','Importacao XLSX',9,2000.00),(54,NULL,2026,112,104.00,'2026-06-25 19:41:01','Importacao XLSX',9,104.00),(55,NULL,2026,117,500.00,'2026-06-25 19:41:01','Importacao XLSX',9,500.00),(56,NULL,2026,102,2746.00,'2026-06-25 19:41:01','Importacao XLSX',9,2746.00),(57,NULL,2026,97,500.00,'2026-06-25 19:41:01','Importacao XLSX',9,500.00),(58,NULL,2026,92,14774.00,'2026-06-25 19:41:01','Importacao XLSX',10,14774.00),(59,NULL,2026,127,2000.00,'2026-06-25 19:41:01','Importacao XLSX',10,2000.00),(60,NULL,2026,82,13000.00,'2026-06-25 19:41:01','Importacao XLSX',10,13000.00),(61,NULL,2026,87,30000.00,'2026-06-25 19:41:01','Importacao XLSX',10,30000.00),(62,NULL,2026,77,160000.00,'2026-06-25 19:41:01','Importacao XLSX',10,160000.00),(63,NULL,2026,42,28000.00,'2026-06-25 19:41:01','Importacao XLSX',10,28000.00),(64,NULL,2026,132,5000.00,'2026-06-25 19:41:01','Importacao XLSX',10,5000.00),(65,NULL,2026,122,0.00,'2026-06-25 19:41:01','Importacao XLSX',10,0.00),(66,NULL,2026,107,5277.00,'2026-06-25 19:41:01','Importacao XLSX',10,5277.00),(67,NULL,2026,67,2000.00,'2026-06-25 19:41:01','Importacao XLSX',10,2000.00),(68,NULL,2026,112,104.00,'2026-06-25 19:41:01','Importacao XLSX',10,104.00),(69,NULL,2026,117,500.00,'2026-06-25 19:41:01','Importacao XLSX',10,500.00),(70,NULL,2026,102,2746.00,'2026-06-25 19:41:01','Importacao XLSX',10,2746.00),(71,NULL,2026,97,500.00,'2026-06-25 19:41:01','Importacao XLSX',10,500.00),(72,NULL,2026,92,14415.00,'2026-06-25 19:41:01','Importacao XLSX',11,14415.00),(73,NULL,2026,127,2000.00,'2026-06-25 19:41:01','Importacao XLSX',11,2000.00),(74,NULL,2026,82,13000.00,'2026-06-25 19:41:01','Importacao XLSX',11,13000.00),(75,NULL,2026,87,30000.00,'2026-06-25 19:41:01','Importacao XLSX',11,30000.00),(76,NULL,2026,77,160000.00,'2026-06-25 19:41:01','Importacao XLSX',11,160000.00),(77,NULL,2026,42,28000.00,'2026-06-25 19:41:01','Importacao XLSX',11,28000.00),(78,NULL,2026,132,5000.00,'2026-06-25 19:41:01','Importacao XLSX',11,5000.00),(79,NULL,2026,122,0.00,'2026-06-25 19:41:01','Importacao XLSX',11,0.00),(80,NULL,2026,107,5277.00,'2026-06-25 19:41:01','Importacao XLSX',11,5277.00),(81,NULL,2026,67,2000.00,'2026-06-25 19:41:01','Importacao XLSX',11,2000.00),(82,NULL,2026,112,104.00,'2026-06-25 19:41:01','Importacao XLSX',11,104.00),(83,NULL,2026,117,500.00,'2026-06-25 19:41:01','Importacao XLSX',11,500.00),(84,NULL,2026,102,2746.00,'2026-06-25 19:41:01','Importacao XLSX',11,2746.00),(85,NULL,2026,97,500.00,'2026-06-25 19:41:01','Importacao XLSX',11,500.00),(86,NULL,2026,92,14967.00,'2026-06-25 19:41:01','Importacao XLSX',12,14967.00),(87,NULL,2026,127,2000.00,'2026-06-25 19:41:02','Importacao XLSX',12,2000.00),(88,NULL,2026,82,13000.00,'2026-06-25 19:41:02','Importacao XLSX',12,13000.00),(89,NULL,2026,87,30000.00,'2026-06-25 19:41:02','Importacao XLSX',12,30000.00),(90,NULL,2026,77,160000.00,'2026-06-25 19:41:02','Importacao XLSX',12,160000.00),(91,NULL,2026,42,28000.00,'2026-06-25 19:41:02','Importacao XLSX',12,28000.00),(92,NULL,2026,132,5000.00,'2026-06-25 19:41:02','Importacao XLSX',12,5000.00),(93,NULL,2026,122,0.00,'2026-06-25 19:41:02','Importacao XLSX',12,0.00),(94,NULL,2026,107,5277.00,'2026-06-25 19:41:02','Importacao XLSX',12,5277.00),(95,NULL,2026,67,2000.00,'2026-06-25 19:41:02','Importacao XLSX',12,2000.00),(96,NULL,2026,112,104.00,'2026-06-25 19:41:02','Importacao XLSX',12,104.00),(97,NULL,2026,117,500.00,'2026-06-25 19:41:02','Importacao XLSX',12,500.00),(98,NULL,2026,102,2746.00,'2026-06-25 19:41:02','Importacao XLSX',12,2746.00),(99,NULL,2026,97,500.00,'2026-06-25 19:41:02','Importacao XLSX',12,500.00);
/*!40000 ALTER TABLE `orcamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordens_compra`
--

DROP TABLE IF EXISTS `ordens_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordens_compra` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_oc` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_preenchimento` date NOT NULL,
  `tipo_material` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fornecedor_id` int NOT NULL,
  `produto_id` int NOT NULL,
  `quantidade` decimal(12,2) NOT NULL,
  `preco_negociado` decimal(14,2) NOT NULL,
  `frete` decimal(14,2) NOT NULL DEFAULT '0.00',
  `valor_total` decimal(14,2) NOT NULL,
  `data_entrega` date NOT NULL,
  `metodo_pagamento` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parcelas` tinyint NOT NULL DEFAULT '1',
  `prazos_parcelas` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prazo_dias` int NOT NULL DEFAULT '0',
  `nota_fiscal` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_compra` enum('aguardando autorizacao','aprovada','reprovada','em compra','recebida','cancelada') COLLATE utf8mb4_unicode_ci DEFAULT 'aguardando autorizacao',
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_oc` (`numero_oc`),
  KEY `fk_oc_fornecedor` (`fornecedor_id`),
  KEY `fk_oc_produto` (`produto_id`),
  CONSTRAINT `fk_oc_fornecedor` FOREIGN KEY (`fornecedor_id`) REFERENCES `fornecedores` (`id`),
  CONSTRAINT `fk_oc_produto` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens_compra`
--

LOCK TABLES `ordens_compra` WRITE;
/*!40000 ALTER TABLE `ordens_compra` DISABLE KEYS */;
INSERT INTO `ordens_compra` VALUES (3,'OC-2026-00001','2026-06-26','2.1.2 Matéria-Prima MDF',3,2,1.00,7994.72,0.00,7994.72,'2026-06-26','Boleto',6,'30,60,90,120,150,180',30,NULL,'aguardando autorizacao','2026-06-26 18:59:08');
/*!40000 ALTER TABLE `ordens_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto_fornecedor_relacionamentos`
--

DROP TABLE IF EXISTS `produto_fornecedor_relacionamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_fornecedor_relacionamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fornecedor` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cnpj` varchar(18) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_fornecedor` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao_fornecedor` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `produto_id` int NOT NULL,
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `atualizado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_rel_cnpj_codigo` (`cnpj`,`codigo_fornecedor`),
  KEY `fk_rel_produto` (`produto_id`),
  KEY `idx_rel_fornecedor_codigo` (`fornecedor`,`codigo_fornecedor`),
  CONSTRAINT `fk_rel_produto` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_fornecedor_relacionamentos`
--

LOCK TABLES `produto_fornecedor_relacionamentos` WRITE;
/*!40000 ALTER TABLE `produto_fornecedor_relacionamentos` DISABLE KEYS */;
INSERT INTO `produto_fornecedor_relacionamentos` VALUES (2,'GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','44.479.620/0001-20','421381','MDF CRU 04MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 126 CHAPAS) - BERNECK',2,'2026-06-24 20:41:58','2026-06-26 20:00:24'),(6,'MARCIO JOSE JACOMASSI ME','05.455.097/0001-40','392','PORTA COPOS',3,'2026-06-25 18:16:51','2026-06-26 16:47:45'),(7,'PAVESA COMERCIO DE FERRAGENS E FERRAMENTAS LTDA','10.779.926/0001-80','8004N2','GRAMPO 80/04',4,'2026-06-25 18:16:51','2026-06-26 16:47:46'),(8,'IDEAL - BOX E EMBALAGENS LTDA','22.962.695/0001-25','CX21616','Caixa de papelao ondulado CX 04',5,'2026-06-25 18:16:51','2026-06-26 16:47:47'),(9,'IDEAL - BOX E EMBALAGENS LTDA','22.962.695/0001-25','CX21652','Caixa de papelao ondulado CX 05',6,'2026-06-25 18:16:51','2026-06-26 16:47:47'),(10,'J C SOUZA FERNANDES','39.511.397/0001-11','241','COLA 345 LV/B50',7,'2026-06-25 18:16:51','2026-06-26 16:47:49'),(11,'J C SOUZA FERNANDES','39.511.397/0001-11','1707','ADESIVO INSTANTANEO N7 100G POWER BOND',8,'2026-06-25 18:16:51','2026-06-26 16:47:49'),(14,'GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','44.479.620/0001-20','394821','MDF CRU 2,8MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 168 CHAPAS)',9,'2026-06-25 18:16:51','2026-06-26 16:47:52'),(15,'MADEIRANIT COM E IND DE  MADEIRAS LTDA','46.676.813/0001-05','MDBKCRU002','BERNECK MDF  2,8 MM 185X275 CRU',10,'2026-06-25 18:16:51','2026-06-26 16:47:53'),(16,'MADEIRANIT COM E IND DE  MADEIRAS LTDA','46.676.813/0001-05','CAFDMDF046','CHAPA MDF 2 QUALIDADE',11,'2026-06-25 18:16:51','2026-06-26 16:47:53'),(17,'INYLBRA INDUSTRIA E COMERCIO LTDA','59.135.509/0006-07','7036003','FELTRO AGULHADO INYLTEX GRAFITE 2,00-',12,'2026-06-25 18:16:51','2026-06-26 16:47:54'),(27,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','64.262.083/0001-70','10.301','LUVA NBR AZUL NITRIL. Tam.G',13,'2026-06-25 18:16:52','2026-06-26 16:47:55'),(28,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','64.262.083/0001-70','10.303','LUVA NBR AZUL NITRIL. Tam.M',14,'2026-06-25 18:16:52','2026-06-26 16:47:55'),(29,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','64.262.083/0001-70','10.302','LUVA NBR AZUL NITRIL. Tam.P',15,'2026-06-25 18:16:52','2026-06-26 16:47:55'),(30,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','64.262.083/0001-70','10.300','LUVA NBR AZUL NITRIL. Tam.GG',16,'2026-06-25 18:16:52','2026-06-26 16:47:55'),(31,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','64.262.083/0001-70','10.427','SAPATO ELASTICO B.PVC N37',17,'2026-06-25 18:16:52','2026-06-26 16:47:56'),(32,'AMPARO EPI PROFISSIONAL E EQUIPAMENTOS LTDA','64.262.083/0001-70','10.433','SAPATO ELASTICO B.PVC N43',18,'2026-06-25 18:16:52','2026-06-26 16:47:56'),(33,'ADAR IND. COM. IMPORT. E EXPORT. LTDA.','03.442.526/0001-10','225.D12.A30','OXFORD STRETCH SUPER BLANC',19,'2026-06-25 18:16:52','2026-06-26 16:47:59'),(66,'UREL & UREL COMPENSADOS LTDA','22.320.037/0001-30','2','MDF CRU 2,8MM 275X185 BERNECK',20,'2026-06-26 18:26:50','2026-06-26 18:28:28');
/*!40000 ALTER TABLE `produto_fornecedor_relacionamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unidade` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantidade_por_unidade_compra` decimal(14,4) NOT NULL DEFAULT '1.0000',
  `unidade_base` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'UN',
  `fornecedor_id` int DEFAULT NULL,
  `estoque_seguranca` decimal(12,2) NOT NULL DEFAULT '0.00',
  `estoque_atual` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `custo_atual` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `estoque_semanal` decimal(12,2) DEFAULT '0.00',
  `consumo_semanal` decimal(12,2) DEFAULT '0.00',
  `consumo_mensal` decimal(12,2) DEFAULT '0.00',
  `status` enum('ativo','inativo','pendente revisao') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ativo',
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_produto_fornecedor` (`fornecedor_id`),
  CONSTRAINT `fk_produto_fornecedor` FOREIGN KEY (`fornecedor_id`) REFERENCES `fornecedores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (2,'MDF4MM','MDF CRU 04MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 126 CHAPAS)','2.1.2 Matéria-Prima MDF','PALLET',126.0000,'CHAPAS',3,2.00,7.0000,7762.5029,0.00,0.00,0.00,'ativo','2026-06-24 20:41:58'),(3,'PORTACOPOS','PORTA COPOS','2.1.9 Matéria-Prima Outros','UN',1.0000,'UN',5,1.00,1000.0000,0.5300,0.00,0.00,0.00,'ativo','2026-06-25 18:16:51'),(4,'Grampo','GRAMPO 80/04','2.1.9 Matéria-Prima Outros','ML',1.0000,'UN',6,1.00,38.5000,1.9000,0.00,0.00,0.00,'ativo','2026-06-25 18:16:51'),(5,'CX4','Caixa de papelao ondulado CX 04','2.1.10 Embalagem','UN',1.0000,'UN',7,1.00,350.0000,4.1600,0.00,0.00,0.00,'ativo','2026-06-25 18:16:51'),(6,'CX5','Caixa de papelao ondulado CX 05','2.1.10 Embalagem','UN',1.0000,'UN',7,1.00,540.0000,2.5400,0.00,0.00,0.00,'ativo','2026-06-25 18:16:51'),(7,'ColaFabrica','COLA 345 LV/B50','2.1.3 Matéria-Prima Cola','KG',1.0000,'UN',8,1.00,200.0000,19.7400,0.00,0.00,0.00,'ativo','2026-06-25 18:16:51'),(8,'ColaPower','ADESIVO INSTANTANEO N7 100G POWER BOND','2.1.3 Matéria-Prima Cola','UN',1.0000,'UN',8,1.00,40.0000,16.0000,0.00,0.00,0.00,'ativo','2026-06-25 18:16:51'),(9,'MDF2MM','MDF CRU 2,8MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 168 CHAPAS)','2.1.2 Matéria-Prima MDF','PALLET',168.0000,'CHAPAS',3,1.00,2.0000,7660.8000,0.00,0.00,0.00,'ativo','2026-06-25 18:16:51'),(10,'MDF2MM','BERNECK MDF  2,8 MM 185X275 CRU','2.1.2 Matéria-Prima MDF','PALLET',168.0000,'CHAPAS',9,1.00,200.0000,44.9500,0.00,0.00,0.00,'ativo','2026-06-25 18:16:51'),(11,'MDF2MM','CHAPA MDF 2 QUALIDADE','2.1.2 Matéria-Prima MDF','PALLET',168.0000,'CHAPAS',9,1.00,3.0000,0.0500,0.00,0.00,0.00,'ativo','2026-06-25 18:16:51'),(12,'Carpete','FELTRO AGULHADO INYLTEX GRAFITE 2,00-','2.1.5 Matéria-Prima Carpete','M2',1.0000,'UN',10,1.00,1600.0000,7.3700,0.00,0.00,0.00,'ativo','2026-06-25 18:16:51'),(13,'Luva','LUVA NBR AZUL NITRIL. Tam.G','2.3.23 EPI','CX',1.0000,'UN',11,1.00,4.0000,10.0000,0.00,0.00,0.00,'ativo','2026-06-25 18:16:52'),(14,'Luva','LUVA NBR AZUL NITRIL. Tam.M','2.3.23 EPI','CX',1.0000,'UN',11,1.00,4.0000,10.0000,0.00,0.00,0.00,'ativo','2026-06-25 18:16:52'),(15,'Luva','LUVA NBR AZUL NITRIL. Tam.P','2.3.23 EPI','CX',1.0000,'UN',11,1.00,4.0000,10.0000,0.00,0.00,0.00,'ativo','2026-06-25 18:16:52'),(16,'Luva','LUVA NBR AZUL NITRIL. Tam.GG','2.3.23 EPI','CX',1.0000,'UN',11,1.00,1.0000,10.0000,0.00,0.00,0.00,'ativo','2026-06-25 18:16:52'),(17,'Sapatão','SAPATO ELASTICO B.PVC N37','2.3.23 EPI','UN',1.0000,'UN',11,1.00,1.0000,98.0000,0.00,0.00,0.00,'ativo','2026-06-25 18:16:52'),(18,'Sapatão','SAPATO ELASTICO B.PVC N43','2.3.23 EPI','UN',1.0000,'UN',11,1.00,1.0000,98.0000,0.00,0.00,0.00,'ativo','2026-06-25 18:16:52'),(19,'TECIDO','OXFORD STRETCH SUPER BLANC','2.1.7 Matéria-Prima Tecido','M',1.0000,'UN',12,1.00,1400.0000,3.8000,0.00,0.00,0.00,'ativo','2026-06-25 18:16:52'),(20,'MDF2MM','MDF CRU 2,8MM 275X185 BERNECK','2.1.2 Matéria-Prima MDF','UN',1.0000,'CHAPAS',14,1.00,312.0000,50.0000,0.00,0.00,0.00,'ativo','2026-06-26 18:26:50');
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recebimento_auditoria`
--

DROP TABLE IF EXISTS `recebimento_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recebimento_auditoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `recebimento_id` int NOT NULL,
  `usuario` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Sistema',
  `acao` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `origem` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detalhes` text COLLATE utf8mb4_unicode_ci,
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_audit_recebimento` (`recebimento_id`),
  CONSTRAINT `fk_audit_recebimento` FOREIGN KEY (`recebimento_id`) REFERENCES `nfe_importacoes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recebimento_auditoria`
--

LOCK TABLES `recebimento_auditoria` WRITE;
/*!40000 ALTER TABLE `recebimento_auditoria` DISABLE KEYS */;
INSERT INTO `recebimento_auditoria` VALUES (16,18,'Sistema','Importacao XML','XML','Documento 1378 importado.','2026-06-26 16:47:45'),(17,18,'Sistema','Processamento de estoque/custo','XML','1 item(ns) processado(s).','2026-06-26 16:47:46'),(18,19,'Sistema','Importacao XML','XML','Documento 7727 importado.','2026-06-26 16:47:46'),(19,19,'Sistema','Processamento de estoque/custo','XML','1 item(ns) processado(s).','2026-06-26 16:47:47'),(20,20,'Sistema','Importacao XML','XML','Documento 14613 importado.','2026-06-26 16:47:47'),(21,20,'Sistema','Processamento de estoque/custo','XML','2 item(ns) processado(s).','2026-06-26 16:47:48'),(22,21,'Sistema','Importacao XML','XML','Documento 1813 importado.','2026-06-26 16:47:48'),(23,21,'Sistema','Processamento de estoque/custo','XML','2 item(ns) processado(s).','2026-06-26 16:47:49'),(24,22,'Sistema','Importacao XML','XML','Documento 1819 importado.','2026-06-26 16:47:49'),(25,22,'Sistema','Processamento de estoque/custo','XML','2 item(ns) processado(s).','2026-06-26 16:47:50'),(26,23,'Sistema','Importacao XML','XML','Documento 156437 importado.','2026-06-26 16:47:50'),(27,23,'Sistema','Processamento de estoque/custo','XML','1 item(ns) processado(s).','2026-06-26 16:47:50'),(28,24,'Sistema','Importacao XML','XML','Documento 156899 importado.','2026-06-26 16:47:51'),(29,24,'Sistema','Processamento de estoque/custo','XML','1 item(ns) processado(s).','2026-06-26 16:47:51'),(30,25,'Sistema','Importacao XML','XML','Documento 157040 importado.','2026-06-26 16:47:52'),(31,25,'Sistema','Processamento de estoque/custo','XML','1 item(ns) processado(s).','2026-06-26 16:47:52'),(32,26,'Sistema','Importacao XML','XML','Documento 675861 importado.','2026-06-26 16:47:53'),(33,26,'Sistema','Processamento de estoque/custo','XML','2 item(ns) processado(s).','2026-06-26 16:47:53'),(34,27,'Sistema','Importacao XML','XML','Documento 131490 importado.','2026-06-26 16:47:54'),(35,27,'Sistema','Processamento de estoque/custo','XML','10 item(ns) processado(s).','2026-06-26 16:47:54'),(36,28,'Sistema','Importacao XML','XML','Documento 967 importado.','2026-06-26 16:47:55'),(37,28,'Sistema','Processamento de estoque/custo','XML','4 item(ns) processado(s).','2026-06-26 16:47:55'),(38,29,'Sistema','Importacao XML','XML','Documento 1095 importado.','2026-06-26 16:47:56'),(39,29,'Sistema','Processamento de estoque/custo','XML','2 item(ns) processado(s).','2026-06-26 16:47:56'),(40,30,'Sistema','Importacao XML','XML','Documento 157341 importado.','2026-06-26 16:47:57'),(41,30,'Sistema','Processamento de estoque/custo','XML','1 item(ns) processado(s).','2026-06-26 16:47:57'),(42,31,'Sistema','Importacao XML','XML','Documento 157342 importado.','2026-06-26 16:47:58'),(43,31,'Sistema','Processamento de estoque/custo','XML','1 item(ns) processado(s).','2026-06-26 16:47:58'),(44,32,'Sistema','Importacao XML','XML','Documento 1567553 importado.','2026-06-26 16:47:59'),(45,32,'Sistema','Processamento de estoque/custo','XML','1 item(ns) processado(s).','2026-06-26 16:47:59'),(46,33,'Sistema','Importacao XML','XML','Documento 31257 importado.','2026-06-26 18:26:50'),(47,33,'Sistema','Processamento de estoque/custo','XML','1 item(ns) processado(s).','2026-06-26 18:26:50'),(48,33,'Sistema','Processamento de estoque/custo','XML','0 item(ns) processado(s).','2026-06-26 18:28:28'),(49,34,'Sistema','Importacao XML','XML','Documento 144240 importado.','2026-06-26 20:00:24'),(50,34,'Sistema','Processamento de estoque/custo','XML','1 item(ns) processado(s).','2026-06-26 20:00:24');
/*!40000 ALTER TABLE `recebimento_auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recebimentos`
--

DROP TABLE IF EXISTS `recebimentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recebimentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ordem_id` int NOT NULL,
  `data_prevista` date NOT NULL,
  `data_real` date DEFAULT NULL,
  `status` enum('aguardando','entregue parcial','entregue completo','atrasado') COLLATE utf8mb4_unicode_ci DEFAULT 'aguardando',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ordem_id` (`ordem_id`),
  CONSTRAINT `fk_rec_ordem` FOREIGN KEY (`ordem_id`) REFERENCES `ordens_compra` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recebimentos`
--

LOCK TABLES `recebimentos` WRITE;
/*!40000 ALTER TABLE `recebimentos` DISABLE KEYS */;
INSERT INTO `recebimentos` VALUES (3,3,'2026-06-26',NULL,'aguardando');
/*!40000 ALTER TABLE `recebimentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidades_medida`
--

DROP TABLE IF EXISTS `unidades_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidades_medida` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('ativo','inativo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ativo',
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5521 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidades_medida`
--

LOCK TABLES `unidades_medida` WRITE;
/*!40000 ALTER TABLE `unidades_medida` DISABLE KEYS */;
INSERT INTO `unidades_medida` VALUES (1,'UN','Unidade','ativo','2026-06-24 19:17:59'),(2,'CX','Caixa','ativo','2026-06-24 19:17:59'),(3,'PCT','Pacote','ativo','2026-06-24 19:17:59'),(4,'KG','Quilograma','ativo','2026-06-24 19:17:59'),(5,'G','Grama','ativo','2026-06-24 19:17:59'),(6,'L','Litro','ativo','2026-06-24 19:17:59'),(7,'ML','Mililitro','ativo','2026-06-24 19:17:59'),(8,'M','Metro','ativo','2026-06-24 19:17:59'),(9,'ROLO','Rolo','ativo','2026-06-24 19:17:59'),(10,'PALLET','Pallet','ativo','2026-06-24 19:17:59'),(11,'FARDO','Fardo','ativo','2026-06-24 19:17:59'),(12,'KIT','Kit','ativo','2026-06-24 19:17:59'),(13,'PAR','Par','ativo','2026-06-24 19:17:59'),(14,'M2','Metro Quadrado (M²)','ativo','2026-06-24 19:17:59'),(15,'M3','Metro Cúbico (M³)','ativo','2026-06-24 19:17:59');
/*!40000 ALTER TABLE `unidades_medida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'sistema_compras'
--

--
-- Dumping routines for database 'sistema_compras'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-30 10:53:11
