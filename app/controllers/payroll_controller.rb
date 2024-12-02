class PayrollController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!

    require 'faraday'

    def calculate
        conn = Faraday.new(
            url: Settings.api.url,
            params: {param: '1'},
            headers: {'Content-Type' => 'application/json'}
        )

        response = conn.post('/payroll/calculate') do |req|
            req.params['limit'] = 100
            req.body = {
                employeeId: params[:employeeId],
                name: params[:name],
                position: params[:position],
                salary: params[:salary],
                bonus: params[:bonus],
                deductions: params[:deductions],
                benefits: params[:benefits],
            }.to_json
        end

        # binding.pry

        puts " xxxxxxxxxxxxxxxxxxxxxxxxxx#{response.status}"

    

        if response.success?
            render json: response.body, status: :ok
        else
            render json: {error: 'Failed to calculate the payroll'}, status: :unprocessable_entity
        end
    end

end
