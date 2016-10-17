require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @post = Post.create(name: params[:name], content: params[:content])
    erb :show
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    erb :edit
  end

  patch 'posts/:id/' do
    @post = Post.find(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save

    redirect '/posts/' + 'params[:id]'
  end

  delete '/posts/:id/delete' do
    @post = Post.find_by(id: params['id'])
    @post.delete
    erb :deleted
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    redirect '/posts/' + params[:id]
  end

end
