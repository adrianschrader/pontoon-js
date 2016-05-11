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
