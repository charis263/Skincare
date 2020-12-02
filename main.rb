     
require 'sinatra'
require 'sinatra/reloader' if development? #if development? means it'll only execute once in development stage and its for computer not for heroku
require 'pry'
require 'pg'
require 'bcrypt'

enable :sessions

def run_sql(sql)
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'skincare_app'})
  results = db.exec(sql)
  db.close
  return results
end

get '/' do
  erb :index
end

get '/new' do
  "Signup to get started"
  erb :'/user/new_user'
end




get '/login' do
  erb :login
end

post '/' do
  user_email = params["email"]
  user_password = params["password"]

  users = run_sql("SELECT * FROM users WHERE email = '#{user_email}''")
end




