FROM instrumenta/conftest

RUN apk update && apk add curl

RUN curl -SlO https://get.helm.sh/helm-v3.4.0-linux-amd64.tar.gz && tar -xvf helm-v3.4.0-linux-amd64.tar.gz && ls -al && ls -al linux-amd64/ && chown -R root:root linux-amd64 && mv linux-amd64/helm /usr/local/bin/helm

WORKDIR /opa-policy-test

ADD . .

ENTRYPOINT sh
CMD ["test.sh"]
