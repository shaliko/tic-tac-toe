import Model, { attr } from '@ember-data/model';

export default class GameModel extends Model {
  @attr state;
  @attr('string') current_symbol;
}
