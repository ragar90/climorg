class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :organizations
  has_many :dimensions
  has_many :demographic_variables
  def menu_bar_label
  	"#{self.name.titleize} #{self.lastname.titleize}" rescue self.email
  end
end
