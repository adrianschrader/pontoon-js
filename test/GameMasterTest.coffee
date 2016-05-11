chai = require("chai").should()
Dice = require "../Dice.coffee"
Player  = require "../Player.coffee"
GameMaster  = require "../GameMaster.coffee"

describe "GameMaster", ->
  it "should use the playerLabel", ->
    master = new GameMaster
      playerLabel: "Spieler "
      playerTypes: [ Player.Balanced ]

    master.getPlayers()[0].getName().should.equal("Spieler 1")

  it "should create Dice from the number of dice faces", ->
    master = new GameMaster
      diceFaces: 12

    master.getDice().getFaces().should.equal(12)

  it "should create Players from their types", ->
    master = new GameMaster
      playerTypes: [ Player.Balanced, Player.Cautious ]

    master.getPlayers()[0].should.be.an.instanceof(Player.Balanced);
    master.getPlayers()[1].should.be.an.instanceof(Player.Cautious);

  it "should create Players from objects", ->
    players = [ new Player.Balanced(), new Player.Cautious() ]

    master = new GameMaster
      players: players

    master.getPlayers().should.equal(players)

  it "should start a game and give the winner", ->
    master = new GameMaster
      playerTypes: [ Player.Balanced, Player.Balanced, Player.Cautious ]

    for i in [ 1 .. 100 ]
      master.play 21, (tie, winner, players) ->
        scoreA = players[0].getScore()
        scoreB = players[1].getScore()

        # Determine consistency of winner
        if not tie
          winner.should.be.an.instanceof(Player)
          winner.should.equal(players[0])

        if scoreA == scoreB
          # It's a tie
          tie.should.be.true
        else if scoreA > 21 and scoreB > 21
          # Both players lose, it's a tie
          tie.should.be.true
        else if scoreB > 21
          # Player A wins by default
          tie.should.be.false
        else if scoreA > scoreB
          # Player A wins by comparison
          tie.should.be.false
        else
          # This case is not supposed to happen, because A always wins
          true.should.be.false
