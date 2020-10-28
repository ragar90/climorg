if Rails.env.development? or Rails.env.production? # Using Amazon S3 for Development and Production
	CarrierWave.configure do |config|
	config.root = Rails.root.join('tmp')
	config.cache_dir = 'uploads'
	config.storage = :fog
	config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV['AWS_ACCESS_KEY'],        # required
    aws_secret_access_key: ENV['AWS_SECRET_KEY'],        # required
	}
	config.fog_directory = 'climorg' # required
	end
end