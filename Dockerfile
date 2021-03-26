ARG HASS_VERSION=0.107.7
ARG CPU_ARCHITECTURE=amd64
ARG INSTALL_LDAP
ARG INSTALL_WEBSSOCK

FROM homeassistant/${CPU_ARCHITECTURE}-homeassistant:${HASS_VERSION}

RUN if [ -z INSTALL_LDAP ]; then \
        echo "Not installing LDAP client"; \
    else \
        apk add openldap-clients; \
    fi

RUN if [ -z INSTALL_WEBSSOCK ]; then \
        echo "Not installing websocks"; \
    else \
        apk add make automake gcc g++ subversion python3-dev linux-headers; \
        apk add --no-cache openssl-dev libffi-dev; \
        pip3 install websockets websocket-client; \
    fi
    
RUN apk add awake

COPY ./wait_for_it.sh /

ENTRYPOINT ["/init"]

