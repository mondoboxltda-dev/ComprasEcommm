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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autorizacoes`
--

LOCK TABLES `autorizacoes` WRITE;
/*!40000 ALTER TABLE `autorizacoes` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cadastro_categorias`
--

LOCK TABLES `cadastro_categorias` WRITE;
/*!40000 ALTER TABLE `cadastro_categorias` DISABLE KEYS */;
INSERT INTO `cadastro_categorias` VALUES (1,'Importado via NF-e','ativo','2026-06-25 17:18:34','2026-06-25 17:18:34'),(28,'2.3.18 Caçamba','ativo','2026-06-25 17:22:19','2026-06-25 17:22:19'),(37,'2.3.13 Eventos/Investimentos','ativo','2026-06-25 17:22:31','2026-06-25 17:22:31'),(42,'2.1.10 Embalagem','ativo','2026-06-25 17:22:39','2026-06-25 17:22:39'),(47,'2.3.14 Endomarketing','ativo','2026-06-25 17:22:48','2026-06-25 17:22:48'),(52,'2.3.19 Farmacia','ativo','2026-06-25 17:22:54','2026-06-25 17:22:54'),(57,'2.3.20 Frete','ativo','2026-06-25 17:23:01','2026-06-25 17:23:01'),(62,'2.3.6 Gasto com Veiculos','ativo','2026-06-25 17:23:11','2026-06-25 17:23:11'),(67,'2.3.5 Manutençao Predial','ativo','2026-06-25 17:23:21','2026-06-25 17:23:21'),(72,'2.1.11 Tercerizados','ativo','2026-06-25 17:23:29','2026-06-25 17:23:29'),(77,'2.1.2 Matéria-Prima MDF','ativo','2026-06-25 17:23:35','2026-06-25 17:23:35'),(82,'2.1.3 Matéria-Prima Cola','ativo','2026-06-25 17:23:42','2026-06-25 17:23:42'),(87,'2.1.5 Matéria-Prima Carpete','ativo','2026-06-25 17:23:55','2026-06-25 17:23:55'),(92,'2.1.4 Matéria-Prima Sisal','ativo','2026-06-25 17:24:01','2026-06-25 17:24:01'),(97,'2.1.6 Matéria-Prima Injetavel','ativo','2026-06-25 17:24:08','2026-06-25 17:24:08'),(102,'2.1.7 Matéria-Prima Tecido','ativo','2026-06-25 17:24:14','2026-06-25 17:24:14'),(107,'2.1.8 Matéria-Prima Acrilico','ativo','2026-06-25 17:24:23','2026-06-25 17:24:23'),(112,'2.1.9 Matéria-Prima Outros','ativo','2026-06-25 17:24:32','2026-06-25 17:24:32'),(117,'2.3.21 Material de Escritório','ativo','2026-06-25 17:24:39','2026-06-25 17:24:39'),(122,'2.1.1 Compra de Mercadorias','ativo','2026-06-25 17:24:46','2026-06-25 17:24:46'),(127,'2.3.16 Supermercado','ativo','2026-06-25 17:24:53','2026-06-25 17:24:53'),(132,'2.1.12 Insumos de Fabricação','ativo','2026-06-25 17:24:59','2026-06-25 17:24:59');
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
) ENGINE=InnoDB AUTO_INCREMENT=367 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedores`
--

LOCK TABLES `fornecedores` WRITE;
/*!40000 ALTER TABLE `fornecedores` DISABLE KEYS */;
INSERT INTO `fornecedores` VALUES (3,'GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','44.479.620/0001-20',NULL,NULL,NULL,'ativo','2026-06-24 20:41:58');
/*!40000 ALTER TABLE `fornecedores` ENABLE KEYS */;
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
  `valor_total` decimal(14,2) NOT NULL DEFAULT '0.00',
  `ean` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('vinculado','pendente') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendente',
  PRIMARY KEY (`id`),
  KEY `fk_nfe_item_importacao` (`nfe_importacao_id`),
  KEY `fk_nfe_item_produto` (`produto_id`),
  CONSTRAINT `fk_nfe_item_importacao` FOREIGN KEY (`nfe_importacao_id`) REFERENCES `nfe_importacoes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nfe_item_produto` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfe_importacao_itens`
--

LOCK TABLES `nfe_importacao_itens` WRITE;
/*!40000 ALTER TABLE `nfe_importacao_itens` DISABLE KEYS */;
INSERT INTO `nfe_importacao_itens` VALUES (2,2,2,'421381','MDF CRU 04MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 126 CHAPAS)','44111210','5102','2803600','PT',1.0000,7994.7000,7994.70,'SEM GTIN','vinculado');
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
  `fornecedor` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fornecedor_cnpj` varchar(18) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_nf` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serie` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chave_nfe` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_emissao` date DEFAULT NULL,
  `data_entrada` date NOT NULL,
  `valor_total` decimal(14,2) NOT NULL DEFAULT '0.00',
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_nfe` (`chave_nfe`),
  UNIQUE KEY `uk_nfe_fornecedor_numero_serie` (`fornecedor_cnpj`,`numero_nf`,`serie`),
  KEY `fk_nfe_ordem` (`ordem_id`),
  CONSTRAINT `fk_nfe_ordem` FOREIGN KEY (`ordem_id`) REFERENCES `ordens_compra` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfe_importacoes`
--

LOCK TABLES `nfe_importacoes` WRITE;
/*!40000 ALTER TABLE `nfe_importacoes` DISABLE KEYS */;
INSERT INTO `nfe_importacoes` VALUES (2,NULL,'GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','44.479.620/0001-20','157341','1','35260644479620000120550010001573411035089710','2026-06-01','2026-06-24',7994.70,'2026-06-24 20:41:58');
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
  `categoria` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ano` smallint NOT NULL,
  `mes` tinyint NOT NULL,
  `orcamento_previsto` decimal(14,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_orcamento` (`categoria`,`ano`,`mes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orcamentos`
--

LOCK TABLES `orcamentos` WRITE;
/*!40000 ALTER TABLE `orcamentos` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens_compra`
--

LOCK TABLES `ordens_compra` WRITE;
/*!40000 ALTER TABLE `ordens_compra` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_fornecedor_relacionamentos`
--

LOCK TABLES `produto_fornecedor_relacionamentos` WRITE;
/*!40000 ALTER TABLE `produto_fornecedor_relacionamentos` DISABLE KEYS */;
INSERT INTO `produto_fornecedor_relacionamentos` VALUES (2,'GMAD AMERICANA COMERCIO DE MADEIRAS E FERRAGENS LTDA','44.479.620/0001-20','421381','MDF CRU 04MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 126 CHAPAS)',2,'2026-06-24 20:41:58','2026-06-24 20:41:58');
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
  `fornecedor_id` int DEFAULT NULL,
  `estoque_seguranca` decimal(12,2) NOT NULL DEFAULT '0.00',
  `estoque_semanal` decimal(12,2) DEFAULT '0.00',
  `consumo_semanal` decimal(12,2) DEFAULT '0.00',
  `consumo_mensal` decimal(12,2) DEFAULT '0.00',
  `status` enum('ativo','inativo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ativo',
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `fk_produto_fornecedor` (`fornecedor_id`),
  CONSTRAINT `fk_produto_fornecedor` FOREIGN KEY (`fornecedor_id`) REFERENCES `fornecedores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (2,'MDF4MM','MDF CRU 04MM 2,75 X 1,85 - B (CORTADA EM 4 PARTES 126 CHAPAS)','Importado via NF-e','PALLET',3,2.00,0.00,0.00,0.00,'ativo','2026-06-24 20:41:58');
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recebimentos`
--

LOCK TABLES `recebimentos` WRITE;
/*!40000 ALTER TABLE `recebimentos` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=736 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidades_medida`
--

LOCK TABLES `unidades_medida` WRITE;
/*!40000 ALTER TABLE `unidades_medida` DISABLE KEYS */;
INSERT INTO `unidades_medida` VALUES (1,'UN','Unidade','ativo','2026-06-24 19:17:59'),(2,'CX','Caixa','ativo','2026-06-24 19:17:59'),(3,'PCT','Pacote','ativo','2026-06-24 19:17:59'),(4,'KG','Quilograma','ativo','2026-06-24 19:17:59'),(5,'G','Grama','ativo','2026-06-24 19:17:59'),(6,'L','Litro','ativo','2026-06-24 19:17:59'),(7,'ML','Mililitro','ativo','2026-06-24 19:17:59'),(8,'M','Metro','ativo','2026-06-24 19:17:59'),(9,'ROLO','Rolo','ativo','2026-06-24 19:17:59'),(10,'PALLET','Pallet','ativo','2026-06-24 19:17:59'),(11,'FARDO','Fardo','ativo','2026-06-24 19:17:59'),(12,'KIT','Kit','ativo','2026-06-24 19:17:59'),(13,'PAR','Par','ativo','2026-06-24 19:17:59'),(14,'M2','Metro Quadrado (M²)','ativo','2026-06-24 19:17:59'),(15,'M3','Metro Cúbico (M³)','ativo','2026-06-24 19:17:59');
/*!40000 ALTER TABLE `unidades_medida` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-25 14:29:54
