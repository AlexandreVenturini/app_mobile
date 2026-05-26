-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 27, 2026 at 12:14 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `loja_pc_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `carrinho`
--

CREATE TABLE `carrinho` (
  `idCarrinho` int NOT NULL,
  `idUsuario` int NOT NULL,
  `valor` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` varchar(30) NOT NULL DEFAULT 'Aberto'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `carrinho`
--

INSERT INTO `carrinho` (`idCarrinho`, `idUsuario`, `valor`, `status`) VALUES
(1, 1, 0.00, 'Aberto');

-- --------------------------------------------------------

--
-- Table structure for table `categoria`
--

CREATE TABLE `categoria` (
  `idCategoria` int NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categoria`
--

INSERT INTO `categoria` (`idCategoria`, `nome`) VALUES
(1, 'Processadores'),
(2, 'Placas de Vídeo'),
(3, 'Memórias RAM'),
(4, 'Placas-mãe'),
(5, 'Fontes'),
(6, 'SSDs');

-- --------------------------------------------------------

--
-- Table structure for table `itemcarrinho`
--

CREATE TABLE `itemcarrinho` (
  `idItemCarrinho` int NOT NULL,
  `idCarrinho` int NOT NULL,
  `idProduto` int NOT NULL,
  `quantidade` int NOT NULL,
  `precoUnitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `itemcarrinho`
--

INSERT INTO `itemcarrinho` (`idItemCarrinho`, `idCarrinho`, `idProduto`, `quantidade`, `precoUnitario`) VALUES
(1, 1, 1, 1, 799.90),
(2, 1, 3, 2, 249.90);

-- --------------------------------------------------------

--
-- Table structure for table `itemmontagem`
--

CREATE TABLE `itemmontagem` (
  `idItemMontagem` int NOT NULL,
  `idMontagem` int NOT NULL,
  `idProduto` int NOT NULL,
  `quantidade` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `itemmontagem`
--

INSERT INTO `itemmontagem` (`idItemMontagem`, `idMontagem`, `idProduto`, `quantidade`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 3, 2),
(4, 1, 4, 1),
(5, 1, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `montagem`
--

CREATE TABLE `montagem` (
  `idMontagem` int NOT NULL,
  `idUsuario` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `data` date NOT NULL,
  `valorTotal` decimal(10,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `montagem`
--

INSERT INTO `montagem` (`idMontagem`, `idUsuario`, `nome`, `data`, `valorTotal`) VALUES
(1, 1, 'PC Gamer Intermediário', '2026-04-27', 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `pagamento`
--

CREATE TABLE `pagamento` (
  `idPagamento` int NOT NULL,
  `idCarrinho` int NOT NULL,
  `tipo` varchar(45) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'Pendente',
  `dataPagamento` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pagamento`
--

INSERT INTO `pagamento` (`idPagamento`, `idCarrinho`, `tipo`, `status`, `dataPagamento`) VALUES
(1, 1, 'PIX', 'Pendente', '2026-04-27 08:54:24');

-- --------------------------------------------------------

--
-- Table structure for table `produto`
--

CREATE TABLE `produto` (
  `idProduto` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `estoque` int NOT NULL DEFAULT '0',
  `idCategoria` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `produto`
--

INSERT INTO `produto` (`idProduto`, `nome`, `descricao`, `preco`, `estoque`, `idCategoria`) VALUES
(1, 'Processador Ryzen 5 5600', 'Processador AMD Ryzen 5 5600 6-Core', 799.90, 15, 1),
(2, 'Placa de Vídeo RTX 4060', 'GPU NVIDIA GeForce RTX 4060 8GB', 1999.90, 8, 2),
(3, 'Memória RAM 16GB DDR4', 'Memória DDR4 3200MHz', 249.90, 30, 3),
(4, 'SSD NVMe 1TB', 'SSD NVMe M.2 1TB alta velocidade', 399.90, 20, 6),
(5, 'Fonte 650W 80 Plus', 'Fonte gamer 650W certificada', 349.90, 12, 5);

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `endereco` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `nome`, `email`, `cpf`, `senha`, `endereco`) VALUES
(1, 'Julia Souza', 'julia@email.com', '123.456.789-00', '123456', 'Rua das Flores, 100');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carrinho`
--
ALTER TABLE `carrinho`
  ADD PRIMARY KEY (`idCarrinho`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indexes for table `itemcarrinho`
--
ALTER TABLE `itemcarrinho`
  ADD PRIMARY KEY (`idItemCarrinho`),
  ADD KEY `idCarrinho` (`idCarrinho`),
  ADD KEY `idProduto` (`idProduto`);

--
-- Indexes for table `itemmontagem`
--
ALTER TABLE `itemmontagem`
  ADD PRIMARY KEY (`idItemMontagem`),
  ADD KEY `idMontagem` (`idMontagem`),
  ADD KEY `idProduto` (`idProduto`);

--
-- Indexes for table `montagem`
--
ALTER TABLE `montagem`
  ADD PRIMARY KEY (`idMontagem`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indexes for table `pagamento`
--
ALTER TABLE `pagamento`
  ADD PRIMARY KEY (`idPagamento`),
  ADD KEY `idCarrinho` (`idCarrinho`);

--
-- Indexes for table `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`idProduto`),
  ADD KEY `idCategoria` (`idCategoria`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `cpf` (`cpf`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carrinho`
--
ALTER TABLE `carrinho`
  MODIFY `idCarrinho` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idCategoria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `itemcarrinho`
--
ALTER TABLE `itemcarrinho`
  MODIFY `idItemCarrinho` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `itemmontagem`
--
ALTER TABLE `itemmontagem`
  MODIFY `idItemMontagem` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `montagem`
--
ALTER TABLE `montagem`
  MODIFY `idMontagem` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pagamento`
--
ALTER TABLE `pagamento`
  MODIFY `idPagamento` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `produto`
--
ALTER TABLE `produto`
  MODIFY `idProduto` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carrinho`
--
ALTER TABLE `carrinho`
  ADD CONSTRAINT `carrinho_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`);

--
-- Constraints for table `itemcarrinho`
--
ALTER TABLE `itemcarrinho`
  ADD CONSTRAINT `itemcarrinho_ibfk_1` FOREIGN KEY (`idCarrinho`) REFERENCES `carrinho` (`idCarrinho`),
  ADD CONSTRAINT `itemcarrinho_ibfk_2` FOREIGN KEY (`idProduto`) REFERENCES `produto` (`idProduto`);

--
-- Constraints for table `itemmontagem`
--
ALTER TABLE `itemmontagem`
  ADD CONSTRAINT `itemmontagem_ibfk_1` FOREIGN KEY (`idMontagem`) REFERENCES `montagem` (`idMontagem`),
  ADD CONSTRAINT `itemmontagem_ibfk_2` FOREIGN KEY (`idProduto`) REFERENCES `produto` (`idProduto`);

--
-- Constraints for table `montagem`
--
ALTER TABLE `montagem`
  ADD CONSTRAINT `montagem_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`);

--
-- Constraints for table `pagamento`
--
ALTER TABLE `pagamento`
  ADD CONSTRAINT `pagamento_ibfk_1` FOREIGN KEY (`idCarrinho`) REFERENCES `carrinho` (`idCarrinho`);

--
-- Constraints for table `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `produto_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`idCategoria`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
