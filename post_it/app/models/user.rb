class User < ActiveRecord::Base

  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  assign_name_to_slug_column(:username)

  def admin?
    role == 'admin'
  end

  def generate_pin!
    update_column(:pin, rand(10 ** 6))
  end

  def two_factor_auth?
    !phone.blank?
  end

  def remove_pin
    pin = nil
  end


  # https://www.twilio.com/user/account/developer-tools/api-explorer/message-create
  def send_pin_to_twilio
    account_sid = 'AC39dffd776a2b1a25137934588bc1c750'
    auth_token = '7956ff6657f7eb0090a27dca326fc392'

    # set up a client to talk to the Twilio REST API
    client = Twilio::REST::Client.new account_sid, auth_token

    msg = "Hi, please input the pin to continue login: #{pin}"
    client.account.messages.create({
                                       :from => '+12892051579',
                                       :to => '9059068467',
                                       :body => msg
                                   })
  end

end
