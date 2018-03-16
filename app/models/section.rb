class Section < ActiveRecord::Base
  belongs_to :post



  	def self.matching_title_or_content search
  		where("title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")
  	end

  
end


