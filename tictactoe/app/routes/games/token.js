import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class GamesTokenRoute extends Route {
  @service store;

  timer;

  activate() {
    this.timer = setInterval(() => {
      const { game_id } = this.paramsFor(this.routeName);

      this.store.findRecord('game', game_id, { reload: true });
    }, 2000);
  }

  deactivate() {
    clearInterval(this.timer);
  }

  async model(params) {
    let gameId = params.game_id;
    let token = params.token;

    let game = await this.store.findRecord('game', gameId);

    return { game, token };
  }
}
