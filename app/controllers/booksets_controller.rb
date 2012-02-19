#coding:utf-8
class BooksetsController < ApplicationController
	before_filter :check_login, :check_omniuser_id
  before_filter :check_offers, :only => 'edit'
	
  # 自分のブックセット一覧を表示する
  def index
  	    uid = current_omniuser ? current_omniuser.id : current_user.omniuser.id #本人のユーザID
    		@booksets = Bookset.find_all_by_omniuser_id(uid) #本人のブックセット一覧
    		@booksets_changing = Bookset.where(:omniuser_id => uid, :approval_flag => 1) #本人のブックセットのうち、成立済みのもの
			
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @booksets }
    end
  end

  # GET /booksets/1
  # GET /booksets/1.json
  def show
  	#当ページの該当ブックセットを取得。
  	#offersでアソシエーションしているので、同じIDを持つものがあればoffersから引っ張ってこれる、つまり当ページの本にオファーした本の一覧がとれる
    @bookset = Bookset.find(params[:id]) 
    
    #オファー元のブックセットを取得する
    offer_from = []
    @bookset.offers.each do |offer|
    	offer_from.push(offer.bookset_offering_id)
    end
    @changeble_booksets = Bookset.find(offer_from) #オファー元ブックセット一覧（つまり交換可能なブックセットのリスト）
    
		#オファー先のブックセットを取得する
		results = Offer.where(:bookset_offering_id => params[:id])
		offer_to = []
		results.each do |res|
			offer_to.push(res.bookset_id)
		end
		@offering_booksets = Bookset.find(offer_to) #オファー先のブックセット一覧（申し込み中のもの）
		
		#取引成立の場合　取引相手のブックセットを取得する（無い場合は後続を処理しない）
		@my_approval_bookset = Approval.where(:bookset_id => params[:id]).first
		if @my_approval_bookset
			@pair_bookset_id = @my_approval_bookset.bookset_pair_id
			@pair_bookset = Bookset.find(@pair_bookset_id)
			#raise @pair_bookset.to_yaml
		end

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

	def check_login #ログインしていなければ、ログインページへリダイレクト
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
	
	def check_offers #そのBooksetが他のユーザから申請(apply)済みでないかをチェック
		#raise params.to_yaml
		#editだからparamsにidが来ているはず
		bookset = Bookset.find(params['id'])
    if bookset.offers.exists?
    	render :text => "このBooksetは交換申請されているため変更できません"
    end
	end