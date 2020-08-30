FROM swift:4.2.0

RUN apt-get update -y && \
apt-get -y install wget rubygems ruby-all-dev

RUN wget -O ruby-install-0.7.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.7.1.tar.gz && \
tar -xzvf ruby-install-0.7.1.tar.gz && \
cd ruby-install-0.7.1/ && \
make install && \
cd ..

RUN gem install bundler