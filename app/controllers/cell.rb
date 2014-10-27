class Cell

	attr_accessor :current_status
	attr_accessor :next_status
	attr_accessor :x
	attr_accessor :y
 
    #======= Initialize Members
 	def initialize(x,y)
 		@x=x
 		@y=y
 		@current_status=0
 		@next_status=0
 	end

 	#====== Kill This Cell
 	def kill
 		@next_status=0
 	end

 	#====== Revive This Cell
 	def revive
 		@next_status=1
 	end

    #====== Set seed
 	# Revive or kill the cell in the current and next generation ( depends on user click )
	# this function is used when the cell is selected or unselected as a seed 
	def set_cell_seed
		#mlogger=Logger.new("#{Rails.root}/log/my.log")
		#mlogger.info("before")/
		
		if @current_status==0
			@current_status=1
			@next_status=1
			return 1
		else
			@current_status=0
			@next_status=0
			return 0
		end
	end

	#===== Update Cell Status
	def update_status
		@current_status=@next_status
	end


 	
end
