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
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' , emp_status = 'off' WHERE (`emp_id` = '3');
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' , emp_status = 'del' WHERE (`emp_id` = '4');
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' , emp_status = 'off' WHERE (`emp_id` = '5');

-- Tabela "article" --
INSERT INTO article (
    art_author,
    art_title,
    art_resume,
    art_thumbnail,
    art_content
) VALUES (
	'2',
    'Primeiro artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
),(
	'3',
    'Segundo  artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
),(
	'4',
    'Terceiro  artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
),(
	'1',
    'Quarto  artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
),(
	'4',
    'Quinto  artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
),(
	'3',
    'Sexto  artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
),(
	'5',
    'Setimo  artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
),(
	'1',
    'Oitavo  artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
),(
	'4',
    'Nono  artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
),(
	'6',
    'Décimo  artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit eum, dolor ad alias nesciunt consequuntur in error enim numquam sit sunt! Quia eius tempora provident tempore culpa cupiditate sunt dignissimos?</p>
<p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Autem qui voluptatum hic repudiandae labore quod deleniti temporibus perferendis quisquam recusandae, eum alias natus, dolor at! Error saepe est cupiditate consectetur!</p>
<img src="https://picsum.photos/200/300" alt="Imagem aleatória">
<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eligendi consequatur laboriosam reiciendis dolorem, exercitationem dolor natus hic quisquam itaque maxime doloribus. Adipisci debitis quod perferendis repudiandae similique quam voluptatum eveniet.</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://catabist.com.br">Site do Fessô</a></li>
    <li><a href="https://github.com/Luferat">Github do fessô</a></li>
</ul>
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Perspiciatis a mollitia doloribus repudiandae incidunt ullam debitis, minima iure quia, recusandae odio magnam velit quos ad nam eaque. Ut, dolorem eveniet?</p>    
    '
);

-- Tabela 'comment' --
INSERT INTO comment(
-- Insira um "art_id" existente --
	com_article,
    com_author_name,
    com_author_email,
    com_comment
) VALUES (
	'10',
    'Marlinelson',
    'marli@nelson.com',
    'É só mais um lorem ipsum.'
),(
	'4',
    'Marluce',
    'marlu@email.com',
    'É isso mesmo.'
),(
	'3',
    'Euclides',
    'clidesu@email.com',
    'Lorem ipsum dolor sit.'
),(
	'7',
    'Soraia',
    'soso@email.com',
    'Lorem ipsum dolor sit.'
),(
	'10',
    'Marcio',
    'marcinho@email.com',
    'Lorem ipsum dolor sit.'
);

-- ----------------------------------- --
-- Testes de SELECT                    --
-- Dica: execute uma linha de cada vez --
-- ----------------------------------- --

-- Mostra todos os registros da tabela 'staff' --
SELECT * FROM staff;

SELECT * FROM staff WHERE emp_id = '5';

SELECT * FROM staff WHERE emp_name = 'Irineu Folha';

-- Troque entre 'DESC' E 'ASC' para testar a ordem
SELECT * FROM staff ORDER BY emp_name DESC;

-- Somente autores
SELECT emp_id, emp_name, emp_email FROM staff 
	WHERE emp_type = 'author' 
	ORDER BY emp_name;


-- Mostra todos os registros da tabela 'article' --
SELECT * FROM article;

-- Mostra todos os registro da tabela 'comment'--
SELECT * FROM comment;






