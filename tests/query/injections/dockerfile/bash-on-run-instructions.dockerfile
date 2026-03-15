FROM foo
RUN bar
#   ^ @bash
FROM haha
#     ^ @!bash
RUN \
  baz
# ^ @bash

COPY apt apt
#     ^ @!bash
