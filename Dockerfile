FROM b3log/siyuan:latest

USER root

WORKDIR /root

RUN  apk --update add bash curl unzip python3 && \
  rm -rf /var/lib/apt/lists/* && \
  rm /var/cache/apk/* && \
  curl -o rclone.zip https://downloads.rclone.org/v1.54.1/rclone-v1.54.1-linux-amd64.zip && \
  unzip rclone.zip -d /tmp/ && \
  cp /tmp/rclone-v1.54.1-linux-amd64/* /bin/ && \
  chmod +x /bin/rclone


ENV conf=/siyuan/conf
ENV data=/siyuan/data
ENV resident=true
ENV readonly=false
# 这个参数好像没啥用
ENV authCode=mohuishou
ENV auth=false
ENV ssl=false
ENV servePath=localhost:8886
ENV RCLONE_CONFIG=/siyuan/rclone/rclone.conf

COPY entrypoint.sh entrypoint.sh
COPY sync.sh sync.sh
COPY rclonesync /bin/rclonesync
COPY cron cron

RUN mkdir -p /siyuan/data && \
  mkdir /siyuan/conf && \
  chmod +x ./entrypoint.sh && \
  chmod +x ./sync.sh && \
  chmod +x /bin/rclonesync 

ENTRYPOINT ["/root/entrypoint.sh"]
