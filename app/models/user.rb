class User < ApplicationRecord

  has_many :answers

  def get_answers
		return self.answers.first.attributes.slice('answer_one', 'answer_two').values 
  end

end
