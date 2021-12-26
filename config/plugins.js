'use strict';

module.exports = ({ env }) => ({
  // ...
  email: {
    config: {
      provider: 'sendgrid',
      providerOptions: {
        apiKey: env('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'),
        //***REMOVED***
        //
      },
      settings: {
        defaultFrom: 'invappstrapi@gmail.com',
        defaultReplyTo: 'invappstrapi@gmail.com',
      },
    },
  },
  // ...
});