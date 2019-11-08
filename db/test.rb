#!/usr/bin/env ruby
require 'sqlite3'

begin
    
    db = SQLite3::Database.open "db/development.sqlite3"
    
    stm = db.prepare "SELECT * FROM song_infos LIMIT 20" 
    rs = stm.execute 
    
    rs.each do |row|
        puts row.join "\s"
    end
           
rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
ensure
    stm.close if stm
    db.close if db
end