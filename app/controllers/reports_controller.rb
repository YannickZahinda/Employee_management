class ReportsController < ApplicationController
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
        params.require(:reports).permit(:title, :content)
    end
end
