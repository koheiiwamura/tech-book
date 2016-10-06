class BanksController < ApplicationController

  def update
    @bank = Bank.find(params[:id])
    if @bank.update(update_params)
      redirect_to :controller => 'users', :action => 'show', notice:"更新しました"
    else
      flash[:alert] = "更新できませんでした"
      render "user/edit"
    end
  end

  private
  def update_params
    params.require(:bank).permit(:bank_name, :branch_name, :account_type, :number, :holder_name)
  end
end
