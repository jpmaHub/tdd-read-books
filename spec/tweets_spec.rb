require 'json'
require 'rest-client'
require 'webmock/rspec'

class Tweets
  def all
    response = RestClient.get("http://api.twitter.com/tweets/get")
    JSON.parse(response, symbolize_names:true)[:tweets]
  end 

  def save(tweets)
    RestClient.post("http://api.twitter.com/tweets/post", tweets , { 'content_type': 'application/json'} )
  end 
end 

xdescribe Tweets, 'Get' do
  before do
    stub_request(:get,"http://api.twitter.com/tweets/get").
    to_return(status: 200 , body: tweets.to_json, headers: { 'content-type': 'application/json'})
  end 

  context 'given account with no tweets' do
    let(:tweets) {{ tweets: [] }}
    it 'returns no tweets' do
      subject.all
      expect(subject.all.count).to eq(0)
    end 

    it 'checks api' do
      subject.all
      expect(WebMock).to have_requested(:get, "http://api.twitter.com/tweets/get")
    end 
  end 

  context 'given account with three tweets' do
    let(:tweets) {{ tweets: ['tweet', 'tweet1', 'helo'] }}
    it 'returns three tweets' do
      subject.all
      expect(subject.all.count).to eq(3)
    end
  end 
end 


describe Tweets, 'Post' do

  context 'given account to save three tweets' do
    let(:tweets) {{ tweets: ['tweet', 'tweet1', 'helo'] }}

    it 'saves the tweets' do
      a_request = stub_request(:post, "http://api.twitter.com/tweets/post").
      with(body: tweets.to_json, headers: { 'content-type': 'application/json'})
      subject.save(tweets.to_json)
      expect(a_request).to have_been_made.at_least_once
    end 
  end 
end 