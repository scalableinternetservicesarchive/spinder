namespace :db do
    desc "TODO"
    task setup: :environment do
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
    end
  
  end
  