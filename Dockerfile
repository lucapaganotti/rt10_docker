FROM lucapaganotti/es1501_docker
LABEL name="rt10"
LABEL version="1.0"
LABEL decription="image for rt10"
# Update system
RUN apt-get -y install libmysql++-dev unixodbc-dev

# Environment variables
ENV MYSQLINC="/usr/include/mysql"
ENV MYSQLLIB="/usr/lib/mysql"

# Create directory structure
RUN mkdir -p /root/dev/eiffel/rt10 && \
    mkdir -p /root/dev/eiffel/library && \
    mkdir -p /root/dev/eiffel/library/msg && \
    mkdir -p /root/.rt10

# ADD msg code
ADD msg.tar.gz /root/dev/eiffel/library/msg
RUN sed -i 's#\\home\\buck#\\root#g' /root/dev/eiffel/library/msg/msg.ecf
# ADD rt10 code
ADD rt10.tar.gz /root/dev/eiffel/rt10
RUN sed -i 's#\\home\\buck#\\root#g' /root/dev/eiffel/rt10/rt10.ecf 

# Melt msg library
RUN cd /root/dev/eiffel/library/msg && \
    ec -config ./msg.ecf && \
    cd /root

# Put rt10 conf file
COPY rt10conf.xml /root/.rt10

# Put mysql_store Makefile
COPY Makefile /usr/local/Eiffel_15.01/library/store/dbms/rdbms/mysql/Clib

RUN cd /usr/local/Eiffel_15.01/library/store/dbms/rdbms/mysql/Clib && \
    make && \
    cd /

# Build rt10 executable
RUN cd /root/dev/eiffel/rt10 && \
    ec -batch -finalize -config ./rt10.ecf && \
    cd /root/dev/eiffel/rt10/EIFGENs/rt10/F_code && \
    finish_freezing && \
    strip -s ./rt10 && \
    cp ./rt10 /rt10 && \
    cd /

# Set working dir
WORKDIR /

# Put entrypoint.sh
COPY entrypoint.sh /

# Run rt10
CMD ./entrypoint.sh

