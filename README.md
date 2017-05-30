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
* Subscribe your new page to this webhook! 
* CURL your application to add a getting started button - this action will add a button that sends the payload START_USER_SURVEY. When the user clicks on it, it will trigger the first question from app/bot/messenger_bot.rb
** curl -X POST -H "Content-Type: application/json"thread_state":"new_thread", "call_to_actions":[ { "payload":"START_USER_SURVEY" } ] }' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=YOUR_ACCESS_TOKEN_HERE"