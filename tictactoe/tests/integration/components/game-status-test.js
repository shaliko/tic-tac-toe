import { module, test } from 'qunit';
import { setupRenderingTest } from 'tictactoe/tests/helpers';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | game-status', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });

    await render(hbs`<GameStatus />`);

    assert.dom().hasText('');

    // Template block usage:
    await render(hbs`
      <GameStatus>
        template block text
      </GameStatus>
    `);

    assert.dom().hasText('template block text');
  });
});
