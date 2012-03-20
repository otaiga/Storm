class MainController < ApplicationController

 KEY = ""
 SECRET = ""	

 API_URL = "http://api.face.com/faces/"



  def index

  end

  # def train
  #   HTTPARTY.post(API_URL + PATH :query => {:api_key => KEY, :api_secret => SECRET, uids => "Rich", :callback_url => redirect_uri})

  # 	#expect img url and name

  # end

  def recognise
  	#http://localhost:3000/main/recognise?name=dicky.jpg   <- request needed
  	name = params[:name]
  	client = Face.get_client(:api_key => KEY, :api_secret => SECRET)
    data = client.faces_detect(:urls => ["http://dl.dropbox.com/u/1512097/#{name}"])
    smiling = data.to_hash["photos"][0]["tags"][1]["attributes"]["smiling"]["value"]
    confidence = data.to_hash["photos"][0]["tags"][1]["attributes"]["smiling"]["confidence"]

    if smiling
      @all = ["Smiling?" => smiling, "Confidence?" => confidence]
    else
      @all = "Sorry, something went wrong"
    end

    respond_to do |format|
      format.html { render :json => @all.to_json }
      format.json { render :json => @all.to_json }
    end

  end


  def callback

  end

  def redirect_uri
    "http://" + request.host_with_port + "/callback"
  end

end
