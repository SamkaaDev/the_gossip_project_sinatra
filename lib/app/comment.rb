  # frozen_string_literal: true

require 'csv'

class Comment
  attr_accessor :gossip_id, :author, :content

  def initialize(gossip_id, author, content)
    # Class constructor
    @gossip_id = gossip_id
    @author = author
    @content = content
  end

  def save
    # Saves comment in db
    # No return
    CSV.open("./db/comment.csv", "ab") do |csv|
      csv << [@gossip_id, @author, @content]
    end
  end

  def self.all_for_gossip(gossip_id)
    # Provides all the comments for one particular gossip
    # Returns an array
    all_comments_for_g = []
    CSV.read("./db/comment.csv").each do |csv_line|
      if csv_line[0] == gossip_id
        all_comments_for_g << Comment.new(csv_line[0], csv_line[1], csv_line[2])
      end
    end
    all_comments_for_g
  end
end