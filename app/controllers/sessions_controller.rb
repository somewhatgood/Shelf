# coding:utf-8

class SessionsController < ApplicationController
  def callback
    
    #omniauth.auth環境変数を取得
    auth = request.env["omniauth.auth"]
 
    #omniuserモデルを検索
    omniuser = Omniuser.find_by_provider_and_uid(auth["provider"], auth["uid"])
        
    if omniuser
       # Omniuserモデルに:providerと:uidが見つかったので(=OAuth認証済み)、続けてUserテーブルを検索する。
       # ①User.omniuser_id = omniuser.id(10行目で取得したomniuserのID)となるレコードが存在するか？
       # ②User.confirmed_at に値が入っている = メール確認済みか？
       user = User.find_by_omniuser_id(omniuser.id)
              
       if user
       
           if user.confirmed_at
			       	 #①②両方存在したのでログインしてルートページへ
			       		session[:user_id] = omniuser.id
			       		redirect_to root_url, :notice => "ログインしました。"
			     else
			     	    #②が無かった = メール確認が済んでいない
			     	    redirect_to new_user_registration_path, :notice => "#{auth["info"]["name"]}さんのアカウントは作成済みですが、メンバー登録が完了していません。登録確認メールをお送りしてありますのでご確認ください。"
			     end
       else
         #存在しなければDevise認証はまだだから、ユーザ登録ページへ
          session[:tmp_uid] = auth["uid"]
       		redirect_to new_user_registration_path, :notice => "#{auth["info"]["name"]}さんのアカウントは作成済みですが、メールアドレスとパスワードが未登録です。メールアドレスとパスワードを入力してメンバー登録を完了してください。"
       end
    else
       # Omniuserモデルに:providerと:uidが無い = OAuth認証がまだ
       # Omniuserモデルに:provider,:uidを保存する
       Omniuser.create_with_omniauth(auth)
       
       # Deviseユーザ登録の際、自分のOmniuser.idを外部キーとして保存させたい。
       # sessionにuid値を保存し、ユーザ登録のビューで使えるようにしておく。
       # sessionに保存した値を使ってOmniuserモデルを検索すれば、Omniuser.idを取得できる。
       session[:tmp_uid] = auth["uid"]
       redirect_to new_user_registration_path, :notice => "#{auth["info"]["name"]}さんの#{auth["provider"]}と接続してアカウントを作りました。メールアドレスとパスワードを入力してメンバー登録を完了してください。"
    end 
  
  end
  
  
  #OAuthログアウト処理
  def destroy  
      session[:user_id] = nil  
      redirect_to root_url, :notice => "ログアウトしました"  
  end  
    
    
end
