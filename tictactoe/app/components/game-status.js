import Component from '@glimmer/component';

export default class GameStatusComponent extends Component {
  get nextTurnSymbol() {
    const { game } = this.args;

    return game.current_symbol.toUpperCase();
  }

  get yourSymbol() {
    const { game, currentPlayerToken } = this.args;

    if (game.player1_token === currentPlayerToken) {
      return game.player1_symbol.toUpperCase();
    } else {
      return game.player2_symbol.toUpperCase();
    }
  }

  get showWinner() {
    const { game } = this.args;

    return game.winner !== null;
  }

  get winnerText() {
    const { game } = this.args;

    if (game.winner === '=') {
      return 'Draw!';
    }

    return `Player "${game.winner.toUpperCase()}" wins!`;
  }
}
