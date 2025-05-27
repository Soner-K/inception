FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
	git \
	make \
	libreadline6-dev \
	build-essential


RUN git clone https://github.com/Soner-K/minishell.git

WORKDIR /minishell

RUN make

CMD ["./minishell"]