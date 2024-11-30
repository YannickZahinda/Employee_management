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

        response = conn.post('/payslip/calculate') do |req|
            req.params['limit'] = 100
            req.body = {
                employeeId: params[:user_id],
                salary: params[:salary],
                bonus: params[:bonus],
                deductions: params[:deductions],
                benefits: params[:benefits],
            }.to_json
        end

        if response.success?
            render json: response.parsed_response, status: :ok
        else
            render json: {error: 'Failed to calculate payroll'}, status: :unprocessable_entity
        end
    end

end
