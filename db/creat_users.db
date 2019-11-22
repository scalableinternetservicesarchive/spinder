require "devise"
require "bcrypt"

cur_user_domain ="@test.com"

def encrypt_pass(password)
    ::BCrypt::Password.create(password, cost: 12).to_s
end

values = ""
100000.times { |n|
    email = "a" + n.to_s + cur_user_domain
    encrypted_password = encrypt_pass('password')
    values.concat("('#{email}', '#{encrypted_password}', '#{Time.now}', '#{Time.now}'),")
}

values = values[0...-1]
ActiveRecord::Base.connection.execute("INSERT INTO users (email, encrypted_password, created_at, updated_at) VALUES #{values}")