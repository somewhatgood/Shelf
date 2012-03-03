#coding:utf-8
class ItemsController < ApplicationController
	before_filter :check_login, :check_omniuser_id
  before_filter :check_offers, :only => 'edit'
	
  #本人のアイテム一覧を表示する
  def index
  	    uid = current_omniuser ? current_omniuser.id : current_user.omniuser.id #本人のユーザID
    		@items = Item.find_all_by_omniuser_id(uid) #本人のアイテム一覧
    		@items_changing = Item.where(:omniuser_id => uid, :approval_flag => 1) #本人のアイテムのうち成立済みのもの
			
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  #アイテム詳細
  #TODO オファーを取り下げる処理を実装する
  def show
  	#offersでアソシエーションしているので同じIDを持つものがあればoffersから引っ張ってこれる。
  	#つまり当アイテムにオファーした、オファー元アイテムの一覧が取得できる。
    @item = Item.find(params[:id]) 
    
    #オファー元のアイテムを取得する
    offer_from = []
    @item.offers.each do |offer|
    	offer_from.push(offer.item_offering_id)
    end
    @changeble_items = Item.find(offer_from) #オファー元アイテム一覧（つまり交換可能なアイテムのリスト）
    
		#オファー先のアイテムを取得する
		results = Offer.where(:item_offering_id => params[:id])
		offer_to = []
		results.each do |res|
			offer_to.push(res.item_id)
		end
		@offering_items = Item.find(offer_to) #オファー先のアイテム一覧（申し込み中のもの）
		
		#取引成立の場合　取引相手のアイテムを取得する（無い場合は後続を処理しない）
		@my_approval_item = Approval.where(:item_id => params[:id]).first
		if @my_approval_item
			@pair_item_id = @my_approval_item.item_pair_id
			@pair_item = Item.find(@pair_item_id)
			#raise @pair_item.to_yaml
		end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  #アイテム新規作成
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  #アイテム編集
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])
    
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :ok }
    end
  end
end

	def check_login #ログインしていなければ、ログインページへリダイレクト
			unless current_omniuser || current_user
				redirect_to :new_user_session
			end
	end

	def check_omniuser_id #自身のブックセット以外へのアクセスはルートへリダイレクトする（直接 /items/:id を叩かれた場合への対処）
				if params["id"]
						itemowner = Item.find(params["id"]) #まずURLパラメータの:idからアクセスされたリソースの情報を取得
						 
						 if current_omniuser #もしオムニでログインしているなら
							 unless itemowner.omniuser_id == current_omniuser.id #本の所有者とログインユーザのIDが一致しない限りリダイレクト
								 redirect_to :root
							 end
						elsif current_user #もしDEVISEでログインしているなら
							 unless itemowner.omniuser_id == current_user.omniuser_id #本の所有者とログインユーザのIDが一致しない限りリダイレクト
							 		redirect_to :root
							 end
						end
				end
	end
	
	def check_offers #そのアイテムが他のユーザから申請(apply)済みでないかをチェック
		#raise params.to_yaml
		#editだからparamsにidが来ているはず
		item = Item.find(params['id'])
    if item.offers.exists?
    	render :text => "このアイテムは交換申請されているため変更できません"
    end
	end
	
  # # GET /items
  # # GET /items.json
  # def index
    # @items = Item.all
# 
    # respond_to do |format|
      # format.html # index.html.erb
      # format.json { render json: @items }
    # end
  # end
# 
  # # GET /items/1
  # # GET /items/1.json
  # def show
    # @item = Item.find(params[:id])
# 
    # respond_to do |format|
      # format.html # show.html.erb
      # format.json { render json: @item }
    # end
  # end
# 
  # # GET /items/new
  # # GET /items/new.json
  # def new
    # @item = Item.new
# 
    # respond_to do |format|
      # format.html # new.html.erb
      # format.json { render json: @item }
    # end
  # end
# 
  # # GET /items/1/edit
  # def edit
    # @item = Item.find(params[:id])
  # end
# 
  # # POST /items
  # # POST /items.json
  # def create
    # @item = Item.new(params[:item])
# 
    # respond_to do |format|
      # if @item.save
        # format.html { redirect_to @item, notice: 'Item was successfully created.' }
        # format.json { render json: @item, status: :created, location: @item }
      # else
        # format.html { render action: "new" }
        # format.json { render json: @item.errors, status: :unprocessable_entity }
      # end
    # end
  # end
# 
  # # PUT /items/1
  # # PUT /items/1.json
  # def update
    # @item = Item.find(params[:id])
# 
    # respond_to do |format|
      # if @item.update_attributes(params[:item])
        # format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        # format.json { head :ok }
      # else
        # format.html { render action: "edit" }
        # format.json { render json: @item.errors, status: :unprocessable_entity }
      # end
    # end
  # end
# 
  # # DELETE /items/1
  # # DELETE /items/1.json
  # def destroy
    # @item = Item.find(params[:id])
    # @item.destroy
# 
    # respond_to do |format|
      # format.html { redirect_to items_url }
      # format.json { head :ok }
    # end
  # end
# end
