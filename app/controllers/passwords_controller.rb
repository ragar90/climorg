class PasswordsController < Devise::PasswordsController
	before_action :load_layout, only: [:edit]
	private
	def load_layout
		render layout: false
	end
end
