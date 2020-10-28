class Organization < ActiveRecord::Base
	# mount_uploader :logo, OrganizationUploader
	has_many :researches
	belongs_to :country
	belongs_to :user
	validates :name, :presence => true
end
