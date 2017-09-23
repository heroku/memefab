class ImageCreator < Mediator
  def initialize(path:, name:, client: Cloudinary::Uploader, model: Image)
    @path   = path
    @name   = name
    @client = client
    @model  = model
  end

  def call
    upload_to_cloud
    begin
      create_record
    rescue
      remove_from_cloud
      raise
    end
  end

  private

  attr_reader :path, :name, :client, :model

  def remote_id
    @remote_id ||= "#{name.parameterize}-#{SecureRandom.hex}"
  end

  def upload_to_cloud
    client.upload(path,
      allowed_formats: "png,jpg,gif",
      public_id: remote_id
    )
  end

  def create_record
    model.create!(name: name, remote_id: remote_id)
  end

  def remove_from_cloud
    client.destroy(remote_id)
  end
end
