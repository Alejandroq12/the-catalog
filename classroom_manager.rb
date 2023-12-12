module ClassroomManager
  @last_id = 0

  class << self
    def next_classroom
      @last_id += 1
    end
  end
end
