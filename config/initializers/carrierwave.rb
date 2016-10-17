CarrierWave.configure do |config|
config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
    region: 'ap-northeast-1'
  }
  # config.cache_storage = :fog
    case Rails.env
    when 'development'
        config.fog_directory  = 'tech-book'
        config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/tech-book'
    when 'production'
        config.fog_directory  = 'tech-book'
        config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/tech-book'
    end
end