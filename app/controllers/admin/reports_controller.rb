class Admin::ReportsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index 
        @reports = Report.all 
    end

    # def new
    #     @reports = Report.new 
    # end

    # def create 
    #     @report = Report.new(report_params)
    #     @report.admin = current_user

    #     if @report.save 
    #         redirect_to reports_path, notice: 'report was successfully created !'
    #     else 
    #         render :new 
    #     end 
    # end

    private 

    # def report_params
    #     params.require(:report).permit(:title, :content)
    # end

    def require_admin
        redirect_to root_path, alert: 'Access Denied !' unless current_user.admin?
    end 

end
