'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function (defaults) {
  const app = new EmberApp(defaults, {
    // Add options here
  });

  app.import('node_modules/material-design-lite/dist/material.min.js');
  app.import('node_modules/material-design-lite/dist/material.min.css');

  return app.toTree();
};
