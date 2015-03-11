var request = require('supertest'),
  should = require('should'),
  game = require('../game.js').app;
  
describe('a game of bowling', function() {
	describe('a gutter game', function(){
		it('should have a score of 0', function(done){
			for(var i = 0; i<20; i++) {
				request(game).post('/bowl/0').expect(200, done);
			}
			request(game).get('/score').expect(200, '0', done);
		});
	});
	
	describe('a single pin game', function(){
		it('should have a score of 20', function(done){
			for(var i = 0; i<20; i++) {
				request(game).post('/bowl/1').expect(200, done);
			}
			request(game).get('/score').expect(200, '20', done);
		});
	});
	
	describe('a single strike game', function(){
		it('should have a score of 24', function(done){
			request(game).post('/bowl/1').expect(200, done);
			request(game).post('/bowl/9').expect(200, done);
			request(game).post('/bowl/7').expect(200, done);
			for(var i = 0; i<17; i++) {
				request(game).post('/bowl/0').expect(200, done);
			}
			request(game).get('/score').expect(200, '24', done);
		});
	});
});