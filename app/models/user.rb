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
		  "You scored a 5 out of 5! Over the course of an average day, your animal consumption uses #{analitics[0][0]} liters of Water and #{analitics[0][1]} grams of Carbon Dioxide"
		when 3..5
		  "You scored a 4 out of 5! Over the course of an average day, your animal consumption uses #{analitics[1][0]} liters of Water and #{analitics[1][1]} grams of Carbon Dioxide"
		when 5..6
		  "You scored a 3 out of 5! Over the course of an average day, your animal consumption uses #{analitics[2][0]} liters of Water and #{analitics[2][1]} grams of Carbon Dioxide"
		when 6..7
		  "You scored a 2 out of 5! Over the course of an average day, your animal consumption uses #{analitics[3][0]} liters of Water and #{analitics[3][1]} grams of Carbon Dioxide"
		when 7..8
		  "You scored a 1 out of 5! Over the course of an average day, your animal consumption uses #{analitics[4][0]} liters of Water and #{analitics[4][1]} grams of Carbon Dioxide"
		else
		  'Sorry we are not able to calculate your score!'
		end
  end


end
