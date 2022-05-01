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


//Apagar todas as relações e nós:
//MATCH (n) DETACH DELETE n;

//Mostrar todos os nós:
//MATCH (n) RETURN n;



