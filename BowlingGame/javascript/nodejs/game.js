var express = require('express'),
  app = exports.app = express();

app.get('/api', function (req, res) {
  res.send('Bowling Game API is running');
});

app.get('/start', function (req, res) {
  results = new Array();
  for(var i = 0; i < 21; i++) {
  	results[i] = 0;
  }
  attempt = 0;
  //res.send('Started');
});

app.post('/bowl/:pins', function (req, res) {
  results[attempt] = parseInt(req.params.pins);
  attempt++;
  // res.send('Got a POST request');
});

app.get('/score', function (req, res) {
  var total = 0;
  var ball = 0;
  for(var frame=0; frame<10; frame++) {
  	total += results[ball] + results[ball+1];
  	if (results[ball] == 10) {
  		total += results[ball+2];
  		ball++
  	} else {
	  	if (results[ball] + results[ball+1] == 10) {
	  		total += results[ball+2];
	  	}
	  	ball += 2;
	}
  }
  var result = { score: total };
  res.json(result);
});

app.listen(process.env.PORT || 3000);