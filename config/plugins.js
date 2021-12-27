'use strict';

module.exports = ({ env }) => ({
    upload: {
      provider: 'azure-storage',
      providerOptions: {
        account: env('STORAGE_ACCOUNT'),
        accountKey: env('STORAGE_ACCOUNT_KEY'),
        containerName: env('STORAGE_CONTAINER_NAME'),
        defaultPath: 'assets',
        maxConcurrent: 10
      }
    },

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
  });



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
