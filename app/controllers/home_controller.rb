class HomeController < ApplicationController
  def index
  end

  def hcpcs
    hcpcs_code = params[:hcpcs_code]

    if service = Service.find_by(hcpcs_code: hcpcs_code)
      description = service.hcpcs_description
      data = service.price_distribution(10)
    else
      description = "HCPCS Code Not Found"
      data = []
    end

    respond_to do |format|
      format.json { render json: {service: "#{hcpcs_code}: #{description}", data: data} }
    end
  end
end
