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

  start_survery(postback)
  # if @user.answers.first.status == false 
  #   start_survery(postback)
  # else 
  #   postback.reply( text: 'Looks like we already have your data, we will be in touch soon!') 
  # end 
end 


def start_survery postback

  set_answer(@user)
  # now have access to @answer

  answer = postback.payload

  case answer
  when "START"
    puts 'start'
    puts 'Ask first question'
    ask_first_question(postback)
  when "EXIT"
    exit(postback)
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
  # when "MEAT_THREE"
  #   @answer.update_attributes(meat_per_week: 3)
  #   @answer.save
  #   puts 'answer meat three, save the data to user table'
  #   puts 'Ask second question'
  #   ask_second_question(postback)
  # when "MEAT_FOUR"
  #   @answer.update_attributes(meat_per_week: 4)
  #   @answer.save
  #   puts 'answer meat four, save the data to user table'
  #   puts 'Ask second question'
  #   ask_second_question(postback)

    # DONE WITH MEAT #############################
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
  # when "DAIRY_THREE"
  #   @answer.update_attributes(dairy_per_week: 3)
  #   @answer.save
  #   puts 'answer dairy three, save the data to user table'
  #   puts 'Ask third question'
  #   ask_third_question(postback)
  # when "DAIRY_FOUR"
  #   @answer.update_attributes(dairy_per_week: 4)
  #   @answer.save
  #   puts 'answer dairy four, save the data to user table'
  #   puts 'Ask third question'
  #   ask_third_question(postback)

    # DONE WITH DAIRY #############################
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
    puts 'Ask fifth question'
    ask_fifth_question(postback)
  when "LOCAL_NO"
    @answer.update_attributes(local: false)
    @answer.save
    puts 'answer LOCAL NO, save the data to user table'
    puts 'Ask fifth question'
    ask_fifth_question(postback)
  when "DETAILS"
    @answer.update_attributes(status: true)
    @answer.save
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
          { type: 'postback', title: '0-5 servings', payload: 'MEAT_ONE' },
          { type: 'postback', title: '5-10 servings', payload: 'MEAT_TWO' }
          # { type: 'postback', title: '10-15 servings', payload: 'MEAT_THREE' },
          # { type: 'postback', title: 'More than 15 servings', payload: 'MEAT_FOUR' }
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
          { type: 'postback', title: '0-5 servings', payload: 'DAIRY_ONE' },
          { type: 'postback', title: '5-10 servings (about one per day)', payload: 'DAIRY_TWO' },
          # { type: 'postback', title: '10-15 servings (about two per day)', payload: 'DAIRY_THREE' },
          # { type: 'postback', title: 'More than 15 servings', payload: 'DAIRY_FOUR' }
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

def exit postback
  postback.reply( text: 'No problem ;)! You can change your mind at any time') 
end

def finish_survey postback
  postback.reply( text: 'Check out http://www.vegaroo.co for more information', image: 'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735') 
end

## CREATE/GET USER CORE
def get_user messenger_id
  puts "i got to get user method"
  @user = User.where(messenger_id: messenger_id).first
  # If user does not exist, create new
  create_new_user(messenger_id) unless @user
end

def set_answer user
  puts 'i got to set_answer method'
  user_id = user.id
  @answer = Answer.where(user_id: user_id).first

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


