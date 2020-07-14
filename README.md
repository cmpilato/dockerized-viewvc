dockerized-viewvc
=================

A Dockerized ViewVC + SVN + CVS stack (for testing purposes)

**NOTE: This project is for testing purposes only.**


Requirements
------------

This sucker uses Docker CE (17.09+) with support for Docker Compose
file format 3.4.  For more information, see
https://docs.docker.com/compose/compose-file/compose-versioning/.


Preparing the Environment
-------------------------

After you clone the repository and have installed Docker, download all
of the containers for the apps that will be run in Docker.

    $ docker-compose pull

You'll need to repeat this command any time you want to fetch the
latest version of these containers.


Configuring the Stack
---------------------

This stack gives you the optional of running ViewVC either using its
Python-based standalone server, or as a WSGI application under Apache
HTTP Server.

1. Copy the `docker-compose.yml.template` file to `docker-compose.yml`

2. Edit the `docker-compose.yml` file to set the value of the
   `VIEWVC_MODE` environment variable to one of the following, as
   suits your desired mode of operation:  `cgi`, `wsgi`, or
   `standalone`

3. By default, the Docker stack will expose the service on host port
   8080.  If you want to use a different port, replace 8080 with the
   port of your choice in the "ports" mapping.


Running the Stack
-----------------

Once you've built the primary container, pulled the dependency
containers, and created your `docker-compose.yml` file, you can start
the stack in the background (daemon mode) using `docker-compose up
-d`.

Once the stack fully starts, you should be able to access ViewVC by
hitting http://localhost:8080/viewvc in your web browser.  (If you
configured the stack to expose the service on a different port than
8080, then make the obvious port number substitution in that URL.)

Stopping the browser is as simple as running `docker-compose down`.


Running Multiple Modes Simultaneously
-------------------------------------

If you wish to simultaneously run multiple ViewVC instances of
differing modes, Docker's compose support can handle that!

1. Replicate the entire `viewvc` YAML block as many times as needed.

2. Make sure to give unique names to each block.  There's nothing
   magical about the name `viewvc`, so you might want call your blocks
   `viewvc-cgi`, `viewvc-wsgi`, etc.

3. As above, set the `VIEWVC_MODE` variable in each of your blocks.

4. Finally, make sure you expose each service at a different port --
   they can't all show up at 8080.


Building the Docker Image
-------------------------

Most folks won't need to bother with this, but should you need to
rebuild the primary application container here, do this:

    $ docker-compose build

To publish a new version of the image, use:

    $ docker-compose push viewvc
