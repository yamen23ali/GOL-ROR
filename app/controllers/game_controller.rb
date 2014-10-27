class GameController < ApplicationController
 
 	def index
 		@@grid=Grid.new(600,600,10) # width ,height , step
 	end

 	def next_generation
 	end

 	def change_seed
 		x=params[:x]
 		y=params[:y]
 		result=@@grid.add_remove_seed(x.to_i,y.to_i)
 		render :json =>{"result"=>result}
 	end

 	def generate
 		frames=params[:frames].to_i
 		result=Hash.new
 		(1..frames).each{ 
 			result=@@grid.next_generation
 		}
 		render :json => result.to_json
 	end

end
