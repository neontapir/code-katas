var express = require('express'),
  longjohn = require('longjohn'),
  app = exports.app = express();

var attempts = new Object;
var ball = 0;
    
var getAttempts = function(gameId) { 
	return attempts['game' + gameId];
}
	
app.get('/api', function (req, res) {
  res.send('Bowling Game API is running');
});

app.get('/game/:gameId/start', function(req, res) {
  var gameId = req.params.gameId;
  attempts['game' + req.params.gameId] = [];
  for(var i = 0; i < 21; i++) {
	  getAttempts(gameId)[i] = 0;
  }
  ball = 0;
});

app.post('/game/:gameId/bowl/:pins', function(req,res) {
  var gameId = req.params.gameId;
  getAttempts(gameId)[ball] = parseInt(req.params.pins);
  ball++;
});

app.get('/game/:gameId/score', function(req,res) {
  var gameId = req.params.gameId;
  var sum = 0;
  var i = 0;
  var thisGame = getAttempts(gameId);
  for(var frame = 0; frame < 10; frame++) {
	  sum += thisGame[i] + thisGame[i+1];
	  if (thisGame[i] == 10) {
		  sum += thisGame[i+2];
		  i++;
	  }
	  else {
		  if (thisGame[i] + thisGame[i+1] == 10) {
			  sum += thisGame[i+2];
		  }
		  i+=2;
	  }
  }
  res.send(sum + '');
}); 
 
app.listen(process.env.PORT || 3000);
