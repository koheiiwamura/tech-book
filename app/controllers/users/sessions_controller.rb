class Users::SessionsController < Devise::SessionsController
  def create
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end

  # 認証が失敗した場合に呼び出されるアクション
  def failed
    # warden で出力されたエラーを保存する
    # flash[:alert] = flash[:notice].to_a.concat [flash[:alert]]
    flash[:alert] = "ユーザーネームまたはパスワードが違います。"
    redirect_to root_path
  end

  protected
  def auth_options
    # 失敗時に recall に設定したパスのアクションが呼び出されるので変更
    # { scope: resource_name, recall: "#{controller_path}#new" } # デフォルト
    { scope: resource_name, recall: "#{controller_path}#failed" }
  end
end
