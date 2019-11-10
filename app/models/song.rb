class Song < ApplicationRecord
  validates :user_email, uniqueness: {scope: :song_id}
end
