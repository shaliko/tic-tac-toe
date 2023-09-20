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

  get showShareUrl() {
    // Only owner of the game can see the share URL
    if (this.token == this.game.player1_token) {
      return true;
    }

    return false;
  }

  get shareUrl() {
    return `http://localhost:4200/games/${this.game.id}/token/${this.game.player2_token}`;
  }

  @action
  async handleMove(row, col) {
    // TODO: Move API URL to config
    const response = await fetch(
      `http://localhost:3000/api/games/${this.game.id}/moves`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          row,
          col,
          player_token: this.token,
        }),
      },
    );
    const data = await response.json();

    this.store.pushPayload(data);
  }
}
