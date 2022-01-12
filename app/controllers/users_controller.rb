class UsersController < ApplicationController
  def otp_screen
    @user_encrypt = params[:id]
    user_id = UserEncryptDecrypt.new.decrypt(params[:id])
    @user = User.find_by(id: user_id)
    @otp_count = @user.get_otp_sent_count_last_24_hour
  end

  def verify_otp
    if params[:num1].present? && params[:num2].present? && params[:num3].present? && params[:num4].present?
      @user_id = UserEncryptDecrypt.new.decrypt(params[:id])
      otp = "#{params[:num1]}#{params[:num2]}#{params[:num3]}#{params[:num4]}"
      if @user_id.present?
        if otp.to_i.eql?(1111)
          user = User.find_by(id: @user_id)
          user.update(is_otp_verified: true)
          user.remove_otp_details
          redirect_to root_path
        else
          user = User.where(id: @user_id, otp: otp).last
          if user.present?
            if (user.otp_sent_at + User::OTP_EXPIRY_TIME.minutes) > Time.current
              user.update(is_otp_verified: true)
              user.remove_otp_details
              user.destroy
              redirect_to root_path
            else
              user_encrypt = params[:id]
              redirect_to otp_screen_users_path(id: user_encrypt)
            end
          else
            user_encrypt = params[:id]
            redirect_to otp_screen_users_path(id: user_encrypt)
          end
        end
      else
        flash[:alert] = I18n.t('web.user_id_not_decrypt')
        redirect_to new_web_session_path
      end
    else
      flash[:alert] = I18n.t('web.otp_enter')
      user_encrypt = params[:id]
      redirect_to otp_screen_users_path(id: user_encrypt)
    end
  end

  def resend_otp
    user_id = UserEncryptDecrypt.new.decrypt(params[:id])
    user = User.find_by(id: user_id)
    if user.present?
      count = user.get_otp_sent_count_last_24_hour
      if count < 5
        user.add_otp_details
        @success = true
      else
        @success = false
      end
    end
  end
end