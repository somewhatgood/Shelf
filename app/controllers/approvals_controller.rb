#encoding:utf-8
class ApprovalsController < ApplicationController
  def create
  	# params["approval"]["bookset_id"] 承認対象のブックセットID = はじめにオファーを出した方
  	# params["approval"]["bookset_pair_id"] 承認したブックセット　= はじめのオファーを受け入れた方
  	
  	#どちらのブックセットもApproval.bookset_idに登録する。キーを逆にして、ペアで登録する。
  	@approval = Approval.new(params["approval"])
  	@approval_pair = Approval.new(
  			:bookset_id => params["approval"]["bookset_pair_id"],
  			:bookset_pair_id => params["approval"]["bookset_id"] 
  	)
  	
  	#TODO saveする前に、対象のブックセットにapproval_flagがたっていないことを確認する必要あり
  	if @approval.save && @approval_pair.save
  		
  		#交換が成立した双方のブックセットにapproval_flagをたてる
  		@bookset = Bookset.find(params["approval"]["bookset_id"]) #オファー元
  		@bookset_approved = Bookset.find(params["approval"]["bookset_pair_id"]) #オファー先
  		
  		@bookset.approval_flag = 1
  		@bookset_approved.approval_flag = 1
  		
  		@bookset.save
  		@bookset_approved.save
  		
  		#Offerテーブルから双方のブックセットを削除する
  		#オファー元も、オファー先も、Offerテーブルには存在できない
  		Offer.delete_all(:bookset_id => params["approval"]["bookset_pair_id"])	
  		Offer.delete_all(:bookset_id => params["approval"]["bookset_id"])
  		
  		redirect_to :root, :notice => "オファーを受け入れました。交換成立です。"
  		
  	end
  end

  def new
  end

end
