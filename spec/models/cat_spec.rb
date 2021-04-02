require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "It should have a valid name" do
    cat = Cat.create age: 4, enjoys: "taking poops on the beach"
    expect(cat.errors[:name]).to include "can't be blank"
  end
  it "It should have a valid age" do
    cat = Cat.create name: "Milo", enjoys: "taking poops on the beach"
    expect(cat.errors[:age]).to include "can't be blank"
  end
  it "It should have a valid enjoys description" do
    cat = Cat.create age: 4, name: "Ottis"
    expect(cat.errors[:enjoys]).to include "can't be blank"
  end
  it "Should have an enjoys description with at least 10 characters" do
    cat = Cat.create name: "Freya", age: 2, enjoys: "laying"
    expect(cat.errors[:enjoys]).to include "is too short (minimum is 10 characters)"
  end
end
