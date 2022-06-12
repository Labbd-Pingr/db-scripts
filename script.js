db = db.getMongo().getDB("pingr--");

db.post.insertMany([
  {post_id: 1, profile_id: 1, date: Date.now(), text: {text: "Acordei bobo hoje"}},
  {post_id: 2, profile_id: 2, date: Date.now(), text: {text: "Também quero dar opiniões #MonologoNão", hashtags: ["#MonologoNão"]}},
  {post_id: 3, profile_id: 3, date: Date.now(), text: {text: "só tem um caminho certo nessas eleições #lula13 #foraBolsonaro", hashtags: ["#lula13", "#foraBolsonaro"]}},
  {post_id: 4, profile_id: 3, date: Date.now(), text: {text: "só tem um caminho certo nessas eleições #lula13 #foraBolsonaro", hashtags: ["#lula13", "#foraBolsonaro"]}},
]);

db.chat.insertMany([
  {chat_id: 1, account_ids: [1, 2].sort(), messages: [
    {account_id: 1, date: Date.now(), text: "Ou mano, vc vai na qib"},
    {account_id: 2, date: Date.now(), text: "Oloco, qq é isso?"},
  ]},
  {chat_id: 2, account_ids: [2, 3].sort(), messages: [
    {account_id: 2, date: Date.now(), text: "essa semana vai ter break?"},
    {account_id: 3, date: Date.now(), text: "vai sim"},
    {account_id: 2, date: Date.now(), text: "top!"},
  ]},
  {chat_id: 3, account_ids: [1, 2, 3].sort(), owner_account_id: 1, privacy: "private", token: "#b709t", messages: [
    {account_id: 3, date: Date.now(), text: "ou rapazeada, bora fazer o ep"},
    {account_id: 1, date: Date.now(), text: "vamo"},
  ]},
  {chat_id: 4, account_ids: [3].sort(), owner_account_id: 3, privacy: "public", messages: [
    {account_id: 3, date: Date.now(), text: "Welcome to my personal notes group! #coursera"},
  ]},
]);

// Queries

// Recuperar todas as postagens de um usuáio específico
db.post.find({"profile_id": 1}).pretty();

// Recuperar o histórico de conversa de um chat específico
db.chat.find({"chat_id": 2}, {_id: 0, messages: 1}).pretty();

// Recuperar todas as postagens que contém uma hashtag específica
db.post.find({"text.hashtags": {$elemMatch: { $eq: "#lula13" }}}).pretty();

// Recuperar todas as postagens idênticas a uma postagem específica.
let srcText = db.post.findOne({"post_id": 3}, {_id: 0, post_id: 1, text: "$text.text"});
db.post.find({"post_id": {$ne: srcText.post_id}, "text.text": srcText.text}).pretty();

// Recuperar todos os chats de um usuário
db.chat.find({"account_ids": {$elemMatch: {$eq: 1}}}).pretty();