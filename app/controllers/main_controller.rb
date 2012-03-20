class MainController < ApplicationController 
 KEY = ENV['KEY']
 SECRET = ENV['SECRET']

 API_URL = "http://api.face.com/faces/"
 URL = "http://dev.spuggy.co.uk/hackspy/upload/"


  def index

  end

  #manual add code:
  def add
    add_url = "http://api.face.com/tags/add"
    name = params[:name]
    label = params[:label]
    add = HTTParty.get(add_url, :query => {
  											:api_key => KEY, 
  											:api_secret => SECRET, 
  											:url => URL+name, 
  											:x => 100, 
  											:y => 100, 
  											:width => 100, 
  											:height => 100,
  											:uid => "Rich@karl.turner5", 
  											:tagger_id => "karl@karl.turner5",
  											:label => label})

    response = add.to_hash
  end



  def recognise
  	#http://localhost:3000/main/recognise?name=dicky.jpg   <- request needed
  	name = params[:name]
  	client = Face.get_client(:api_key => KEY, :api_secret => SECRET)
    data = client.faces_detect(:urls => [URL+name])

    # if data.to_hash["photos"][0]["tags"] != nil

    #   unless data.to_hash["photos"][0]["tags"][0] == nil
    #     smiling = data.to_hash["photos"][0]["tags"][0]["attributes"]["smiling"]["value"]
    #     confidence = data.to_hash["photos"][0]["tags"][0]["attributes"]["smiling"]["confidence"] 
    #     @all = ["Smiling?" => smiling, "Confidence?" => confidence]
    #   else
    #     @all = "Something went wrong"
    #   end
    # else
    	@all = data.to_hash
    # end

    respond_to do |format|
      format.html { render :json => @all.to_json }
      format.json { render :json => @all.to_json }
     end

  end


  # def save
  #   name = params[:name]
  #   label = params[:label]
  #   save_url = "http://api.face.com/tags/save.json"
  #   client = Face.get_client(:api_key => KEY, :api_secret => SECRET)
  #   data = client.faces_detect(:urls => [URL+name])
  #   tid = data["photos"][0]["tags"][0]["tid"]

  #   save= HTTParty.get(save_url, :query => {:api_key => KEY, :api_secret => SECRET, :uid => "Rich@karl.turner5", :tids => tid, :label => label })
  #   response = save.to_hash
  #   status = response["status"]
  #   message = response["message"]

  
  # #training code:
  #   train_url = "http://api.face.com/faces/train.json"
  #   train = HTTParty.get(train_url, :query => {:api_key => KEY, :api_secret => SECRET, :uids => "Rich@karl.turner5", :callback_url => redirect_uri})
  #   train_response = train.to_hash
  # end

  # def redirect_uri
  #   "http://" + request.host_with_port + "/callback"
  # end

end
