require "secure_attributes"
ActiveRecord::Base.send(:include, SecureAttributes)
#AdminPermisions.set_available_scopes
#def set_available_scopes
#  controllers = Dir.new("#{Rails.root.to_s}/app/controllers/somthing")
#  @@set_available_scopes =  controllers.collect{|controller| controller.camelize.gsub(".rb","")}
#end