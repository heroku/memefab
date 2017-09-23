class Mediator
  def self.run(options = {})
    new(options).call
  end
end
