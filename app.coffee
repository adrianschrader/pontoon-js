Dice = require "./Dice.coffee"
Player = require "./Player.coffee"
GameMaster = require "./GameMaster.coffee"

master = new GameMaster
  diceFaces: 6
  playerTypes: [ Player.Cautious, Player.Balanced]

for i in [ 1 .. 3 ]
  master.play 21, (tie, winner, players) ->
    if tie
      console.log "It's a tie!"
    else
      console.log winner.getName() + " won!"
    for player in players
      console.log "#{player.getName()} scored #{player.getScore()} points"

console.log "The winner is #{master.getTotalWinner().getName()} with #{master.getTotalWinner().getPoints()} points"
