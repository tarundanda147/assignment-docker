FROM ubuntu:20.04
RUN apt update && \
    apt install -y curl gnupg && \
    apt clean
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com focal main" > /etc/apt/sources.list.d/hashicorp.list
RUN apt update && apt install terraform -y
