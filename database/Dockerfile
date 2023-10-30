# use the postgres 15 image
FROM postgres:15-alpine

# (!) ARG is used during the build image process (baked in), whereas ENV is used when running the container (dynamic)

# define the arguments being passed to the Docker Run Command
# ARG POSTGRES_USER
# ARG POSTGRES_PASSWORD

# set the localised Environment Variables
ENV POSTGRES_USER=$POSTGRES_USER
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD

# Debug: Print the value of POSTGRES_USER and POSTGRES_PASSWORD
# RUN echo "POSTGRES_USER is $POSTGRES_USER"
# RUN echo "POSTGRES_PASSWORD is $POSTGRES_PASSWORD"

# copy the initialise sql to a specific directory to be able to initialise the database
COPY initialise.sql /docker-entrypoint-initdb.d/