class User < ApplicationRecord

  has_many :answers

  def impact_score
  	#Get answer
  	answer = self.answers.first
  	
  	#get only the values to calc
  	values = self.answers.first.attributes.slice('meat_per_week', 'dairy_per_week', 'organic', 'local').values
  	#Covert Boolean into Integer
		newValues = calc_val(values)
		
		return newValues.map(&:to_i).inject(:+)
  end

  def get_range
		analitics = [[800,600],[1600,1200],[2400,1800],[3200,2400],[3900,2900]]
		
  	total = impact_score
		case total
		when 0..3
		  "You scored a 5 out of 5! Over the course of an average day, your food accounts for #{analitics[0][0]} liters of Water and #{analitics[0][1]} grams of Carbon Dioxide"
		when 3..5
		  "You scored a 4 out of 5! Over the course of an average day, your food accounts for #{analitics[1][0]} liters of Water and #{analitics[1][1]} grams of Carbon Dioxide"
		when 5..6
		  "You scored a 3 out of 5! Over the course of an average day, your food accounts for #{analitics[2][0]} liters of Water and #{analitics[2][1]} grams of Carbon Dioxide"
		when 6..7
		  "You scored a 2 out of 5! Over the course of an average day, your food accounts for #{analitics[3][0]} liters of Water and #{analitics[3][1]} grams of Carbon Dioxide"
		when 7..8
		  "You scored a 1 out of 5! Over the course of an average day, your food accounts for #{analitics[4][0]} liters of Water and #{analitics[4][1]} grams of Carbon Dioxide"
		else
		  'Sorry we are not able to calculate your score!'
		end
  end

  def calc_val array
  	newValues = []
  	array.each do |val|
			if val.is_a? String
				newValues << val.to_i
			else
				if !val
					newValues << 1
				else
					newValues << 0
				end
			end
		end
		return newValues
  end


end
