#coding:utf-8
class ShelfController < ApplicationController
	#TODO SHELFコントローラーってほんとに必要？再考する
	#ユーザ別にShelfを表示する
	#shelf/:idでアクセスしたときのアクション
  def index
				
  	    unless params[:id] == nil #:idが空かどうかチェック。空ならルートへリダイレクトさせる。
  	    		unless params[:id].to_i > Omniuser.count || params[:id].to_i <= 0 #:idが、登録ユーザ数を超えているか、ゼロ以下であれば不正値なので処理をする
				  	  	@booksets = Bookset.find_all_by_omniuser_id(params[:id])
				  	  	@omniuser = Omniuser.find(params[:id])
				  	    #raise @omniuser.to_yaml
				  	else
				  		render :text => "ページが存在しないか、削除されたかもしれません。"
				    end
		  	else
		  		  redirect_to :root
		    end
  end

end
