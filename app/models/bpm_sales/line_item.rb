module BpmSales
  class LineItem < ActiveRecord::Base
    include Payday::LineItemable

    belongs_to :invoice

    attr_accessor :description, :quantity, :display_quantity, :display_price, :price

    # Initializes a new LineItem
    def initialize(options = {})
      self.quantity = options[:quantity] || "1"
      self.display_quantity = options[:display_quantity]
      self.display_price = options[:display_price]
      self.price = options[:price] || "0.00"
      self.description = options[:description] || ""
    end

    # Sets the quantity of this {LineItem}
    def quantity=(value)
      @quantity = BigDecimal.new(value.to_s)
    end

    # Sets the price for this {LineItem}
    def price=(value)
      @price = BigDecimal.new(value.to_s)
    end





    validates_numericality_of :price
    validates_numericality_of :quantity
    validates_presence_of :description
  end
end