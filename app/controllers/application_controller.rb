class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  	redirect '/recipes'
  end

  get '/recipes' do
  	@recipes = Recipe.all
  	erb :index
  end

  get '/recipes/new' do
  	erb :new
  end

  post '/recipes' do
  	Recipe.create(params)
  	redirect "/recipes/#{Recipe.find_by(params).id}"
  end

  get '/recipes/:id' do
  	@recipe = Recipe.find(params[:id])
  	erb :show
  end

  get '/recipes/:id/edit' do
  	erb :edit
  end

  patch '/recipes/:id/edit' do
        @recipe = Recipe.find(params[:id])
        @recipe.update(name: params[:name])
        @recipe.update(ingredients: params[:ingredients])
        @recipe.update(cook_time: params[:cook_time])
        redirect '/recipes/' + params[:id]
  end


  delete '/recipes/:id' do
        @recipe = Recipe.find(params[:id])
        @recipe.destroy
        redirect '/recipes'
  end

end
