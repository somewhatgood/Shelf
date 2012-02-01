# coding:utf-8
class Omniuser < ActiveRecord::Base
	has_one :user
	has_many :applies
	
	 # twitter / facebookに接続後、omniuser.provider, omniuser.uidがなかったときに呼ばれるクラスメソッド
   def self.create_with_omniauth(auth)
   	
	    create!do |omniuser|
		      omniuser.provider = auth["provider"]
		      omniuser.uid = auth["uid"]
		      omniuser.image = auth["info"]["image"]
		 
		      if omniuser.provider == "facebook"
		         omniuser.name = auth["info"]["name"]
		      else
		         omniuser.name = auth["info"]["nickname"]
		      end
	    
	    end
	    
   end
  
end
