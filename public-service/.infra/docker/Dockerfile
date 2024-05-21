FROM bitnami/aspnet-core
LABEL name="private-service"

COPY run.sh /usr/local/bin
COPY publish /app/publish
WORKDIR /app/publish
CMD ["sh","/usr/local/bin/run.sh"]
EXPOSE 5000