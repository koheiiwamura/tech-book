class BanksController < ApplicationController

  def create
    @bank = Bank.new(bank_params)
    if @bank.save
      redirect_to user_path(current_user), notice:"銀行口座を登録しました"
    else
      flash[:alert] = "更新できませんでした"
      render "user/edit"
    end
  end


  def update
    @bank = Bank.find(params[:id])
    if @bank.update(bank_params)
      redirect_to user_path(@bank.user), notice:"銀行口座を更新しました"
    else
      flash[:alert] = "銀行口座を更新できませんでした"
      render "user/edit"
    end
  end

  private

  def bank_params
    params.require(:bank).permit(
      :bank_name, :branch_name, :account_type,
      :number, :holder_name
      ).merge(user_id: current_user.id)
  end
end
