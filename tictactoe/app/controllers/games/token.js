import Controller from '@ember/controller';
import { action } from '@ember/object';
import { service } from '@ember/service';

export default class GamesTokenController extends Controller {
  @service store;

  get game() {
    return this.model.game;
  }

  get token() {
    return this.model.token;
  }

  @action
  async handleMove(row, col) {
    // TODO: Move API URL to config
    const response = await fetch(`http://localhost:3000/api/games/${this.game.id}/moves`, {
        method: 'POST',
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          row,
          col,
          player_token: this.token,
        }),
    });
    const data = await response.json();

    this.store.pushPayload(data);
  }
}
