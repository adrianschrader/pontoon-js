Dice = require "./Dice.coffee"

module.exports = class GameMaster
  constructor: (options) ->
    # Organize constructor options in private variables
    { diceFaces = 6, playerLabel = "Player", playerTypes = [], @players = [], @dice = new Dice diceFaces } = options

    # Create all players from their ClassTypes with a unique name
    for type in playerTypes
      playerName = playerLabel + ( @players.length + 1 )
      @players.push new type(playerName)

  getPlayers: () ->
    return @players

  getDice: () ->
    return @dice

  play: (goal, callback = -> ) ->
    # Let each player play his turn with the same dice
    for player in @players
      player.resetScore()
      player.play(goal, @dice)


    this.sortPlayersByScore(goal)

    # Decide if there is a tie between the leading players
    tie = @players[0].getScore() == @players[1].getScore() or @players[0].getScore() > goal

    # Give back the results
    result =
      tie: tie
      winner: @players[0]
      runnerup: @players[1]
      players: @players
      goal: goal
      faces: @dice.getFaces()

    for player in @players
      player.addResult(result)

    callback(tie, result.winner, @players)
    return result

  getTotalWinner: ->
    this.sortPlayersByPoints()

    return @players[0]

  sortPlayersByScore: (goal) ->
    @players.sort (a, b) ->
      scoreA = a.getScore()
      scoreB = b.getScore()
      negA = goal < scoreA # If A is too high
      negB = goal < scoreB # If B is too high

      if negA or negB
        return negA and not negB ? -1 : negA and negB ? 0 : 1

      return scoreA < scoreB ? 1 : scoreA > scoreB ? -1 : 0

  sortPlayersByPoints: ->
    @players.sort (a, b) ->
      return a.getPoints() < b.getPoints() ? 1 : a.getPoints() > b.getPoints() ? -1 : 0
