class Order < ActiveRecord::Base
  attr_accessor :card_number, :card_verification
  validates_presence_of :name
  validates_presence_of :address1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :country
  validates_presence_of :zip
  

  validate_on_create :validate_card

  belongs_to :user

  def purchase
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    Rails.logger.info response.inspect
    if response.success?
      self.update_attributes({:status => "active", :tran => response.instance_variable_get(:@params)["transaction_id"],:message => response.instance_variable_get(:@message)})
      self.user.update_attributes({:status => "active",:access_until => Date.today.next_month(self.duration)})
      self.user.update_active
    end
    response.success?
  end

  def price_in_cents
    amount.to_f.round
  end

  def create_user
    user = User.new({:first_name => self.first_name, :last_name => self.last_name, :email => self.email, :login => self.login,:password => self.password})
    user.save
    user
   end

  private

  def purchase_options
    {
      :ip => ip_address,
      :billing_address => {
        :name     => self.name,
        :address1 => self.address1,
        :address2 => self.address2,
        :city     => self.city,
        :state    => self.state,
        :country  => self.country,
        :zip      => self.zip
      }
    }
  end

  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end


end
