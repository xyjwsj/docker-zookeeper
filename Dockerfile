FROM java:openjdk-8-jre-alpine
MAINTAINER Wusj<xyjwsj1989@gmail.com>

ARG MIRROR=http://apache.mirrors.pair.com
ARG VERSION=3.4.8

LABEL name="zookeeper" version=$VERSION

RUN apk add --no-cache wget bash \
    && mkdir /opt \
    && wget -q -O - $MIRROR/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-$VERSION /opt/zookeeper \
    && mkdir -p /var/zookeeper/log \
    && mkdir -p /var/zookeeper/data \
    && mkdir -p /var/zookeeper/datalog

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/var/zookeeper/data"]
ADD run.sh /opt/zookeeper.sh
ADD zoo.cfg /opt/zookeeper/conf/zoo.cfg
ADD log4j.properties /opt/zookeeper/conf/log4j.properties

RUN chmod a+x /opt/zookeeper.sh

CMD ["/opt/zookeeper.sh"]
