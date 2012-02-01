#coding:utf-8
class BooksetsController < ApplicationController
	before_filter :check_login, :check_omniuser_id
  before_filter :check_applied, :only => 'edit'
	
	
	#ログインしていなければ、ログインページへリダイレクト
	def check_login
			unless current_omniuser || current_user
				redirect_to :new_user_session
			end
	end

	def check_omniuser_id #自身のブックセット以外へのアクセスはルートへリダイレクトする（直接 /booksets/:id を叩かれた場合への対処）
				if params["id"]
						bookowner = Bookset.find(params["id"]) #まずURLパラメータの:idからアクセスされたリソースの情報を取得
						 
						 if current_omniuser #もしオムニでログインしているなら
							 unless bookowner.omniuser_id == current_omniuser.id #本の所有者とログインユーザのIDが一致しない限りリダイレクト
								 redirect_to :root
							 end
						elsif current_user #もしDEVISEでログインしているなら
							 unless bookowner.omniuser_id == current_user.omniuser_id #本の所有者とログインユーザのIDが一致しない限りリダイレクト
							 		redirect_to :root
							 end
						end
				end
	end
	
	#そのBooksetが他のユーザから申請(apply)済みでないかをチェック
	def check_applied
		#raise params.to_yaml
		#editだからparamsにidが来ているはず
		bookset = Bookset.find(params['id'])
    if bookset.applies.exists?
    	render :text => "このBooksetは交換申請されているため変更できません"
    end
	end
	
	
  # GET /booksets
  # GET /booksets.json
  def index
  	
  	if current_omniuser #omniuserでログインしているなら
  		  #raise current_omniuser.to_yaml
    		@booksets = Bookset.find_all_by_omniuser_id(current_omniuser.id)
		elsif current_user #Deviseでログインしているなら
				#raise current_user.inspect
				@booksets = Bookset.find_all_by_omniuser_id(current_user.omniuser.id)
		end
			
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @booksets }
    end
  end

  # GET /booksets/1
  # GET /booksets/1.json
  def show
    @bookset = Bookset.find(params[:id])
    #raise @bookset.applies.to_yaml
    
    omniusers = []
    @bookset.applies.each do |apply|
    	omniusers.push(apply.omniuser_id) #★@bookset.applies配列の各要素から、omniuser_idを取得。各申請の持ち主を配列に突っ込む。
    end
    
    changeble_booksets = Bookset.find_all_by_omniuser_id(omniusers)
    raise changeble_booksets.to_yaml
    #bookset.appliesメソッドの戻り値は配列であることに注意　eachで回してから、ひとつひとつのプロパティにアクセスする
		

    #@changeble_booksets = Bookset.find_all_by_omniuser_id(omniuser.id)
    #raise @changeble_booksets.to_yaml

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookset }
    end
  end

  # GET /booksets/new
  # GET /booksets/new.json
  def new
    @bookset = Bookset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookset }
    end
  end

  # GET /booksets/1/edit
  def edit
    @bookset = Bookset.find(params[:id])
  end

  # POST /booksets
  # POST /booksets.json
  def create
    @bookset = Bookset.new(params[:bookset])
    
    respond_to do |format|
      if @bookset.save
        format.html { redirect_to @bookset, notice: 'Bookset was successfully created.' }
        format.json { render json: @bookset, status: :created, location: @bookset }
      else
        format.html { render action: "new" }
        format.json { render json: @bookset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /booksets/1
  # PUT /booksets/1.json
  def update
    @bookset = Bookset.find(params[:id])

    respond_to do |format|
      if @bookset.update_attributes(params[:bookset])
        format.html { redirect_to @bookset, notice: 'Bookset was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bookset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /booksets/1
  # DELETE /booksets/1.json
  def destroy
    @bookset = Bookset.find(params[:id])
    @bookset.destroy

    respond_to do |format|
      format.html { redirect_to booksets_url }
      format.json { head :ok }
    end
  end
end
