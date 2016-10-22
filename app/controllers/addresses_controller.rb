class AddressesController < ApplicationController
  skip_before_filter :verify_authenticity_token ,:only=>[:update]

  def create
    @address = Address.new(update_params)
    if @address.save
      redirect_to ({:controller => 'users', :action => 'show', id: @address.user}), notice:"更新しました"
    else
      flash[:alert] = "更新できませんでした"
      render "user/edit"
    end
  end

  def update
    binding.pry
    @address = Address.find(params[:id])
    if @address.update(update_params)
      redirect_to ({:controller => 'users', :action => 'show', id: @address.user}), notice:"更新しました"
    else
      flash[:alert] = "更新できませんでした"
      render "user/edit"
    end
  end
  private
  def update_params
    params.require(:address).permit(:last_name, :first_name, :postal_code, :street_address, :phone_number)
  end
end
