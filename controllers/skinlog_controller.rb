get '/' do
    skinlog = run_sql("SELECT * FROM skinlog ORDER BY id")
      #this skin_data is another variable which will call the run_sql function
      #to select skinlog from database
      error = ""
      like_button = ""
      time_date = Time.now.strftime("%d-%m-%y")
      
    erb :'/skinlog/index', locals: {
        skinlog: skinlog,
        error: error,
        like_button: like_button,
        time_date: time_date
      }
  end
  
  
  #new entry
  get '/skinlog/new' do
      erb :'/skinlog/new'
  end
    
  post '/newlog' do
      skin_concern = params["skin_concern"]
      day_no = params["day_no"]
      date_time = Time.now.strftime("%d-%m-%y")
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
      day_no = params["day_no"]
      product = params["product"]
      details = params["details"]
      
      #DONT PUT COMMAS UNDER RUBY BECAUSE ITS NOT NEEDED!!! PLEASE OBSERVE PROPERLY
    
      run_sql("UPDATE skinlog SET skin_concern='#{skin_concern}',image_url='#{skin_image_url}', day_no='#{day_no}', products='#{product}', details='#{details}' WHERE id=#{skinlog_id}")
    
      redirect '/'
      #erb is html which is for get request thats why we have erb file. But post,delete and patch method is redirect 
  end
  
  get '/contact' do
    erb :'/skinlog/contact'
  end