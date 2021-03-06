# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments
  validates :content, length: { maximum: 255 }, presence: true
end
