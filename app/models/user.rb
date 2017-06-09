class User < ActiveRecord::Base

	def self.from_omniauth(auth)
  	where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.name = auth.info.name
	    user.oauth_token = auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at) unless auth.credentials.expires_at.nil?
	    user.save!
  	end
	end

	def facebook
		@facebook ||= Koala::Facebook::API.new(oauth_token)
	end

	def friends_count
		facebook.get_connection("me", "invitable_friends").size
	end

	def homework_copier
		facebook.get_connection("me", "invitable_friends")[5]["name"]
	end

	def love_thief
		facebook.get_connection("me", "invitable_friends")[6]["name"]
	end

	def family_killer
		facebook.get_connection("me", "invitable_friends")[7]["name"]
	end

	def secret_sharer
		facebook.get_connection("me", "invitable_friends")[8]["name"]
	end

	def homework_copier_image
		facebook.get_connection("me", "invitable_friends")[5]["picture"]["data"]["url"]
	end

	def love_thief_image
		facebook.get_connection("me", "invitable_friends")[6]["picture"]["data"]["url"]
	end

	def family_killer_image
		facebook.get_connection("me", "invitable_friends")[7]["picture"]["data"]["url"]
	end

	def secret_sharer_image
		facebook.get_connection("me", "invitable_friends")[8]["picture"]["data"]["url"]
	end
end