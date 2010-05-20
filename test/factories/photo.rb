Factory.define :photo do |photos|
  photos.image_file_name { 'string' }
  photos.image_content_type { 'string' }
  photos.image_file_size { 1 }
  photos.image_updated_at { Time.now.to_s(:db) }
end
