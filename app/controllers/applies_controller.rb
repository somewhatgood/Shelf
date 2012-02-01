# coding:utf-8
class AppliesController < ApplicationController

	
  def new
  	@apply = Apply.new  	
  	@apply.bookset_id = params["bookset"]
  	@apply.omniuser_id = current_omniuser ? current_omniuser.id : current_user.omniuser.id
  	#raise @apply.to_yaml
  end
  
  def create
  		#raise params.to_yaml
  		@apply = Apply.new(params[:apply])
  		
  		if @apply.save
  			#ToDo セーブする前に、対象のBooksetが取引可能かをチェックする
  			redirect_to :root, notice: "申請成功です"
  		else
  			ridirect_to :root, notice: "申請に失敗しました。すでに他の人と交換が成立したようです。"
  		end
  end

  def destroy
  end

end
