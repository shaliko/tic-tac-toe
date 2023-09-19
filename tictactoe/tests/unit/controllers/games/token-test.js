import { module, test } from 'qunit';
import { setupTest } from 'tictactoe/tests/helpers';

module('Unit | Controller | games/token', function (hooks) {
  setupTest(hooks);

  // TODO: Replace this with your real tests.
  test('it exists', function (assert) {
    let controller = this.owner.lookup('controller:games/token');
    assert.ok(controller);
  });
});
