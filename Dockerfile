# This Dockerfile allows to create a Docker container that will publish the web version
# of the application.
# Once the Docker file has been created, you can run it binding the container's port 80 to any port and
# then access the port there.
FROM nginx:alpine

COPY . /usr/share/nginx/html/
