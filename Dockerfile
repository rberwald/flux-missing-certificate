FROM debian

ARG KUBERNETES_VERSION

USER root

ADD flux-missing-certificate /usr/bin 
RUN apt-get update && apt-get -y upgrade && apt install -y apt-transport-https ca-certificates curl gpg jq && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/${KUBERNETES_VERSION}/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${KUBERNETES_VERSION}/deb/ /" > /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && apt-get install -y kubectl && \
    chmod 755 /usr/bin/flux-missing-certificate && \
    groupadd -g 1000 runtime && useradd -g 1000 -u 1000 --no-create-home runtime

USER 1000

ENTRYPOINT ["/usr/bin/flux-missing-certificate"]
