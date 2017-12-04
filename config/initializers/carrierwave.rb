if Rails.env.development? or Rails.env.production?
  
  CarrierWave.configure do |config|
    config.fog_provider = "fog/aws"
    config.fog_credentials = {
      :provider               => 'AWS',                
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY'],
      :aws_secret_access_key  => ENV['AWS_SECRET_KEY'],
      :host                   => ENV['AWS_HOST'],
      :region                 => ENV['AWS_REGION']
    }
    config.fog_directory  = ENV['AWS_S3_BUCKET']                   # required
    config.fog_public     = true                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'} # optional, defaults to {}
  end

end
