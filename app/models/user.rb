class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save :downcase_email
    before_create :create_activation_digest

    validates :username, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6}, allow_nil: true

    has_many :tier_lists, dependent: :destroy
    
    # Following Relationships
    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    # Followed Relationships
    has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :followers, through: :passive_relationships, source: :follower
    
    # Returns the hash digest of the given string
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database for use in persisten sessions
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
        remember_digest
    end

    # Returns a session token to prevent session hijacking, reuses the remember digest
    def session_token
        remember_digest || remember
    end
    
    # Returns true of the given token matches the digest
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    # Forgets a user
    def forget
        update_attribute(:remember_digest, nil)
    end

    # Activates an account
    def activate
        update_columns(activated: true, activated_at: Time.zone.now)
    end

    # Sends activation email
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    # Sets password reset attributes
    def create_reset_digest
        self.reset_token = User.new_token
        update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
    end

    # Sends password reset email
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    # Returns true if a passsword reset has expired
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    # Follows a user
    def follow(other_user)
        following << other_user unless self == other_user
    end

    # Unfollows a user
    def unfollow(other_user) 
        following.delete(other_user)
    end

    # Returns true if the current user is following the other user
    def following?(other_user)
        following.include?(other_user)
    end

    # Returns a user's tierlist feed
    def feed
        following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
        TierList.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
    end

    # Returns the users total movie count 
    def total_ranked_movie_count
        tier_lists.joins(tiers: :movies).where.not(tiers: { title: "Search Results" }).count
    end

    # Seaches User by username
    def User.search(search)
        if search
            User.where('username LIKE ?', "%#{search}%")
        else
            User.all
        end
    end

    private
        # Converts email to all lowercase
        def downcase_email
            self.email = email.downcase
        end   
        
        # Creates and assigns a activation token and digest
        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(activation_token)
        end
end
