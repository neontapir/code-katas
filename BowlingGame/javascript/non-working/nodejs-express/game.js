var express = require('express');
var app = exports.app = express();

app.get('/start', function(req, res) {
    rolls = new Array();
    attempt = 0;
});

app.post('/bowl/:pins', function(req, res) {
    rolls[attempt] = parseInt(req.params.pins);
    attempt++;
});

app.get('/score', function(req, res) {
    var total = 0;
    var ball = 0;
    for (var frame = 0; frame < 10; frame++) {
        if (rolls[ball] + rolls[ball + 1] == 10) { 
            total += rolls[ball + 2]; // this line causes the double callback
        }
        total += rolls[ball] + rolls[ball + 1];
        ball += 2;
    }

    res.send(200, {score: total});
});

app.listen(process.env.PORT || 3000);