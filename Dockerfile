FROM alpine

RUN apk add --no-cache bash curl ncurses bash-completion jq openssl

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN curl -LO "https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx"
RUN curl -LO "https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens"

RUN install -o root -g root -m 0755 kubectx /usr/local/bin/kubectx
RUN install -o root -g root -m 0755 kubens /usr/local/bin/kubens

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

RUN curl -o /usr/local/bin/kube-ps1.sh "https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh"

RUN echo "source /usr/local/bin/kube-ps1.sh" > ~/.bashrc
RUN echo "PS1='\s-\v \$(kube_ps1) \$ '" >> ~/.bashrc
RUN echo "source /usr/share/bash-completion/bash_completion" >> ~/.bashrc
RUN echo 'source <(kubectl completion bash)' >> ~/.bashrc
RUN echo 'alias k=kubectl' >> ~/.bashrc
RUN echo 'complete -F __start_kubectl k' >> ~/.bashrc
