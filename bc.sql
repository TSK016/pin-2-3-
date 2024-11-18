create database dbpin;
use dbpin;vendas

CREATE TABLE Transferencias (
	Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	Referencia VARCHAR(255),
	Periodo INT,
	Tipo VARCHAR(255),
	Valor INT,
	PeriodoAnt INT,
	PercComparacao INT,
	ResultComparacao VARCHAR(255)
);

CREATE TABLE Produtos (
	Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	ProdutoNome VARCHAR(255),
	ProdutoNomeAbrev VARCHAR(255),
	ProdutoGrupo VARCHAR(255),
	Kit1Id INT,
	Kit2Id INT,
	Kit3Id INT,
	Valor INT,
	DataAdicao DATE
);

CREATE TABLE Vendas (
	Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	ItemPedidoId INT,
	ProdutoId INT,
	Produto VARCHAR(255),
	DataMes INT,
	DataCompleta DATETIME,
	Valor INT,
	Desconto INT,
	ClienteId INT
);

CREATE TABLE RelatorioMensal (
	Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	Ano INT,
	Mes INT,
	TotalGasto INT,
	TotalGanho INT,
	TotalGeral INT,
	TotalGeralAnt INT,
	ProdMaisVendido INT,
	ProdMenosVendido INT,
	ProdMaiorAumento INT,
	ProdMenorAumento INT
);

CREATE TABLE Clientes (

	Id INT NOT NULL PRIMARY KEY auto_increment,
	Usuario VARCHAR(255),
	Senha VARCHAR(255),
	Nome VARCHAR(255),
	Email VARCHAR(255),
	Telefone1 VARCHAR(255),
	Telefone2 VARCHAR(255),
	LocaldEntrega VARCHAR(255),
	DataCriacao DATETIME
);

select * from vendas;

INSERT INTO Transferencias (Referencia, Periodo, Tipo, Valor, PeriodoAnt, PercComparacao, ResultComparacao)
VALUES
    ('REF001', 202310, 'Entrada', 5000, 202309, 10, 'Aumento'),
    ('REF002', 202311, 'Saída', 3000, 202310, -5, 'Redução'),
    ('REF003', 202311, 'Entrada', 7000, 202310, 15, 'Aumento');

INSERT INTO Vendas (ItemPedidoId, ProdutoId, Produto, DataMes, DataCompleta, Valor, Desconto, ClienteId)
VALUES
    (101, 1, 'Notebook', 202310, '2023-10-12 14:30:00', 5000, 500, 1),
    (102, 2, 'Mouse', 202310, '2023-10-15 10:15:00', 50, 5, 2),
    (103, 3, 'Teclado', 202311, '2023-11-01 16:45:00', 150, 15, 3);

INSERT INTO Clientes (Usuario, Senha, Nome, Email, Telefone1, Telefone2, LocaldEntrega, DataCriacao)
VALUES
    ('johndoe', 'senha123', 'John Doe', 'john@example.com', '999999999', '888888888', 'Rua A, 123', '2023-10-01 09:00:00'),
    ('janedoe', 'senha456', 'Jane Doe', 'jane@example.com', '977777777', '866666666', 'Rua B, 456', '2023-10-05 10:30:00'),
    ('marksmith', 'senha789', 'Mark Smith', 'mark@example.com', '955555555', NULL, 'Rua C, 789', '2023-10-10 14:15:00');

select * from Vendas;

INSERT INTO RelatorioMensal (Ano, Mes, TotalGasto, TotalGanho, TotalGeral, TotalGeralAnt, ProdMaisVendido, ProdMenosVendido, ProdMaiorAumento, ProdMenorAumento) VALUES
(2023, 1, 15000, 25000, 10000, NULL, 101, 201, 101, 202),
(2023, 2, 17000, 27000, 10000, 10000, 102, 202, 103, 201),
(2023, 3, 18000, 30000, 12000, 10000, 103, 203, 104, 202),
(2023, 4, 20000, 32000, 12000, 12000, 101, 204, 105, 203),
(2023, 5, 22000, 34000, 12000, 12000, 102, 205, 101, 204);