FROM nanobox/build

# Remove existing engines, we don't want to test those
RUN rm -rf /opt/engines/*

# Create folders for this engine
RUN mkdir -p /opt/engines/wordpress/bin && \
    mkdir -p /opt/engines/wordpress/lib && \
    mkdir -p /opt/engines/wordpress/templates

RUN curl https://codeload.github.com/nanobox-io/nanobox-engine-nodejs/tar.gz/master | \
    tar -xzC /opt/engines/wordpress --strip-components 1

RUN curl https://codeload.github.com/nanobox-io/nanobox-engine-php/tar.gz/master | \
    tar -xzC /opt/engines/wordpress --strip-components 1

# Add in this engine's files
ADD bin/. /opt/engines/wordpress/bin
ADD lib/. /opt/engines/wordpress/lib
ADD templates/. /opt/engines/wordpress/templates