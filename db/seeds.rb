# coding:utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Bookset.delete_all
Omniuser.delete_all
User.delete_all

User.create(
	id: 1,
	email: "test01@test.com"
)
User.create(
	id: 2,
	email: "test02@test.com"
)
User.create(
	id: 3,
	email: "test03@test.com"
)
User.create(
	id: 4,
	email: "test04@test.com"
)
User.create(
	id: 5,
	email: "test05@test.com"
)


Omniuser.create(
	id: 1,
	provider: "twitter",
	uid: 00001,
	name: "一郎"
)
Omniuser.create(
	id: 2,
	provider: "twitter",
	uid: 00002,
	name: "二郎"
)
Omniuser.create(
	id: 3,
	provider: "twitter",
	uid: 00003,
	name: "三郎"
)
Omniuser.create(
	id: 4,
	provider: "twitter",
	uid: 00004,
	name: "四郎"
)
Omniuser.create(
	id: 5,
	provider: "twitter",
	uid: 00005,
	name: "五郎"
)

Bookset.create(
  id: 1,
  description: "小さなチーム、大きな仕事",
  category: 'ビジネス',
  image_url: '01.jpg',
  omniuser_id: 1
)
Bookset.create(
  id: 2,
  description: "プラットフォーム戦略",
  category: 'ビジネス',
  image_url: '02.jpg',
  omniuser_id: 1
)
Bookset.create(
  id: 3,
  description: "シェア 共有から生み出す新戦略",
  category: 'ビジネス',
  image_url: '03.jpg',
  omniuser_id: 1
)
Bookset.create(
  id: 4,
  description: "上級ウェブ解析士教本",
  category: 'IT',
  image_url: '04.jpg',
  omniuser_id: 2
)
Bookset.create(
  id: 5,
  description: "よくわかる基本情報技術者試験",
  category: 'IT',
  image_url: '05.jpg',
  omniuser_id: 2
)
Bookset.create(
  id: 6,
  description: "応用情報技術者合格教本",
  category: 'IT',
  image_url: '06.jpg',
  omniuser_id: 2
)
Bookset.create(
  id: 7,
  description: "LIFE AFTER GOD",
  category: '小説',
  image_url: '07.jpg',
  omniuser_id: 3
)
Bookset.create(
  id: 8,
  description: "シャンプー・プラネット",
  category: '小説',
  image_url: '08.jpg',
  omniuser_id: 3
)
Bookset.create(
  id: 9,
  description: "ノルウェイの森",
  category: '小説',
  image_url: '09.jpg',
  omniuser_id: 3
)
Bookset.create(
  id: 10,
  description: "AKB48の秘密",
  category: '芸能',
  image_url: '10.jpg',
  omniuser_id: 4
)
Bookset.create(
  id: 11,
  description: "宇多田ヒカル、歌姫の伝説",
  category: '芸能',
  image_url: '11.jpg',
  omniuser_id: 4
)
Bookset.create(
  id: 12,
  description: "80年代を彩ったアメリカン・アイドルたち",
  category: '芸能',
  image_url: '12.jpg',
  omniuser_id: 4
)
Bookset.create(
  id: 13,
  description: "ニーチェの言葉",
  category: '自己啓発',
  image_url: '13.jpg',
  omniuser_id: 5
)
Bookset.create(
  id: 14,
  description: "ジョブズ名言集",
  category: '自己啓発',
  image_url: '14.jpg',
  omniuser_id: 5
)
Bookset.create(
  id: 15,
  description: "７つの習慣",
  category: '自己啓発',
  image_url: '15.jpg',
  omniuser_id: 5
)