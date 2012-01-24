# coding:utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Bookset.delete_all


# Bookset.create(
  # id: 1,
  # description: "これが九十九文字です。これが九十九文字です。これが九十九文字です。これが九十九文字です。これが九十九文字です。これが九十九文字です。これが九十九文字です。これが九十九文字です。これが九十九文字です。",
  # category: '本',
  # image_url: '01.jpg',
  # omniuser_id: 1
# )
# Bookset.create(
  # id: 2,
  # description: "<p>HTML入りのエントリーです。</p>",
  # category: '本',
  # image_url: '02.jpg',
  # omniuser_id: 1
# )
# Bookset.create(
  # id: 3,
  # description: "３番目の説明文です。今度はたくさん記号を入れてみます。!#%&'()=~|",
  # category: '本',
  # image_url: '03.jpg',
  # omniuser_id: 1
# )