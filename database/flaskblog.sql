-- Apaga o banco de dados se ele existir
-- PERIGO! Só faça isso em tempo de desenvolvimento
DROP DATABASE IF EXISTS flaskblogdb;

-- (Re)criar o banco de dados
-- PERIGO! Só faça isso em tempo de desenvolvimento
CREATE DATABASE flaskblogdb
	-- Usando a tabela de caracteres universal extendidas
	CHARACTER SET utf8mb4
    -- Buscas também em utf8 e case insensitive
    COLLATE utf8mb4_general_ci;

-- Seleciona o banco de dados para os próximos comandos
USE flaskblogdb;

-- Cria a tabela 'Staff' conforme o modelo lógico
CREATE TABLE staff (
-- Define O id como chave primária
	emp_id INT PRIMARY KEY  AUTO_INCREMENT,
	-- Define a data com valor do sistema
    emp_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- Define o nome do usuário com 127 caracteres.
    emp_name VARCHAR (127) NOT NULL,
    -- Define email do usuário com 255 caracteres
    emp_email VARCHAR (255) NOT NULL,
    emp_password VARCHAR (63) NOT NULL,
    emp_image VARCHAR (255),
	-- data em formato iso/ system date
    emp_birth DATE NOT NULL,
    emp_description VARCHAR (255),
    emp_type ENUM ('admin', 'author','moderator')
		DEFAULT 'moderator',
	emp_status ENUM ('on', 'off','del')
		DEFAULT 'on'
);

-- Criar tabela "article" de modo lógico
CREATE TABLE article(
	art_id INT PRIMARY KEY  AUTO_INCREMENT,
	-- Define a data com valor do sistema
    art_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    art_author INT NOT NULL,
    art_title VARCHAR(127) NOT NULL,
    art_resume VARCHAR(255) NOT NULL,
    art_thumbnail VARCHAR(255) NOT NULL,
    art_content TEXT NOT NULL,
    art_veiws INT NOT NULL
		DEFAULT 0,
    art_status ENUM ('on', 'off','del')
		DEFAULT 'on',
	FOREIGN KEY (art_author) REFERENCES staff (emp_id)
);

CREATE TABLE contact(
	id INT PRIMARY KEY  AUTO_INCREMENT,
	-- Define a data com valor do sistema
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    name VARCHAR (127) NOT NULL,
    email VARCHAR (255) NOT NULL,
    subject VARCHAR (255) NOT NULL,
    messange TEXT,
    status ENUM ('on', 'off','del')
		DEFAULT 'on'
);

CREATE TABLE comment(
	com_id INT PRIMARY KEY  AUTO_INCREMENT,
	-- Define a data com valor do sistema
    com_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    com_article INT NOT NULL,
    com_author_name VARCHAR (127) NOT NULL,
    com_author_email VARCHAR (255) NOT NULL,
    com_comment TEXT,
    com_status ENUM ('on', 'off','del')
		DEFAULT 'on',
	FOREIGN KEY (com_article) REFERENCES article (art_id)
);


-- --------------- ----		
-- POPULANDO TABELAS COM DADOS FAKE
-- --------------- ----

-- Inserindo dados na tabela 'staff'
	INSERT INTO staff (
    emp_name,
    emp_email,
    emp_password,
    emp_image,
    emp_birth,
    emp_description
    ) VALUES(
		'Joca da Silva',
        'jocasilva@email.com',
        SHA1('Senha123'),
        'https://randomuser.me/api/portraits/lego/5.jpg',
        '2000-06-27',
        'Programador, escultor, pescador e enrolador.'
    ), (
		'Marineusa Castro',
        'marineusacastro@email.com',
        SHA1('Senha123'),
        'https://randomuser.me/api/portraits/women/53.jpg',
        '1997-08-22',
        'Programadora, psicultora, distribuidora e controladora.'
    ),(
		'Jucleide Sousa',
        'jusousa@email.com',
        SHA1('Senha123'),
        'https://randomuser.me/api/portraits/women/25.jpg',
        '1985-07-16',
        'Programadora, escritora, cartunista e boleira.'
    ),(
		'Irineu Folha',
        'irineufolha@email.com',
        SHA1('Senha123'),
        'https://randomuser.me/api/portraits/men/53.jpg',
        '1990-09-05',
        'Programador, filosofo, organizador e festeiro.'
	),(
    'Ana Beatriz',
    'anabeatriz@email.com',
    SHA1('Senha789'),
    'https://randomuser.me/api/portraits/women/55.jpg',
    '1990-11-15',
    'Designer gráfica, apaixonada por arte digital.'
    ),(
    'Carlos Silva',
    'carlossilva@email.com',
    SHA1('Senha101'),
    'https://randomuser.me/api/portraits/men/56.jpg',
    '1988-07-30',
    'Engenheiro de software e amante de viagens.'
    );
    -- Atualiza type do staff --
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'admin' WHERE (`emp_id` = '1');
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' WHERE (`emp_id` = '3');
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' WHERE (`emp_id` = '4');
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' WHERE (`emp_id` = '5');

-- Mostra registros da tabela 'Staff' --
SELECT * FROM staff;




