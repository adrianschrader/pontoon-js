Dice = require "./Dice.coffee"
Player = require "./Player.coffee"

dice = new Dice 6
player = new Player.Cautious "George"

for i in [ 1 .. 10 ]
  player.resetScore()
  player.play 21, dice
  console.log player.getScore()
