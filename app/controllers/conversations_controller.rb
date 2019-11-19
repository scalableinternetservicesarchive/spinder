class ConversationsController < ApplicationController
  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  # GET pages/profile
  def get_matches
    if current_user

      # Get all the songs that a user likes
      songs = ActiveRecord::Base.connection.execute("""
                SELECT r.name, r.song_id, r.artist
                FROM songs l JOIN song_infos r ON r.song_id = l.song_id
                WHERE l.user_email = '#{current_user.name}';
            """)

      # Extract only the song id's (song_ids required to find matches in next query)
      song_id_arr = []
      for i in songs
        song_id_arr.push(i["song_id"])
      end

      # Run query that computes the matches that a user has, sorted from greatest to least
      matches = ActiveRecord::Base.connection.execute("""
                SELECT user_email, COUNT(*) AS cnt
                FROM songs
                WHERE (song_id IN ('#{song_id_arr.join("', '")}')) AND user_email != '#{current_user.name}'
                GROUP BY user_email
                ORDER BY cnt DESC;
            """)
      return matches
    else
      return []
    end
  end

  def new
    #TODO: replace this with one query to get matches
    matchedEmails = []
    get_matches.each do |doc|
      matchedEmails.push(doc["user_email"])
    end

    p matchedEmails
    @matchedUsers = []
    User.all.each do |user|
      if matchedEmails.include? user.email
        @matchedUsers.push(user)
      end
    end

  end

  def create
    recipient = User.find(params[:user_email])
    receipt =  current_user.send_message(recipient, params[:body], params[:subject])
    redirect_to conversations_path(receipt.conversation)
  end 
end
