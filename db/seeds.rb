# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: "a@a", password: "aaaaaa")

Customer.create(last_name: "田中", first_name: "太郎", last_name_kana: "タナカ",
				first_name_kana: "タロウ", email: "a@a", password: "aaaaaa",
				postal_code: "1111111", address: "東京都", telephone_number: "09011111111"
				)

11.times do |n|

	Genre.create(name: "ジャンル#{n}")

	Item.create(genre_id: "#{n}", name: "商品#{n}", image: File.open("./app/assets/images/image#{n}.jpg"),
	 introduction: "これは商品#{n}これは商品#{n}これは商品#{n}これは商品#{n}これは商品#{n}これは商品#{n}これは商品#{n}これは商品#{n}これは商品#{n}これは商品#{n}",
	 price: (111 * n))
end

5.times do |m|

	Address.create(customer_id: "1", name: "宛名#{m}", postal_code: "#{m}#{m}#{m}#{m}#{m}#{m}#{m}#{m}", address: "住所#{m}")

end
