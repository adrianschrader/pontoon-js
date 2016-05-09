module.exports = class Dice
  constructor: (@faces = 6) ->

  roll: ->
    return Math.random() * @faces // 1 + 1

  getFaces: ->
    return @faces

  getMeanValue: ->
    return 0.5 + ( @faces / 2.0 )
