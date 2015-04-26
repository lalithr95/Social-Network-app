class User < ActiveRecord::Base
    has_many :microposts , dependent: :destroy # for destorying all tweets when user gets deleted . dependent is used as option to has_many
    attr_accessor :remember_token,:activation_token,:reset_token
    before_save { self.email = email.downcase }
    before_create :create_activation 
    # passes a block of action to before_save callback
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name,presence:true,length: {maximum: 50}
    validates :email,presence:true,length: {maximum: 255},format: {with: VALID_EMAIL_REGEX},uniqueness: {case_sensitive: false}
    # validating email with validate function which uses email(Model attribute) , length , format of email 
    # uniqueness which doesn't allow duplicate values .
    validates :password,length: { minimum: 6 }, allow_blank: true
    has_secure_password 
    # this will add secure password , confirmation password while creating object,also for authentication
    
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest,remember_token)
    end
   
    #def authenticated?(remember_token)
    #    return false if remember_digest.nil?
    #    remember_token == remember_digest
    #end
    
    def authenticated?(attribute,token)# to convert string to varaiable and access as class instance var use self.send(string)
        att = self.send("#{attribute}_digest")
        return false if att.nil?
        att == token
    end
    def password_reset_expired?
        self.reset_sent_at < 2.hours.ago
    end
    def forget
        update_attribute(:remember_digest, nil)
    end
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,reset_token)
        update_attribute(:reset_sent_at,Time.zone.now)
    end
    def send_password_reset_email
        UserMailer.password_reset(self).deliver
    end
    private
    def create_activation
       self.activation_token = User.new_token
       self.activation_digest = self.activation_token
    end
    # activates an account
    def activate
        update_attribute(:activated,true)
        update_attribute(:activated_at,Time.zone.now)
    end
    def send_activation_email
        UserMailer.account_activation(self).deliver
    end   
end
