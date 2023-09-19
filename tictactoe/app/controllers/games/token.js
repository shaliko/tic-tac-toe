import Controller from '@ember/controller';
// import { action } from '@ember/object';

export default class GamesTokenController extends Controller {
  get game() {
    return this.model.game;
  }

  get token() {
    return this.model.token;
  }
}
