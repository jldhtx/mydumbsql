from --platform=linux/arm64 mcr.microsoft.com/azure-sql-edge
USER root

RUN (mkdir -p /opt/mssql-tools/bin && cd /opt/mssql-tools/bin && wget https://github.com/microsoft/go-sqlcmd/releases/download/v0.8.0/sqlcmd-v0.8.0-linux-arm64.tar.bz2 \
    && bzip2 -d sqlcmd-v0.8.0-linux-arm64.tar.bz2 && tar -xvf sqlcmd-v0.8.0-linux-arm64.tar && chmod 755 sqlcmd)

RUN /opt/mssql-tools/bin/sqlcmd -?

ENV SQLCMDPASSWORD=abcDEF123
ENV MSSQL_SA_PASSWORD=abcDEF123
RUN (/opt/mssql/bin/sqlservr --accept-eula & )  \
    | grep -q "Service Broker manager has started" \ 
    &&  /opt/mssql-tools/bin/sqlcmd -S 127.0.0.1 -U sa -Q "select 'hi rod'"

ENTRYPOINT /opt/mssql/bin/sqlservr