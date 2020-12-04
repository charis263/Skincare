     
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


get '/signup/new' do
  "Signup to get started"
  erb :'/user/new_user'
end

post '/signup' do
  first_name = params["first_name"]
  last_name = params["last_name"]
  user_email = params["email"]
  user_password = params["password"]
  password_digest = BCrypt::Password.create(user_password)

  run_sql("INSERT INTO users(first_name, last_name, email, password_digest) VALUES('#{first_name}','#{last_name}','#{user_email}', '#{password_digest}')")
  redirect '/'
end

post '/' do
  user_email = params["email"]
  user_password = params["password"]
  users = run_sql("SELECT * FROM users WHERE email = '#{user_email}'")
  user = user_found(users)
  skinlog = run_sql("SELECT * FROM skinlog ORDER BY id")
  error = ""
  like_button = ""
  
  if user && BCrypt::Password.new(user['password_digest']) == params['password']
    session[:user_id] = user['id']
    redirect '/'
  else
    error = "Wrong details, please try again"
    erb :'/skinlog/index', locals:{
      error: error,
      skinlog: skinlog,
      like_button: like_button
    }
  end
end

delete '/' do
  session[:user_id]=nil
  redirect '/'
end



get '/' do
  skinlog = run_sql("SELECT * FROM skinlog ORDER BY id")
    #this skin_data is another variable which will call the run_sql function
    #to select skinlog from database
    error = ""
    like_button = ""
    
  erb :'/skinlog/index', locals: {
      skinlog: skinlog,
      error: error,
      like_button: like_button
    }
end


#new entry
get '/skinlog/new' do
    erb :'/skinlog/new'
end
  
post '/newlog' do
    skin_concern = params["skin_concern"]
    day_no = params["day_no"]
    date_time = params["date_time"]
    skin_image_url = params["image_url"]
    product = params["product"]
    details = params["details"]
    #params are taken from name of input tag in new.erb file
    run_sql("INSERT INTO skinlog (skin_concern, day_no, date_time, image_url, products, details) VALUES('#{skin_concern}', '#{day_no}','#{date_time}', '#{skin_image_url}', '#{product}', '#{details}')")
    #got #{} to make them string interpolation and putting string in the interpolation so that it'll convert the output to string
    #DONT PUT erb link for post request (e.g. erb :new) only for get request.use redirect "router name" instead to send u back to '/' route url. because if use erb:new will make user being prompted to resubmit and in the end they'll have 2 records since they'll resubmit twice
    redirect '/'
  
end
  
  # route is made of the request aka the verb/action (get/post) + route/path (e.g. /food) - the verb has to be written in lowercase for sinatra
  
delete '/skinlog/:id' do
    #to make it restful route
    skinlog_id = params["id"]
    run_sql("DELETE FROM skinlog WHERE id=#{skinlog_id};")
  
    redirect '/'
end
  
get '/skinlog/:id/edit' do
    skinlog_id = params["id"]
    puts skinlog_id
    skinlog = run_sql("SELECT * FROM skinlog WHERE id=#{skinlog_id}")
    skin_condition = skinlog_id[0]
    #only in server file: when u :id it allows u to go params["id"] and access whatever we put in index.erb file hyperlink area
    erb :'/skinlog/edit', locals: {
      skinlog: skinlog
    }
end
  
  #patch request same as put as both for updating.
patch '/skinlog/:id' do
    skinlog_id = params["id"]
    skin_concern = params["skin_concern"]    
    skin_image_url = params["image_url"]
    
    #DONT PUT COMMAS UNDER RUBY BECAUSE ITS NOT NEEDED!!! PLEASE OBSERVE PROPERLY
  
    run_sql("UPDATE skinlog SET skin_concern='#{skin_concern}',image_url='#{skin_image_url}' WHERE id=#{skinlog_id}")
  
    redirect '/'
    #erb is html which is for get request thats why we have erb file. But post,delete and patch method is redirect 
end

get '/contact' do
  erb :'/skinlog/contact'
end