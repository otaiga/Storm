class MainController < ApplicationController 
 KEY = ENV['KEY']
 SECRET = ENV['SECRET']

 API_URL = "http://api.face.com/faces/"
 URL = "http://dev.spuggy.co.uk/hackspy/upload/"


  def index

  end

  def add
    add_url = "http://api.face.com/tags/add"
    name = params[:name]
    label = params[:label]

    data = HTTParty.get(add_url, :query => {
  	  :api_key => KEY, 
  		:api_secret => SECRET, 
  		:url => URL+name, 
  		:x => 100, 
  		:y => 100, 
  		:width => 100, 
  		:height => 100,
  		:uid => "#{label}@karl.turner5", 
  		:tagger_id => "",
  		:label => label})

    @all = data

    respond_to  do |format|
      format.html { render :json => @all.to_json }
      format.json { render :json => @all.to_json }
    end
  end


  def remove
    tid_id = params[:tid_id]
    remove_url = "http://api.face.com/tags/remove.json"
    data = HTTParty.get(remove_url, :query => {
      :api_key => KEY, 
      :api_secret => SECRET,  
      :tids =>tid_id})

    @all = data

    respond_to  do |format|
      format.html { render :json => @all.to_json }
      format.json { render :json => @all.to_json }
    end
  end 


  def recognise
  	name = params[:name]
  	client = Face.get_client(:api_key => KEY, :api_secret => SECRET)
    data = client.faces_detect(:urls => [URL+name], :attributes => "all")
    @all = data

    respond_to do |format|
      format.html { render :json => @all.to_json }
      format.json { render :json => @all.to_json }
     end

  end




end
