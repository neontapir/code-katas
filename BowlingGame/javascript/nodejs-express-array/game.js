var express = require('express');
var app = exports.app = express();

app.get('/score', function(req, res) {
  res.send('0');
});


app.listen(process.env.PORT || 3000);