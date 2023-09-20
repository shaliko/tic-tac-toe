import { module, test } from 'qunit';
import { setupRenderingTest } from 'tictactoe/tests/helpers';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | share-url', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });

    await render(hbs`<ShareUrl />`);

    assert.dom().hasText('');

    // Template block usage:
    await render(hbs`
      <ShareUrl>
        template block text
      </ShareUrl>
    `);

    assert.dom().hasText('template block text');
  });
});
