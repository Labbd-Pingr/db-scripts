function listToHash(list) {
  list.sort();
  return list.join('-');
}

const gridfs = require('gridfs');

db = db.getMongo().getDB("pingr--");

db.post.insertMany([
  {post_id: 1, profile_id: 1, date: Date.now(), text: {text: "Acordei bobo hoje"}},
  {post_id: 2, profile_id: 2, date: Date.now(), text: {text: "Semana de break! #feliz", hashtags: ["#feliz"]}},
])

db.chat.insertMany([
  {chat_id: 1, account_ids: listToHash([1, 2]), messages: [
    {account_id: 1, date: Date.now(), text: "Comi o cu de quem ta lendo"},
    {account_id: 2, date: Date.now(), text: "Oloco, que é isso?"},
  ]},
  {chat_id: 2, account_ids: listToHash([2, 3]), messages: [
    {account_id: 2, date: Date.now(), text: "Mano, o doido do Foo me mandou uma msg mo entranha"},
    {account_id: 3, date: Date.now(), text: "qual?"},
    {account_id: 2, date: Date.now(), text: "Comi o cu de quem ta lendo"},
  ]},
  {chat_id: 3, account_ids: listToHash([1, 2, 3]), owner_account_id: 1, privacy: "private", token: "#b709t", messages: [
    {account_id: 3, date: Date.now(), text: "O Foo, para com essas porra ai irmão"},
    {account_id: 1, date: Date.now(), text: "meu pau na sua mão"},
  ]},
  {chat_id: 4, account_ids: listToHash([3]), owner_account_id: 3, privacy: "public", messages: [
    {account_id: 3, date: Date.now(), text: "Welcome to my personal notes group!"},
  ]},
]);