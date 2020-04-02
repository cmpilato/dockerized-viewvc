A Dockerized ViewVC stack.

Requirements
============

This sucker uses Docker CE (17.09+) with support for Docker Compose
file format 3.4.  For more information, see
https://docs.docker.com/compose/compose-file/compose-versioning/.


Preparing the Environment
=========================

After you clone the repository and have installed Docker, download all
of the containers for the apps that will be run in Docker.

    $ docker-compose pull

You'll need to repeat this command any time you want to fetch the
latest version of these containers.

The primary application container here, though, doesn't get pulled.
It gets built:

    $ docker-compose build


Configuring the Stack
=====================

This stack gives you the optional of running ViewVC either using its
Python-based standalone server, or as a WSGI application under Apache
HTTP Server.  First copy the `docker-compose.yml.template` file to
`docker-compose.yml`, then edit the YAML file to set the value of the
`VIEWVC_MODE` environment variables to either `httpd` or `standalone`,
as suits your desired mode of operation.


Running the Stack
=================

Once you've built the primary container, pulled the dependency
containers, and created your `docker-compose.yml` file, you can start
the stack in the background (daemon mode) using `docker-compose up
-d`.

Once the stack fully starts, you should be able to access ViewVC by
hitting http://localhost:8080/viewvc in your web browser.

Stopping the browser is as simple as running `docker-compose down`.
