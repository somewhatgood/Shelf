# coding:utf-8

class Bookset < ActiveRecord::Base
	  validates :description, presence: true,
	  						  length: {minimum: 1, maximum: 99, message: '1〜99文字以内にしてください。'}
	  validates :category,    presence: true,
	  						  length: {minimum: 1, maximum:20, message: '1〜20文字以内にしてください。'}
	  validates :image_url,   allow_blank: true, 
	  						  format: {
									    with: %r{\.(gif|jpg|png)$}i, 
									    message: 'はGIF、JPG、PNGにしてください。'
									  }
end