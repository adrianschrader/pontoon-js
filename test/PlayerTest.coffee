chai = require "chai"
Dice = require "../Dice.coffee"
Player  = require "../Player.coffee"
chai.should()

describe "Player", ->

  it "should say his own name", ->
    player = new Player "George"
    player.getName().should.equal "George"

  it "should roll the dice and return his score", ->
    dice = new Dice 6
    player = new Player "George"

    player.play(21, dice)
    player.getScore().should.be.above(0)

  it "should reset his score", ->
    dice = new Dice 6
    player = new Player "George"

    player.play(21, dice)
    player.resetScore()
    player.getScore().should.equal(0)

  it "should add results to its scoreboard", ->
    player1 = new Player "George"
    player2 = new Player "Joe"

    result1 =
      winner: player1,
      runnerup: player2,
      tie: false,
      goal: 21,
      faces: 6

    result2 =
      winner: player2,
      runnerup: player1,
      tie: true,
      goal: 21,
      faces: 6

    # Player 1 won once (3 points) and draw once (1 point)
    player1.getPoints().should.equal(3 + 1)

    # Player 2 lost once (0 points) and draw once (1 point)
    player2.getPoints().should.equal(0 + 1)

  it "should reset the scoreboard points", ->
    player1 = new Player "George"

    player1.addResult {
      winner: player1,
      tie: false,
    }

    player1.resetScore()
    player1.getScore().should.equal(0)
