# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# t.string "song_id"
# t.string "name"
# t.string "artist"
# t.string "image_url"

require "json"
require "devise"
require "bcrypt"

song_data = JSON.parse(File.read(File.dirname(__FILE__) + "/all_songs.json"))["items"]

for song in song_data do
    
    image_url_nf = 'https://sciences.ucf.edu/psychology/wp-content/uploads/sites/63/2019/09/No-Image-Available.png'
    image = ''
    if song["track"]["album"]["images"] == []
        image = image_url_nf
    else
        image = song["track"]["album"]["images"][0]["url"]
    end
    
    SongInfo.create({
        song_id: song["track"]["id"],
        name: song["track"]["name"],
        artist: song["track"]["artists"][0]["name"],
        sample_url: song["track"]["preview_url"],
        image_url: image
    })
      
end

# Load fake users
cur_user_domain ="@test.com"
  
values = ""
song_values = ""
500.times { |n|
  email = "a" + n.to_s + cur_user_domain
  song_id = "3SdTKo2uVsxFblQjpScoHy"
  encrypted_password = '$2y$13$0Uz7oBtWPr.tEi8XNYTEaO2LZl64/4skBndMz1V..gBivS3nPamjO'
  values.concat("('#{email}', '#{encrypted_password}', '#{Time.now}', '#{Time.now}'),")
  song_values.concat("('#{email}', '#{song_id}', '#{Time.now}', '#{Time.now}'),")
}

values = values[0...-1]
song_values = song_values[0...-1]
ActiveRecord::Base.connection.execute("INSERT INTO users (email, encrypted_password, created_at, updated_at) VALUES #{values}")
ActiveRecord::Base.connection.execute("INSERT INTO songs (user_email, song_id, created_at, updated_at) VALUES #{song_values}")