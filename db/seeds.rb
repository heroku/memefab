default_images = [
  {
    name: "Admiral Ackbar: It's a Trap",
    url: "https://memegenerator.net/img/images/600x600/9388/admiral-ackbar.jpg"
  },
  {
    name: "All the things",
    url: "https://memegenerator.net/img/images/600x/1121885.jpg",
  },
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
    name: "Oprah: You Get A Car",
    url: "https://memegenerator.net/img/images/600x600/8825147/giving-oprah.jpg"
  },
  {
    name: "Overly Attached Girlfriend",
    url: "https://memegenerator.net/img/images/600x600/4915715/overly-attached-girlfriend.jpg"
  },
  {
    name: "El Paso Girl: Why don't we have both",
    url: "https://memegenerator.net/img/images/600x/13141187.jpg"
  },
  {
    name: "Willy Wonka: Sarcastic",
    url: "https://memegenerator.net/img/images/600x600/2729805/willy-wonka.jpg"
  },
  {
    name: "Yoda: Advice",
    url: "https://memegenerator.net/img/images/600x/963.jpg"
  }
]

default_images.each do |opts|
  unless Image.exists?(name: opts[:name])
    ImageComposer.run(name: opts[:name], path: opts[:url])
  end
end
