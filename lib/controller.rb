require 'gossip'
require 'comment'

class ApplicationController < Sinatra::Base
	attr_accessor :all_gossips

	get '/' do
	erb :index, locals: {gossips: Gossip.all}
	end

	get '/gossips/new/' do
	erb :new_gossip
	end

	post '/gossips/new/' do
	Gossip.new(params["gossip_author"], params["gossip_content"]).save
	redirect '/'
	end

	get '/gossips/:id' do
    erb :show, locals: { gossip: Gossip.find(params['id'].to_i), comments: Comment.all_for_gossip(params['id']) }
  	end

  	 # Edit gossip x
  	get '/gossips/:id/edit' do
    erb :edit, locals: { gossip: Gossip.find(params['id'].to_i) }
  	end

  	# Edit gossip x - post
 	 post '/gossips/:id/update' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).update(params["id"].to_i)
    redirect '/'
  	end

  	# New comment - post
  	post '/gossips/:id/comment' do
    Comment.new(params['id'], params["gossip_author"], params["gossip_content"]).save
    redirect '/gossips/' + params['id']
  	end

end
