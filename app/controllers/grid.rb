require "Cell.rb"
class Grid
 
 	#====== Initialize Members
 	def initialize(width,height,step)
 		@width=width
 		@height=height
 		@step=step
 		@cells=Array.new(height+2) { Array.new(width+2) } 
 		# build grid of cells
 		mlogger=Logger.new("#{Rails.root}/log/my.log")
 		mlogger.info(@cells)
 		mlogger.info(@cells[1][2])
 		(0..height+1).each{ |i|
 			(0..width+1).each{ |j|
                 @cells[i][j] = Cell.new((i-1)*step,(j-1)*step)

 			}

 		}
 	end

 	#====== Update Grid
 	def update
 		(1..@height).each{ |i|
 			(1..@width).each { |j|
 				@cells[i][j].update_status
 			}

 		}
 	end

	#==== Get NExt Generation
	def next_generation

		live_cells=Array.new

		(1..@height).each{ |i|
			(1..@width).each{ |j|
				#live_neighbours=get_live_neighbours(i,j)
				live_neighbours=(@cells[i-1][j-1].current_status + @cells[i-1][j].current_status + @cells[i-1][j+1].current_status + 
								 @cells[i][j-1].current_status + @cells[i][j+1].current_status + 
								 @cells[i+1][j-1].current_status + @cells[i+1][j].current_status + @cells[i+1][j+1].current_status)
				cell=@cells[i][j]

				# if cell is live
				if cell.current_status==1
					if live_neighbours==3 || live_neighbours==2  
						live_cells <<  [ cell.x , cell.y ] 	#keep it live for the next generation	
					else
						cell.kill  # kill it
					end
				elsif live_neighbours==3  #if cell is dead but have 3 live neighbours
					live_cells <<  [ cell.x , cell.y ]		#revive the cell in the next generation
					cell.revive
				end
			}
		}
		
		#update the values ( move to next generation)
		update

		return live_cells
	end

	# Add Cell as seed ( when user click on it)
	/ Add Cell as seed ( when user click on it) 
	* @param x : the x coordinates where user cliked
	* @param y : the y coordinates where user cliked
	* @return 1 : if cell is live , 0 : if cell is dead
	*/
	def add_remove_seed(x,y)
		return @cells[(y/@step)+1][(x/@step)+1].set_cell_seed
	end
 	
end
