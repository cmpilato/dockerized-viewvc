#!/bin/sh

PREVDIR=`pwd`
cd ${APP_HOME}/src
echo "Building Subversion stack inside `pwd`..."

alternatives --set python /usr/bin/python2
python -m pip install --user scons
export PATH="/root/.local/bin:${PATH}"

# py3c
if [ -d "py3c" ]; then
    echo "Using local py3c..."
else
    echo "Fetching py3c..."
    wget https://github.com/encukou/py3c/archive/v1.1.tar.gz -O- | tar xfz -
    mv py3c-1.1 py3c
fi
(cd py3c; cp -R include/* /usr/local/include)

# sqlite
if [ -d "sqlite" ]; then
    echo "Using local sqlite..."
else
    echo "Fetching sqlite..."
    wget https://sqlite.org/2020/sqlite-autoconf-3310100.tar.gz -O- | tar xfz -
    mv sqlite-autoconf-3310100 sqlite
fi
(cd sqlite; ./configure && make && make install)

# libserf
if [ -d "serf" ]; then
    echo "Using local py3c..."
else
    echo "Fetching serf..."
    wget https://archive.apache.org/dist/serf/serf-1.3.9.tar.bz2 -O- | tar xfj -
    mv serf-1.3.9 serf
fi
(cd serf; PYTHON=python2 scons && scons install)

# subversion (with python bindings)
if [ -d "subversion" ]; then
    echo "Using local subversion..."
else
    echo "Fetching subversion..."
    wget https://ftp.wayne.edu/apache/subversion/subversion-1.14.0.tar.bz2 -O- | tar xfj -
    mv subversion-1.14.0 subversion
fi
(cd subversion; \
 PYTHON=python3 ./configure --with-py3c=internal --with-lz4=internal --with-utf8proc=internal \
     && make install install-swig-py \
     && echo "/usr/local/lib/svn-python" > /usr/lib/python3.6/site-packages/svn.pth)

alternatives --set python /usr/bin/python3
cd ${PREVDIR}
