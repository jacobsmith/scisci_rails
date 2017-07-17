class NilProject
  attr_accessor :user

  delegate :nickname, to: :user

  def initialize(args)
    args.each do |k, v|
      send("#{k}=", v)
    end
  end

  def name
    "(No Project exists yet)"
  end

  def id
    nil
  end

  def created_at
    nil
  end

  def sources
    []
  end

  def notes
    []
  end
end
