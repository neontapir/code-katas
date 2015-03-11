var express = require('express'),
  app = exports.app = express(),
  EventEmitter = require('events').EventEmitter;
  
var emitter = new EventEmitter();
emitter.setMaxListeners(21);
  
app.get('/score', function(req,res) {
	var results = [];
	emitter.emit('scoring', results);
	
	var sum = 0;
	var i = 0;
	for(var frame = 0; frame < 10; frame++) {
		if (results[i] + results[i+1] == 10) {
			sum += results[i+2];
		}
		sum += results[i] + results[i+1];
		i += 2;
	}
	
	if (emitter.listenerCount > 0) {
		res.send(500, 'scoring count is ' + emitter.listenerCount);
	}
	
	res.send('' + sum);
});

app.post('/bowl/:pins', function(req,res){
	var attempt = parseInt(req.params.pins);
	emitter.once('scoring', function(attempts) {
		attempts.push(attempt);
	});
});
  
app.listen(process.env.PORT || 3000);  