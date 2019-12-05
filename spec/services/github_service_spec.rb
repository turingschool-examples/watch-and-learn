<<<<<<< HEAD
# require 'rails_helper'
#
# describe GithubService do
#   it "returns github data", :vcr do
#     search = subject.repos_by_user
#     expect(search).to be_an Array
#   end
# end
=======
require 'rails_helper'

describe GithubService do
  it "returns github data", :vcr do
    search = subject.repos_by_user
    expect(search).to be_an Array
  end
end
>>>>>>> 8494c042f4f17b4861ccf9a0d017de033838ec32
