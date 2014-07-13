#blackjack_r3.rb

#Full deck - ok (r3)
#Distinguish between 4 suits
#Repeat game


def draw_card(carddeck, cardhand)
  numcards = carddeck.length
  randindex = rand(numcards)
  tempcard = carddeck[randindex]
  cardhand.push(tempcard)
  carddeck.delete_at(randindex)
end

#1st Card Deal - 2 cards each
def initial_deal(carddeck, player1, dealer)
  for i in 1..2 do
    #player
    draw_card(carddeck, player1)
    #dealer
    draw_card(carddeck, dealer)
    i += 1
  end
end

#initial score check before final
def check_total (player1, player1_total)
  player1.each do |card|
    if card == "Jack" || card == 
      "Queen" || card == "King"
      player1_total += 10
    elsif card == "Ace"
      player1_total += 1
    elsif card >= 1 && card <= 10
      player1_total += card
    else
      player1_total += 0
    end
  end
  player1_total
end

def player_hits(carddeck, player1)
  player1_total = check_total(player1, 0)
  puts "Player hits."
  draw_card(carddeck, player1)
  p player1
  player1_total = check_total(player1, 0)
end

def dealer_hits(carddeck, dealer, player_choice)
  dealer_total = check_total(dealer, 0)
  if dealer.include?("Ace") && (dealer_total + 10) >= 17
    puts "Dealer declines hit."
    dealer_total += 10

  elsif player_choice == "h"
    if dealer_total < 17 
      puts "Dealer hits."
      draw_card(carddeck, dealer)
    else 
      puts "Dealer declines hit." #dealer_total >= 17
    end

  elsif player_choice == "p"
    if dealer_total < 17
      puts "Dealer hits."
      draw_card(carddeck, dealer)
      dealer_hits(carddeck, dealer, player_choice) #recursive
    else 
      puts "Dealer declines hit." #when dealer_total >= 17
    end
  end
  dealer_total = check_total(dealer, 0)
  dealer_total
end



def hit_or_play(carddeck, player1, dealer)
  puts "Player: Type 'h' to hit or 'p' to play:"
  player_choice = gets.chomp
    #to add function to check input
  if player_choice == "h"
    player_hits(carddeck, player1)
    dealer_hits(carddeck, dealer, player_choice)
    hit_or_play(carddeck, player1, dealer) #recursive
  elsif player_choice == "p"
    puts "Player plays cards."
    dealer_hits(carddeck, dealer, player_choice)
  else
    puts "ERROR: Invalid input."
    hit_or_play(carddeck, player1, dealer)
  end
end


def check_finaltotal (player1, player1_total)
  player1.each do |card|
    if card == "Ace" && (player1_total + 10) <= 21 
      player1_total += 10
    else
      player1_total += 0
    end
  end
  player1_total
end


def display_final(player1, player1_total, dealer, dealer_total)
  puts "Player: #{player1} => Score: #{player1_total}"
  puts "Dealer: #{dealer} => Score: #{dealer_total}"
end


def compare_hands (dealer_total, player1_total)
  if dealer_total > 21
    if player1_total > 21
      puts "RESULT: Both dealer & player lose. No winner."
    else
      puts "RESULT: Player wins!"
    end
  elsif player1_total > 21
    puts "RESULT: Player loses. Dealer wins!"
  elsif player1_total == dealer_total
    puts "RESULT: Draw. No winner."
  elsif player1_total > dealer_total
    puts "RESULT: Player wins!"
  else
    puts "RESULT: Dealer wins!"
  end
end

# cardsuits = ["Clubs", "Diamonds", "Hearts", "Spades"]
# cardranks = ["Ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King"]
carddeck2 = ["Ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King"]
dealer_hand = []
player1_hand = []
player1_total = 0
dealer_total = 0

#<----MAIN USER INTERFACE--->

initial_deal(carddeck2, player1_hand, dealer_hand)
# player1_hand = [10, "Ace"]
# dealer_hand = ["Ace", "Jack"]
puts "<---Initial Deal--->"
puts "Player: #{player1_hand}"
puts "Dealer 1st card: #{dealer_hand[0]}\n\n"
player1_total = check_total(player1_hand, player1_total)
dealer_total = check_total(dealer_hand, dealer_total)
player1_total = check_finaltotal(player1_hand, player1_total)
dealer_total = check_finaltotal(dealer_hand, dealer_total)

#dealer draws ace
if dealer_hand.include?("Ace") && dealer_total == 21
  #player draws ace too
  if player1_hand.include?("Ace") && dealer_total == 21
    display_final(player1_hand, player1_total, dealer_hand, dealer_total)
    puts "RESULT: Both drew aces. No winner."
  else
    display_final(player1_hand, player1_total, dealer_hand, dealer_total)
    puts "RESULT: Dealer wins!"
  end
#player draws ace
elsif player1_hand.include?("Ace") && player1_total == 21
  display_final(player1_hand, player1_total, dealer_hand, dealer_total)
  puts "RESULT: Player drew aces. Player wins!"

#neither draws ace
else
  puts "<---Hit or Play--->"
  hit_or_play(carddeck2, player1_hand, dealer_hand)
  player1_total = check_total(player1_hand, 0)
  dealer_total = check_total(dealer_hand, 0)

  puts "\n<---Compare Hands--->"
  player1_total = check_finaltotal(player1_hand, player1_total)
  dealer_total = check_finaltotal(dealer_hand, dealer_total)
  display_final(player1_hand, player1_total, dealer_hand, dealer_total)
  compare_hands(dealer_total, player1_total)
end

# p carddeck2
# p carddeck2.length
# drawncards = player1_hand.length + dealer_hand.length
# p drawncards

