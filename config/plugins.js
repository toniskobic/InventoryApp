'use strict';

module.exports = ({ env }) => ({
  /*
  email: {
    config: {
      provider: 'sendgrid',
      providerOptions: {
        apiKey: env('***REMOVED***'),
        //***REMOVED***
        //
      },
      settings: {
        defaultFrom: '***REMOVED***',
        defaultReplyTo: '***REMOVED***',
      },
    },
  },
*/
  email: {
    config: {
      provider: 'nodemailer',
      providerOptions: {
        host: env('SMTP_HOST', ''),
        port: env('SMTP_PORT', 0),
        auth: {
          user: env(''),
          pass: env(''),
        },
        // ... any custom nodemailer options
      },
      settings: {
        defaultFrom: '',
        defaultReplyTo: '',
      },
    },
  },
  // ...
});