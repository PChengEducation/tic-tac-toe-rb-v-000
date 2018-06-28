
board = [" "," "," "," "," "," "," "," "," "]

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]}  "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]}  "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]}  "
end

def input_to_index(user_input)
user_input = user_input.to_i
user_input = user_input - 1
end

def move(board, position = 0, char)
board[position] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
if !position_taken?(board, index) && index.between?(0,8) && board[index] == " "
  return true
else
  return false
end
end

def turn (board)
puts "Please enter 1-9:"
user_input = gets.strip
index = input_to_index(user_input)
if valid_move?(board, index)
  board[index]="X"
  display_board(board)
else
  turn(board)
end
end

def turn_count(board)
counter = 0
board.each do |occupied|
if occupied == "X" || occupied == "O"
  counter += 1
end
end
return counter
end

def current_player(board)
if turn_count(board)%2 == 0
return "X"
elsif turn_count(board)%2 == 1
return "O"
end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_set|
    if win_set.all? {|win_position| board[win_position] == "X"} || win_set.all? {|win_position| board[win_position] == "O"}
      return win_set
    elsif board.all? {|win_position| win_position == " "} || board.all? {|win_position| win_position == ""}
      false
    end
  end
  false
end

def full? (board)
WIN_COMBINATIONS.each do |win_set|
  if win_set.none? {|win_position| board[win_position] == " "}
    return true
  else
    return false
    end
  end
end

def draw? (board)
  won?(board)
  full?(board)
WIN_COMBINATIONS.each do |win_set|
if win_set.all? {|win_position| board[win_position] != "X"} && win_set.all? {|win_position| board[win_position] != "O"} && win_set.none? {|win_position| board[win_position] != " "}
  return true
elsif win_set.all? {|win_position| board[win_position] != "X"} || win_set.all? {|win_position| board[win_position] != "O"}
  return false
end
end
end

def over? (board)
if draw?(board)
  return true
elsif won?(board) && full?(board)
  return true
elsif won?(board) && !full?(board)
  return true
elsif !won?(board) && !full?(board)
  return false
end
end

def winner(board)
WIN_COMBINATIONS.each do |win_set|
if win_set.all? {|win_position| board[win_position] == "X"} && over?(board)
    return "X"
  elsif win_set.all? {|win_position| board[win_position] == "O"} && over?(board)
    return "O"
  elsif !won?(board) && over?(board)
    return nil
end
end
end
=begin
def play(board)
display_board(board)
until over?(board)
turn(board)
display_board(board)
current_player(board)
if won?(board) && current_player(board) == "X"
  puts "Congratulates X!"
elsif won?(board) && current_player(board) == "O"
  puts "Congratulates O!"
elsif draw?(board)
  puts "Cat's Game!"
end
end
end
=end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
