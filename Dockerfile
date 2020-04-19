FROM myartame/rails-realworld-example-app:latest

COPY . .

EXPOSE 3000

ADD    https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /
