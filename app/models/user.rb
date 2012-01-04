# coding:utf-8

class User < ActiveRecord::Base
	validates	:name, presence: true, uniqueness: true, length: {minimum: 1, maximum: 30, message: '1〜30文字以内にしてください。'}
	validates	:email, presence: true, uniqueness: true
	validates	:pw_digest, presence: true, length: {minimum: 1, maximum: 20, message: '1〜20文字以内にしてください。'}
	has_secure_password
end
