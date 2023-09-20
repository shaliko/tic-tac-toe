import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class GameBoardComponent extends Component {
  @action
  handleMove(rowIndex, columnIndex) {
    if (this.args.onMove) {
      this.args.onMove(rowIndex, columnIndex);
    }
  }
}
