using System;
using StackExchange.Redis;

namespace TextListener
{
    class RedisManager
    {
        IDatabase _dataBase;

        public RedisManager()
        {
            ConnectionMultiplexer redisConnection;
            redisConnection = ConnectionMultiplexer.Connect("localhost, abortConnect=false");
            _dataBase = redisConnection.GetDatabase();
        }

        public void Add(string key, string value)
        {
            _dataBase.StringSet(key, value);
        }

        public string Get(string key)
        {
            return _dataBase.StringGet(key);
        }
    }
}
