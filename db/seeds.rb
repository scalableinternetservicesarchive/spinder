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
SongInfo.create({
    song_id: "1",
    name: "Test song",
    artist: "Matthew Wang",
    image_url: "hippo"
})