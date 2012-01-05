# coding:utf-8

class SessionsController < ApplicationController
  def callback
    
    #omniauth.auth環境変数を取得
    auth = request.env["omniauth.auth"]
 
    #omniuserモデルを検索
    omniuser = Omniuser.find_by_provider_and_uid(auth["provider"], auth["uid"])
 
    if omniuser
       # Omniuserモデルに:providerと:uidが見つかった場合（外部認証済み）、続けてUser.emailが存在するか確認する。存在すればログインさせる。
       # もし存在しなければ、ウェルカム（新規登録）ページへ遷移させる。
       session[:user_id] = omniuser.id
       redirect_to root_url, :notice => "ログインしました。"
    else
       # Omniuserモデルに:providerと:uidが無い場合（外部認証していない）、:provider,:uidを保存してから、ウェルカム(新規登録)ページへ遷移させる
       Omniuser.create_with_omniauth(auth)
       redirect_to new_user_registration_path, :notice => "接続は完了しました。emailがみつかりませんでした。"
    end 
  
  end
  
  
  #ログアウト処理
  def destroy  
      session[:user_id] = nil  
      redirect_to root_url, :notice => "オムニユーザログアウトしました"  
  end  
    
    
end
