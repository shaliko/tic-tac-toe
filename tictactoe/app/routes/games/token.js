import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class GamesTokenRoute extends Route {
  @service store;

  async model(params) {
    let gameId = params.game_id;
    let token = params.token;

    let game = await this.store.findRecord('game', gameId);

    return { game, token };
  }
}
