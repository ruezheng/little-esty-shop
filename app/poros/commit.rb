class Commit

  def initialize(commits)
    @commits = commits
  end

  def name
    @username = commits[:author][:login]
  end

  def count
    commit_count_hash = Hash.new(0)
    @name.each do |name|
      commit_count_hash[:name] += 1
    end
  end
end
