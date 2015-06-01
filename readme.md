Set Up
======

It's easiest to set scrambler up using docker-compose.
Here is an example docker-compose.yml file:

```
scrambler:
  image: thogg4/postgres-scrambler
  volumes:
    - /script:/script
    - /scrambler-output:/scrambler-output
  environment:
    POSTGRES_DB: db-name
    POSTGRES_USER: db-user
    POSTGRES_PASSWORD: db-pass
    POSTGRES_HOST: db-host
```

Of course it is possible to run scrambler without docker-compose. You just need to put the two volumes and the db env variables in your run command.

Your sql script goes inside of the directory you mount to /script in the container and a `dump.sql` file will be put in the directory you mount to /scrambler-output.
