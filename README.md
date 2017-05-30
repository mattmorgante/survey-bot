# Survey Bot

ToDo: 
* Try and run it yourself 
* Make sure methods work 

## Requirements 
* Ruby v 2.3+
* Rails 5.0+
* PostgresQL Database

## QuickStart: 
* Clone the repository 
* Run bundle install to get the facebook-messenger gem 
* Create a facebook page 
* Create a facebook app 
* Download ngrok 
* run ~/downloads/ngrok http 3000 
* visit the ngrok URL and make sure you see the rails welcome aboard message 
* Add configuration for webhooks! Use ngrok https URL, verify as verify token
* In your facebook app, add configuration for messenger 
* Token Generation: link to the page you have created, then copy the page access token to the .env file of this repository (Note: try not to change this, as it will just cause problems)
* restart the rails server 
* Add the HTTPS ngrok url /bot as the callback URL 
* add verify as the verify token 
* check messages, messaging_postbacks, message_reads, message_deliveries 