require 'rails_helper'

RSpec.describe User, type: :model do

  subject {described_class.new(:first_name => 'Jon', :last_name => 'Jones', :email => 'bones@gamil.com', :password => "888", :password_confirmation => "888")}

  describe 'Validations do' do
    
    it 'saves successfully when all four feilds are set' do
      subject.valid?
      expect(subject.errors).to be_empty
    end

    it 'fails to save when email is not set' do
      subject.email = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when first name is not set' do
      subject.first_name = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when last name is not set' do
      subject.last_name = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when password is not set' do
      subject.password = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when password_confirmation is not set' do
      subject.password_confirmation = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when password and password_confirmation does not match' do
      subject.password_confirmation = '456'
      subject.valid?
      expect(subject.errors).not_to be_empty
    end
    
    it 'fails to save when email is not unique (not case sensitive)' do
      User.create(:first_name => 'Jon', :last_name => 'Jones', :email => 'bones@gamil.com', :password => "888", :password_confirmation => "888", :password_digest => "123")
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when password and password_confirmation is less than length 3' do
      subject.password = '12'
      subject.password_confirmation = '12'
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    describe '.authenticate_with_credentials' do
      it 'returns user if succesfully authenticated' do
        subject.save
        user = User.authenticate_with_credentials('bones@gamil.com', '888')
        expect(subject).to be == user
      end

      it 'returns nil if not successfully authenticated' do
        subject.save
        user = User.authenticate_with_credentials('bones@gamil.com', 'ggg')
        expect(user).to be == nil
      end

      it 'authenticates and users if user type white space before / after email' do
        subject.save
        user = User.authenticate_with_credentials(' bones@gamil.com ', '888')
        expect(subject).to be == user
      end

      it 'authenticates and users if users type lower and upper case in email' do
        subject.save
        user = User.authenticate_with_credentials('boNes@gAmil.com', '888')
        expect(subject).to be == user
      end
    end
    
  end
end