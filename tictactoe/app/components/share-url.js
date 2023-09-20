import Component from '@glimmer/component';
import { action } from '@ember/object';
import { inject as service } from '@ember/service';

export default class ShareUrlComponent extends Component {
  @service clipboard;

  get url() {
    return this.args.url;
  }

  @action
  async copyUrl() {
    try {
      await this.clipboard.copy(this.url);
      alert('URL copied!');
    } catch (e) {
      console.log(this.clipboard);
      alert('Failed to copy URL. Please try again.');
    }
  }
}
