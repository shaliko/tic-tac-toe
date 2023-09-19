import Controller from '@ember/controller';
import { action } from '@ember/object';
import { service } from '@ember/service';

export default class ApplicationController extends Controller {
  @service store;
  @service router;

  @action
  async createGame() {
    try {
      let newGame = this.store.createRecord('game', {});

      const game = await newGame.save();

      this.router.transitionTo('games.token', game.id, game.player1_token);
    } catch (error) {
      // TODO: Better error handling
      alert(error);
    }
  }
}
