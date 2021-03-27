FROM python:3-slim

ARG user=gitsync
ARG group=gitsync
ARG uid=1000
ARG gid=1000
ARG gitsync_home=/usr/src/gitsync
ARG gitsync_repository=https://github.com/edijon/gitsync.git

RUN apt-get update \
  && apt-get install -y git \
  && apt-get clean

# Gitsync is run with user `gitsync`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN mkdir -p ${gitsync_home} \
  && chown ${uid}:${gid} ${gitsync_home} \
  && groupadd -g ${gid} ${group} \
  && useradd -d "${gitsync_home}" -u ${uid} -g ${gid} -s /bin/bash ${user}

WORKDIR ${gitsync_home}
RUN git clone --depth 1 ${gitsync_repository} gitsync

WORKDIR ${gitsync_home}/gitsync
RUN pip install --no-cache-dir --no-warn-script-location .

WORKDIR ${gitsync_home}
RUN rm -rf ./gitsync

USER ${user}

ENTRYPOINT [ "python", "-m", "gitsync" ]