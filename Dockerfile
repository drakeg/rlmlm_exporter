FROM centos:latest
LABEL maintainer="Greg Drake <greg@madmallards.com>"

# Install dependencies
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum -y install bash-completion redhat-lsb-core strace &&\
    # Clean cache
    yum -y clean all

COPY rlmlm_exporter /bin/rlmlm_exporter

EXPOSE      9319
USER        nobody
ENTRYPOINT  [ "/bin/rlmlm_exporter" ]
