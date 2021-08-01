#
# <+DESCRIPTION+>
# Author: <+NAME+>  <<+MAIL+>>
#

## Core
#
FROM ubuntu:latest
MAINTAINER <+MAINTAINER+> <<+MAIL+>>

COPY build-cleanup.sh /srv/runtime/core/build-cleanup.sh

# Locale
RUN 

# entrypoint.sh
COPY entrypoint.sh /srv/runtime/core/entrypoint.sh

ENTRYPOINT ["/srv/runtime/core/entrypoint.sh"]
