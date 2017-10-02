default_images = [
 "Admiral Ackbar: It's a Trap",
 "All the things",
 "Boromir: One Does Not Simply",
 "El Paso Girl: Why Don't We Have Both",
 "Fry: Not Sure If",
 "Kermit the Frog: Drinking Tea",
 "Kevin Durant: The Real MVP",
 "Morpheus: What if I told you",
 "Most Interesting Man",
 "Oprah: You Get A Car",
 "Overly Attached Girlfriend",
 "Willy Wonka: Sarcastic",
 "Yoda: Advice"
]

default_images.each do |name|
  unless Image.exists?(name: name)
    filename = "#{name.parameterize}.jpg"
    filepath = File.join(Rails.root, "db/seeds", filename)
    ImageComposer.run(name: name, path: filepath)
  end
end
