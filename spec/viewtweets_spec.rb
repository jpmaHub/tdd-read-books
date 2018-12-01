class ViewTweets
  def initialize(tweet_gateway: )
    @tweet_gateway = tweet_gateway
  end 

  def execute
   @tweet_gateway.all
  end 

end

describe ViewTweets do
  let(:tweet_gateway_stub) { TweetGatewayStub.new }

  class TweetGatewayStub
    def initialize
      @tweets = []
    end 

    def get_tweets(tweets)
      @tweets = tweets
    end 

    def all
      @tweets
    end 
  end 
  
  it 'returns tweets to view' do
    view_tweets = ViewTweets.new(tweet_gateway: tweet_gateway_stub)
    tweet_gateway_stub.get_tweets(['hi'])
    response = view_tweets.execute
    expect(response).to eq(['hi'])
  end 
end 