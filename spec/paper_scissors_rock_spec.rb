# require 'rspec'
require_relative '../paper_scissors_rock'

describe 'paper, scissors, rock' do
  ## Note: Seeding the randomizer so the computer will always pick paper for testing

  it 'paper beats rock' do
    psr = PSR.new(guess: "rock")
    psr.rand_seed = 0
    expect(psr.winner_is).to eq("Computer wins")
  end

  # also check downcase
  it 'paper loses to scissors' do
    psr = PSR.new(guess: "Scissors")
    psr.rand_seed = 0
    expect(psr.winner_is).to eq("You win!")
  end

  it 'paper ties with paper' do
    psr = PSR.new(guess: "paper")
    psr.rand_seed = 0
    expect(psr.winner_is).to eq("Tie")
  end

end
