module Admin::PostsHelper
	def nested_posts(posts)
		posts.map do |post, sub_posts|
			render(post) + content_tag(:div, nested_posts(sub_posts), :class => "nested-posts")
		end.join.html_safe
	end


	def filter_types
	filter_types = [
	  ["Velg type", 0],
	  ["1 - Artikkel", 1],
	  ["2 - Linker", 2],
	  ["3 - Video", 3],
	]
	end

end
