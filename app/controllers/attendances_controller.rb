class AttendancesController < ApplicationController
    before_action :authenticate_user!

    def index
      @attendances = current_user.attendances
    end
end
