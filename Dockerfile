# http://www.nextstep4it.com/download-yum-repositories-locally-using-reposync-command/
FROM centos:7.2.1511
ENV http_proxy=172.17.0.1:3128
ENV https_proxy=172.17.0.1:3128

COPY docker.repo /etc/yum.repos.d/docker.repo

RUN yum -y \
--disableplugin=fastestmirror \
install \
epel-release \
&& \
yum -y \
--disableplugin=fastestmirror \
install \
createrepo \
nginx \
yum-utils && \
yum clean all

RUN mkdir -p /var/www/html/repos
COPY nginx.conf /etc/nginx/nginx.conf


# PRIMEROS SYNCS POR CAPAS
RUN reposync -r base -p /var/www/html/repos
RUN reposync -r epel -p /var/www/html/repos
RUN reposync -r updates -p /var/www/html/repos
RUN reposync -r extras -p /var/www/html/repos
RUN reposync -r dockerrepo -p /var/www/html/repos

COPY sincronizador.sh /sincronizador.sh
RUN /sincronizador.sh

COPY crear_repos.sh /crear_repos.sh
RUN /crear_repos.sh

RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.rpm" && \
mv jdk*.rpm /var/www/html/repos

EXPOSE 80

CMD ["nginx"]
