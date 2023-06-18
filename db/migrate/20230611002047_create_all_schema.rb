class CreateAllSchema < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :description
      t.timestamps
    end

    create_table :carts do |t|
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end

    create_table :products do |t|
      t.string     :name
      t.string     :description
      t.float      :total_value
      t.belongs_to :store, foreign_key: true
      t.timestamps
    end

    create_table :cart_products do |t|
      t.belongs_to :cart, foreign_key: true
      t.belongs_to :product, foreign_key: true
      t.float      :total_value
      t.timestamps
    end
  end
end
