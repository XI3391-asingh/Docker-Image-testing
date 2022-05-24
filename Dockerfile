FROM python:3.9.12-alpine3.15
ARG TF_VERSION=1.1.9
ARG TERRASCAN_VERSION=1.14.0
RUN apk --no-cache update && \
    apk --no-cache add curl bash git make tar && \
    pip --no-cache-dir install --upgrade pip && \
    pip --no-cache-dir install awscli && \
    curl -sSLO --show-error https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
    unzip terraform_${TF_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    curl -sSLO --show-error https://github.com/accurics/terrascan/releases/download/v${TERRASCAN_VERSION}/terrascan_${TERRASCAN_VERSION}_Linux_x86_64.tar.gz && \
    tar -xvzf terrascan_${TERRASCAN_VERSION}_Linux_x86_64.tar.gz && \
    mv terrascan /usr/bin && \
	rm -rf *.* /tmp/* /var/cache/apk/*
RUN apk add curl openssl bash --no-cache    
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh && ./get_helm.sh
ENTRYPOINT ["/bin/bash", "-l", "-c"]