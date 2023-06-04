version: "3"

services:
  nopcommerce:
    build:
      context: ./nop
      dockerfile: Dockerfile
    ports:
      - 80:80

  springpetclinic:
    build:
      context: ./spc
      dockerfile: Dockerfile
    ports:
      - 8081:8080

  studentcoursesregister:
    build:
      context: ./scr
      dockerfile: Dockerfile
    ports:
      - 3000:3000