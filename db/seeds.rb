default_images = [
  {
    name: "Boromir: One Does Not Simply",
    url: "https://memegenerator.net/img/images/600x600/3291562/one-does-not-simply.jpg"
  },
  {
    name: "Fry: Not Sure If",
    url: "https://memegenerator.net/img/images/600x600/84688/futurama-fry.jpg"
  },
  {
    name: "Kermit the Frog: Drinking Tea",
    url: "https://memegenerator.net/img/images/600x600/11590722/kermit-the-frog-drinking-tea.jpg"
  },
  {
    name: "Kevin Durant: The Real MVP",
    url: "https://memegenerator.net/img/images/600x600/11413624/kd-you-the-real-mvp-f.jpg"
  },
  {
    name: "Morpheus: What if I told you",
    url: "https://memegenerator.net/img/images/600x600/4796874/what-if-i-told-you.jpg"
  },
  {
    name: "Most Interesting Man",
    url: "https://memegenerator.net/img/images/600x600/265862/worlds-most-interesting-man.jpg"
  },
  {
    name: "Overly Attached Girlfriend",
    url: "https://memegenerator.net/img/images/600x600/4915715/overly-attached-girlfriend.jpg"
  },
  {
    name: "Willy Wonka: Sarcastic",
    url: "https://memegenerator.net/img/images/600x600/2729805/willy-wonka.jpg"
  },
]

default_images.each do |opts|
  unless Image.exists?(name: opts[:name])
    ImageCreator.run(name: opts[:name], path: opts[:url])
  end
end
