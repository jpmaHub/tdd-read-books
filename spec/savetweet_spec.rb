class SaveTweet
  def initialize(tweet_gateway: )
    @tweet_gateway = tweet_gateway
  end 

  def execute(tweet: )
    return [] if tweet.nil?
    @tweet_gateway.save(tweet: tweet) 
  end 
end 

describe SaveTweet do

  let(:tweet_gateway_spy) { TweetGatewaySpy.new }
  let(:tweet_gateway_mock) { TweetGatewayMock.new(self)}

  class TweetGatewayMock
    def initialize(suite)
      @suite = suite
      @count = 0
    end 

    def save(tweet: )
      @count += 1
      @tweet = tweet
    end 

    def have_received_once(tweet)
      @suite.expect(@tweet).to @suite.eq(tweet)
      @suite.expect(@count).to @suite.eq(1)
    end 

    attr_reader :count , :tweet


  end 

  class TweetGatewaySpy
    def save(tweet: )
      @tweet = tweet
    end 

    attr_reader :tweet
  end 

  it 'saves tweet' do
    save_tweet = SaveTweet.new(tweet_gateway: tweet_gateway_spy)
    save_tweet.execute(tweet: 'tweet1')
    expect(tweet_gateway_spy.tweet).to eq('tweet1')
  end 

  it 'saves tweet once' do
    save_tweet = SaveTweet.new(tweet_gateway: tweet_gateway_mock)
    save_tweet.execute(tweet: 'tweets')
    tweet_gateway_mock.have_received_once('tweets')
  end 

end 