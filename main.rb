     
require 'sinatra'
require 'sinatra/reloader' #if development? #if development? means it'll only execute once in development stage and its for computer not for heroku
require 'pry'
require 'pg'
require 'bcrypt'

enable :sessions

def user_found(users)
  if users.to_a.length > 0
    users[0]
  else
    nil
  end
end

def logged_in?
  !!session[:user_id]
end

def current_user
  if logged_in?
    user_id = session[:user_id]
    users = run_sql("SELECT * FROM users WHERE id= #{user_id}")
    user = user_found(users)
  else
    nil
  end
end


def run_sql(sql)
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'skincare_app'})
  results = db.exec(sql)
  db.close
  return results
end





require_relative 'controllers/skinlog_controller'
require_relative 'controllers/users_controller'