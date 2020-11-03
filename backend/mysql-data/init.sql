-- CREATE USER 'ecommerceApp'@'ecommerce-backend' IDENTIFIED BY 'ecommerceApp';

-- GRANT ALL PRIVILEGES ON * . * TO 'ecommerceApp'@'ecommerce-backend';


-- ALTER USER 'ecommerceApp'@'ecommerce-backend'
-- IDENTIFIED WITH mysql_native_password 
-- BY 'ecommerceApp';

-- -----------------------------------------------------
-- Schema full-stack-ecommerce
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `full-stack-ecommerce`;

CREATE SCHEMA `full-stack-ecommerce`;
USE `full-stack-ecommerce` ;

-- -----------------------------------------------------
-- Table `full-stack-ecommerce`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `full-stack-ecommerce`.`product_category` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE=InnoDB
AUTO_INCREMENT = 1;

-- -----------------------------------------------------
-- Table `full-stack-ecommerce`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `full-stack-ecommerce`.`product` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `sku` VARCHAR(255) DEFAULT NULL,
  `name` VARCHAR(255) DEFAULT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  `ingredients` VARCHAR(255) DEFAULT NULL,
  `recipe` VARCHAR(255) DEFAULT NULL,
  `unit_price` DECIMAL(13,2) DEFAULT NULL,
  `image_url` VARCHAR(255) DEFAULT NULL,
  `active` BIT DEFAULT 1,
  `units_in_stock` INT(11) DEFAULT NULL,
   `date_created` DATETIME(6) DEFAULT NULL,
  `last_updated` DATETIME(6) DEFAULT NULL,
  `category_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_category` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`id`)
) 
ENGINE=InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Add sample data
-- -----------------------------------------------------

INSERT INTO product_category(CATEGORY_NAME) VALUES ('International Cusine');

INSERT INTO `product` (`id`, `sku`, `name`, `description`, `ingredients`, `recipe`, `unit_price`, `image_url`, `active`, `units_in_stock`, `date_created`, `last_updated`, `category_id`) VALUES
(1, 'bg-100', 'Салата Цезар с хрупкаво пиле', 'салата', '900 ml олио\r\n150 ml за дресинга и 300 ml за пържене\r\n4 бр. яйца\r\n1 бр. за майонезата и 1 бр. за панировката\r\n2 с.л. горчица\r\n2 лимони\r\nсокът и кората\r\n100 g пармезан\r\n400 g пилешки филета\r\n60 g брашно\r\n100 g галета\r\n600 g салата Айсберг\r\nнакъсана и почистена\r\n2 бр. багети\r\nфранзела или стар хляб за крутони или препечени филийки\r\nсол и черен пипер', 'Време за приготвяне: 30 min\r\nПриготвяме домашна майонеза, като наливаме 300 ml олио, добавяме 1 яйце и пасираме. С много бавно и плавно движение изтегляме пасатора нагоре, за да получим по-гъста текстура.\r\nДобавяме горчицата, настъргания пармезан, кората и сока от лимона.\r\nОвкусяваме със сол и пипер. Можем да съхраняваме в хладилник до момента на поднасяне на салтата (не повече от 24 часа).\r\nПилешкото овкусяваме със сол и пипер и овалваме в панировка от брашно, яйце и галета. Пържим в олио на тиган, докато хване златиста коричка.\r\nНарязваме или накъсваме Айсберга и го овкусяваме с дресинга.\r\nДобавяме пилешкото и пармезана.\r\nПо желание можем да добавим крутони или препечени филийки.', '14.99', 'https://gotvi.lidl.bg/var/lidl-recipes/storage/images/lidl-verga-ot-lyubimi-recepti/recipes/salata-cezar-s-hrupkavo-pile/2922167-1-bul-BG/Salata-Cezar-s-hrupkavo-pile_image950x533.jpg', b'1', 100, '2020-02-10 22:00:00.000000', '2020-11-02 19:02:28.124000', 1),
(2, 'bg-101', 'Гювече със сирене, домати, чушки и препечен хляб с масло', 'предястие', '4 домата\r\n4 яйца\r\n400 g сирене\r\n4 зелени чушки\r\n8 резена хляб\r\nзамразен\r\nмаслиново масло\r\nмасло\r\nза намазване на хляба\r\nчубрица\r\nсол и черен пипер', 'Време за приготвяне: 20 min\r\nИзпичаме чушките на котлон, тиган или чушкопек и ги обелваме. По желание обелваме и доматите, след което ги нарязваме. Поставяме ги заедно с чушките в гювечето, овкусяваме с маслиново масло, а отгоре подреждаме сиренето, чукваме яйцата и ги посоляваме. Печем на 180° около 30 min от студена фурна. Замразения хляб изпичаме в тиган (за вкус като от едно време) или на фурна, намазваме с масло и поръсваме с чубрица, докато е горещ. Може да използваме и пресен от Фурната на Лидл.', '20.99', 'https://gotvi.lidl.bg/var/lidl-recipes/storage/images/recepti/recipes/gyuveche-s-s-sirene-domati-chushki-i-prepechen-hlyab-s-maslo/2895129-1-bul-BG/Gyuveche-s-s-sirene-domati-chushki-i-prepechen-hlyab-s-maslo_image950x533.jpg', b'1', 100, '2020-02-10 22:00:00.000000', '2020-11-02 19:05:29.622000', 1),
(3, 'bg-102', 'Бургер от сьомга, поднесен със сос Тартар и рукола', 'основно ястие', '4 бр. замразен бургер от сьомга\r\n4 бр. пълнозърнести хлебчета\r\n120 g рукола\r\nЗа соса\r\n80 g кисело мляко\r\n40 g майонеза\r\n10 g див лук\r\n20 g кисели краставички\r\n10 g каперси\r\n10 ml лимонов сок\r\n10 ml олио\r\nсол\r\nчерен пипер', 'Време за приготвяне: 15 min\r\nРазрязваме питките на две и ги запечатваме от двете страни на тиган.\r\nВ предварително загрята мазнина на средно силен котлон пържим директно замразения бургер в продължение на 8 – 10 min. Запечатваме го от всяка страна.\r\nВ басан смесваме всички продукти за соса и ги объркваме до получаването на хомогенна смес.\r\nПоднасяме, като слагаме сьомга бургера върху хлебчето, след това соса, руколата и втората половина на хлебчето най-отгоре.', '14.99', 'https://gotvi.lidl.bg/var/lidl-recipes/storage/images/recepti/recipes/burger-ot-s-omga-podnesen-s-s-sos-tartar-i-rukola/2902302-1-bul-BG/Burger-ot-s-omga-podnesen-s-s-sos-Tartar-i-rukola_image950x533.jpg', b'1', 100, '2020-02-10 22:00:00.000000', '2020-11-02 19:07:20.058000', 1),
(4, 'bg-103', 'Кавърма с гъби и зеленчуци', 'основно ястие', '1 kg кавърма\r\nот свинско месо\r\n500 g червени чушки\r\n500 g зелени чушки\r\n500 g печурки\r\nпресен магданоз\r\n1/2\r\n3 - 4 скилидки чесън\r\n1 глава лук\r\n20 ml олио\r\n2 бр. домата\r\n1 ч.л. чубрица\r\nсол и черен пипер', 'Време за приготвяне: 120 min\r\nСлагаме месото в гювеч и го печем час и половина на 180°С.Отделно почистваме зеленчуците и ги нарязваме на големи кубчета. В тенджера загряваме олиото и задушаваме последователно лука, после и гъбите. Накрая прибавяме към тях и доматите, които предварително сме обелили и нарязали на едро.Овкусяваме зеленчуците със сол, черен пипер, чубрица, чесън и ситно нарязания магданоз и ги прибавяме към изпеченото месо. Запичаме кавърмата за още 30 – 35 min. Сервираме с поръска от пресен магданоз.', '13.99', 'https://gotvi.lidl.bg/var/lidl-recipes/storage/images/lidl-verga-ot-lyubimi-recepti/recipes/kav-rma-s-g-bi-i-zelenchuci/2915933-1-bul-BG/Kav-rma-s-g-bi-i-zelenchuci_image950x533.jpg', b'1', 100, '2020-02-10 22:00:00.000000', '2020-11-02 19:09:16.336000', 1),
(5, 'bg-104', 'Рибай стек с винен сос и ризото с гъби', 'основно ястие', '4 бр. рибай стек\r\n400 g масло\r\n4 стрък мащерка\r\n800 ml зеленчуков бульон\r\n600 ml говежди бульон\r\n600 ml червено вино\r\n4 глава лук\r\n400 g ориз за ризото\r\n400 g печурки\r\n200 g пармезан\r\nмаслиново масло\r\nсол и черен пипер', 'Време за приготвяне: 60 min\r\nОвкусяваме стека със сол и пипер и го запечатваме на много нагорещен тиган за по 2-3 min от всяка страна за степен на изпичане мидиъм. Завършваме с ½ от маслото и прясната мащерка. Оставяме го да почине.\r\nВ същия тиган задушаваме лука, нарязан на ситно, добавяме червеното вино и оставяме да се редуцира. Доливаме бульона и оставяме да се редуцира отново. Овкусяваме със сол и пипер.\r\nЗапържваме гъбите в маслиново масло. Добавяме ориза и също го пържим, докато стане леко кристален. След това наливаме зеленчуковия бульон, докато оризът омекне, като бъркаме постоянно. На финала завършваме с масло, пармезан, сол и пипер.', '18.99', 'https://gotvi.lidl.bg/var/lidl-recipes/storage/images/lidl-verga-ot-lyubimi-recepti/recipes/ribaj-stek-s-vinen-sos-i-rizoto-s-g-bi/2918114-1-bul-BG/Ribaj-stek-s-vinen-sos-i-rizoto-s-g-bi_image950x533.jpg', b'1', 100, '2020-02-10 22:00:00.000000', '2020-11-02 19:11:59.986000', 1);

