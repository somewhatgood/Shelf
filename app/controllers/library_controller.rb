#coding:utf-8
class LibraryController < ApplicationController
  def index

			  	if notice =~ /メンバー登録を完了してください/
			  		render :template => "welcome/send_instractions"
			    elsif notice =~ /ようこそリンクシェルフへ/
			    	render :template => "welcome/mail_confirmed"
			    end

	end
end