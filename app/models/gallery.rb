class Gallery < ActiveRecord::Base
  belongs_to :post
  has_many :images, dependent: :destroy

  validates :title, presence: true

  accepts_nested_attributes_for :images, reject_if: proc { |attributes| attributes[:image].blank? }

end
