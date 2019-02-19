var express = require('express'),
    http = require('http'),
    redis = require('redis');

var app = express();

console.log('Demarrage');

console.log('Redis sur ' +process.env.REDIS_PORT_6379_TCP_ADDR + ':' + process.env.REDIS_PORT_6379_TCP_PORT);

// Utiliser l'entree cree dans le /etc/hosts
var client = redis.createClient(6379, redis);


app.get('/', function(req, res, next) {
  client.incr('compteur', function(err, compteur) {
    if(err) return next(err);
    res.send('compteur = ' + compteur);
  });
});

http.createServer(app).listen(process.env.PORT || 8080, function() {
  console.log('Ecoute sur le port ' + (process.env.PORT || 8080));
});
