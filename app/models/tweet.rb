class Tweet < ApplicationRecord

	has_many :replies, dependent: :destroy
	has_many :likes, dependent: :destroy
	belongs_to :user

	validates(:post, presence: true)


end