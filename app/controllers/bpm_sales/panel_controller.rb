require_dependency "bpm_sales/application_controller"

module BpmSales
  class PanelController < ApplicationController
    def index
      @total_customer_count=Customer.count
      @new_customer_count=Customer.where('created_at > ?', Time.zone.now-1.month).count
      @total_invoice_count=Invoice.count
      @new_invoice_count=Invoice.where('created_at > ?', Time.zone.now-1.day).count
    end
  end
end
