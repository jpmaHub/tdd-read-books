describe 'Tweets' do
  let(:tweet_gateway) { InMemoryGateway.new }

  class InMemoryGateway
    def initialize
      @tweets = []
    end 

    def save(tweet: )
      @tweets.push(tweet)
    end 

    def all
      @tweets
    end
  end 


  it 'saves the tweet using the gateway' do 
    save_tweet = SaveTweet.new(tweet_gateway: tweet_gateway)
    save_tweet.execute(tweet: nil)
    expect(tweet_gateway.all).to eq([])
  end 
end 