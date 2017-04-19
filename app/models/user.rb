class User < ApplicationRecord

  # has_many :reports

  has_many :answers

  def impact_score
  	#Get answer
  	answer = self.answers.first
  	
  	#get only the values to calc
  	values = self.answers.first.attributes.slice('meat_per_week', 'dairy_per_week', 'organic', 'local').values
  	
  	#Covert Boolean into Integer
  	values.map { |a| !!a == a ? 1 : 0  }
  	#Convert and Sum all the arrays indexs
		values.collect! { |element| (!!element == element) ? (element ? 1 : 0) : element }
		return values.map(&:to_i).inject(:+)
  end

  def get_range
		analitics = [[800,600],[1600,1200],[2400,1800],[3200,2400],[3900,2900]]
		
  	total = impact_score
		case total
		when 0..3
		  "5 out of 5 - in details Water:#{analitics[0][0]}l | Co2:#{analitics[0][1]}g "
		when 3..5
		  "4 out of 5 - in details Water:#{analitics[1][0]}l | Co2:#{analitics[1][1]}g "
		when 5..6
		  "3 out of 5 - in details Water:#{analitics[2][0]}l | Co2:#{analitics[2][1]}g "
		when 6..7
		  "2 out of 5 - in details Water:#{analitics[3][0]}l | Co2:#{analitics[3][1]}g "
		when 7..8
		  "1 out of 5 - in details Water:#{analitics[4][0]}l | Co2:#{analitics[4][1]}g "
		else
		  'Sorry we are not able to calculate your score!'
		end
  end


end
