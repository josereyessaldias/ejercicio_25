class SalesController < ApplicationController
  


  def done 
  	@sale = Sale.last
  end
  	
  
  def new
  	@sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)

    if @sale.tax.to_i == 1
      @sale.tax = 0
      @sale.total = @sale.value.to_i * (1- @sale.discount.to_f/100)
    elsif @sale.tax.to_i == 0
      @sale.tax = 19
      @sale.total = @sale.value.to_i * (1- @sale.discount.to_f/100) * 1.19
    end

    respond_to do |format|
      if @sale.save
        format.html { redirect_to sales_path, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end

    #@sale.save
    #redirect_to sales_path

  end


  private

  def sale_params
  	params.require(:sale).permit(:cod, :detail, :category, :value, :discount, :tax, :total)
  end

end
