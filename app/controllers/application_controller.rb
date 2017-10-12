class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  # index
  get '/recipes' do
    @recipes = Recipe.all
    erb :recipes
  end

  # new
  get '/recipes/new' do
    erb :new
  end

  # create
  post '/recipes' do
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{recipe.id}"
  end

  # show
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  # edit
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    recipe.update_attributes(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    recipe.save
    redirect "/recipes/#{recipe.id}"
  end

  # delete
  delete '/recipes/:id/delete' do
    recipe = Recipe.find(params[:id])
    recipe.delete
    redirect '/recipes'
  end

end
