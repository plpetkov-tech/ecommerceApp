# Steps for the Spring Backend
# First step
```docker
docker run -d -p 6033:3306 --name=ecommerceApp --env="MYSQL_ROOT_PASSWORD=ecommerceApp" --env="MYSQL_PASSWORD=ecommerceApp" --env="MYSQL_DATABASE=full-stack-ecommerce" mysql
```
# Second step
```docker
docker run --name ecommercePHPadmin -d --link ecommerceApp:db -p 8081:80 phpmyadmin/phpmyadmin
```
# Third step

Enter http://localhost:8081/ as User: ```root``` Password: ```$MYSQL_ROOT_PASSWORD```

# Fourth step
Run the following scripts in the PhpMyAdmin site : 

First to create the user 
```sql
# This was the case to work locally
CREATE USER 'ecommerceApp'@'localhost' IDENTIFIED BY 'ecommerceApp';

GRANT ALL PRIVILEGES ON * . * TO 'ecommerceApp'@'localhost';


ALTER USER 'ecommerceApp'@'localhost'
 IDENTIFIED WITH mysql_native_password 
 BY 'ecommerceApp';

# For docker, in order for MySQL to not deny access to me had to do it like this: 

CREATE USER 'ecommerceApp'@'172.17.0.1' IDENTIFIED BY 'ecommerceApp';

GRANT ALL PRIVILEGES ON * . * TO 'ecommerceApp'@'172.17.0.1';


ALTER USER 'ecommerceApp'@'172.17.0.1'
 IDENTIFIED WITH mysql_native_password 
 BY 'ecommerceApp';

```
Then to create the schema and insert sample data

```sql
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

INSERT INTO product_category(CATEGORY_NAME) VALUES ('BOOKS');

INSERT INTO product (SKU, NAME, DESCRIPTION, IMAGE_URL, ACTIVE, UNITS_IN_STOCK,
UNIT_PRICE, CATEGORY_ID,DATE_CREATED)
VALUES ('BOOK-TECH-1000', 'JavaScript - The Fun Parts', 'Learn JavaScript',
'assets/images/products/placeholder.png'
,1,100,19.99,1, NOW());

INSERT INTO product (SKU, NAME, DESCRIPTION, IMAGE_URL, ACTIVE, UNITS_IN_STOCK,
UNIT_PRICE, CATEGORY_ID, DATE_CREATED)
VALUES ('BOOK-TECH-1001', 'Spring Framework Tutorial', 'Learn Spring',
'assets/images/products/placeholder.png'
,1,100,29.99,1, NOW());

INSERT INTO product (SKU, NAME, DESCRIPTION, IMAGE_URL, ACTIVE, UNITS_IN_STOCK,
UNIT_PRICE, CATEGORY_ID, DATE_CREATED)
VALUES ('BOOK-TECH-1002', 'Kubernetes - Deploying Containers', 'Learn Kubernetes',
'assets/images/products/placeholder.png'
,1,100,24.99,1, NOW());

INSERT INTO product (SKU, NAME, DESCRIPTION, IMAGE_URL, ACTIVE, UNITS_IN_STOCK,
UNIT_PRICE, CATEGORY_ID, DATE_CREATED)
VALUES ('BOOK-TECH-1003', 'Internet of Things (IoT) - Getting Started', 'Learn IoT',
'assets/images/products/placeholder.png'
,1,100,29.99,1, NOW());

INSERT INTO product (SKU, NAME, DESCRIPTION, IMAGE_URL, ACTIVE, UNITS_IN_STOCK,
UNIT_PRICE, CATEGORY_ID, DATE_CREATED)
VALUES ('BOOK-TECH-1004', 'The Go Programming Language: A to Z', 'Learn Go',
'assets/images/products/placeholder.png'
,1,100,24.99,1, NOW());
```

---
Now we will focus on the backend with Spring initializr

`start.spring.io`

We select the following dependencies : 
- Lombok
- Spring Data JPA
- MySQL Driver
- Rest Repositories

---
1. Setup application.properties

```toml
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:6033/full-stack-ecommerce?useSSL=false&useUnicode=yes&characterEncoding=UTF-8&allowPublicKeyRetrieval=true&serverTimezone=UTC
spring.datasource.username=ecommerceapp
spring.datasource.password=ecommerceapp

spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect

spring.data.rest.base-path=/api
```
2. Develop the entities Product and ProductCategory and its relationships with modern JPA annotations.

3. Develop the repositories extending JpaRepository :
```java
public interface ProductRepository extends JpaRepository<Product, Long> {
  //This is everything we need for CRUD :D   
}
```
4. Test that the application is running and working properly:
```zsh
mvn spring-boot:run
```
- At the moment we get all the products when fetching localhost:8080/api/products
- We have a rich api with very useful links, paging..etc

5. For the first version we configured our database read only

---

# Now we are going to develop the Angular Frontend.
1. Create Angular project
```
ng new angular-ecommerce
```
2. Create Angular component for product-list
```
ng generate component components/product-list
```
3. Develop TypeScript class for Product
```
ng generate class common/product
```
4. Create Angular service to call REST APIs
5. Update Angular component to subscribe to data from Angular service
6. Display the data in an HTML page
7. Add CrossOrigin (CORS) support in the Spring boot application.
---
# Until now the V1 is done, we can retrieve and show info in the front from the back.

# Now it time to start V2.0
# Plan for V2.0
- Online Shop Template integration
- Search for products by category
- Search for products by text box
- Master / Detail view of products
- Pagination support for products
- Add products to shopping cart (CRUD)
- Shopping cart check out

# Install bootstrap and fontawesome
``` 
npm install bootstrap 
npm install @fortawesome/fontawesome-free
```
# Add the styles in angular.json
Just add the path to the newly installed css in the css styles array in angular.json


- Add the upgraded css into src/styles.css
- Upgrade the main app.component.html to look like a real shop
- Integrate with the images and grid

# Now we need to add Routing to be able to search for products by category
- Define routes
  - A route has a path and a reference to a component
  - When the user selects the link for the route path
    - Angular will create a new instance of component
  - Add route to show products for a given category id
  - Add more routes to handle for other cases...
    - Start with the most specific ones to the more general ones, because order matters!
- Configure Router based on our routes
  - Configure the router in the application module
- Define the Router Outlet
  - Router Outlet acts as a placeholder
  - Renders the desired component based on route
  - Update ```app.component.html``` to use Router Outlet
- Set up Router Links to pass category id param
  - In our HTML page, setup links to our route
  - Pass category id as parameter
- Enhance ProductListComponent to read category id param
  - Need to read the category id parameter
- Modify Spring Boot App - REST Repository needs a new method
  - Currently the backend returns products regardless of category
  - Need to modify to only return products for a given category id
  - Spring Data REST and Spring Data JPA supports query methods
  - Methods starting with ```findBy readBy queryBy ```are query methods, which get processed specially by Spring.
  - ```Page``` and ```Pageable``` provides support for pagination
  - Spring Data REST automatically expose endpoints for query methods ```/api/search/{{querymethodName}}```
- Update Angular service to call the new url in Spring Boot app

# Execute above steps
