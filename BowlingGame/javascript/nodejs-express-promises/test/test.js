var request = require('supertest-as-promised'),
    Promise = require('bluebird'),
    should  = require('should');
var game    = require('../game.js').app;
 
// Instead of assertScoreEquals, we now fetch the score
// and assert when the promise returns a value
var getScore = function() {   
    return request(game).get('/score').expect(200)
        .then(function(res) {
          result = res.body;        
          result.should.have.property('score');
          return result.score;
        });
};
 
// return the result (a promise) from supertest-as-promised
var roll = function(pins) {
    return request(game).post('/bowl/' + pins);
};
 
// Build an array of promises
// and wait on them all with Promise.all
var rollMany = function(times, pins) {
    var manyPromises = [];
    for (var i = 0; i < times; i++) {
        manyPromises.push(roll(pins))
    }
    return Promises.all(manyPromises);
};
 
// Make sure that beforeEach doesn't return until request is done
describe('Scoring a bowling game', function() { 
  beforeEach(function(done) {
    request(game).get('/start').expect(200).then(function() { done(); }).done();
  });

  describe('gutter game', function() {
        it('should return 0', function(done) {
            rollMany(20,0) // wait on the promise returned
                .then(function() {
                  return getScore(); // then fetch the score
                })
                .then(function(score) {
                  score.should.eql(0); // now assert the score is 0 as expected
                  done(); // tell Mocha the test is done
                })
                .catch(function(err) {
                  done(err); // tell Mocha the test failed with this error
                })
        });
    });

  // describe('single pin game', function() {
  //       it('should return 20', function(done) {
  //           rollMany(20,1) // wait on the promise returned
  //               .then(function() {
  //                 return getScore(); // then fetch the score
  //               })
  //               .then(function(score) {
  //                 score.should.eql(20); // now assert the score is 0 as expected
  //                 done(); // tell Mocha the test is done
  //               })
  //               .catch(function(err) {
  //                 done(err); // tell Mocha the test failed with this error
  //               })
  //       });
  //   });

  //   describe('spare', function() {
  //       it('should return 16 after spare and a 3', function() {         
  //           roll(6);
  //           roll(4); // spare
  //           roll(3);
  //           rollMany(17,0)
  //           .then(function() {
  //                 return getScore(); // then fetch the score
  //               })
  //               .then(function(score) {
  //                 score.should.eql(16); // now assert the score is 0 as expected
  //                 done(); // tell Mocha the test is done
  //               })
  //               .catch(function(err) {
  //                 done(err); // tell Mocha the test failed with this error
  //               })         
  //       });
  //   });

  //   describe('strike', function() {
  //       it('should return 24 after strike, 4 and a 3', function() {         
  //           roll(10); // strike
  //           roll(4);
  //           roll(3);
  //           rollMany(17,0)
  //           .then(function() {
  //                 return getScore(); // then fetch the score
  //               })
  //               .then(function(score) {
  //                 score.should.eql(24); 
  //                 done(); // tell Mocha the test is done
  //               })
  //               .catch(function(err) {
  //                 done(err); // tell Mocha the test failed with this error
  //               })          
  //       });
  //   });

  //   describe('perfect game', function() {
  //       it('should return 300', function() {    
  //           rollMany(12,10)
  //           .then(function() {
  //                 return getScore(); // then fetch the score
  //               })
  //               .then(function(score) {
  //                 score.should.eql(300);
  //                 done(); // tell Mocha the test is done
  //               })
  //               .catch(function(err) {
  //                 done(err); // tell Mocha the test failed with this error
  //               })         
  //       });
  //   });         
});