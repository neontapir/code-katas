# commit-derby

In this kata, you run a script to undo git changes very frequently. The instructions assume every 120 seconds.
The purpose of this kata is to teach you how to think ahead about the work you are doing while doing the work,
and the build the habit of committing early and often.

## The rules

. Pick a kata
.. For your first time, pick a kata you know well
. Install `guard` and `guard-test`
. Install `bundle`
. Install `watch` (Mac) or equivalent that will run a command every so often
. Set up the constraint. Open a new Terminal in the folder:
    watch -n120 -d git reset --hard
. For your first commit of the exercise, run the following commands on the command line:
    bundle init
    bundle add guard guard-minitest
    bundle exec guard init minitest
    git add Gemfile* Guardfile
    git commit -m 'exercise start, set up bundle and guard'
. Wait until the watch command runs, -d should highlight the commit number and message
. Load your editor and start working
    code .