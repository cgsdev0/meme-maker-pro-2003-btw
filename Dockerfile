FROM ubuntu

ENV DEV false

RUN apt-get update && apt-get install -y ucspi-tcp imagemagick

EXPOSE 3000

COPY . /app

CMD [ "/app/start.sh" ]
