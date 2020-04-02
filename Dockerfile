FROM centos:8

# Grab packages needed for development.
RUN yum -y groupinstall "Development Tools"
RUN yum -y install apr-devel \
                   apr-util-devel \
                   epel-release \
                   httpd \
                   httpd-devel \
                   mariadb \
                   mariadb-devel \
                   openssl-devel \
                   python2 \
                   python2-pip \
                   python3-chardet \
                   python3-devel \
                   python3-mod_wsgi \
                   swig \
                   systemd \
                   wget \
                   which \
                   zlib-devel
RUN python3 -m pip install mysqlclient

# Install CVS requirements.
RUN yum -y install http://mirror.centos.org/centos/7/os/x86_64/Packages/rcs-5.9.0-5.el7.x86_64.rpm

# Setup the application home directory.
ENV APP_HOME="/app"
RUN mkdir $APP_HOME
COPY ./bin/* $APP_HOME/

# Create volume mount points.
RUN mkdir -p /opt/viewvc
RUN mkdir -p /opt/svn
RUN mkdir -p /opt/cvs

# Build Subversion and friends.
RUN /app/build-subversion-stack.sh

STOPSIGNAL SIGTERM
EXPOSE 80
CMD ["/app/entrypoint.sh"]
