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