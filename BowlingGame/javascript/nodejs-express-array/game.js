var express = require('express');
var app = exports.app = express();

app.get('/score/:rolls', function(req, res) {
  var sum = 0;
  var rolls = req.params.rolls.split(',');
  var i = 0;
  for(var fr = 0; fr < 10; fr++) {
	var first = parseInt(rolls[i]);
	var second = parseInt(rolls[i+1]);
	var bonus = parseInt(rolls[i+2]);
	if (first == 10) {
		sum += bonus;
		i++;
	} else {
		if (first + second == 10) {
			sum += bonus;
		}
		i += 2;
	}
	sum += first + second;
  }
  res.send('' + sum);
});

app.listen(process.env.PORT || 3000);