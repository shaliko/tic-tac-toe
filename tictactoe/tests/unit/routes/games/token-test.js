import { module, test } from 'qunit';
import { setupTest } from 'tictactoe/tests/helpers';

module('Unit | Route | games/token', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    let route = this.owner.lookup('route:games/token');
    assert.ok(route);
  });
});
