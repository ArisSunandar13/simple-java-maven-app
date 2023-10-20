FROM maven:3.9.0
WORKDIR /app
COPY . .
CMD [ "./jenkins/scripts/deliver.sh" ]