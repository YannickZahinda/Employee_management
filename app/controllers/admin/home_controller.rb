class Admin::HomeController < AdminController
    before_action :authenticate_user!
    before_action :require_admin

    def index
        @meetings = Meeting.all 
        @sick_leaves = SickLeave.all 
        @attendances = Attendance.all 
        @holy_days = HolyDay.all 
        @reports = Report.all
        @users = User.all
    end

    private 

    def require_admin 
        redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
    end

end
