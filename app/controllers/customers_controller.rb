# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :set_customer, only: %i[update destroy]
  skip_before_action :verify_authenticity_token, only: %i[update create destroy]

  # POST /customers or /customers.json
  def create
    @customer = Customer.create!(customer_params)
    render(json: CustomerSerializer.new(@customer).attributes, status: :ok)
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    @customer.update(customer_params)
    render(json: CustomerSerializer.new(@customer).attributes, status: :ok)
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy
    render(json: nil, status: :no_content)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(%i[name email mobile_no])
    params.permit(:name, :email, :mobile_no, :dob, :height, :city, :state, :country)
  end
end
