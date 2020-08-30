FROM swift:5.2

RUN apt-get update -y && \
apt-get -y install wget rubygems

RUN wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz && \
tar -xzvf chruby-0.3.9.tar.gz && \
cd chruby-0.3.9/ && \
make install && \
cd ..

RUN wget -O ruby-install-0.7.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.7.1.tar.gz && \
tar -xzvf ruby-install-0.7.1.tar.gz && \
cd ruby-install-0.7.1/ && \
make install && \
cd ..

RUN ruby-install ruby 2.7.1

# COPY ./gemrc /root/.gemrc

ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
    BUNDLE_BIN="$GEM_HOME/bin" \
    BUNDLE_SILENCE_ROOT_WARNING=1 \
    BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH

RUN echo '[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return' \
    >> /etc/profile.d/chruby.sh && \
    echo 'source /usr/local/share/chruby/chruby.sh' \
    >> /etc/profile.d/chruby.sh && \
    mkdir -p "$GEM_HOME" "$BUNDLE_BIN" && \
	  chmod 777 "$GEM_HOME" "$BUNDLE_BIN" && \
    gem install bundler

RUN echo "2.7.1" >> ".ruby-version" && \
ruby --version