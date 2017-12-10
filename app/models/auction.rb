class Auction < ApplicationRecord
  validates :start_value,
            :current_value,
            :ending_value,
            :description,
            presence: true
  validates :description,
            length: { maximum: 255 }
  validates :start_value,
            :current_value,
            :ending_value,
            numericality: { greater_than: 0 }
  validates :start_value,
            :current_value,
            :ending_value,
            format: {
              with: /\A\d{1,10}\.\d{1,2}\z/,
              message: I18n.t('errors.messages.wrong_format_price')
            }, allow_blank: true
  validate :lower_ending_value

  private

  def lower_ending_value
    return if ending_value.blank? || current_value.blank? ||
              ending_value > current_value

    errors.add(:ending_value, 'ending_value must be greater than start_value')
  end
end