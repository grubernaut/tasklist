class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :trackable, :rememberable, :registerable

  def update_with_password(params)
    @new_password = params[:password]
    @confirm_new_password = params[:password_confirmation]
    @current_password = params[:current_password]

    if (@confirm_new_password == @new_password)
      if (Devise::LDAP::Adapter.valid_credentials?(login_with,@current_password))
        Devise::LDAP::Adapter.update_own_password(login_with, @new_password, @current_password)
      else
        errors[:base] << "Incorrect Password Given"
      end
    else
        errors[:base] << "New Passwords do not match!"
    end
  end

end
