#coding:utf-8

class OffersController < ApplicationController
	before_filter :has_bookset, :has_address
	before_filter :check_myself, :only => :new


  #raise params["offer"]["bookset_id"] => オファー先のブックセットID
  #@mybooksets => 自身のブックセット一覧 (has_booksetで取得済)
  def new
  	unless params["offer"].nil?
  		@bookset_offered = Bookset.find(params["offer"]["bookset_id"])
  	else
  		@bookset_offered = Bookset.find(flash[:bookset_id]) #Offer#Createから来たときはflashからオファー先のブックセットIDを取得する
  	end
  end



	#params["offer"]["bookset_offering_id"]　　オファー元のブックセットID
  #params["offer"]["bookset_id"] 　オファー先のブックセットID
  def create
		@offer = Offer.new(params["offer"])
		if @offer.save
			redirect_to	:new_offer, :notice => 'オファーを出しました', :flash => {:bookset_id => params["offer"]["bookset_id"] }
		end
  end
  
  
  def has_bookset #自分のbooksetを登録していなければ、相手にOfferする資格がない
  	@mybooksets = Bookset.find_all_by_omniuser_id(current_omniuser ? current_omniuser.id : current_user.omniuser.id)
  	if @mybooksets.empty?
  		 render :text => 'まだBooksetを登録していないようです'
  	end
  end
  
  
  def has_address
  	#住所を登録していなければ、相手にOfferする資格がない
  end
  
  
  #自分のブックセットにはOfferできない
  def check_myself
  	unless params["offer"].nil?
		  	res1 = Bookset.find(params["offer"]["bookset_id"])
		  	res2 = current_omniuser ? current_omniuser.id : current_user.omniuser.id
		  	if res1.omniuser_id == res2
		  		render :text => '自分のBooksetにはオファーできません！'
		  	end
		end
  end


end
