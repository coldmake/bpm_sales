require_dependency "bpm_sales/application_controller"

module BpmSales
  class LineItemsController < ApplicationController
    before_action :set_line_item, only: [:show, :edit, :update, :destroy]

    # GET /line_items
    def index
      @line_items = LineItem.all
    end

    # GET /line_items/1
    def show
    end

    # GET /line_items/new
    def new
      @invoice = Invoice.find(params[:invoice_id])
      @line_item = LineItem.new
    end

    # GET /line_items/1/edit
    def edit
      @invoice = Invoice.find(params[:invoice_id])
      @line_item = LineItem.find(params[:id])
    end

    # POST /line_items
    def create
      @invoice = Invoice.find(params[:invoice_id])
      @line_item = LineItem.new(line_item_params, invoice_id: params[:invoice_id].to_i)
      if @line_item.save
        binding.pry
        redirect_to invoice_url(@invoice), notice: 'Customer was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /line_items/1
    def update
      invoice_url(@invoice)
    end

    # DELETE /line_items/1
    def destroy
      @line_item.destroy
      redirect_to line_items_url, notice: 'LineItem was successfully destroyed.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def line_item_params
      temp=params.require(:line_item).permit(:price, :quantity, :description)
      binding.pry
      temp[:invoice_id]=params[:invoice_id]
      temp
    end
  end
end
