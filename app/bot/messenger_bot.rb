require 'facebook/messenger'

include Facebook::Messenger

Bot.on :message do |message|
  message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
  message.sender      # => { 'id' => '1008372609250235' }
  message.seq         # => 73
  message.sent_at     # => 2016-04-22 21:30:36 +0200
  message.text        # => 'Hello, bot!'
  message.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]

  message.reply(
    attachment: {
      type: 'template',
      payload: {
        template_type: 'button',
        text: 'Ready to get started with vegaroo?',
        buttons: [
          { type: 'postback', title: 'Yes', payload: 'Start_Yes' },
          { type: 'postback', title: 'No', payload: 'Start_No' }
        ]
      }
    }
  )
end

Bot.on :postback do |postback|
  postback.sender    # => { 'id' => '1008372609250235' }
  postback.recipient # => { 'id' => '2015573629214912' }
  postback.sent_at   # => 2016-04-22 21:30:36 +0200
  postback.payload   # => 'EXTERMINATE'

  if postback.payload == 'Affirmative'
    postback.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Servings of meat last week',
          buttons: [
            { type: 'postback', title: '1', payload: 'Meat_One' },
            { type: 'postback', title: '2', payload: 'Meat_Two' }
          ]
        }
      }
    )
  end

  if postback.payload == 'Meat_One' or 'Meat_Two'
    # store data here 
    postback.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Servings of dairy last week',
          buttons: [
            { type: 'postback', title: '1', payload: 'Dairy_One' },
            { type: 'postback', title: '2', payload: 'Dairy_Two' }
          ]
        }
      }
    )
  end 


  if postback.payload == 'Dairy_One' or 'Dairy_Two' 
      postback.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Do you eat organic meat and dairy products?',
          buttons: [
            { type: 'postback', title: 'Yes', payload: 'Organic_Yes' },
            { type: 'postback', title: 'No', payload: 'Organic_No' }
          ]
        }
      }
    )
  end    

  if postback.payload == 'Organic_Yes' or 'Organic_No'
    postback.reply( 
            attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Do you eat local meat and dairy products?',
          buttons: [
            { type: 'postback', title: 'Yes', payload: 'Local_Yes' },
            { type: 'postback', title: 'No', payload: 'Local_No' }
          ]
        }
      }
    ) 
  end 

  if postback.payload == 'Local_Yes' or 'Local_No'
    postback.reply( 
        attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Do you eat local meat and dairy products?',
          buttons: [
            { type: 'postback', title: 'Yes', payload: 'Local_Yes' },
            { type: 'postback', title: 'No', payload: 'Local_No' }
          ]
        }
      }
    ) 
  end
end   
