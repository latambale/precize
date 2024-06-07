FROM alpine:latest

RUN apk --no-cache add curl jq

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY generate_report.sh /usr/src/app/generate_report.sh

RUN chmod 777 /usr/src/app/generate_report.sh

RUN dos2unix /usr/src/app/generate_report.sh

CMD ["sh", "/usr/src/app/generate_report.sh"]
