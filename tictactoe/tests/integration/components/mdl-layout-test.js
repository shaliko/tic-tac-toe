import { module, test } from 'qunit';
import { setupRenderingTest } from 'tictactoe/tests/helpers';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | mdl-layout', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });

    await render(hbs`<MdlLayout />`);

    assert.dom().hasText('');

    // Template block usage:
    await render(hbs`
      <MdlLayout>
        template block text
      </MdlLayout>
    `);

    assert.dom().hasText('template block text');
  });
});
