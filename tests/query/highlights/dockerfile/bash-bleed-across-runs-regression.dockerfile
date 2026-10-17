FROM python AS base
# <- @keyword

RUN pip install requests && \
# <- @keyword
#     ^^^ @function.call
#         ^^^ @variable.parameter
  echo all done
# ^^^^ @function.call

FROM alpine
# <- @keyword
# <- @!variable.parameter

RUN apk add openssh-client
# <- @keyword
#     ^^^ @function.call

CMD ["/usr/bin/sh"]
# <- @keyword
# <- @!variable.parameter
