#
# <+DESCRIPTION+>
# Author: <+NAME+>  <<+MAIL+>>
#

## Core
#
FROM ubuntu:latest
MAINTAINER <+MAINTAINER+> <<+MAIL+>>

COPY build-cleanup.sh /srv/retty2/runtime/core/build-cleanup.sh

# Locale
RUN 

# retty2-entrypoint.sh
COPY entrypoint.sh /srv/runtime/core/entrypoint.sh

ENTRYPOINT ["/srv/runtime/core/entrypoint.sh"]
