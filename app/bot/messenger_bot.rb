require 'facebook/messenger'

include Facebook::Messenger


Bot.on :message do |message|
  puts "in the message"
  messenger_id = message.sender['id']
  get_user(messenger_id)

  puts " ----- "
  puts @user
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
  messenger_id = postback.sender['id']
  get_user(messenger_id)

  puts " ----- "
  puts @user
  answer = postback.payload
  case answer
  when "START"
    puts 'start'
    puts 'Ask first question'
    ask_first_question(postback)
  when "EXIT"
    puts 'exit'
  when "MEAT_ONE"
    @user.answers.create!(meat_per_week: 1)
    puts 'answer meat one, save the data to user table'
    puts 'Ask second question'
    ask_second_question(postback)
  when "MEAT_TWO"
    @user.answers.create!(meat_per_week: 2)
    puts 'answer meat two, save the data to user table'
    puts 'Ask second question'
    ask_second_question(postback)
  when "DAIRY_ONE"
    @user.answers.create!(dairy_per_week: 1)
    puts 'answer dairy one, save the data to user table'
    puts 'Ask third question'
    ask_third_question(postback)
  when "DAIRY_TWO"
    @user.answers.create!(dairy_per_week: 2)
    puts 'answer dairy two, save the data to user table'
    puts 'Ask third question'
    ask_third_question(postback)
  when "ORGANIC_YES"
    @user.answers.create!(organic: true)
    puts 'answer organic YES, save the data to user table'
    puts 'Ask fourth question'
    ask_fourth_question(postback)
  when "ORGANIC_NO"
    @user.answers.create!(organic: false)
    puts 'answer organic NO, save the data to user table'
    puts 'Ask fourth question'
    ask_fourth_question(postback)
  when "LOCAL_YES"
    @user.answers.create!(local: true)
    puts 'answer LOCAL YES, save the data to user table'
    puts 'Ask fifth question'
    ask_fifth_question(postback)
  when "LOCAL_NO"
    @user.answers.create!(local: false)
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
            { type: 'postback', title: 'Yes', payload: 'DETAILS' },
            { type: 'postback', title: 'No', payload: 'DETAILS' }
          ]
        }
      }
    ) 
  end

  def finish_survey postback
    postback.reply( 
          text: 'Thanks, we will be in touch soon'
    ) 
  end

  def get_user messenger_id
    puts "i got to get user method"
    @user = User.where(messenger_id: messenger_id).first
    # If user does not exist, create new
    create_new_user(messenger_id) unless @user
  end

  def create_new_user(messenger_id)
    # Create new user object
    @user = User.new(messenger_id: messenger_id)

    # Get user info from Messenger User Profile API
    url = "https://graph.facebook.com/v2.6/#{messenger_id}?fields=first_name,last_name,gender&access_token=#{ENV["ACCESS_TOKEN"]}"
    user_data = api_call(url)

    # Store user's name and gender
    @user.first_name = user_data["first_name"]
    @user.last_name = user_data["last_name"]
    @user.gender = user_data["gender"]
    @user.save
  end

  # Retrieve user informationa from an api
  def api_call(url)
    require 'json'
    require 'open-uri'
    user_data = JSON.parse(open(url).read)
  end


