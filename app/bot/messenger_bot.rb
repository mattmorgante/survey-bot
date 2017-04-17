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
          { type: 'postback', title: 'Yes', payload: 'START' },
          { type: 'postback', title: 'No', payload: 'EXIT' }
        ]
      }
    }
  )
end

Bot.on :postback do |postback|

  answer = postback.payload
  case answer
  when "START"
    puts 'start'
    puts 'Ask first question'
    ask_first_question(postback)
  when "EXIT"
    puts 'exit'
  when "MEAT_ONE"
    puts 'answer meat one, save the data to user table'
    puts 'Ask second question'
    ask_second_question(postback)
  when "MEAT_TWO"
    puts 'answer meat two, save the data to user table'
    puts 'Ask second question'
    ask_second_question(postback)
  when "DAIRY_ONE"
    puts 'answer dairy one, save the data to user table'
    puts 'Ask third question'
    ask_third_question(postback)
  when "DAIRY_TWO"
    puts 'answer dairy two, save the data to user table'
    puts 'Ask third question'
    ask_third_question(postback)
  when "ORGANIC_YES"
    puts 'answer organic YES, save the data to user table'
    puts 'Ask fourth question'
    ask_fourth_question(postback)
  when "ORGANIC_NO"
    puts 'answer organic NO, save the data to user table'
    puts 'Ask fourth question'
    ask_fourth_question(postback)
  when "LOCAL_YES"
    puts 'answer LOCAL YES, save the data to user table'
    puts 'Ask fifth question'
    ask_fifth_question(postback)
  when "LOCAL_NO"
    puts 'answer LOCAL NO, save the data to user table'
    puts 'Ask fifth question'
    ask_fifth_question(postback)
  when "DETAILS"
    puts 'answer DETAILS, save the data to user table'
    puts 'FINISH'
    finish_survey(postback)
  else
    puts "SORRY WE FUCKED UP!!"
  end

end 
  def ask_first_question postback
    postback.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Servings of meat last week',
          buttons: [
            { type: 'postback', title: '1', payload: 'MEAT_ONE' },
            { type: 'postback', title: '2', payload: 'MEAT_TWO' }
          ]
        }
      }
    )
  end

  def ask_second_question postback
    postback.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Servings of DAIRY last week',
          buttons: [
            { type: 'postback', title: '1', payload: 'DAIRY_ONE' },
            { type: 'postback', title: '2', payload: 'DAIRY_TWO' }
          ]
        }
      }
    )
  end

  def ask_third_question postback
    postback.reply( 
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Do you eat organic meat and dairy products?',
          buttons: [
            { type: 'postback', title: 'Yes', payload: 'ORGANIC_YES' },
            { type: 'postback', title: 'No', payload: 'ORGANIC_NO' }
          ]
        }
      }
    ) 
  end


  def ask_fourth_question postback
    postback.reply( 
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Do you eat local meat and dairy products?',
          buttons: [
            { type: 'postback', title: 'Yes', payload: 'LOCAL_YES' },
            { type: 'postback', title: 'No', payload: 'LOCAL_NO' }
          ]
        }
      }
    ) 
  end

  def ask_fifth_question postback
    postback.reply( 
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Do you want to share anything else with Vegaroo?',
          # to do just get the answer reply as a string
          buttons: [
            { type: 'postback', title: 'Yes', payload: 'LOCAL_YES' },
            { type: 'postback', title: 'No', payload: 'LOCAL_NO' }
          ]
        }
      }
    ) 
  end

  def finish_survey postback
    postback.reply( 
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'DID YOU LOVE IT!???',
          buttons: [
            { type: 'postback', title: 'Yes', payload: 'LOCAL_YES' },
            { type: 'postback', title: 'No', payload: 'LOCAL_NO' }
          ]
        }
      }
    ) 
  end


