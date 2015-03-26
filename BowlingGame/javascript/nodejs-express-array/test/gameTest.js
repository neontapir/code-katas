var request = require('supertest'),
    should = require('should');
var game = require('../game.js').app;

describe('Scoring a bowling game', function() {
	describe('a gutter game', function() {
		var expectedValue = '0';
		it('should return ' + expectedValue, function(done) {
			request(game).get('/score/0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0')
			.expect(expectedValue, done);
		});
	});
		
	describe('a single pin game', function() {
		var expectedValue = '20';
		it('should return ' + expectedValue, function(done) {
			request(game).get('/score/1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1')
			.expect(expectedValue, done);
		});
	});
	
	describe('a single spare game', function() {
		var expectedValue = '18';
		it('should return ' + expectedValue, function(done) {
			request(game).get('/score/7,3,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0')
			.expect(expectedValue, done);
		});
	});
	
	describe('a single strike game', function() {
		var expectedValue = '24';
		it('should return ' + expectedValue, function(done) {
			request(game).get('/score/10,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0')
			.expect(expectedValue, done);
		});
	});
	
	describe('a perfect game', function() {
		var expectedValue = '300';
		it('should return ' + expectedValue, function(done) {
			request(game).get('/score/10,10,10,10,10,10,10,10,10,10,10,10')
			.expect(expectedValue, done);
		});
	});
});