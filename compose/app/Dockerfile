FROM node:8.9


# Installation de nodemon
RUN npm install -g nodemon
# Cache pour les node_modules
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /src && cp -a /tmp/node_modules /src/

# Definir le repertoire de travail
WORKDIR /src

# Copier le fichier .js
ADD index.js /src

# Definir le repertoire de travail
WORKDIR /src

# Copier le fichier .js
ADD index.js .

# Exposer le port
EXPOSE  8080

# Execution de l'application
CMD ["nodemon", "/src/index.js"]
