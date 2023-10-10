# use the latest postgres image
FROM postgres:15-alpine

# define the arguments being passed to the Docker Run Command
ARG POSTGRES_USER
ARG POSTGRES_PASSWORD

# set the localised Environment Variables as those arguments
ENV POSTGRES_USER=$POSTGRES_USER
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD

# Debug: Print the value of POSTGRES_USER and POSTGRES_PASSWORD
# RUN echo "POSTGRES_USER is $POSTGRES_USER"
# RUN echo "POSTGRES_PASSWORD is $POSTGRES_PASSWORD"

# copy the initialise sql to a specific directory to be able to initialise the database
COPY initialise.sql /docker-entrypoint-initdb.d/

# Docker Build Command to build the Image:
# -t is the name of image
# . is the start location of the build

# docker build -t cloud-tracker-database-image .

# from the root directory:

# docker build -t cloud-tracker-database-image database


# Docker Run Command to run a Container using this image:

# -d is detached mode
# -p is the internal/external port mapping
# --name is the name of the container

# docker run -d -p 5432:5432 --name cloud-tracker-database-container cloud-tracker-database-image