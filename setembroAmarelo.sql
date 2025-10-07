CREATE DATABASE  IF NOT EXISTS `setembroamarelo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `setembroamarelo`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: setembroamarelo
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `ID_Categoria` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Descricao` text,
  PRIMARY KEY (`ID_Categoria`),
  UNIQUE KEY `Nome` (`Nome`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (0,'Outros','Outros tipos de arquivos que possuem o tema de saúde mental em comum.'),(1,'Artigo','Textos que analisam a obra de um autor, um gênero, um movimento literário ou um tema específico em obras literárias.'),(2,'Vídeo','Vídeos com temática destinada à informação sobre conteúdos de saúde mental.'),(3,'Livro','Livros que abordam sobre assuntos com relação a saúde mental.'),(4,'Podcast','Produções audíveis com objetivo de promover diálogos com relação ao tema de Saúde Mental.');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conteudo`
--

DROP TABLE IF EXISTS `conteudo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conteudo` (
  `ID_Conteudo` int NOT NULL AUTO_INCREMENT,
  `Titulo` varchar(200) NOT NULL,
  `Sinopse` text,
  `Ano` year DEFAULT NULL,
  `Capa` tinyint(1) DEFAULT '0',
  `Data_Inclusao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `URL_Arquivo` varchar(255) DEFAULT NULL,
  `ID_Categoria` int NOT NULL,
  `Autor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID_Conteudo`),
  KEY `ID_Categoria` (`ID_Categoria`),
  CONSTRAINT `conteudo_ibfk_1` FOREIGN KEY (`ID_Categoria`) REFERENCES `categoria` (`ID_Categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conteudo`
--

LOCK TABLES `conteudo` WRITE;
/*!40000 ALTER TABLE `conteudo` DISABLE KEYS */;
INSERT INTO `conteudo` VALUES (1,' O demônio do meio-dia','\"O Demônio do Meio-Dia: Uma Anatomia da Depressão\", de Andrew Solomon, é um livro que explora a depressão através de relatos pessoais do autor e de entrevistas com outras pessoas, especialistas e médicos, analisando os aspectos científicos, psicológicos, culturais e sociais da doença. A obra desmistifica a depressão, diferencia-a da tristeza, descreve os tratamentos existentes (medicamentos, terapias, eletrochoques) e aborda o impacto da doença na vida dos indivíduos e na sociedade. ',2014,1,'2025-10-07 03:02:03','static/assets/arquivos\\1.pdf',3,'Andrew Solomon'),(2,'Um Crime da Solidão','Uma seleção inédita de textos do extraordinário autor de O demônio do meio-dia e Longe da árvore, que discutem com sensibilidade e empatia os vários aspectos do suicídio e da depressão.O demônio do meio-dia foi um livro divisor de águas sobre a depressão. Seu autor, Andrew Solomon, tratou de forma singular e inédita sobre esse mal que afeta milhões de pessoas no mundo, mas que, muitas vezes, ainda não é tratado com a seriedade devida. O suicídio é o extremo a que a doença pode levar, e é muito mais comum do que imaginamos: a cada quarenta segundos, alguém tira a própria vida. Nestes artigos que foram reunidos em livro pela primeira vez, numa edição exclusiva para o Brasil, Solomon reflete sobre casos recentes de suicídio de personalidades, como Anthony Bourdain, Robin Williams e Kate Spade, assim como de literatos, entre eles Sylvia Plath e David Foster Wallace, e ainda Virginia Woolf, que \\\"tentou salvar-se pela arte\\\" mas que sofria de um mal clínico intolerável e escolheu a água como um meio de morrer. Com sua narrativa fluida e seu olhar sempre empático, ele relata e analisa uma série de casos de pessoas que acabaram partindo antes da hora.\r\n',2018,1,'2025-10-07 03:07:22','static/assets/arquivos\\2.pdf',3,'Andrew Solomon'),(3,'Imagens do Inconsciente','É um Clássico da psiquiatria humanista que apresenta a experiência de Nise da Silveira com a terapia através da arte. No livro, a autora descreve como pacientes psiquiátricos, especialmente pessoas diagnosticadas com esquizofrenia, expressavam seus mundos internos por meio da pintura, da escultura e do desenho. As obras produzidas nos ateliês revelam não só vivências pessoais, mas também símbolos universais aproximando a psicologia, arte e cultura. Publicado pela primeira vez em 1981.',1981,1,'2025-10-07 03:15:23','static/assets/arquivos\\3.pdf',3,'Nise da Silveira'),(4,'O mundo das imagens','\"O Mundo das Imagens\" é um livro da psiquiatra Nise da Silveira que sintetiza seu trabalho revolucionário no tratamento da esquizofrenia através da arte, explorando a relação entre o mundo interno dos pacientes e o mundo externo, com base nas ideias de Carl Jung. A obra detalha as histórias de vida dos frequentadores de seus ateliês de arte, analisando temas arquetípicos e as conexões com a psiquiatria atual.',1992,1,'2025-10-07 03:18:58','static/assets/arquivos\\4.pdf',3,'Nise da Silveira'),(5,'Psicopatologia e Semiologia dos Transtornos Mentais','O livro Psicopatologia e Semiologia dos Transtornos Mentais, de Paulo Dalgalarrondo, é uma obra de referência que introduz os conceitos fundamentais da psicopatologia e serve como guia para o exame clínico dos transtornos psiquiátricos, auxiliando estudantes e profissionais na identificação e compreensão de sinais e sintomas.',2000,1,'2025-10-07 03:24:11','static/assets/arquivos\\5.pdf',3,'Paulo Dalgalarrondo'),(6,'Muito Além do Nosso Eu: A Nova Neurociência','\"Muito além do nosso eu\" por Miguel Nicolelis descreve o futuro da neurociência, onde interfaces cérebro-máquina possibilitam controlar máquinas e se comunicar através do pensamento, aplicando o conhecimento cerebral para avanços em saúde e tecnologia. O livro explora como essa simbiose virtual entre humanos e tecnologia pode expandir nossas habilidades cognitivas e motoras, prometendo um futuro otimista e impulsionado pela inovação. ',2011,1,'2025-10-07 03:37:22','static/assets/arquivos\\6.pdf',3,'Miguel Nicolelis'),(7,'O Lado Bom da Vida','\"O Lado Bom da Vida\", de Matthew Quick, narra a história de Pat Peoples, um ex-professor que sai de uma clínica psiquiátrica determinado a reconquistar sua ex-esposa, Nikki, e reconstruir sua vida. Em sua jornada, ele conhece Tiffany, a irmã viúva de um amigo, que também está passando por dificuldades emocionais. Juntos, Pat e Tiffany se apoiam, buscando entender e viver o lado bom da vida, apesar de suas dores passadas, tornando a história um conto sobre esperança, amor e superação. ',2008,1,'2025-10-07 03:41:41','static/assets/arquivos\\7.pdf',3,'Matthew Quick'),(8,'Garoto 21','\"Garoto 21\" narra a história de Finley, um jovem fã de basquete de uma cidade violenta, que tem a vida transformada quando conhece Russ, um gênio do esporte que, após uma tragédia, se isolou do mundo acreditando ser um alienígena. Finley assume a missão de ajudar Russ a se recuperar e voltar a jogar, formando uma forte amizade que trará esperança e redenção para ambos. ',2012,1,'2025-10-07 03:55:26','static/assets/arquivos\\8.pdf',3,'Matthew Quick');
/*!40000 ALTER TABLE `conteudo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorito`
--

DROP TABLE IF EXISTS `favorito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorito` (
  `ID_Usuario` int NOT NULL,
  `ID_Conteudo` int NOT NULL,
  `Data_Favorito` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Usuario`,`ID_Conteudo`),
  KEY `ID_Conteudo` (`ID_Conteudo`),
  CONSTRAINT `favorito_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`) ON DELETE CASCADE,
  CONSTRAINT `favorito_ibfk_2` FOREIGN KEY (`ID_Conteudo`) REFERENCES `conteudo` (`ID_Conteudo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorito`
--

LOCK TABLES `favorito` WRITE;
/*!40000 ALTER TABLE `favorito` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `ID_Usuario` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Usuario` varchar(50) NOT NULL,
  `Senha` varchar(255) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Telefone` varchar(20) DEFAULT NULL,
  `Data_Cadastro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Usuario`),
  UNIQUE KEY `Usuario` (`Usuario`),
  UNIQUE KEY `Email_UNIQUE` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (0,'Kaio','wolyo','kaio123','kaio@gmail.com','(84) 99865-9580','2025-10-06 14:58:44'),(1,'Eduarda','Eduarda','eduarda123','eduarda@gmail.com','(44) 44444-4444','2025-10-06 16:07:44'),(2,'Emanuelle','manu','manu123','manuzinha@gmail.com','(55) 55555-5555','2025-10-06 16:08:24'),(3,'Ana','Candy','aejd','anaeloisa@gmail.com','(66) 66666-6666','2025-10-06 16:11:28'),(4,'Vitória','vitória','vivi123','vitoria@gmail.com','(77) 77777-7777','2025-10-06 16:12:39'),(5,'Vinícius','Vini','viniboy','vinicius@gmail.com','(88) 88888-8888','2025-10-06 16:13:29');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-07  3:59:09
