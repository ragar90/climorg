class RegistrationsController < Devise::RegistrationsController
	before_action :load_layout, only: [:edit]
	private
	def load_layout
		render layout: false
	end
end
