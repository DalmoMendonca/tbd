OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['1601632693481916'], ENV['dcfee4bcf463a9848a1f42a714f622aa']
end