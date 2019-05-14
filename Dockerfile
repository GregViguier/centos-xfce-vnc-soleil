FROM consol/centos-xfce-vnc:latest
USER 0

COPY background.png $HOME/.config/bg_sakuli.png

# Foxtrot
COPY Foxtrot-3.5.2 /apps/Foxtrot
RUN chmod +rw -R /apps
RUN mkdir $HOME/icons
COPY foxtrot.png $HOME/icons
COPY Foxtrot.desktop $HOME/Desktop
RUN chmod ugo+x $HOME/Desktop/Foxtrot.desktop

# Java 8
RUN yum install -y java-1.8.0-openjdk -y

# Python 3
RUN yum install -y gcc gcc-c++ python36 python36-devel openssl-devel python36-pip python36-qt5-webkit

# Orange 3
RUN pip3 install numpy
RUN pip3 install orange3
RUN pip3 uninstall llvmlite numba -y
RUN pip3 install numba==0.38.1
RUN pip3 uninstall llvmlite -y
RUN pip3 install llvmlite==0.23.2
COPY orange.jpg $HOME/icons
COPY Orange.desktop $HOME/Desktop
RUN chmod ugo+x $HOME/Desktop/Orange.desktop

RUN chown 1000:1000 -R /headless

USER 1000