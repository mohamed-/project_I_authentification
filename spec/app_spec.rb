#encoding: UTF-8
require_relative 'spec_helper'
require_relative '../app.rb'

describe "Authenticatin Service" do 
  describe "User registration" do 
    describe "get /users/new" do 
      it "should return a form to post registration info to /users" do 
        get '/users/new'
        last_response.should be_ok
        last_response.body.should match %r{<form.*action="/users".*method="post".*}
      end
    end

    describe "post /users" do
      let(:params){ { "user" => {"login" => "toto", "name" => "Théodore Oto" }} }
      it "should create a new user" do 
        User.stub(:create)
        User.should_receive(:create).with(params['user'])
        post '/users', params
      end

      it "should redirect to user private page" do 
        User.stub(:create){true}
        post '/users', params
        last_response.should be_redirect
        follow_redirect!
        last_request.path.should == '/users/toto'
      end

      context "creation went berserk" do 
        it "should rerender the registration form" do 
          User.stub(:create).and_return(false)
          post '/users', params
          last_response.should be_ok
          last_response.body.should match %r{<form.*action="/users".*method="post".*}
        end
      end
    end
  end
end
