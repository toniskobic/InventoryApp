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
        host: env('SMTP_HOST', '***REMOVED***'),
        port: env('SMTP_PORT', 587),
        auth: {
          user: env('***REMOVED***'),
          pass: env('***REMOVED***'),
        },
        // ... any custom nodemailer options
      },
      settings: {
        defaultFrom: '***REMOVED***',
        defaultReplyTo: '***REMOVED***',
      },
    },
  },
  // ...
});