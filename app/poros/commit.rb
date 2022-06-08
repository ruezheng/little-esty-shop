class Commit

  def initialize(commits)
    @commits = commits
  end

  def name
    @usernames = commits[:author][:login]
  end

  def count
    commit_count_hash = Hash.new(0)
    @username.each do |user|
      commit_count_hash[:user] += 1
    end
  end
end
