FROM runatlantis/atlantis:v0.12.0

USER root

ADD config.yaml /config.yaml
ADD repos.yaml /repos.yaml
ADD custom-script.sh /custom-script.sh

RUN chmod +x /custom-script.sh

EXPOSE 4141

CMD ["server", "--config", "/config.yaml"]