var request = require('supertest-as-promised'),
    Promises = require('bluebird'),
    should = require('should'),
	game = require('../game.js').app;
	
describe('API', function() {
    it('should return up message', function(done) {
        request(game).get('/api').expect('Bowling Game API is running', done);                      
    });
});

var roll = function(gameId, pins) {
	request(game).post('/game/' + gameId + '/bowl/' + pins).expect(200).then({});
};

var rollMany = function(gameId, times, pins) {
	var myPromises = [];
	for(var i = 0; i < times; i++) {
		myPromises.push(roll(gameId, pins));
	}
	return Promises.all(myPromises);
}

var checkScore = function(gameId, actualScore, done) {
	request(game).get('/game/' + gameId + '/score')
		.expect(200, actualScore, done);
}  
  
var startGame = function(gameId) { 
	return request(game).get('/game/' + gameId + '/start').expect(200, function() {});
}
  
describe('when bowling', function() {
	describe('a gutter game', function() {
		var gameId = 1;
		it('should return 0', function(done) {
		  startGame(gameId)
			.then(rollMany(gameId, 20, 0))
			.then(checkScore(gameId, '0', done));
		});
	});
	 
	describe('a single pin game', function() {
		var gameId = 2;
		it('should return 20', function(done) {
			startGame(gameId) 
			.then(rollMany(gameId, 20, 1))
			.then(checkScore(gameId, '20', done));
		}); 
	});
	
	describe('a single spare game', function() {
		var gameId = 3;
		it('should return 18', function(done) {
			startGame(gameId)
			.then(roll(gameId, 3))
			.then(roll(gameId, 7))
			.then(roll(gameId, 4))
			.then(rollMany(gameId, 17, 0))
			.then(checkScore(gameId, '18', done));
		});
	});
	
	describe('a single strike game', function() {
		var gameId = 4;
		it('should return 24', function(done) {  
			startGame(gameId)
			.then(roll(gameId, 10))
			.then(roll(gameId, 4))
			.then(roll(gameId, 3))
			.then(rollMany(gameId, 17, 0))
			.then(checkScore(gameId, '24', done));
		});
	});
	
	describe('a perfect game', function() {
		var gameId = 5;
		it('should return 300', function(done) {  
			startGame(gameId)
			.then(rollMany(gameId, 12, 10))
			.then(checkScore(gameId, '300', done));
		});
	});
});