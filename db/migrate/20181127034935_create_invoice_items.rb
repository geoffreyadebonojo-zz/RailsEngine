class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.integer :quantity
      t.integer :unit_price

      t.references :item
      t.references :invoice

      t.timestamps
    end
  end
end
