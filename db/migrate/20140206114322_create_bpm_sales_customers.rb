class CreateBpmSalesCustomers < ActiveRecord::Migration
  def change
    create_table :bpm_sales_customers do |t|
      t.string :email
      t.string :name
      t.string :phone
      t.string :company
      t.string :remark

      t.timestamps
    end
  end
end
