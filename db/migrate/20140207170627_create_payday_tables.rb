class CreatePaydayTables < ActiveRecord::Migration
  def self.up
    create_table :bpm_sales_invoices do |t|
      # invoices will work without anything but bill_to, but there are quite a few options for the fields you can save, like ship_to
      t.date :due_at
      t.date :paid_at

      t.decimal :total, precision: 10, scale: 2

      t.string :bill_to
      t.references :customer

      t.timestamps
    end

    create_table :bpm_sales_line_items do |t|
      t.decimal :price, precision: 10, scale: 2
      t.string :description
      t.integer :quantity     # can also be :decimal or :float - just needs to be numeric

      t.references :invoice

      t.timestamps
    end
  end
  
  def self.down
    drop_table :bpm_sales_invoices
    drop_table :bpm_sales_line_items
  end
end