using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Concurrent;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    public class ValuesController : Controller
    {
        RedisManager _redisManager = new RedisManager();
        RabbitMQManager _rabbitMQManager = new RabbitMQManager();
        
        // GET api/values/<id>
        [HttpGet("{id}")]
        public string Get(string id)
        {
            return _redisManager.Get(id);
        }

        // POST api/values
        [HttpPost]
        public string Post([FromForm]string value)
        {
            string id = Guid.NewGuid().ToString();
            _redisManager.Add(id, value);
            _rabbitMQManager.Send(id);

             return id;
        }
    }
}
