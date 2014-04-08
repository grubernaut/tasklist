class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :trackable, :rememberable, :registerable

  def update_with_password(params)
    @new_password = params[:password]
    @current_password = params[:current_password]

    raise "Need to auth password first" if @current_password.blank?

    Devise::LDAP::Adapter.update_own_password(login_with, @new_password, @current_password)
  end

end
