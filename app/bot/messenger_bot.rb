require 'facebook/messenger'

include Facebook::Messenger


Bot.on :message do |message|
  messenger_id = message.sender['id']
  get_user(messenger_id)
end

Bot.on :postback do |postback|
  messenger_id = postback.sender['id']
  get_user(messenger_id)
  execute_survey(postback)
end 


def execute_survey postback
  set_answer(@user)
  answer = postback.payload

  case answer
  when "START_USER_SURVEY"
    puts 'Ask zeroth question'
    ask_zeroth_question(postback)
  when "EXIT"
    exit_survey(postback)
  when "START"
    puts 'Ask first question'
    ask_first_question(postback)
  when "ANSWER_ONE_ONE"
    @answer.update_attributes(answer_one: 1)
    @answer.save
    puts 'answer question one, save the data to user table'
    puts 'Ask second question'
    ask_second_question(postback)
  when "ANSWER_ONE_TWO"
    @answer.update_attributes(answer_one: 2)
    @answer.save
    puts 'answer question one, save the data to user table'
    puts 'Ask second question'
    ask_second_question(postback)
  when "ANSWER_ONE_THREE"
    @answer.update_attributes(answer_one: 3)
    @answer.save
    puts 'answer question one, save the data to user table'
    puts 'Ask second question'
    ask_second_question(postback)
  when "ANSWER_TWO_ONE"
    @answer.update_attributes(answer_two: 1)
    @answer.save
    puts 'answer question two, save the data to user table'
    puts 'Ask third question'
    show_result(postback, @user)
  when "ANSWER_TWO_TWO"
    @answer.update_attributes(answer_two: 2)
    @answer.save
    puts 'answer question two, save the data to user table'
    puts 'Ask third question'
    show_result(postback, @user)
  when "ANSWER_TWO_THREE"
    @answer.update_attributes(answer_two: 3)
    @answer.save
    puts 'answer question two, save the data to user table'
    puts 'Show result'
    show_result(postback, @user)
  else
    puts "Somehow you sent an invalid postback value!"
  end
end

def ask_zeroth_question postback 
  postback.reply(
    attachment: {
      type: 'template',
      payload: {
        template_type: 'button',
        text: 'Ready to get started with the survey?',
        buttons: [
          { type: 'postback', title: 'Lets go!', payload: 'START' },
          { type: 'postback', title: 'No thanks', payload: 'EXIT' }
        ]
      }
    }
  )
end 

def ask_first_question postback
  postback.reply(
    attachment: {
      type: 'template',
      payload: {
        template_type: 'button',
        text: 'This is the first question. It has three buttons to answer from',
        buttons: [
          { type: 'postback', title: 'Button one', payload: 'ANSWER_ONE_ONE' },
          { type: 'postback', title: 'Button two', payload: 'ANSWER_ONE_TWO' },
          { type: 'postback', title: 'Button three', payload: 'ANSWER_ONE_THREE' }
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
        text: 'This is the second question. It works just like the first one ;)',
        buttons: [
          { type: 'postback', title: 'Button one', payload: 'ANSWER_TWO_ONE' },
          { type: 'postback', title: 'Button two', payload: 'ANSWER_TWO_TWO' },
          { type: 'postback', title: 'Button three', payload: 'ANSWER_TWO_THREE' }
        ]
      }
    }
  )
end

def show_result postback, user
  #Get sesult from User model
  surname = user.first_name 
  result = user.get_answers
  postback.reply(text: "Ok #{surname}, Here are your answers to the questions") 
  postback.reply(text: "#{result}") 
end

def exit_survey postback
    # you can also send photos by including a URL in the payload response
    postback.reply( 
    attachment: {
      type: 'image',
      payload: {
        url: 'http://s2.quickmeme.com/img/ee/ee71aaef710f28451bb40f142ce53d35ce50405caafdfdb53e73417fc2619af3.jpg'
      }
    }
  ) 
end

# User Functionality 
def get_user messenger_id
  @user = User.where(messenger_id: messenger_id).first
  # If user does not exist, create new
  create_new_user(messenger_id) unless @user
end

def set_answer user
  user_id = user.id
  @answer = Answer.where(user_id: user_id).first
  # If answer does not exist, create new
  create_new_answer(user_id) unless @answer
end 

def create_new_answer(user_id)
  @answer = Answer.new(user_id: user_id)
  @answer.save
end 

def create_new_user(messenger_id)
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

def api_call(url)
  require 'json'
  require 'open-uri'
  user_data = JSON.parse(open(url).read)
end


