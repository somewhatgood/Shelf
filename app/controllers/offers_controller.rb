#coding:utf-8

class OffersController < ApplicationController
	before_filter :has_item, :has_address
	before_filter :check_myself, :only => :new


  #raise params["offer"]["item_id"] => オファー先のブックセットID
  #@myitems => 自身のブックセット一覧 (has_itemで取得済)
  def new
  	#raise params.to_yaml
  	unless params["offer"].nil?
  		@item_offered = Item.find(params["offer"]["item_id"])
  	else
  		@item_offered = Item.find(flash[:item_id]) #Offer#Createから来たときはflashからオファー先のブックセットIDを取得する
  	end
  end



	#params["offer"]["item_offering_id"]　　オファー元のブックセットID
  #params["offer"]["item_id"] 　オファー先のブックセットID
  def create
		@offer = Offer.new(params["offer"])
		@item_offered = Item.find(params["offer"]["item_id"])
		@item_offering = Item.find(params["offer"]["item_offering_id"])
		
		# TODO: オファー先のブックセットが取引成立していないことを確認する必要あり
		if @offer.save && @item_offered.update_attribute(:offered_flag, 1) && @item_offering.update_attribute(:offering_flag, 1)	
			redirect_to	:new_offer, :notice => 'オファーを出しました', :flash => {:item_id => params["offer"]["item_id"] }
		else
			render :text => '処理に失敗しました。'
		end
  end
  
  
  def has_item #オファー可能なアイテムがなければ、相手にオファーする資格がない（成立していないアイテムが１冊は必要）
  	uid = current_omniuser ? current_omniuser.id : current_user.omniuser.id
  	@myitems = Item.where(:omniuser_id => uid, :approval_flag => 0) #未成立のものだけ
  	if @myitems.empty?
  		 render :text => 'オファー可能なアイテムがないようです。こちらから登録してください。'
  	end
  end
  
  
  def has_address
  	#住所を登録していなければ、相手にOfferする資格がない
  end
  
  
  #自分のブックセットにはOfferできない
  def check_myself
  	unless params["offer"].nil?
		  	res1 = Item.find(params["offer"]["item_id"])
		  	res2 = current_omniuser ? current_omniuser.id : current_user.omniuser.id
		  	if res1.omniuser_id == res2
		  		render :text => '自分のアイテムにはオファーできません！'
		  	end
		end
  end


end
