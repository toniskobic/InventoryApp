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
  });



  /*
  email: {
    config: {
      provider: 'sendgrid',
      providerOptions: {
        apiKey: env(''),
        //
        //
      },
      settings: {
        defaultFrom: '',
        defaultReplyTo: '',
      },
    },
  },
*/
