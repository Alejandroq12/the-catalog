module IDManager
  @last_id = 0

  class << self
    def next_id
      @last_id += 1
    end
  end
end
