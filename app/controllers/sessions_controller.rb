# coding:utf-8

class SessionsController < ApplicationController
  def callback
    
    #omniauth.auth環境変数を取得
    auth = request.env["omniauth.auth"]
 
    #Userモデルを検索
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
 
    if user
       # Userモデルに:providerと:uidが見つかった場合（外部認証済み）、続けてUserinfo.emailが存在するか確認する。存在すればログインさせる。
       # もし存在しなければ、ウェルカム（新規登録）ページへ遷移させる。
       session[:user_id] = user.id
       redirect_to root_url, :notice => "ログインしました。"
    else
       # Userモデルに:providerと:uidが無い場合（外部認証していない）、:provider,:uidを保存してから、ウェルカム(新規登録)ページへ遷移させる
       redirect_to welcome_index_path, :notice => "登録IDがみつかりませんでした。"
    end 
  
  end
end
