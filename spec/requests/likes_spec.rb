# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes' do
  user1 = User.create!(name: 'example', email: 'test@example.com', password: '123456', password_confirmation: '123456')
  post1 = user1.posts.create!(content: 'A new post')

  let(:user_params) do
    {
      user: {
        email: 'test@example.com',
        password: '123456'
      }
    }
  end
  context 'when logged in' do
    before do
      post '/users/sign_in', params: user_params
    end

    it 'increase like count' do
      get posts_path
      post likes_path(like: { user_id: 1, post_id: 1 })

      expect(post1.reload.likes.count).to eq(1)
    end
  end

  context 'when not logged in' do
    it 'redirects to login path when trying to like without being logged in' do
      post likes_path(like: { user_id: 1, post_id: 1 })

      expect(response).to redirect_to('/users/sign_in')
    end
  end
end
