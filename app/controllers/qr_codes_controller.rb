class QrCodesController < ApplicationController
    # def create 
    #     @qr_code = current_user.qr_codes.create(expires_at: 5.minutes.from_now)
    #     redirect_to @qr_code 
    # end

    # def show 
    #     @qr_code = QrCode.find(params[:id])
    # end

    # def scan 
    #     @qr_code = QrCode.find_by(code: params[:code])
    #     if @qr_code && @qr_code.expires_at > Time.current 
    #         Attendance.create(user: @qr_code.user, date: Date.today)
    #         # redirect_to root_path, notice: 'Présence marquée'
    #         render json: {success: true, message: 'Présence marquée avec succès'}
    #     else 
    #         render json: {success: false, message: 'Code invalide ou expirée'}
    #     end
    # end
end
