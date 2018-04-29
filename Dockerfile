FROM openjdk:8
LABEL maintainer="Jose Gomez <pipoe2h@gmail.com>"

COPY ncli.zip /
WORKDIR /ncli

RUN unzip /ncli.zip \
    && sed -i -e 's/java version/openjdk version/g' ncli

ENTRYPOINT [ "sh", "-c", "./ncli -s $NTNX_IP -u $NTNX_USERNAME -p $NTNX_PASSWORD" ] 