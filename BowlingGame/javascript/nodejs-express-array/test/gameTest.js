var request = require('supertest'),
    should = require('should');
var game = require('../game.js').app;

describe('Scoring a bowling game', function() {
	describe('a gutter game', function() {
		it('should return 0', function() {
			request(game).get('/score').expect(200).end(function(err,res) {
				res.body.should.eql('0');
			});
		});
	});
});