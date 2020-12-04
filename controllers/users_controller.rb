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
  