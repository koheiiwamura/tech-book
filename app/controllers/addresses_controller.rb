class AddressesController < ApplicationController

  def update
    @address = Address.find(params[:id])
    if @address.update(update_params)
      # redirect_to :back, notice:"更新しました"
      redirect_to(session[:return_to] || user_path(@address.user), notice:"更新しました")
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
