# Class Player
# This class supposed to be an *abstract* to implement diffenent stategies in
# child classes. The method *play() will be overridden* in those cases.

module.exports = class Player

  ## Constructor
  # Every player *must have a name* generated by the GameMaster. The score at
  # the beginning of each turn is zero and can be resettet to that value by the
  # resetScore() method.
  constructor: (@name) ->
    @score = 0

  # Name of the player from the constructor
  getName: ->
    return @name

  # Current score for the player and round. Should be between 1 and 27.
  getScore: ->
    return @score

  # Resets the score to zero. Should only be called by the GameMaster
  resetScore: ->
    @score = 0

  #Throws the dice and increments the score by the result.
  throwDice: (dice) ->
    @score += dice.roll()

  # Is called once every round by the GameMaster. Should be overriden by child
  # classes to implement further game strategy. Only allowed methods in this are
  # throwDice, getScore and inspections of the dice.
  play: (goal, dice) ->
    this.throwDice dice

module.exports.Cautious = require "./PlayerCautious.coffee"
module.exports.Balanced = require "./PlayerBalanced.coffee"
