class ApplicationController < ActionController::Base
    def get_all_songs
        # Get the most recent event
        last_modified = SongInfo.order(:updated_at).last
        last_modified_str = last_modified.updated_at.utc.to_s(:number) 
        cache_key = "all_songs/#{last_modified_str}"
    
        all_songs = Rails.cache.fetch(cache_key) do 
          SongInfo.all.to_a
        end
    
        return all_songs
      end
  
      def get_liked_songs
          # Get the most recent event
          last_modified = Song.order(:updated_at).last
          last_modified_str = last_modified.updated_at.utc.to_s(:number) 
          cache_key = "liked_songs/#{last_modified_str}"
      
          liked_songs = Rails.cache.fetch(cache_key) do 
            ActiveRecord::Base.connection.execute("" "
              SELECT r.name, r.song_id, r.artist
              FROM songs l JOIN song_infos r ON r.song_id = l.song_id
              WHERE l.user_email = '#{params["user_email"]}';
          " "").to_a
          end
          return liked_songs
        end
    
      def get_liked_songs_only_id(email)
        # Get the most recent event
        last_modified = Song.order(:updated_at).last
        last_modified_str = last_modified.updated_at.utc.to_s(:number) 
        cache_key = "liked_songs_id/#{last_modified_str}"
    
        liked_songs = Rails.cache.fetch(cache_key) do 
          songs = ActiveRecord::Base.connection.execute("" "
            SELECT r.name, r.song_id
            FROM songs l JOIN song_infos r ON r.song_id = l.song_id
            WHERE l.user_email = '#{email}';
        " "").to_a
          l_set = Set.new
          for i in songs
              l_set.add(i["song_id"])
          end
          next l_set
        end
        return liked_songs
      end
    
      def get_disliked_songs
        # Get the most recent event
        last_modified = DislikedSong.order(:updated_at).last
        if last_modified == nil
          return Set.new
        end
  
        last_modified_str = last_modified.updated_at.utc.to_s(:number) 
        cache_key = "disliked_songs/#{last_modified_str}"
    
        disliked_songs = Rails.cache.fetch(cache_key) do 
          songs = ActiveRecord::Base.connection.execute("" "
            SELECT r.name, r.song_id
            FROM songs l JOIN song_infos r ON r.song_id = l.song_id
            WHERE l.user_email 
            = '#{params["user_email"]}';
        " "").to_a
          d_set = Set.new
          for i in songs
              d_set.add(i["song_id"])
          end
          next d_set
        end
        return disliked_songs
      end

      def get_user_matches(email)
        # Get the most recent event
        last_modified = Song.order(:updated_at).last
        last_modified_str = last_modified.updated_at.utc.to_s(:number) 
        cache_key = "matches/#{last_modified_str}"
        song_id_arr = get_liked_songs_only_id(email).to_a

        matches = Rails.cache.fetch(cache_key) do 
            ActiveRecord::Base.connection.execute("""
                SELECT user_email, COUNT(*) AS cnt
                FROM songs
                WHERE (song_id IN ('#{song_id_arr.join("', '")}')) AND user_email != '#{email}'
                GROUP BY user_email
                ORDER BY cnt DESC;
            """).to_a
        end

        return matches
    end

end
