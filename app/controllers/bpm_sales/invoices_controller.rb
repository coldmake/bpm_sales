require_dependency "bpm_sales/application_controller"

module BpmSales
  class InvoicesController < ApplicationController
    before_action :set_invoice, only: [:show, :edit, :update, :destroy]

    # GET /invoices
    def index
      @invoices = Invoice.all
    end

    # GET /invoices/1
    def show
      respond_to do |format|
      format.html
      format.pdf {
        Payday::Config.default.invoice_logo = "app/assets/images/logo.png"
        Payday::Config.default.company_name = "Asental Pte. Ltd."
        Payday::Config.default.company_details = "Innovation Centre BLK 2, #02-235 18 Nanyang Drive, Singapore 637723 \nsamuel.shen@asental.com"
        send_data(@invoice.render_pdf, :filename => "Invoice #{@invoice.id}.pdf", :type => "application/pdf", :disposition => "inline") }
    end
    end

    # GET /invoices/new
    def new
      @invoice = Invoice.new
      Payday::Config.default.invoice_logo = "app/assets/images/logo.png"
      Payday::Config.default.company_name = "Asental Pte. Ltd."
      Payday::Config.default.company_details = "Innovation Centre BLK 2, #02-235 18 Nanyang Drive, Singapore 637723 \nsamuel.shen@asental.com"
      invoice = Payday::Invoice.new(:invoice_number => 1, :bill_to => "Another Pte. Ltd.\nclient@another.com")
      invoice.line_items << LineItem.new(:price => 20, :quantity => 5, :description => "Pants")
      invoice.line_items << LineItem.new(:price => 10, :quantity => 3, :description => "Shirts")
      invoice.line_items << LineItem.new(:price => 5, :quantity => 200, :description => "Hats")
      invoice.render_pdf_to_file("app/assets/invoices/sample.pdf")
    end

    # GET /invoices/1/edit
    def edit
    end

    # POST /invoices
    def create
      @invoice = Invoice.new(invoice_params)

      if @invoice.save
        redirect_to @invoice, notice: 'Invoice was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /invoices/1
    def update
      if @invoice.update(invoice_params)
        redirect_to @invoice, notice: 'Invoice was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /invoices/1
    def destroy
      @invoice.destroy
      redirect_to invoices_url, notice: 'Invoice was successfully destroyed.'
    end

    def mark_paid
      if !@invoice.paid?
        @invoice.update_attribute(:paid_at, Time.now)
      end 
      redirect_to @invoice and return
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invoice_params
      params.require(:invoice).permit(:due_at, :pay_at, :total, :bill_to, :customer_id)
    end
  end
end
