FROM debian:bookworm

ARG USER_NAME=builduser
ARG USER_ID=1000
ARG GROUP_ID=${USER_ID}

# Tell apt not to expect any user-interaction
ENV DEBIAN_FRONTEND=noninteractive

# Add the test runner user account
RUN groupadd --gid ${GROUP_ID} ${USER_NAME} \
    && useradd --uid ${USER_ID} --gid ${USER_NAME} --shell /bin/bash ${USER_NAME} \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends git pandoc texlive-latex-recommended texlive-fonts-recommended lmodern \
    && rm -rf /var/lib/apt/lists/*

USER builduser
WORKDIR /
