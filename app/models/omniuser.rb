# coding:utf-8
class Omniuser < ActiveRecord::Base
	
   def self.create_with_omniauth(auth)
    create!do |omniuser|
      omniuser.provider = auth["provider"]
      omniuser.uid = auth["uid"]
 
      if omniuser.provider == "facebook"
         omniuser.name = auth["info"]["name"]
      else
         omniuser.name = auth["info"]["nickname"]
      end
 
    end
  end
  
end
