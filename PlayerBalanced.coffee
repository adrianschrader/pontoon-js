Player = require "./Player.coffee"

# Class "Balanced Player"
# This class implements a game strategy. The player will throw so long, that he
# has a chance of
module.exports = class PlayerBalanced extends Player
  constructor: (@name, @scaling = 1) ->
    super @name

  play: (goal, dice) ->
    this.throwDice dice

    # Throw it again, when the current score is lower then half of the mean of
    # the dice. With a scaling factor of one half, this means the player will
    # lose in 50% of cases, but has a good  chance of winning for the remaining
    # 50%.
    if this.getScore() + ( dice.getMeanValue() * @scaling ) <= goal
      this.play goal, dice
