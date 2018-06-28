using System;
using System.Text;
using System.Text.RegularExpressions;

using RabbitMQ.Client;
using RabbitMQ.Client.Events;

namespace TextListener
{
    class RabbitMQManager
    {
        IModel _model;
        EventingBasicConsumer _consumer;
        RedisManager _redisManager;

        public RabbitMQManager()
        {
            _redisManager = new RedisManager();

            ConnectionFactory factory = new ConnectionFactory();
            factory.HostName = "localhost";

            IConnection connection = factory.CreateConnection();
            _model = connection.CreateModel();
            _model.QueueDeclare("backend-api", false, false, false, null);

            _consumer = new EventingBasicConsumer(_model);
        }

        public void Receive()
        {
            _consumer.Received += (model, ea) =>
            {
                byte[] body = ea.Body;
                string id = Encoding.UTF8.GetString(body);
                string value = _redisManager.Get(id);

                Console.WriteLine(value);
            };

            _model.BasicConsume("backend-api", true, _consumer);
        }
    }
}