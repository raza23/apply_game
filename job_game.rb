require 'gosu'

class ViewsGame < Gosu::Window
    def initialize 
        super(800,600)
        self.caption = "Views"
        # @image = Gosu::Image.new('images/helpwanted.png')
        @image = Gosu::Image.new('images/nash3.png')

        @x = 200
        @y = 300
        
        ## image size
        @width = 100
        @height = 144
        
        
        @velocity_x = 2
        @velocity_y = 2
        @visible = 0
        # @cursor = Gosu::Image.new('images/resume.png')
        @cursor = Gosu::Image.new('images/dobrik1.png')

        # @celebrate = Gosu::Image.new('images/hired.png')
        @hit = 0
        @font = Gosu::Font.new(30)
        @score = 0
        @playing = true
        @start_time = 0
    end

    def draw 
        if @visible > 0 
            @image.draw(@x-@width/2,@y-@height/2,1)
        end

        @cursor.draw(mouse_x - 200 ,mouse_y - 228,1)

        if @hit == 0
            screen = Gosu::Color::NONE
        elsif @hit == 1
            screen = Gosu::Color::GREEN
        elsif @hit == -1 
            screen = Gosu::Color::RED
        end
        draw_quad(0,0,screen,800,0,screen,800,600,screen,0,600,screen)
        @hit = 0
        @font.draw("Score:",570,50,2)
        @font.draw(@score.to_s,650,50,2)
        @font.draw("Time:",50,50,2)
        @font.draw(@time_left.to_s,120,50,2)
        unless @playing 
            if @score < 1
            @font.draw("KEEP SHOOTING",300,300,3)
            @font.draw("Press SpaceBar to Replay",300,500,3)
            @visible =20
            else 
                @font.draw("HAHAHA",300,300,3)
                @font.draw("Press SpaceBar to Replay",300,500,3)
                @visible=20
                # @celebrate.draw(mouse_x - 150 ,mouse_y - 150,1)
                screen = Gosu::Color::BLUE
                draw_quad(0,0,screen,800,0,screen,800,600,screen,0,600,screen)
            end
        
    end

    def update
        if @playing 
            @x += @velocity_x
            @y += @velocity_y
            @velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width /2 < 0
            @velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height /2  < 0  
            @visible -= 1
            @visible = 50 if @visible < -1 && rand < 0.01 
            @time_left = (30 - ((Gosu.milliseconds-@start_time)/1000))
            @playing = false if @time_left < 1
        end

    end

    def button_down(id)
        if @playing 
            if (id == Gosu::MsLeft)
              if Gosu.distance(mouse_x,mouse_y,@x,@y) < 100 && @visible >=0 
                 @hit = 1
                 @score +=10
             else
                    @hit = -1
                    @score -=10
            end
        end
    else 
        if (id == Gosu::KbSpace)
            @playing=true
            @visible=10
            @start_time= Gosu.milliseconds
            @score = 0
        end
    end
end
end


end

window = ViewsGame.new
window.show