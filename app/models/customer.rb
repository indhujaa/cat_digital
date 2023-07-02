# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :name, :email, :mobile_no, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :mobile_no, numericality: true,
                        length: { minimum: 10, maximum: 15 }, uniqueness: true
  validates :dob, allow_blank: true, comparison: { less_than: Date.current }
  validates :height, allow_blank: true, comparison: { greater_than: 0 }

  after_save_commit :update_third_party

  private

  def update_third_party
    ExternalApiService::UpdateThirdPartyEndpoints.new.call(self)
  end
end
