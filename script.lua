redis.call('FLUSHALL')

redis.call('SET', 'session:1', "2022-06-16 22:34:00")
redis.call('SET', 'session:2', "2022-06-28 23:24:00")
redis.call('SET', 'session:3', "2022-06-17 23:24:00")

redis.call('RPUSH', '0201202202PM', "#foraBolsonaro","#Lula2022","#AmorLivre","#queroCafé","#KeanuReeves","#Cavill","#anakin","#obiwan","#peakyblinders","#tomeShelby")

redis.call('HMSET', 'post:1', 'text', "Salve guerrerinho", 'datetime', "2022-06-16 22:34:00")
redis.call('HMSET', 'post:2', 'text', "Hoje eu acordei feliz", 'datetime', "2022-06-16 22:34:00")
redis.call('HMSET', 'post:3', 'text', "Callzinha com o Daniel, sempre bom", 'datetime', "2022-06-16 22:34:00")
redis.call('HMSET', 'post:4', 'text', "Bora jogar CS rapazeada?", 'datetime', "2022-06-16 22:34:00")
redis.call('HMSET', 'post:5', 'text', "Lula 2022", 'datetime', "2022-06-16 22:34:00")
redis.call('HMSET', 'post:6', 'text', "Fora bolsonaro", 'datetime', "2022-06-16 22:34:00")


redis.call('RPUSH', 'profile:1', 'post:1', 'post:2', 'post:3')
redis.call('RPUSH', 'profile:2', 'post:4', 'post:5', 'post:6')

local variable = redis.call('GET', 'session:1')
local variable2 = redis.call('GET', 'session:2')

local variable3 = redis.call('LRANGE', '0201202202PM', '0', '-1')

local variable4 = redis.call('LRANGE', 'profile:1', '0', '-1')
local variable5 = redis.call('HGETALL', 'post:1')
return {variable, variable2, variable3, variable4, variable5}