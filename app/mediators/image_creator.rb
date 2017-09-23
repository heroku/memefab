class ImageCreator < Mediator
  def initialize(path:, name:, client: Cloudinary::Uploader, model: Image)
    @path   = path
    @name   = name
    @client = client
    @model  = model
  end

  def call
    upload_to_cloud
    create_record
  end

  private

  attr_reader :path, :name, :client, :model

  def remote_id
    @remote_id ||= "#{name.parameterize}-#{SecureRandom.hex}"
  end

  def upload_to_cloud
    @upload ||= client.upload(path, public_id: remote_id)
  end

  def create_record
    @record ||= model.create(name: name, remote_id: remote_id)
  end
end
