require 'facebook/messenger'

include Facebook::Messenger


Bot.on :message do |message|
  puts "in the message"
  messenger_id = message.sender['id']
  get_user(messenger_id)

  puts " ----- "
  puts @user
end

Bot.on :postback do |postback|
  messenger_id = postback.sender['id']
  get_user(messenger_id)
  
  start_survery(postback)
end 


def start_survery postback

  set_answer(@user)
  # now have access to @answer
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
  when "MEAT_ONE"
    @answer.update_attributes(meat_per_week: 1)
    @answer.save
    puts 'answer meat one, save the data to user table'
    puts 'Ask second question'
    ask_second_question(postback)
  when "MEAT_TWO"
    @answer.update_attributes(meat_per_week: 2)
    @answer.save
    puts 'answer meat two, save the data to user table'
    puts 'Ask second question'
    ask_second_question(postback)
  when "MEAT_THREE"
    @answer.update_attributes(meat_per_week: 3)
    @answer.save
    puts 'answer meat three, save the data to user table'
    puts 'Ask second question'
    ask_second_question(postback)
  when "DAIRY_ONE"
    @answer.update_attributes(dairy_per_week: 1)
    @answer.save
    puts 'answer dairy one, save the data to user table'
    puts 'Ask third question'
    ask_third_question(postback)
  when "DAIRY_TWO"
    @answer.update_attributes(dairy_per_week: 2)
    @answer.save
    puts 'answer dairy two, save the data to user table'
    puts 'Ask third question'
    ask_third_question(postback)
  when "DAIRY_THREE"
    @answer.update_attributes(dairy_per_week: 3)
    @answer.save
    puts 'answer dairy three, save the data to user table'
    puts 'Ask third question'
    ask_third_question(postback)
  when "ORGANIC_YES"
    @answer.update_attributes(organic: true)
    @answer.save
    puts 'answer organic YES, save the data to user table'
    puts 'Ask fourth question'
    ask_fourth_question(postback)
  when "ORGANIC_NO"
    @answer.update_attributes(organic: false)
    @answer.save
    puts 'answer organic NO, save the data to user table'
    puts 'Ask fourth question'
    ask_fourth_question(postback)
  when "LOCAL_YES"
    @answer.update_attributes(local: true)
    puts 'answer LOCAL YES, save the data to user table'
    puts 'Show result after survey'
    show_result(postback, @user)
  when "LOCAL_NO"
    @answer.update_attributes(local: false)
    @answer.save
    puts 'answer LOCAL NO, save the data to user table'
    puts 'Show result after survey'
    show_result(postback, @user)
  when "DETAILS_YES"
    @answer.update_attributes(cta: true)
    @answer.update_attributes(status: true)
    @answer.save
    puts 'answer DETAILS_YES, save the data to answer table, column CTA'
    puts 'FINISH'
    finish_survey_positive(postback)
  when "DETAILS_NO"
    @answer.update_attributes(cta: false)
    @answer.update_attributes(status: true)
    @answer.save
    puts 'answer DETAILS_NO, save the data to answer table, column CTA'
    puts 'FINISH'
    finish_survey_negative(postback)
  else
    puts "SORRY WE SCREWED UP!! We are going to squash this bug and get back to you"
  end
end

def ask_zeroth_question postback 
  postback.reply(
    attachment: {
      type: 'template',
      payload: {
        template_type: 'button',
        text: 'Welcome! Vegaroo calculates the impact of your food choices and makes it easier to make a positive impact on the environment. To kick things off, we are going to ask you a few questions to learn more about you. Ready to get started?',
        buttons: [
          { type: 'postback', title: 'Lets go!', payload: 'START' },
          { type: 'postback', title: 'Sorry, nah', payload: 'EXIT' }
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
        text: 'How many servings of meat did you in the last week? A serving of meat is about the size of a deck of cards',
        buttons: [
          { type: 'postback', title: '0-5 servings', payload: 'MEAT_ONE' },
          { type: 'postback', title: '5-10 servings', payload: 'MEAT_TWO' },
          { type: 'postback', title: '10-15 servings', payload: 'MEAT_THREE' }
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
        text: 'How many servings of dairy did you eat last week? A serving of dairy is one egg, 1/2 cup of milk, or a slice of cheese',
        buttons: [
          { type: 'postback', title: '0-5 servings', payload: 'DAIRY_ONE' },
          { type: 'postback', title: '5-10 servings', payload: 'DAIRY_TWO' },
          { type: 'postback', title: '10-15 servings', payload: 'DAIRY_THREE' }
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
        text: 'Do you eat organic or biological meat and dairy products?',
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
        text: 'Do you eat local meat and dairy products? Local food is from within a 150 kilometer radius.',
        buttons: [
          { type: 'postback', title: 'Yes', payload: 'LOCAL_YES' },
          { type: 'postback', title: 'No', payload: 'LOCAL_NO' }
        ]
      }
    }
  ) 
end

def show_result postback, user
  #Get sesult from User model
  surname = user.first_name 
  result = user.get_range
  postback.reply(text: "Ok #{surname}, I'm calculating your impact..") 
  postback.reply(text: "#{result}") 
  postback.reply( 
    attachment: {
      type: 'template',
      payload: {
        template_type: 'button',
        text: 'Are you interested in learning more about your impact?',
        # to do just get the answer reply as a string
        buttons: [
          { type: 'postback', title: 'Yes', payload: 'DETAILS_YES' },
          { type: 'postback', title: 'No', payload: 'DETAILS_NO' }
        ]
      }
    }
  ) 
end

def exit_survey postback
    postback.reply( 
    attachment: {
      type: 'image',
      payload: {
        url: 'http://s2.quickmeme.com/img/ee/ee71aaef710f28451bb40f142ce53d35ce50405caafdfdb53e73417fc2619af3.jpg'
      }
    }
  ) 
end

def finish_survey_positive postback
  postback.reply( text: 'Great, thanks for sharing! We will be in touch soon. In the meantime, check out http://www.vegaroo.co for more information.') 
end

def finish_survey_negative postback
  postback.reply( text: 'Thats ok! If you change your mind, you can come back at anytime or check out http://www.vegaroo.co for more information.') 
end

## CREATE/GET USER CORE
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

def api_call(url)
  require 'json'
  require 'open-uri'
  user_data = JSON.parse(open(url).read)
end


