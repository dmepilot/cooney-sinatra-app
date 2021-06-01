class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true 


    def slug
        self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def self.find_by_slug(slugx)
        user=User.all
        slugged = User.all.find_index do |user|
            user.slug == slugx
        end
        user[slugged]
    end
end
