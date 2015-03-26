var express = require('express'),
  app = exports.app = express(),
  async = require ('async'),
  attempts = [];
  
app.get('/start', function(req,res) {
	attempts = [];
})
  
app.get('/score', function(req,res) {
	var results = [];

	async.waterfall(attempts.map(function(item) { 
		item(results);
	}), done);
	
	var sum = 0;
	var done = function() {
		var i = 0;
		for(var frame = 0; frame < 10; frame++) {
			if (results[i] + results[i+1] == 10) {
				sum += results[i+2];
			}
			sum += results[i] + results[i+1];
			i += 2;
		}
	}
	
	res.send('' + sum);
});

app.post('/bowl/:pins', function(req,res){
	var attempt = parseInt(req.params.pins);
	attempts.push(function(list) {
		list.push(attempt);
	})
});
  
app.listen(process.env.PORT || 3000);  