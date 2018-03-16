class Post < ActiveRecord::Base
	has_ancestry
	has_many :tags, through: :post_tags
	has_many :post_tags, dependent: :destroy
	has_many :sections, dependent: :destroy
	has_many :galleries, dependent: :destroy
	has_many :links, dependent: :destroy
	has_many :documents, dependent: :destroy
  	belongs_to :moderator
  	belongs_to :category

  	validates :title, presence: true
  	#validates :content, presence: true #, uniqueness: {case_sensitive: false}
  	#validates :category_id, presence: true

	scope :published, -> { where(publish: true).order(id: :desc) }

	accepts_nested_attributes_for :sections, :allow_destroy => true, reject_if: proc { |attributes| attributes[:title].blank? }
	accepts_nested_attributes_for :galleries, reject_if: proc { |attributes| attributes[:title].blank? }
	accepts_nested_attributes_for :links, reject_if: proc { |attributes| attributes[:title].blank? }
	accepts_nested_attributes_for :documents, reject_if: proc { |attributes| attributes[:title].blank? }

	mount_uploader :image, ImageUploader

  	def self.matching_title_or_content search
  		where("title LIKE ? OR content LIKE ?", "%#{search.downcase}%", "%#{search.downcase}%")
  		#includes(:sections).where("title LIKE ? OR content LIKE ?", "%#{search.downcase}%", "%#{search.downcase}%")
  	end

  	def self.filter_by_tags param_tag
  		includes(:tags).where(publish: true, tags: {name: param_tag}).order(id: :asc)
  	end

end
