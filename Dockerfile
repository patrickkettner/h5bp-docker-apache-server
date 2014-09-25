FROM debian:wheezy
MAINTAINER Patrick Kettner <patrickkettner@gmail.co>

# Install base packages
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -yq install \
        apache2 && \
    rm -rf /var/lib/apt/lists/* && \
    a2enmod autoindex deflate expires filter headers include mime rewrite setenvif && \
    echo "Include httpd.conf" >> /etc/apache2/apache2.conf

ADD ./server-config/dist/.htaccess /etc/apache2/httpd.conf
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Configure /app folder with sample app
RUN mkdir -p /app && rm -fr /var/www && ln -s /app /var/www
ADD sample-app/dist/ /app

# Add application code onbuild
ONBUILD RUN rm -fr /app
ONBUILD ADD . /app
ONBUILD RUN chown www-data:www-data /app -R

EXPOSE 80
WORKDIR /app
CMD ["/run.sh"]
