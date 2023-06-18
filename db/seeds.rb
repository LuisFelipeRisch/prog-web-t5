# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

now = Time.now.utc

store_one = Store.find_or_create_by(name: "BCC - CAAD", description: "Monster a preço de bala!!!!!")
store_two = Store.find_or_create_by(name: "Burguer King", description: "Melhor que Mcdonald's")

products = [
  {name: "Monster", description: "Não tome quando for meia noite, se não vai te dar vontade de fazer trabalho 2 de prog web :). Já são 3 da manhã, socorro", total_value: 7.90, store: store_one},
  {name: "Trento de Morango", description: "Hmmmm moranguinho...", total_value: 1.50, store: store_one},
  {name: "Trento de Limão", description: "Hmmmm azedinho...", total_value: 2.53, store: store_one},
  {name: "Whopper", description: "Chora Big Mac", total_value: 11.90, store: store_two},
  {name: "Bk Fritas", description: "Chora Mac fritas", total_value: 7.50, store: store_two},
  {name: "Coquinha", description: "Hmmmm docinho...", total_value: 5.74, store: store_two}
]

products.each do |attrs|
  Product.find_or_create_by(attrs)
end
