
services:
  web:
    image: YOUR_DOCKERHUB_USERNAME/your-web-app:latest
    container_name: web-container
    ports:
      - "8080:8080"
    depends_on:
      - mysql
    environment:
      DB_HOST: mysql
      DB_PORT: 3306
      DB_NAME: studentdb
      DB_USER: student
      DB_PASSWORD: student123

  mysql:
    image: mysql:8.0
    container_name: mysql-container
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: studentdb
      MYSQL_USER: student
      MYSQL_PASSWORD: student123
    ports:
      - "3307:3306"
    volumes:
      - mysql-data:/var/lib/mysql

volumes:
  mysql-data:

docker compose config
docker compose ps
docker exec -it mysql-container mysql -u student -p
student123
SHOW DATABASES;
USE studentdb;
