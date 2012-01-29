class AppliesController < ApplicationController
  def new
  	@apply = Apply.new  	
  	@apply.bookset_id = params["bookset"]
  	@apply.omniuser_id = current_omniuser ? current_omniuser.id : current_user.omniuser.id
  	#raise @apply.to_yaml
  end
  
  def create
  		raise params.to_yaml
  end

  def destroy
  end

end
