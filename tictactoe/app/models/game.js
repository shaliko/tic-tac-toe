import Model, { attr } from '@ember-data/model';

export default class GameModel extends Model {
  @attr state;
  @attr('string') current_symbol;
  @attr('string') player1_token;
  @attr('string') player2_token;
  @attr('string') player1_symbol;
  @attr('string') player2_symbol;
  @attr('string') winner;
}
