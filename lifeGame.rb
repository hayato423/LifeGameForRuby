$ROW = 8
$COL = 8


def init_board()
    srand(3)
    board = Array.new($ROW).map{Array.new($COL,0)}
    board.map! do |row|
        next row.map! do |index|
            r = rand(100)
            if r.even? then next 1
            else next 0
            end
        end
    end
    return board
end


def draw(b)
    for y in 0...$ROW do
        for x in 0...$COL do
            if b[y][x] == 1 then
                print "■"
            else
                print "□"
            end
            if x < $COL - 1 then
                print " "
            else
                print "\n"
            end
        end
    end
    print "\n"
end


def dead_or_alive(b)
    nb = Array.new($ROW).map{Array.new($COL,0)}
    for y in 0...$ROW do
        for x in 0...$COL do
            alive_cells = 0
            (-1..1).each do |i|
                (-1..1).each do |j|
                    if y+i < 0 or y+i >= $ROW or x+j < 0 or x+j >= $COL or (i==0 and j==0) then next
                    else
                        alive_cells += b[y+i][x+j]
                    end
                end
            end
            if b[y][x] == 0 and alive_cells == 3 then nb[y][x] = 1
            elsif b[y][x] == 1 and alive_cells <= 1 then nb[y][x] = 0
            elsif b[y][x] == 1 and alive_cells >= 4 then nb[y][x] = 0
            else nb[y][x] = b[y][x]
            end
        end
    end
    return nb
end

board = init_board()
gen = 1
puts "gen:#{gen}"
draw(board)
while true do
    gen += 1
    board = dead_or_alive(board)
    draw(board)
    puts "gen:#{gen}"
    sleep 0.3
end