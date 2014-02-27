require 'spec_helper'

describe User do
  #  pending "add some examples to (or delete) #{__FILE__}"
  before {@user = User.new(login:"masheng",email: "steve2008.ma@gmail.com",username: "machine")}
  subject {@user}
  it {should respond_to(:login)}
  it {should respond_to(:email)}
  it {should respond_to(:username)}
end
