class Reply < ApplicationRecord

	belongs_to :user
	belongs_to :tweet

	validates(:post, presence: true)


end