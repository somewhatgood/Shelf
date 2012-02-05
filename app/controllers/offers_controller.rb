#coding:utf-8

class OffersController < ApplicationController
	before_filter :has_bookset, :has_address


  def new
  	#params["offer"]["bookset_id"] => オファー対象の bookset_id
  	#@mybooksets => 自身のブックセット一覧 (has_booksetで取得済)
  	@bookset_offered = Bookset.find(params["offer"]["bookset_id"])
  end


  def create
  	#params["offer"]["bookset_offering_id"]
  	#params["offer"]["bookset_offered_id"]
  	
		@offer = Offer.new(params["offer"])
		
		if @offer.save
			redirect_to	:root, :notice => 'オファーを出しました'
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

end
