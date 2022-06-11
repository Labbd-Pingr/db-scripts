// Criação dos usuários

CREATE (user:User {account_id: 1});
CREATE (user:User {account_id: 2});
CREATE (user:User {account_id: 3});
CREATE (user:User {account_id: 4});
CREATE (user:User {account_id: 5});
CREATE (user:User {account_id: 6});


// Criação dos posts

CREATE (post:Post {post_id: 1});
CREATE (post:Post {post_id: 2});
CREATE (post:Post {post_id: 3});
CREATE (post:Post {post_id: 4});
CREATE (post:Post {post_id: 5});
CREATE (post:Post {post_id: 6});

// Associação dos posts com os usuários

MATCH (user), (post)
WHERE user.account_id = 1 AND post.post_id = 1
CREATE (user)-[:PUBLISH]->(post);

MATCH (user), (post)
WHERE user.account_id = 2 AND post.post_id = 2
CREATE (user)-[:PUBLISH]->(post);

MATCH (user), (post)
WHERE user.account_id = 3 AND post.post_id = 3
CREATE (user)-[:PUBLISH]->(post);

MATCH (user), (post)
WHERE user.account_id = 4 AND post.post_id = 4
CREATE (user)-[:PUBLISH]->(post);

MATCH (user), (post)
WHERE user.account_id = 5 AND post.post_id = 5
CREATE (user)-[:PUBLISH]->(post);

MATCH (user), (post)
WHERE user.account_id = 6 AND post.post_id = 6
CREATE (user)-[:PUBLISH]->(post);

// Associação dos likes

MATCH (user), (post)
WHERE user.account_id = 1 AND post.post_id = 3
CREATE (user)-[:LIKE {datetime: datetime()}]->(post) ;

MATCH (user), (post)
WHERE user.account_id = 2 AND post.post_id = 4
CREATE (user)-[:LIKE {datetime: datetime()}]->(post);

MATCH (user), (post)
WHERE user.account_id = 3 AND post.post_id = 1
CREATE (user)-[:LIKE {datetime: datetime()}]->(post);

MATCH (user), (post)
WHERE user.account_id = 4 AND post.post_id = 6
CREATE (user)-[:LIKE {datetime: datetime()}]->(post);

MATCH (user), (post)
WHERE user.account_id = 5 AND post.post_id = 3
CREATE (user)-[:LIKE {datetime: datetime()}]->(post);

MATCH (user), (post)
WHERE user.account_id = 6 AND post.post_id = 1
CREATE (user)-[:LIKE {datetime: datetime()}]->(post);

MATCH (user), (post)
WHERE user.account_id = 6 AND post.post_id = 2
CREATE (user)-[:LIKE {datetime: datetime()}]->(post);

// Associação entre usuário seguido e seguidor

MATCH (user1), (user2)
WHERE user1.account_id = 1 AND user2.account_id = 2
CREATE (user1)-[:FOLLOW {datetime: datetime()}]->(user2);

MATCH (user1), (user2)
WHERE user1.account_id = 1 AND user2.account_id = 3
CREATE (user1)-[:FOLLOW {datetime: datetime()}]->(user2);

MATCH (user1), (user2)
WHERE user1.account_id = 2 AND user2.account_id = 1
CREATE (user1)-[:FOLLOW {datetime: datetime()}]->(user2);

MATCH (user1), (user2)
WHERE user1.account_id = 2 AND user2.account_id = 3
CREATE (user1)-[:FOLLOW {datetime: datetime()}]->(user2);

// Associação entre usuário bloqueado e bloqueador:

MATCH (user1), (user2)
WHERE user1.account_id = 3 AND user2.account_id = 4
CREATE (user1)-[:BLOCK {datetime: datetime()}]->(user2);

MATCH (user1), (user2)
WHERE user1.account_id = 4 AND user2.account_id = 5
CREATE (user1)-[:BLOCK {datetime: datetime()}]->(user2);

MATCH (user1), (user2)
WHERE user1.account_id = 5 AND user2.account_id = 6
CREATE (user1)-[:BLOCK {datetime: datetime()}]->(user2);

MATCH (user1), (user2)
WHERE user1.account_id = 3 AND user2.account_id = 5
CREATE (user1)-[:BLOCK {datetime: datetime()}]->(user2);


// Associação entre dois posts (compartilhamento).

MATCH (post1), (post2)
WHERE post1.post_id = 2 AND post2.post_id = 5
CREATE (post1)-[:SHARE {datetime: datetime()}]->(post2);

// Associação entre dois posts (resposta).

MATCH (post1), (post2)
WHERE post1.post_id = 1 AND post2.post_id = 5
CREATE (post1)-[:REPLY {datetime: datetime()}]->(post2);


// ##### QUERIES #####


// Retorna os posts de um usuário específico que foram curtidos por um outro usuário específico, sendo que este último foi bloqueado pelo primeiro.
MATCH (user1:User {account_id: 3}) - [:PUBLISH] -> (post:Post),
      (user2: User {account_id: 5}) - [:LIKE] -> (post),
      (user1) - [:BLOCK] -> (user2)
RETURN user1, user2, post;

// Grau de distância entre dois usuários específicos.
MATCH path = ((user1:User {account_id: 1}) - [:FOLLOW *] - (:User {account_id: 2}))
RETURN length(path) as distance
ORDER BY length(path)
LIMIT 1;

// Usuários que interagiram com um usuário específico na última semana.
MATCH (user1:User {account_id: 1}) - [:PUBLISH] -> (post:Post)
OPTIONAL MATCH (user2:User) - [int:LIKE] -> (post)
WHERE int.datetime >= datetime()-duration('P7D')
WITH collect(distinct user2) as c1

OPTIONAL MATCH (user3:User) - [int2:PUBLISH] -> (post2:Post),
               (post2) - -> (post)
WHERE int2.datetime >= datetime()-duration('P7D')
WITH collect(distinct user3) + c1 as c2

UNWIND c2 as users
RETURN DISTINCT users;

// Usuários que publicam mais que N =5 valores em um intervalo M de horas.
WITH 5 as N, duration({hours: 5}) as M

MATCH (user:User) - [int:PUBLISH] -> (post:Post)
WHERE  int.datetime >= datetime()-M
WITH user as user, N as N, count(post) as numOfPosts
WHERE numOfPosts > N
RETURN DISTINCT user;

// Dado um post específico, retorna a maior profundidade de compartilhamento.
MATCH (post:Post {post_id: 5}),
      path = ((post2:Post) - [:SHARE *] -> (post))
RETURN length(path) as depth
ORDER BY length(path) DESC
LIMIT 1;

//Apagar todas as relações e nós:
//MATCH (n) DETACH DELETE n;

//Mostrar todos os nós:
//MATCH (n) RETURN n;



