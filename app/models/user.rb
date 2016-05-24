class User < ActiveRecord::Base

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.provider         = auth.provider 
	    user.uid              = auth.uid
	    user.name             = auth.info.name
	    user.oauth_token      = "EAACEdEose0cBADeAI3pbbXgb5md6nJciItCYNZBvdREgy5HahVWAIJ8rBD5K9D8NnZADZAz1j9ua7LmTOOhdNeLJvUV4TXwNGvV1rBmlXoRK0UYRYZBMlZADvDoXxo4SbiqAxbRwa0Tf3avxPwTayNZCD9XdqW3jlvppCOEcNfRQZDZD" #auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.save
	  end
	end

	def facebook
		@facebook ||= Koala::Facebook::API.new(oauth_token)
	end

	def friends_count
		facebook.get_connection("me", "friends").size
	end
end