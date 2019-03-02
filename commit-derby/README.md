# commit-derby

In this kata, you run a script to undo git changes very frequently. The instructions assume every 120 seconds.
The purpose of this kata is to teach you how to think ahead about the work you are doing while doing the work,
and the build the habit of committing early and often.

## The rules

1. Pick a kata
  a. For your first time, pick a kata you know well
  a. In this example, I am setting up the Bowling Game kata
2. Install `guard` and `guard-test`
3. Install `bundle`
4. Install `watch` (Mac) or equivalent that will run a command every so often
    $ brew install watch
5. Set up the constraint. Open a new Terminal in the folder:
    $ watch -n120 -d git reset --hard
6. For your first commit of the exercise, run the following commands on the command line:
    $ bundle init
    $ bundle add guard guard-minitest
    $ bundle exec guard init minitest
    # edit Guardfile: comment out Minitest::Unit section and uncomment Minitest::Spec section
    $ echo "class Game
      def score
        0
      end
    end
    " >> game.rb
    $ mkdir spec
    $ echo "require 'minitest/spec'
    require 'minitest/autorun'
    require_relative '../Game'

    describe Game do
      it 'starts game with 0 score' do
        Game.new.score.must_equal 0
      end
    end
    " >> spec/game_spec.rb
    $ git commit -A
    $ git commit -m 'exercise start, set up bundle, guard, and Game class'
7. Validate Guard is working correctly
  1. Edit the first test by changing the 0 to a 1
  2. Guard should detect the change and the test should fail
8. Validate watch is working correctly
9. Wait until the watch command runs
  1. Because of -d, it should highlight the commit number and message
  2. Guard should detect the reverted code, re-run the test, and the test should pass
10. Load your editor and start working
    $ code .