class Mediator
  def self.run(*args)
    new(*args).call
  end
end
