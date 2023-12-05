class Person
  def intialize(age, name: 'Unknown', parent_permission: true)
    @id = Random.rand(1..5000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end


end
