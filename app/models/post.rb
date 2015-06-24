class Post < ActiveRecord::Base
	has_many :images, dependent: :destroy
	has_many :pages
end
