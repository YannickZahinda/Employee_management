class ReportsController < ApplicationController
    before_action :authorize_user, only: [:new, :create]

    def index
        @reports = current_user.reports
    end 

    def new 
        @report = current_user.reports.build
    end

    def create
        @report = current_user.reports.build(reports_params)
        if @report.save
            redirect_to reports_path, notice: 'Report was created successfully'
        else 
            render :new
        end
    end

    private 

    def reports_params
        params.require(:report).permit(:title, :content)
    end

    def authorize_user 
        if current_user.admin?
            redirect_to root_path, alert: 'administrateur ne peut créér un rapport; sinon parler à ingenieur '
        end 
    end
end
