
class ConversationsController < ApplicationController
  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def new
    #TODO: replace this with one query to get matches
    puts 'hello1'
    matchedEmails = []
    matches = get_user_matches(current_user.name)
    matches.each do |doc|
      matchedEmails.push(doc["user_email"])
    end

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
