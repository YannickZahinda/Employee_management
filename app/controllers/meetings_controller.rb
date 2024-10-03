class MeetingsController < ApplicationController
    before_action :authenticate_user!
    
    def index 
        @meetings = Meeting.all
    end
end
