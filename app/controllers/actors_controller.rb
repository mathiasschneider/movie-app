class ActorsController < ApplicationController

  before_action :authenticate_admin, except: [:index, :show]

  def index
    render json: Actor.all.order(age: :desc)
  end

  def create
    actor = Actor.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      known_for: params[:known_for],
      age: params[:age],
      gender: params[:gender]
      movie_id: params[:movie_id]
    )
    if actor.save
      render json: actor
    else
      render json: actor.errors.full_messages
    end
  end

  def show
    actor = Actor.find(params[:id])
    render json: actor
  end
  
  def update
    actor = Actor.find(params[:id])
    actor.first_name = params[:first_name] || actor.first_name
    actor.last_name = params[:last_name] || actor.last_name
    actor.known_for = params[:known_for] || actor.known_for
    actor.age = params[:age] || actor.age
    actor.gender = params[:gender] || actor.gender
    actor.movie_id = params[:movie_id] || actor.movie_id
    actor.save
    if actor.save
      render json: actor
    else
      render json: actor.errors.full_messages
    end
  end

  def destroy
    actor = Actor.find(params[:id])
    actor.destroy
    render json: {message: "#{actor.first_name} #{actor.last_name} was destroyed."}
  end

  # def param_actor_method
  #   actor_id = params[:input_id]
  #   actor = Actor.find_by(id: actor_id)
  #   render json: {message: "#{actor["first_name"]} #{actor["last_name"]}"}
  # end

end
