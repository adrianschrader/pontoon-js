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

    # Sort the players by their score, the winning player should be on position 0. Scores higher than the goal will be disqualified.
    @players.sort (a, b) ->
      scoreA = a.getScore()
      scoreB = b.getScore()
      negA = goal < scoreA # If A is too high
      negB = goal < scoreB # If B is too high

      if negA or negB
        return negA and not negB ? -1 : negA and negB ? 0 : 1

      return scoreA < scoreB ? 1 : scoreA > scoreB ? -1 : 0

    # Decide if there is a tie between the leading players
    tie = @players[0].getScore() == @players[1].getScore() or @players[0].getScore() > goal
    winner = @players[0] if not tie

    # Give back the results
    callback(tie, winner, @players)
    return {
      tie: tie,
      winner: winner
      players: @players
    }
