module ApplicationHelper

	def status_converter(status, truthy: 'Active', falsey: 'Pending')
		if status
			truthy
		else
			falsey
		end
	end

	def time_ago time
		"#{time_ago_in_words(time)} ago"
	end

	def double_digit_number n 
		'%02d' % n
	end

	def selection_type_icon stype
		case stype
		when 1
		  "<i class='fa fa-question'></i>"
		when 2
		   "<i class='fa fa-link'></i>"
		when 3
			 "<i class='fa fa-film'></i>"
		else
		    "<i class='fa fa-arrow-right'></i>"
		end
	end

end


  