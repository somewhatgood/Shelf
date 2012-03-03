#encoding:utf-8
class ApprovalsController < ApplicationController
  def create
  	# params["approval"]["item_id"] 承認対象のブックセットID = はじめにオファーを出した方
  	# params["approval"]["item_pair_id"] 承認したブックセット　= はじめのオファーを受け入れた方
  	
  	#どちらのブックセットもApproval.item_idに登録する。キーを逆にして、ペアで登録する。
  	@approval = Approval.new(params["approval"])
  	@approval_pair = Approval.new(
  			:item_id => params["approval"]["item_pair_id"],
  			:item_pair_id => params["approval"]["item_id"] 
  	)
  	
  	#TODO saveする前に、対象のブックセットにapproval_flagがたっていないことを確認する必要あり
  	if @approval.save && @approval_pair.save
  		
  		#交換が成立した双方のブックセットにapproval_flagをたてる
  		@item = Item.find(params["approval"]["item_id"]) #オファー元
  		@item_approved = Item.find(params["approval"]["item_pair_id"]) #オファー先
  		
  		@item.approval_flag = 1
  		@item_approved.approval_flag = 1
  		
  		@item.save
  		@item_approved.save
  		
  		#Offerテーブルから双方のブックセットを削除する
  		#オファー元も、オファー先も、Offerテーブルには存在できない
  		Offer.delete_all(:item_id => params["approval"]["item_pair_id"])	
  		Offer.delete_all(:item_id => params["approval"]["item_id"])
  		
  		redirect_to :root, :notice => "オファーを受け入れました。交換成立です。"
  		
  	end
  end

  def new
  end

end
