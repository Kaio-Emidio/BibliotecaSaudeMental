CREATE DATABASE  IF NOT EXISTS `setembroamarelo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `setembroamarelo`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: setembroamarelo
-- ------------------------------------------------------
-- Server version	8.0.36

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conteudo`
--

LOCK TABLES `conteudo` WRITE;
/*!40000 ALTER TABLE `conteudo` DISABLE KEYS */;
INSERT INTO `conteudo` VALUES (1,' O demônio do meio-dia','\"O Demônio do Meio-Dia: Uma Anatomia da Depressão\", de Andrew Solomon, é um livro que explora a depressão através de relatos pessoais do autor e de entrevistas com outras pessoas, especialistas e médicos, analisando os aspectos científicos, psicológicos, culturais e sociais da doença. A obra desmistifica a depressão, diferencia-a da tristeza, descreve os tratamentos existentes (medicamentos, terapias, eletrochoques) e aborda o impacto da doença na vida dos indivíduos e na sociedade. ',2014,1,'2025-10-07 03:02:03','static/assets/arquivos\\1.pdf',3,'Andrew Solomon'),(2,'Um Crime da Solidão','Uma seleção inédita de textos do extraordinário autor de O demônio do meio-dia e Longe da árvore, que discutem com sensibilidade e empatia os vários aspectos do suicídio e da depressão.O demônio do meio-dia foi um livro divisor de águas sobre a depressão. Seu autor, Andrew Solomon, tratou de forma singular e inédita sobre esse mal que afeta milhões de pessoas no mundo, mas que, muitas vezes, ainda não é tratado com a seriedade devida. O suicídio é o extremo a que a doença pode levar, e é muito mais comum do que imaginamos: a cada quarenta segundos, alguém tira a própria vida. Nestes artigos que foram reunidos em livro pela primeira vez, numa edição exclusiva para o Brasil, Solomon reflete sobre casos recentes de suicídio de personalidades, como Anthony Bourdain, Robin Williams e Kate Spade, assim como de literatos, entre eles Sylvia Plath e David Foster Wallace, e ainda Virginia Woolf, que \\\"tentou salvar-se pela arte\\\" mas que sofria de um mal clínico intolerável e escolheu a água como um meio de morrer. Com sua narrativa fluida e seu olhar sempre empático, ele relata e analisa uma série de casos de pessoas que acabaram partindo antes da hora.\r\n',2018,1,'2025-10-07 03:07:22','static/assets/arquivos\\2.pdf',3,'Andrew Solomon'),(3,'Imagens do Inconsciente','É um Clássico da psiquiatria humanista que apresenta a experiência de Nise da Silveira com a terapia através da arte. No livro, a autora descreve como pacientes psiquiátricos, especialmente pessoas diagnosticadas com esquizofrenia, expressavam seus mundos internos por meio da pintura, da escultura e do desenho. As obras produzidas nos ateliês revelam não só vivências pessoais, mas também símbolos universais aproximando a psicologia, arte e cultura. Publicado pela primeira vez em 1981.',1981,1,'2025-10-07 03:15:23','static/assets/arquivos\\3.pdf',3,'Nise da Silveira'),(4,'O mundo das imagens','\"O Mundo das Imagens\" é um livro da psiquiatra Nise da Silveira que sintetiza seu trabalho revolucionário no tratamento da esquizofrenia através da arte, explorando a relação entre o mundo interno dos pacientes e o mundo externo, com base nas ideias de Carl Jung. A obra detalha as histórias de vida dos frequentadores de seus ateliês de arte, analisando temas arquetípicos e as conexões com a psiquiatria atual.',1992,1,'2025-10-07 03:18:58','static/assets/arquivos\\4.pdf',3,'Nise da Silveira'),(5,'Psicopatologia e Semiologia dos Transtornos Mentais','O livro Psicopatologia e Semiologia dos Transtornos Mentais, de Paulo Dalgalarrondo, é uma obra de referência que introduz os conceitos fundamentais da psicopatologia e serve como guia para o exame clínico dos transtornos psiquiátricos, auxiliando estudantes e profissionais na identificação e compreensão de sinais e sintomas.',2000,1,'2025-10-07 03:24:11','static/assets/arquivos\\5.pdf',3,'Paulo Dalgalarrondo'),(6,'Muito Além do Nosso Eu: A Nova Neurociência','\"Muito além do nosso eu\" por Miguel Nicolelis descreve o futuro da neurociência, onde interfaces cérebro-máquina possibilitam controlar máquinas e se comunicar através do pensamento, aplicando o conhecimento cerebral para avanços em saúde e tecnologia. O livro explora como essa simbiose virtual entre humanos e tecnologia pode expandir nossas habilidades cognitivas e motoras, prometendo um futuro otimista e impulsionado pela inovação. ',2011,1,'2025-10-07 03:37:22','static/assets/arquivos\\6.pdf',3,'Miguel Nicolelis'),(7,'O Lado Bom da Vida','\"O Lado Bom da Vida\", de Matthew Quick, narra a história de Pat Peoples, um ex-professor que sai de uma clínica psiquiátrica determinado a reconquistar sua ex-esposa, Nikki, e reconstruir sua vida. Em sua jornada, ele conhece Tiffany, a irmã viúva de um amigo, que também está passando por dificuldades emocionais. Juntos, Pat e Tiffany se apoiam, buscando entender e viver o lado bom da vida, apesar de suas dores passadas, tornando a história um conto sobre esperança, amor e superação. ',2008,1,'2025-10-07 03:41:41','static/assets/arquivos\\7.pdf',3,'Matthew Quick'),(8,'Garoto 21','\"Garoto 21\" narra a história de Finley, um jovem fã de basquete de uma cidade violenta, que tem a vida transformada quando conhece Russ, um gênio do esporte que, após uma tragédia, se isolou do mundo acreditando ser um alienígena. Finley assume a missão de ajudar Russ a se recuperar e voltar a jogar, formando uma forte amizade que trará esperança e redenção para ambos. ',2012,1,'2025-10-07 03:55:26','static/assets/arquivos\\8.pdf',3,'Matthew Quick'),(10,'Saúde Mental e Atenção Psicossocial','Saúde mental é bem-estar psicológico, emocional e social, impactado por fatores biopsicossociais, e a atenção psicossocial é o sistema de cuidado no Brasil, focado em desinstitucionalização, liberdade e direitos humanos, através de serviços como os CAPS (Centros de Atenção Psicossocial), que visam a reabilitação e reintegração das pessoas à comunidade, promovendo a saúde mental na vida cotidiana. ',2007,1,'2025-10-07 14:47:37','static/assets/arquivos\\10.pdf',3,'Paulo Amarante'),(11,'Gestão da Emoção','Estamos na era da sustentabilidade. Mas precisamos ter consciência de que não apenas o planeta tem recursos limitados, mas o planeta cérebro também. Estamos esgotando a nossa mente ao ruminar perdas e mágoas, sofrer pelo futuro, preocupar-nos muito com a opinião das pessoas, ter a necessidade neurótica de mudar os outros e cobrar demais de nós e de quem está ao nosso redor. Ao agir assim, podemos ser ótimos para a empresa em que trabalhamos, mas nos tornamos carrascos de nosso cérebro e de nossa qualidade de vida. Em Gestão da emoção - um livro único no mundo -, o psiquiatra, psicoterapeuta e pesquisador Augusto Cury ajudará você a identificar o mau uso da emoção e o gasto desnecessário de energia, além de sugerir ferramentas para corrigir a rota. Através de técnicas simples mas impactantes, Cury o ensinará a trabalhar melhor a emoção e expandir as habilidades vitais da inteligência.',2022,1,'2025-10-07 16:34:52','static/assets/arquivos\\11.pdf',3,'Augusto Cury'),(12,'É Nóia Minha?','No Podcast “É nóia minha?” a roteirista, escritora e paranoica de plantão Camila Fremder divide com seus convidados - que muitas vezes acabam sendo tão noiados quanto ela - todas as maluquices que passam pela sua cabeça. Então, se você é do tipo que perde o sono com pensamentos absurdos, esse podcast com certeza é feito para você.',2029,1,'2025-10-07 16:46:13','static/assets/arquivos\\12.pdf',4,'Camila Fremder'),(13,'Saúde Mental em Evidência','Falamos sobre saúde mental no cotidiano, de maneira simples, desmistificando pseudociências e debatendo com outros profissionais da área da saúde. Alguns assuntos não deveriam ser sobre achismos.',2021,1,'2025-10-07 16:52:30','static/assets/arquivos\\13.pdf',4,'Jan Luiz Leonardi'),(14,'Tratando sua Ansiedade','Você encontrará dicas e insights para controlar a ansiedade e viver de forma mais leve e equilibrada. Com episódios semanais, trazendo reflexões e práticas para te ajudar nessa jornada de bem-estar.',2020,1,'2025-10-07 17:03:37','static/assets/arquivos\\14.pdf',4,'Laura Tomasini Potrich'),(15,'Estamos Bem?','O podcast Estamos Bem?, com Bárbara dos Anjos Lima, é feito em forma de conversa aberta e bem-humorada sobre os altos e baixos da vida. A cada episódio, experiências são trocadas sobre amizade, autoestima, amor e cotidiano, misturando leveza com reflexões sinceras.',2018,1,'2025-10-07 17:15:32','static/assets/arquivos\\15.pdf',4,'Bárbara dos Anjos Lima'),(16,'Para dar Nome ás Coisas','Oi, meu nome é Natália Sousa, sou jornalista, roteirista, escritora e comunicadora. Viciada em autoconhecimento, conversas profundas e mergulhos internos (mesmo quando desconfortáveis), criei o Para dar Nome às Coisas para ser uma mesa de bar na web. Aqui compartilho histórias que eu vivi e que eu só contaria numa mesa de boteco, no sofá de casa ou num divã de psicanalista - de um jeito honestão e em primeira pessoa. A cada play você vou te guiar por uma viagem sobre medo, fracasso, coragem, recomeço, dor e tudo o mais que atravessa uma vida viva.',2021,1,'2025-10-07 17:22:10','static/assets/arquivos\\16.pdf',4,'Natália Sousa'),(17,'SAC de Saúde Mental','Saúde mental parece ser um bicho de sete cabeças, mas, na verdade, é um elemento importante para nossa saúde. Aqui no SAC de Saúde Mental, as psicólogas Lizandra Brandani e Bianca Dalmaso falam, com bom humor, dos temas de saúde mental que você sempre quis saber, mas não tinha pra quem perguntar.\r\nImagina que a Saúde Mental é uma empresa que, agora, tem um SAC para você interagir com ela à vontade! ',2021,1,'2025-10-07 17:28:44','static/assets/arquivos\\17.pdf',4,'Lizandra Brandani e Bianca Dalmaso'),(18,'As Mídias Sociais Alimentam uma Crise de Suicídio entre Adolescentes?','As redes sociais são conhecidas como um espaço para conexão e entretenimento, mas podem estar escondendo um lado sombrio: o aumento preocupante de casos de depressão e suicídio entre adolescentes. O artigo publicado na The New Yorker por Andrew Solomon investiga como plataformas digitais e seus algoritmos estão impactando a saúde mental dos jovens revelando histórias e dados que não podem ser ignorados. ',2024,1,'2025-10-07 17:36:44','static/assets/arquivos\\18.pdf',1,'Andrew Solomon'),(19,'Depressão e Gravidez: O Dilema Aterrorizante?','A gravidez é normalmente vista como um momento de alegria e renovação, mas para muitas mulheres ela também pode se transformar em um período de angústia silenciosa. O artigo escrito por Andrew Solomon explica a realidade de quem enfrenta sintomas depressivos durante a gestação mostrando os impactos emocionais, sociais e até físicos desse desafio.',2014,1,'2025-10-07 17:41:22','static/assets/arquivos\\19.pdf',1,'Andrew Solomon'),(20,'Suicídio, um Crime de Solidão','O suicídio ainda é cercado de silêncio e preconceito. No artigo, Andrew Solomon mostra como por trás desse ato extremo muitas vezes existe uma solidão profunda e uma sensação de abandono. Ele faz refletir sobre como a falta de escuta e de apoio pode encorajar alguém para esse caminho sem volta. O artigo levanta uma questão importante: será que estamos realmente atentos aos sinais e preparados para ajudar quem sofre em silêncio?\r\n',2014,1,'2025-10-07 17:46:54','static/assets/arquivos\\20.pdf',1,'Andrew Solomon');
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

-- Dump completed on 2025-10-07 18:06:03
