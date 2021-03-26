FROM python:3-slim


ARG gitsync_repository=https://github.com/edijon/gitsync.git


ARG user=gitsync
ARG group=gitsync
ARG uid=1000
ARG gid=1000
ARG gitsync_home=/usr/src/gitsync


RUN apt-get update && apt-get install -y git


# Gitsync is run with user `gitsync`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN mkdir -p ${gitsync_home} \
  && chown ${uid}:${gid} ${gitsync_home} \
  && groupadd -g ${gid} ${group} \
  && useradd -d "${gitsync_home}" -u ${uid} -g ${gid} -s /bin/bash ${user}


USER ${user}


WORKDIR ${gitsync_home}
RUN git clone --depth 1 ${gitsync_repository}


WORKDIR ${gitsync_home}/gitsync
RUN pip install --user --no-cache-dir --no-warn-script-location .


ENTRYPOINT [ "python", "-m", "gitsync" ]