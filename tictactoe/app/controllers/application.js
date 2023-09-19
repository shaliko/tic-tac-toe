import Controller from '@ember/controller';
import { action } from '@ember/object';
import { service } from "@ember/service";

export default class ApplicationController extends Controller {
  @service store;

  @action
  async createGame() {
    try {
      let newGame = this.store.createRecord('game', {});

      const game = await newGame.save();
    } catch (error) {
      // TODO: Better error handling
      alert(error);
    }

    console.log({
      id: game.id,
      current_symbol: game.current_symbol,
      state: game.state,
      player1_token: game.player1_token,
    });
  }
}
