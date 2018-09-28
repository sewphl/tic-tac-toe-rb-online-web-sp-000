
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0,1,2],  # Top row
[3,4,5],  # Middle row
[6,7,8],  # Bottom row
[0,3,6],  # First col
[1,4,7],  # Second col
[2,5,8],  # Third col
[0,4,8],  # First diagonal
[2,4,6]   # Second diagonal
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)  ##= "X"
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
  display_board(board)
end

##this tells us how many turns have been played
def turn_count(arr)
    i = 0
    arr.each_with_index do |ele,idx|
        if arr[idx] !=nil && arr[idx] != " "
            i += 1
        end
    end
    i
end

##this tells us whether the current player is X or O,
##based on number of turns played (relies on turn_count above)
def current_player(arr)
    j = turn_count(arr)
    if j % 2 == 0
        return "X"
    else
        return "O"
    end
end

def won?(board)
    ## #find will return the first combo that evals to true
    WIN_COMBINATIONS.find do |combo|
        ##all positions in the combo are the same, and all are non-empty (if one is, all are, since all must be same)
        board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && position_taken?(board,combo[2])
        #also note: this will return the combo for ANYTHING that's three of the same non-empty value that gets three in a row.
        ##it's not specific to just X and O.
    end
end


def full?(board)
    board.all? do |ele|
        ele=="X" || ele=="O"
    end
end

#Build a method #draw? that accepts a board and returns true if the board has not been won but is full,
##false if the board is not won and the board is not full, and false if the board is won.
def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end

##Build a method #over? that accepts a board and returns true if the board has been won, is a draw, or is full.
def over?(board)
    w = won?(board)
    if w.kind_of?(Array) == true || draw?(board) == true || full?(board) == true
        return true
    end
end

def winner(board)
    w = won?(board)
    if w.kind_of?(Array) == true
        return board[w[0]]
    end
end

def play(board)
  until over?(board) || won?(board)
    turn(board)
  end
  iwon = winner(board)
  if iwon != false
    puts "Congratulations #{iwon}!"
  elsif draw?(board)
    puts "Cat\'s Game!"
  end
end
