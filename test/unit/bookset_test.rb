# coding:utf-8

require 'test_helper'

class BooksetTest < ActiveSupport::TestCase
  test "bookset image_url must be jpg/png/gif" do
    bookset = Bookset.new(description: "説明です",
                          category: "本"
                          )
    bookset.image_url = "test.mov"
    assert bookset.invalid?, ".movが検証パスしてしまいました"
    
    bookset.image_url = "test.jpg"
    assert bookset.valid?, ".jpgが検証パスしなかったようです"
    
    bookset.image_url = "test.png"
    assert bookset.valid?, ".pngが検証パスしなかったようです"
    
    bookset.image_url = "test.gif"
    assert bookset.valid?, ".gifが検証パスしなかったようです"
  end
  test "bookset description must be between 1 and 99" do
    bookset = Bookset.new(category: "本",
                          image_url: "test.jpg")
    bookset.description = ""
    assert bookset.invalid?, "空の状態で検証パスしてしまいました"
    
    bookset.description = "これで１００文字だ。これで１００文字だ。これで１００文字だ。これで１００文字だ。これで１００文字だ。これで１００文字だ。これで１００文字だ。これで１００文字だ。これで１００文字だ。これで１００文字だ。"
    assert bookset.invalid?, "100文字以上で検証パスしてしまいました"
  end
end
