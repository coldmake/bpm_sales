module BpmSales
  class Invoice < ActiveRecord::Base

    has_many :line_items

    validates_presence_of :bill_to

    #include Payday::Invoiceable

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

    # Calculates the subtotal of this invoice by adding up all of the line items
    def subtotal
      line_items.inject(BigDecimal.new("0")) { |result, item| result += item.amount }
    end

    # The tax for this invoice, as a BigDecimal
    def tax
      if defined?(tax_rate)
        calculated = subtotal * tax_rate
        return 0 if calculated < 0
        calculated
      else
        0
      end
    end

    # TODO Add a per weight unit shipping cost
    # Calculates the shipping
    def shipping
      if defined?(shipping_rate)
        shipping_rate
      else
        0
      end
    end

    # Calculates the total for this invoice.
    def total
      subtotal + tax + shipping
    end

    def overdue?
      defined?(:due_at) && ((due_at.is_a?(Date) && due_at < Date.today) || (due_at.is_a?(Time) && due_at < Time.now))  && !paid_at
    end

    def paid?
      defined?(:paid_at) && !!paid_at
    end

    # Renders this invoice to pdf as a string
    def render_pdf
      Payday::PdfRenderer.render(self)
    end

    # Renders this invoice to pdf
    def render_pdf_to_file(path)
      Payday::PdfRenderer.render_to_file(self, path)
    end

    # Iterates through the details on this invoiceable. The block given should accept
    # two parameters, the detail name and the actual detail value.
    def each_detail(&block)
      return if defined?(invoice_details).nil?

      invoice_details.each do |detail|
        block.call(detail[0], detail[1])
      end
    end


  end
end