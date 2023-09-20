import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class GameBoardComponent extends Component {
  get isMyTurn() {
    const { game, currentPlayerToken } = this.args;

    const currentUserSymbol = game.player1_token === currentPlayerToken ? game.player1_symbol : game.player2_symbol;

    return currentUserSymbol === game.current_symbol;
  }

  get board() {
    return this.args.game.state;
  }

  @action
  handleMove(rowIndex, columnIndex) {
    if (this.args.onMove) {
      this.args.onMove(rowIndex, columnIndex);
    }
  }
}
