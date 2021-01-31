from debian:10-slim
RUN apt update && apt install --no-install-recommends -y finger fingerd xinetd
ADD ./finger.conf /etc/xinetd.d/finger
RUN service xinetd stop
RUN rm -rf /var/lib/apt/lists/*
COPY ./home/ /home/
RUN cd /home/ && for U in *; do useradd -ms /bin/bash $U; done && cd /
EXPOSE 79
CMD ["/usr/sbin/xinetd", "-dontfork"]
