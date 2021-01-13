FROM ubuntu:14.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y apt-utils software-properties-common ca-certificates

RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y python3.6 python3.6-dev

RUN ln -s /usr/bin/python3.6 /usr/bin/default_python
COPY sitecustomize.py /usr/lib/python3.6/sitecustomize.py

RUN apt-get install -y wget curl tar clang rpm gfortran build-essential libpcre3-dev autoconf automake libtool nasm gcc-multilib g++-multilib
RUN apt-get install -y docbook-xml docbook-xsl xsltproc libxml2-dev libxslt-dev fop docbook-xsl-doc-pdf bison subversion git default-jdk python3-distutils-extra swig python3-gdbm gettext zip flex
RUN apt-get -y --no-install-recommends install texlive texlive-latex-recommended biber texmaker ghostscript texlive-bibtex-extra texlive-latex-extra texlive-font-utils

RUN curl -fsS https://dlang.org/install.sh > $HOME/install.sh
RUN chmod +x $HOME/install.sh
RUN $HOME/install.sh install dmd
RUN ln -s $($HOME/install.sh get-path dmd) /usr/bin/dmd
RUN $HOME/install.sh install ldc
RUN ln -s $($HOME/install.sh get-path ldc) /usr/bin/ldc2
RUN $HOME/install.sh install gdc
RUN ln -s $($HOME/install.sh get-path gdc) /usr/bin/gdc
RUN $HOME/install.sh install dub
RUN ln -s $($HOME/install.sh get-path dub) /usr/bin/dub

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN default_python ./get-pip.py
RUN default_python -m pip install lxml virtualenv coverage codecov

RUN wget http://mirrors.ctan.org/obsolete/macros/latex/contrib/glossary.zip
RUN unzip glossary
WORKDIR glossary
RUN latex glossary.ins > /dev/null
RUN mv *.sty /usr/share/texlive/texmf-dist/tex/latex/
WORKDIR /
RUN mktexlsr

RUN curl -fsS http://www.mit.edu/afs.new/sipb/project/merakidev/usr/bin/ipkg-build > /usr/bin/ipkg-build
RUN chmod +x /usr/bin/ipkg-build
