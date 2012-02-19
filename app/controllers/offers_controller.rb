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
		@bookset_offered = Bookset.find(params["offer"]["bookset_id"])
		@bookset_offering = Bookset.find(params["offer"]["bookset_offering_id"])
		
		# TODO: オファー先のブックセットが取引成立していないことを確認する必要あり
		if @offer.save && @bookset_offered.update_attribute(:offered_flag, 1) && @bookset_offering.update_attribute(:offering_flag, 1)	
			redirect_to	:new_offer, :notice => 'オファーを出しました', :flash => {:bookset_id => params["offer"]["bookset_id"] }
		else
			render :text => '処理に失敗しました。'
		end
  end
  
  
  def has_bookset #オファー可能なbooksetがなければ、相手にOfferする資格がない（成立していないBooksetが１冊は必要）
  	uid = current_omniuser ? current_omniuser.id : current_user.omniuser.id
  	@mybooksets = Bookset.where(:omniuser_id => uid, :approval_flag => 0) #未成立のものだけ
  	if @mybooksets.empty?
  		 render :text => 'オファー可能なブックセットがないようです。こちらから登録してください。'
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
