module BpmSales
  class Invoice < ActiveRecord::Base
    include Payday::Invoiceable

    has_many :line_items

    validates_presence_of :bill_to

    # Payday won't display invoice numbers unless invoice_number exists on our invoice
    def invoice_number
      id
    end

    def tax_rate
      0.07
    end

    def tax_description
      'GST'
    end

    def shipping_rate
      0
    end
  end
end