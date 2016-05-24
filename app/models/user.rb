class User < ActiveRecord::Base

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.provider         = auth.provider 
	    user.uid              = auth.uid
	    user.name             = auth.info.name
	    user.oauth_token      = auth.credentials.token #"EAACEdEose0cBADeAI3pbbXgb5md6nJciItCYNZBvdREgy5HahVWAIJ8rBD5K9D8NnZADZAz1j9ua7LmTOOhdNeLJvUV4TXwNGvV1rBmlXoRK0UYRYZBMlZADvDoXxo4SbiqAxbRwa0Tf3avxPwTayNZCD9XdqW3jlvppCOEcNfRQZDZD" 
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.save
	  end
	end

	def facebook
		@facebook ||= Koala::Facebook::API.new(oauth_token)
	end

	def friends_count
		facebook.get_connection("me", "invitable_friends").size
	end

	def backstabbers 
		@homework_copier = facebook.get_connection("me", "invitable_friends")[5]
		@love_thief = facebook.get_connection("me", "invitable_friends")[6]
		@family_killer = facebook.get_connection("me", "invitable_friends")[7]
		@secret_sharer = facebook.get_connection("me", "invitable_friends")[8]
	end
end