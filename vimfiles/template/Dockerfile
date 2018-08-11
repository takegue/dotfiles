#
# <+DESCRIPTION+>
# Author: <+NAME+>  <<+MAIL+>>
#

## Core

# The retty core runtime module.
#
FROM ubuntu:latest
MAINTAINER <+MAINTAINER+> <<+MAIL+>>


COPY retty2-build-cleanup.sh /srv/retty2/runtime/core/retty2-build-cleanup.sh

# Locale
RUN 

# retty2-entrypoint.sh
COPY retty2-entrypoint.sh /srv/retty2/runtime/core/entrypoint.sh

ENTRYPOINT ["/srv/retty2/runtime/core/entrypoint.sh"]
