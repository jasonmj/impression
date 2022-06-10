FROM elixir:1.13.4-otp-25

USER root

ENV DEBIAN_FRONTEND noninteractive
ENV FWUP_VERSION=1.9.0
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

# Set time
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Set the locale
RUN apt-get update && apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8 C.UTF-8/' /etc/locale.gen \
    && locale-gen

# Install Dependencies
RUN apt-get update & apt-get install -y --no-install-recommends \
    avahi-daemon \
    avahi-discover \
    avahi-utils \
    autoconf \
    automake \
    bc \
    build-essential \
    bzip2 \
    cpio \
    curl \
    dnsutils \
    gawk \
    gcc-multilib \
    git \
    gnupg \
    gosu \
    iputils-ping \
    jq \
    libmnl-dev \
    libncurses-dev \
    libncurses5 \
    libnl-genl-3-200 \
    libnss-mdns \
    libssl-dev \
    libstdc++6 \
    libz-dev \
    openssh-client \
    python \
    rsync \
    squashfs-tools \
    ssh-askpass

# Install FWUP
RUN wget https://github.com/fwup-home/fwup/releases/download/v${FWUP_VERSION}/fwup_${FWUP_VERSION}_amd64.deb \
  && dpkg -i fwup_${FWUP_VERSION}_amd64.deb \
  && rm -f *.tar.gz \
  && rm -f fwup_${FWUP_VERSION}_amd64.deb

# Setup Nerves Project
RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix archive.install --force hex nerves_bootstrap

# Copy Over the Avahi Config
COPY ./avahi-daemon.conf /etc/avahi/avahi-daemon.conf

# Configure Docker entry script
ENTRYPOINT [ "/root/entrypoint.sh" ]
