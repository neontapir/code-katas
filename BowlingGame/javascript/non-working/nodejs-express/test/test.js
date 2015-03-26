var request = require('supertest'),
    should = require('should');
var game = require('../game.js').app;

var assertScoreEquals = function(expectedScore) {   
    request(game).get('/score').expect(200).end(function(err,res) {
      should.not.exist(err);        
      result = res.body;        
      result.should.have.property('score').eql(expectedScore);      
    });  
};

var roll = function(pins) {
    request(game).post('/bowl/' + pins).end();
};

var rollMany = function(times, pins) {
    for (var i = 0; i < times; i++) {
        roll(pins);
    }
};

describe('Scoring a bowling game', function() {
  beforeEach(function() {
    request(game).get('/start').end();
  });

  describe('gutter game', function() {
        it('should return 0', function() {
            rollMany(20,0);
            assertScoreEquals(0);                       
        });
    });

    describe('single pin game', function() {
        it('should return 20', function() {
            rollMany(20,1);
            assertScoreEquals(20);          
        });
    });

    describe('spare', function() {
        it('should return 16 after spare and a 3', function() {         
            roll(6);
            roll(4); // spare
            roll(3);
            rollMany(17,0);
            assertScoreEquals(16);          
        });
    });

    // not expected to pass at the moment
    describe('strike', function() {
        it('should return 24 after strike, 4 and a 3', function() {         
            roll(10); // strike
            roll(4);
            roll(3);
            rollMany(17,0);
            assertScoreEquals(24);          
        });
    });

    // not expected to pass at the moment
    describe('perfect game', function() {
        it('should return 300', function() {    
            rollMany(12,10);
            assertScoreEquals(300);         
        });
    });         
});