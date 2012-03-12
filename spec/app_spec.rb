#encoding: UTF-8
require_relative 'spec_helper'
require_relative '../app.rb'

describe "Authentication Service" do 
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
        user = double(:user)
        User.stub(:new){user}
        user.stub(:save){true}
        User.should_receive(:new).with(params['user'])
        post '/users', params
      end

      it "should redirect to user private page" do 
        user = double(:user)
        User.stub(:new){user}
        user.stub(:save){true}
        post '/users', params
        last_response.should be_redirect
        follow_redirect!
        last_request.path.should == '/users/toto'
      end

      context "creation went berserk" do 
        it "should rerender the registration form" do 
          user = double(:user)
          User.stub(:new){user}
          user.stub(:save){false}
          post '/users', params
          last_response.should be_ok
          last_response.body.should match %r{<form.*action="/users".*method="post".*}
        end
      end
    end
  end
end
