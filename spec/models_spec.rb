require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { should have_many(:watchlists).dependent(:destroy) }
    it { should have_many(:users).through(:watchlists) }
  end

  describe 'validations' do
    describe 'title' do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title).is_at_most(255) }
    end

    describe 'description' do
      it { should validate_length_of(:description).is_at_most(500) }
      it { should allow_value(nil).for(:description) }
      it { should allow_value('').for(:description) }
    end

    describe 'release_year' do
      it { should validate_numericality_of(:release_year).only_integer }
      it { should validate_numericality_of(:release_year).is_greater_than_or_equal_to(1888) }
      it { should validate_numericality_of(:release_year).is_less_than_or_equal_to(Date.current.year + 5) }
      it { should allow_value(nil).for(:release_year) }
    end
  end
end

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:watchlists).dependent(:destroy) }
    it { should have_many(:movies).through(:watchlists) }
  end

  describe 'validations' do
    subject { build(:user) }

    describe 'username' do
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }
      it { should validate_length_of(:username).is_at_least(3).is_at_most(50) }
    end

    describe 'password' do
      context 'when creating a new user' do
        it 'validates password length' do
          user = build(:user, password: '12345')
          expect(user).not_to be_valid
          expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
        end

        it 'is valid with password of minimum length' do
          user = build(:user, password: '123456')
          expect(user).to be_valid
        end
      end

      context 'when updating existing user without password' do
        it 'does not validate password length' do
          user = create(:user)
          user.username = 'newusername'
          expect(user).to be_valid
        end
      end

      context 'when updating existing user with password' do
        it 'validates password length' do
          user = create(:user)
          user.password = '12345'
          expect(user).not_to be_valid
          expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
        end
      end
    end
  end

  describe 'username normalization' do
    it 'converts username to lowercase' do
      user = create(:user, :with_uppercase_username)
      expect(user.username).to match(/^user\d+$/)
      expect(user.username).not_to match(/^USER\d+$/)
    end

    it 'removes leading and trailing whitespace' do
      user = create(:user, :with_spaces_in_username)
      expect(user.username).to match(/^user\d+$/)
      expect(user.username).not_to start_with(' ')
      expect(user.username).not_to end_with(' ')
    end

    it 'handles mixed case and spaces' do
      user = build(:user, username: '  TestUser  ')
      user.save
      expect(user.username).to eq('testuser')
    end
  end
end

RSpec.describe Watchlist, type: :model do
  subject { build(:watchlist) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
  end

  describe 'validations' do
    describe 'uniqueness' do
      it { should validate_uniqueness_of(:user_id).scoped_to(:movie_id) }

      it 'allows multiple users to add the same movie to their watchlist' do
        movie = create(:movie)
        user1 = create(:user)
        user2 = create(:user)

        watchlist1 = create(:watchlist, user: user1, movie: movie)
        watchlist2 = build(:watchlist, user: user2, movie: movie)

        expect(watchlist2).to be_valid
      end

      it 'allows the same user to add different movies to their watchlist' do
        user = create(:user)
        movie1 = create(:movie)
        movie2 = create(:movie)

        watchlist1 = create(:watchlist, user: user, movie: movie1)
        watchlist2 = build(:watchlist, user: user, movie: movie2)

        expect(watchlist2).to be_valid
      end

      it 'prevents the same user from adding the same movie twice' do
        user = create(:user)
        movie = create(:movie)

        create(:watchlist, user: user, movie: movie)
        duplicate_watchlist = build(:watchlist, user: user, movie: movie)

        expect(duplicate_watchlist).not_to be_valid
        expect(duplicate_watchlist.errors[:user_id]).to include('has already been taken')
      end
    end
  end
end
