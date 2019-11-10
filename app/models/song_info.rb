class SongInfo < ApplicationRecord
  validates :name, uniqueness: true
end
