require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) {Category.new(:name => 'DC')}
  subject {described_class.new(:name => 'Batman', :price => 300, :quantity => 30, :category => category)}  
  
  describe 'Validations' do
  
    
    it 'saves successfully with all four fields set and belong to a category' do
      subject.valid?
      expect(subject.errors).to be_empty
      assc = described_class.reflect_on_association(:category)
      expect(assc.macro).to eq :belongs_to
    end

    it 'fails to save when name is not set' do
      subject.name = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end
    
    it 'fails to save when price is not set' do
      subject.price_cents = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when quantity is not set' do
      subject.quantity = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when category is not set' do
      subject.category = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end


  end  
end