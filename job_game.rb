require 'gosu'

class JobGame < Gosu::Window
    def initialize 
        super(800,600)
        self.caption = "Apply Apply Apply"
        @image = Gosu::Image.new('images/helpwanted.png')
        @x = 200
        @y = 200

        ## image size
        @width = 100
        @height = 100


        @velocity_x = 5
        @velocity_y = 5 
    end

    def draw 
        @image.draw(@x-@width/2,@y-@height/2,1)
    end

    def update
        @x += @velocity_x
        @y += @velocity_y
        @velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width /2 < 0
        @velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height /2  < 0   

    end


end

window = JobGame.new
window.show