# Acey Ducey: adapted from the original BASIC game written by Bill Palmby and
# published in BASIC Computer Games, edited by David H. Ahl, 1978

# The who_wins method returns 'computer' or 'player' based on parameters
def who_wins(card1, card2, player_card)
  # assumes the three input parameters are members of the 'deck' hash, below
  # determines if the player_card is BETWEEN the values of card1 and card2
  # if so, the player wins, if not, the computer wins.
  winner = "computer"

  if card1[0] > card2[0] 
    if card2[0] < player_card[0] && player_card[0] < card1[0]
      winner = "player"
    end
  elsif card1[0] < player_card[0] && player_card[0] < card2[0]
    winner = "player"
  end
  return winner
end

# The pretty_print method returns a long name for a given card (parameter)
def pretty_print(card)
  # assumes the input parameter is a member of the 'deck' hash, below
  # returns the long name for the card (e.g. [12, Hearts] = "Queen of Hearts"
  case card[0]
    when 11
      cardname = "Jack of " + card[1]
    when 12
      cardname = "Queen of " + card[1]
    when 13
      cardname = "King of " + card[1]
    when 14
      cardname = "Ace of " + card[1]
    else
      cardname = card[0].to_s + " of " + card[1]
  end 
  return cardname

end

# The get_deck method returns a hash representing a deck of 52 poker cards
def get_deck
  deck = {}
  deck['2H'] =  [2,'Hearts']  #Hearts
  deck['3H'] =  [3,'Hearts']
  deck['4H'] =  [4,'Hearts']
  deck['5H'] =  [5,'Hearts']
  deck['6H'] =  [6,'Hearts']
  deck['7H'] =  [7,'Hearts']
  deck['8H'] =  [8,'Hearts']
  deck['9H'] =  [9,'Hearts']
  deck['10H'] = [10,'Hearts']
  deck['JH'] =  [11,'Hearts']
  deck['QH'] =  [12,'Hearts']
  deck['KH'] =  [13,'Hearts']
  deck['AH'] =  [14,'Hearts']
  deck['2D'] =  [2,'Diamonds']  #Diamonds
  deck['3D'] =  [3,'Diamonds']
  deck['4D'] =  [4,'Diamonds']
  deck['5D'] =  [5,'Diamonds']
  deck['6D'] =  [6,'Diamonds']
  deck['7D'] =  [7,'Diamonds']
  deck['8D'] =  [8,'Diamonds']
  deck['9D'] =  [9,'Diamonds']
  deck['10D'] = [10,'Diamonds']
  deck['JD'] =  [11,'Diamonds']
  deck['QD'] =  [12,'Diamonds']
  deck['KD'] =  [13,'Diamonds']
  deck['AD'] =  [14,'Diamonds']
  deck['2S'] =  [2,'Spades']  #Spades
  deck['3S'] =  [3,'Spades']
  deck['4S'] =  [4,'Spades']
  deck['5S'] =  [5,'Spades']
  deck['6S'] =  [6,'Spades']
  deck['7S'] =  [7,'Spades']
  deck['8S'] =  [8,'Spades']
  deck['9S'] =  [9,'Spades']
  deck['10S'] = [10,'Spades']
  deck['JS'] =  [11,'Spades']
  deck['QS'] =  [12,'Spades']
  deck['KS'] =  [13,'Spades']
  deck['AS'] =  [14,'Spades']
  deck['2C'] =  [2,'Clubs']  #Clubs
  deck['3C'] =  [3,'Clubs']
  deck['4C'] =  [4,'Clubs']
  deck['5C'] =  [5,'Clubs']
  deck['6C'] =  [6,'Clubs']
  deck['7C'] =  [7,'Clubs']
  deck['8C'] =  [8,'Clubs']
  deck['9C'] =  [9,'Clubs']
  deck['10C'] = [10,'Clubs']
  deck['JC'] =  [11,'Clubs']
  deck['QC'] =  [12,'Clubs']
  deck['KC'] =  [13,'Clubs']
  deck['AC'] =  [14,'Clubs']
  return deck 
end 

# The Acey-Ducey game begins!
# ---------------------------
puts "Acey-Ducey is played in the following manner"
puts "the dealer (computer) deals two cards face up."
puts "You have an option to bet or not bet depending"
puts "on whether or not you feel the next card will have"
puts "a value between the first two."
puts "If you do not want to bet, enter 0."
puts ""
puts "You have 100 dollars. Ace is the highest card, 2 is the lowest card."
puts ""

player_money = 100     # keep track of the player's money 
round = 1              # count the number of rounds that are dealt 
chicken_count = 0      # we are going to count the number of times they don't bet
#shuffle the deck (shuffle the array of keys to the card values)
deck = get_deck
shuffled_cards = deck.keys.shuffle 

puts "Round " + round.to_s 
puts "Here are your first two cards:"
card1 = deck[shuffled_cards[0]]
card2 = deck[shuffled_cards[1]]
puts pretty_print(card1) + ", " + pretty_print(card2)
next_card = 2

# play until we've dealt all the rounds in the deck, or the player's money runs out
while player_money > 0 && next_card <= 51 # The deck has cards 0 through 51 (52 cards)
  puts "What is your bet?"
  bet = gets.chomp.to_i
  puts
  if bet > player_money
    puts "You don't have that much money!  No bet."
  elsif bet <= 0 
    chicken_count = chicken_count + 1
    puts "Chicken!"
  else
    player_card = deck[shuffled_cards[next_card]]
    next_card = next_card + 1
    puts "Your card is: " + pretty_print(player_card)
    winner = who_wins(card1, card2, player_card)
    if winner == "player"
      puts "You win!  Lucky bet."
      player_money = player_money + bet
    else
      puts "Too bad!  You lose."
      player_money = player_money - bet
    end
  end
  
  puts "You now have " + player_money.to_s + " dollars."
  if player_money > 0 && next_card <= 49 # we need three cards to play another round if the player has money
    round = round + 1
    puts 
    puts "Round " + round.to_s 
    puts "Here are your next two cards:"
    card1 = deck[shuffled_cards[next_card]]
    card2 = deck[shuffled_cards[next_card + 1]]
    puts pretty_print(card1) + ", " + pretty_print(card2)
    next_card = next_card + 2
  elsif player_money == 0
    puts "Money's all gone!"
  else # The player has money, but we don't have enough cards for another round.  They win!
    next_card = 52
  end

end

# Either the money is all gone, or we've gone through the deck.  Say good bye!
if player_money == 0 
  puts "You lose! Better luck next time." 
else
  puts "That was the last round of cards in the deck.  You win!"
end
puts "Wow, you chickened out " + chicken_count.to_s + " times!" 
puts