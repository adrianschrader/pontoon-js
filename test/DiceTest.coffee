chai  = require "chai"
Dice  = require "../Dice.coffee"
chai.should()

describe 'Dice', ->

  it 'should give the number of faces', ->
    dice = new Dice 12
    dice.getFaces().should.equal 12

  it 'should give the arithmetic mean', ->
    dice = new Dice 12
    dice.getMeanValue().should.equal 6.5

  it 'should produce random numbers', ->
    dice = new Dice 12
    mean = dice.getMeanValue()
    sum = 0
    sampleSize = 10000
    uncertainty = 0.1

    for i in [ 1 .. sampleSize]
      sum += dice.roll()

    sampleMean = sum / sampleSize
    sampleMean.should.be.within mean - uncertainty, mean + uncertainty
