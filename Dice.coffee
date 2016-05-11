module.exports = class Dice
  constructor: (@faces = 6) ->

  roll: () ->
    return Math.floor(Math.random() * @faces) + 1

  getFaces: () ->
    return @faces

  getMeanValue: () ->
    return 0.5 + ( @faces / 2.0 )

  getOutcomes: () ->
    return [ 1 .. @faces ];
